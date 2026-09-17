# OTel shipping with FusionReactor

From version **2025.2.0**, the FusionReactor agent includes built-in OpenTelemetry (OTel) support and ships metrics, traces, and logs directly to any OTel-compatible destination. You no longer need to run a separate OTel agent alongside FusionReactor.

## Shipping modes

There are three shipping modes depending on your setup:

| Mode | When it applies | Config required |
|---|---|---|
| **Default (OpsPilot)** | No existing OTel endpoint configured | None |
| **Single endpoint** | You configure one external OTel endpoint | Set `otel.exporter.otlp.endpoint` |
| **Multiple destinations** | You need to ship to more than one destination | Collector required |

## Default: shipping to OpsPilot

Without any OTel endpoint configured, the FR agent automatically ships all metrics, traces, and logs to OpsPilot. No configuration is needed.

If you upgrade from a pre-2025.2.0 agent with no existing OTel configuration, your data will appear in OpsPilot automatically.

## Single endpoint shipping

To override the OpsPilot default and ship to a single external provider (Datadog, New Relic, Dash0, Grafana, etc.), configure the endpoint via system property or environment variable:

```properties
otel.exporter.otlp.endpoint=https://your-endpoint:4317
```

```bash
export OTEL_EXPORTER_OTLP_ENDPOINT=https://your-endpoint:4317
```

!!! warning
    When you configure an external endpoint, shipping to OpsPilot stops. To keep sending data to OpsPilot alongside another destination, use a collector instead.

If you had an existing OTel configuration before upgrading to 2025.2.0, the FR agent picks up your configured endpoint automatically - your data will go to that endpoint rather than OpsPilot.

## Multiple destinations via a collector

To ship to more than one destination simultaneously, point the FR agent at a local collector, then configure the collector to fan out to multiple destinations.

The FR agent configuration is the same regardless of which collector you use:

```properties
otel.exporter.otlp.endpoint=http://localhost:4317
```

Then configure your collector:

=== "OTel Collector"

    The OpenTelemetry Collector uses YAML configuration. Create or edit your `collector.yaml`:

    ```yaml
    receivers:
      otlp:
        protocols:
          grpc:
            endpoint: 0.0.0.0:4317
          http:
            endpoint: 0.0.0.0:4318

    processors:
      batch:
        timeout: 5s
        send_batch_size: 1000

    exporters:
      otlp/grafana:
        endpoint: https://<your-stack>.grafana.net/otlp
        headers:
          authorization: "Basic <base64(instanceID:apiToken)>"

      prometheusremotewrite/opspilot:
        endpoint: https://api.fusionreactor.io/v1/metrics
        headers:
          authorization: "${env:FR_API_KEY}"

      otlphttp/opspilot:
        endpoint: https://api.fusionreactor.io
        headers:
          authorization: "${env:FR_API_KEY}"

    service:
      pipelines:
        traces:
          receivers: [otlp]
          processors: [batch]
          exporters: [otlp/grafana, otlphttp/opspilot]
        metrics:
          receivers: [otlp]
          processors: [batch]
          exporters: [otlp/grafana, prometheusremotewrite/opspilot]
        logs:
          receivers: [otlp]
          processors: [batch]
          exporters: [otlp/grafana, otlphttp/opspilot]
    ```

    !!! info "OpsPilot metrics format"
        OpsPilot ingests metrics in **Prometheus Remote Write format**, not raw OTLP. The metrics pipeline must use the `prometheusremotewrite` exporter targeting `https://api.fusionreactor.io/v1/metrics`. Use the `otel/opentelemetry-collector-contrib` image - the standard `otel/opentelemetry-collector` image does not include this exporter.

=== "Alloy"

    Grafana Alloy uses HCL syntax. Create or edit your `collector.alloy`:

    ```hcl
    otelcol.receiver.otlp "default" {
      grpc {
        endpoint = "0.0.0.0:4317"
      }
      http {
        endpoint = "0.0.0.0:4318"
      }

      output {
        metrics = [otelcol.processor.batch.default.input]
        logs    = [otelcol.processor.batch.default.input]
        traces  = [otelcol.processor.batch.default.input]
      }
    }

    otelcol.processor.batch "default" {
      timeout         = "5s"
      send_batch_size = 1000

      output {
        metrics = [otelcol.exporter.otlp.grafana.input, otelcol.exporter.prometheus.opspilot.input]
        logs    = [otelcol.exporter.otlp.grafana.input, otelcol.exporter.otlphttp.opspilot.input]
        traces  = [otelcol.exporter.otlp.grafana.input, otelcol.exporter.otlphttp.opspilot.input]
      }
    }

    otelcol.exporter.otlp "grafana" {
      client {
        endpoint = "https://<your-stack>.grafana.net/otlp"
        auth     = otelcol.auth.basic.grafana.handler
      }
    }

    otelcol.auth.basic "grafana" {
      username = env("GRAFANA_INSTANCE_ID")
      password = env("GRAFANA_API_TOKEN")
    }

    // OpsPilot traces and logs
    otelcol.exporter.otlphttp "opspilot" {
      client {
        endpoint = "https://api.fusionreactor.io"
        headers  = {
          "authorization" = env("FR_API_KEY"),
        }
      }
    }

    // OpsPilot metrics - convert to Prometheus Remote Write format
    otelcol.exporter.prometheus "opspilot" {
      forward_to = [prometheus.remote_write.opspilot.receiver]
    }

    prometheus.remote_write "opspilot" {
      endpoint {
        url = "https://api.fusionreactor.io/v1/metrics"
        headers = {
          "authorization" = env("FR_API_KEY"),
        }
      }
    }
    ```

    !!! warning
        OpsPilot requires the raw API key in the `Authorization` header **without** a `Bearer ` prefix. Use a plain `headers` map rather than `otelcol.auth.bearer`, which adds the prefix automatically.

`FR_API_KEY` is your OpsPilot API key from **Account Settings > API Keys** in the OpsPilot UI. This is different from your FR licence key.

## Troubleshooting

### Verifying your configuration

Check the **Cloud Status** page in the local FusionReactor UI (`localhost:8088` by default) to confirm that OTel shipping settings have been applied and shipping is active. Also review the agent startup logs for any configuration errors or warnings.

### Data not appearing in OpsPilot

- Verify your endpoint URL is correct
- Check that authentication credentials are set via environment variables
- Ensure the protocol matches the endpoint (gRPC uses port `4317`, HTTP uses `4318`)
- Check collector logs if using a collector

### Connection errors

- Verify network connectivity to the endpoint
- Check that firewall rules allow outbound connections on the required ports
- Ensure the endpoint supports the protocol you have configured

### Authentication failures

- Verify that API keys/tokens are valid and not expired
- Check the header format matches the provider's requirements
- Ensure environment variables are set and accessible to the process

For further help, see the [OpsPilot OpenTelemetry troubleshooting guide](https://docs.opspilot.com/Monitor-your-data/OpenTelemetry/Troubleshooting) or contact support via the chat bubble on this page.
