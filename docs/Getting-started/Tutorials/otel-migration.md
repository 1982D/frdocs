# Migrating from a dual OTel + FR agent setup

From version **2025.2.0**, the FusionReactor agent ships OTel data natively. If you were previously running a standalone OTel Java agent alongside the FR agent, you can remove it and let the FR agent handle shipping directly.

This page covers what the FR agent handles, what it does not, and how to migrate your collector configuration.

## What the FR agent handles

The FR agent (2025.2.0+) automatically collects and ships:

- **Traces** - all request traces instrumented by the FR agent
- **Metrics** - JVM metrics, HTTP request metrics, and FR agent instrumentation metrics
- **Logs** - application logs captured by the FR agent

These are shipped via the built-in OTel exporter to whichever endpoint you configure (OpsPilot by default).

## What the FR agent does not handle

### Custom metrics via `GlobalOpenTelemetry`

The FR agent does not register itself as the global OTel SDK instance. If your application code calls `GlobalOpenTelemetry.get()` to record custom metrics or spans, those calls will return a no-op implementation - your custom instrumentation will not be collected.

If you rely on custom metrics or spans created via `GlobalOpenTelemetry`, you have two options:

- **Keep a standalone OTel agent** for custom instrumentation alongside the FR agent (point both at the same collector)
- **Initialise the OTel SDK explicitly** in your application code so it does not depend on the global instance

Example of explicit SDK initialisation (Java):

```java
SdkMeterProvider meterProvider = SdkMeterProvider.builder()
    .registerMetricReader(
        PeriodicMetricReader.builder(
            OtlpGrpcMetricExporter.builder()
                .setEndpoint("http://localhost:4317")
                .build()
        ).build()
    )
    .build();

OpenTelemetrySdk openTelemetry = OpenTelemetrySdk.builder()
    .setMeterProvider(meterProvider)
    .build();

Meter meter = openTelemetry.getMeter("your-instrumentation-name");
```

This creates an independent OTel instance that ships to the same collector as the FR agent, without depending on the global singleton.

### FRAPI metrics

Metrics recorded via the FusionReactor FRAPI are captured locally and visible in the FR UI. They are not currently included in OTel shipping.

## Migration steps

### Step 1: Remove the standalone OTel agent

Remove the `-javaagent:/path/to/opentelemetry-javaagent.jar` JVM argument from your startup configuration. The FR agent now handles OTel shipping, so the standalone agent is no longer needed for standard instrumentation.

If you have custom metrics via `GlobalOpenTelemetry`, see the section above before removing the standalone agent.

### Step 2: Update your collector configuration

If you were previously sending OTel data from a standalone agent to a collector, and that collector was already forwarding to OpsPilot, you need to update the metrics pipeline to use Prometheus Remote Write format. OpsPilot does not accept raw OTLP metrics.

=== "OTel Collector (before)"

    ```yaml
    exporters:
      otlp/opspilot:
        endpoint: https://api.fusionreactor.io
        headers:
          authorization: "${env:FR_API_KEY}"

    service:
      pipelines:
        metrics:
          receivers: [otlp]
          processors: [batch]
          exporters: [otlp/opspilot]
    ```

=== "OTel Collector (after)"

    ```yaml
    exporters:
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
          exporters: [otlphttp/opspilot]
        metrics:
          receivers: [otlp]
          processors: [batch]
          exporters: [prometheusremotewrite/opspilot]
        logs:
          receivers: [otlp]
          processors: [batch]
          exporters: [otlphttp/opspilot]
    ```

    !!! warning
        Use the `otel/opentelemetry-collector-contrib` image. The standard `otel/opentelemetry-collector` image does not include the `prometheusremotewrite` exporter.

=== "Alloy (before)"

    ```hcl
    otelcol.exporter.otlphttp "opspilot" {
      client {
        endpoint = "https://api.fusionreactor.io"
        headers  = {
          "authorization" = env("FR_API_KEY"),
        }
      }
    }

    otelcol.processor.batch "default" {
      output {
        metrics = [otelcol.exporter.otlphttp.opspilot.input]
        logs    = [otelcol.exporter.otlphttp.opspilot.input]
        traces  = [otelcol.exporter.otlphttp.opspilot.input]
      }
    }
    ```

=== "Alloy (after)"

    ```hcl
    // Traces and logs via OTLP HTTP
    otelcol.exporter.otlphttp "opspilot" {
      client {
        endpoint = "https://api.fusionreactor.io"
        headers  = {
          "authorization" = env("FR_API_KEY"),
        }
      }
    }

    // Metrics via Prometheus Remote Write
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

    otelcol.processor.batch "default" {
      output {
        metrics = [otelcol.exporter.prometheus.opspilot.input]
        logs    = [otelcol.exporter.otlphttp.opspilot.input]
        traces  = [otelcol.exporter.otlphttp.opspilot.input]
      }
    }
    ```

    !!! warning
        OpsPilot requires the raw API key in the `Authorization` header without a `Bearer ` prefix. Do not use `otelcol.auth.bearer` - it adds the prefix automatically.

### Step 3: Verify data is arriving

1. Open the **Cloud Status** page in the local FusionReactor UI (`localhost:8088` by default) and confirm shipping is active.
2. Check OpsPilot to verify metrics, traces, and logs are appearing.
3. If you have custom instrumentation, confirm those metrics are still being recorded (either via the standalone agent you kept, or via the explicitly initialised SDK).

## Summary

| | Standalone OTel agent | FR agent 2025.2.0+ |
|---|---|---|
| Standard JVM metrics | Yes | Yes |
| Request traces | Yes | Yes |
| Logs | Yes | Yes |
| Custom `GlobalOpenTelemetry` metrics | Yes | No |
| FRAPI metrics | No | Local only |

For the full shipping configuration reference, see [OTel shipping with FusionReactor](otel-shipping.md).
