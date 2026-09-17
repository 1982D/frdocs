# OpenTelemetry Shipping Configuration

## Overview

The FusionReactor agent now supports shipping observability data to any OpenTelemetry (OTel) compatible provider. By default, the agent ships to OpsPilot, but you can configure it to send data to any single OTel endpoint or use an OTel collector or Grafana Alloy to send data to multiple destinations simultaneously.

<div style="padding:56.25% 0 0 0;position:relative;"><iframe src="https://player.vimeo.com/video/1139978038?badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479" frameborder="0" allow="autoplay; fullscreen; picture-in-picture; clipboard-write; encrypted-media; web-share" referrerpolicy="strict-origin-when-cross-origin" style="position:absolute;top:0;left:0;width:100%;height:100%;" title="OTel Shipping Configuration"></iframe></div><script src="https://player.vimeo.com/api/player.js"></script>

## Key Concepts

### Default behavior
- **OpsPilot is the default destination** - no configuration needed.
- All metrics, traces, and logs are automatically shipped to FusionReactor.

### Single endpoint shipping
- You can override the default and ship directly to **one** external provider (Datadog, New Relic, Dash0, Grafana, etc.).
- When you configure an external endpoint, shipping to FusionReactor stops unless you use a collector.
- Use standard OTel configuration properties.

### Multiple endpoint shipping
- **Requires a collector** - You cannot ship to multiple destinations directly from the agent.
- The collector acts as a "fork" that receives data from the agent and distributes it to multiple destinations.
- Two collector options available:
    - **OTel Collector** - Standard OpenTelemetry collector
    - **Alloy** - Grafana's collector with enhanced features

## Configuration methods

### Method 1: Direct shipping to a **single** endpoint

#### Shipping ALL signals to one endpoint

Use this method when you want to ship to one destination only.

**Datadog**

```bash
# Example: Ship everything to Datadog
OTEL_OPTS="$OTEL_OPTS -Dotel.exporter.otlp.endpoint=https://datadoghq.eu"
OTEL_OPTS="$OTEL_OPTS -Dotel.exporter.otlp.headers=DD-API-KEY=${DD_API_KEY}"
OTEL_OPTS="$OTEL_OPTS -Dotel.exporter.otlp.protocol=http/protobuf"
```
**New Relic**


```bash
# Example: Ship everything to New Relic
OTEL_OPTS="$OTEL_OPTS -Dotel.exporter.otlp.endpoint=https://otlp.eu01.nr-data.net:4318"
OTEL_OPTS="$OTEL_OPTS -Dotel.exporter.otlp.headers=api-key=${NEW_RELIC_KEY}"
```
**Dash0**

```bash
# Example: Ship everything to Dash0
OTEL_OPTS="$OTEL_OPTS -Dotel.exporter.otlp.endpoint=https://ingress.eu-west-1.aws.dash0.com:4317"
OTEL_OPTS="$OTEL_OPTS -Dotel.exporter.otlp.headers=Authorization=Bearer\ ${DASH0_TOKEN}"
```

**Grafana**

```bash
# Example: Ship everything to Grafana
OTEL_OPTS="$OTEL_OPTS -Dotel.exporter.otlp.metrics.endpoint=${GRAFANA_METRICS_ENDPOINT}"
OTEL_OPTS="$OTEL_OPTS -Dotel.exporter.otlp.traces.endpoint=${GRAFANA_TRACES_ENDPOINT}"
OTEL_OPTS="$OTEL_OPTS -Dotel.exporter.otlp.logs.endpoint=${GRAFANA_LOGS_ENDPOINT}"
OTEL_OPTS="$OTEL_OPTS -Dotel.exporter.otlp.headers=Authorization=Basic\ ${GRAFANA_USER}:${GRAFANA_PASSWORD}"
```
#### Shipping individual signals to different endpoints

You can configure metrics, traces, and logs to go to different destinations:

```bash
# Send metrics to one endpoint
OTEL_OPTS="$OTEL_OPTS -Dotel.exporter.otlp.metrics.endpoint=https://endpoint/v1/metrics"

# Send traces to another endpoint
OTEL_OPTS="$OTEL_OPTS -Dotel.exporter.otlp.traces.endpoint=https://endpoint/v1/traces"

# Send logs to yet another endpoint
OTEL_OPTS="$OTEL_OPTS -Dotel.exporter.otlp.log.endpoint=https://endpoint/v1/logs"
```

### Method 2: Shipping to a Collector (For multiple destinations)

When you need to send data to multiple destinations simultaneously, configure the agent to send to a local collector, then configure the collector to distribute the data.

#### Agent Configuration for Collector

The agent configuration is identical whether you're using an [OTel Collector](https://opentelemetry.io/docs/collector/) or [Alloy](https://grafana.com/docs/alloy/):

**Using gRPC (Port 4317)**

```bash
OTEL_OPTS="$OTEL_OPTS -Dotel.exporter.otlp.endpoint=http://localhost:4317"
OTEL_OPTS="$OTEL_OPTS -Dotel.exporter.otlp.protocol=grpc"
```

**Using HTTP (Port 4318)**

```bash
OTEL_OPTS="$OTEL_OPTS -Dotel.exporter.otlp.endpoint=http://localhost:4318"
OTEL_OPTS="$OTEL_OPTS -Dotel.exporter.otlp.protocol=http/protobuf"
```

#### OTel Collector configuration

The OpenTelemetry Collector is the standard collector from the OpenTelemetry project. It uses YAML configuration files and provides a straightforward way to receive, process, and export telemetry data.

Create a `collector.yaml` file:

```yaml
receivers:
  otlp:
    protocols:
      http:
        endpoint: "0.0.0.0:4318"
      grpc:
        endpoint: "0.0.0.0:4317"

processors:
  batch:
    send_batch_max_size: 100
    send_batch_size: 10
    timeout: 10s

exporters:
  # Datadog
  datadog/exporter:
    api:
      site: "datadoghq.eu"
      key: "${DD_API_KEY}"
    sending_queue:
      batch:

  # New Relic   
  otlphttp/newrelic:
    endpoint: "https://otlp.eu01.nr-data.net:4318"
    headers:
      api-key: "${NEW_RELIC_KEY}"

  # Dash0
  otlp/dash0:
    endpoint: "https://ingress.eu-west-1.aws.dash0.com:4317"
    headers:
      Authorization: "Bearer ${DASH0_TOKEN}"

  # FusionReactor Production
  otlphttp/fr/prod:
    endpoint: "https://api.fusionreactor.io"
    headers:
      Authorization: "${FR_PROD_API_KEY}"

  # Grafana
    otlphttp/grafana/metrics:
    endpoint: "${GRAFANA_METRICS_ENDPOINT}"
    headers:
      Authorization: "Basic ${GRAFANA_USER}:${GRAFANA_PASSWORD}"
  otlphttp/grafana/traces:
    endpoint: "${GRAFANA_TRACES_ENDPOINT}"
    headers:
      Authorization: "Basic ${GRAFANA_USER}:${GRAFANA_PASSWORD}"
  otlphttp/grafana/logs:
    endpoint: "${GRAFANA_LOGS_ENDPOINT}"
    headers:
      Authorization: "Basic ${GRAFANA_USER}:${GRAFANA_PASSWORD}"


service:
  pipelines:
    metrics:
      receivers: [datadog/connector, otlp]
      processors: [batch]
      exporters: [datadog/exporter, otlphttp/newrelic, otlp/dash0, otlphttp/fr/prod, otlphttp/grafana/metrics]
    traces:
      receivers: [otlp]
      processors: [batch]
      exporters: [datadog/exporter, otlphttp/newrelic, otlp/dash0, otlphttp/fr/prod, otlphttp/grafana/metrics]
    logs:
      receivers: [otlp]
      processors: [batch]
      exporters: [datadog/exporter, otlphttp/newrelic, otlp/dash0, otlphttp/fr/prod, otlphttp/grafana/logs]
```
!!! tip
    **Customizing Pipelines**: Remove exporters from specific pipelines if you don't want certain signals sent to all destinations. For example, to exclude traces from Dash0, remove `otlp/dash0` from the traces pipeline.

!!! info "Learn more"
    [OTel Collector Documentation](https://opentelemetry.io/docs/collector/)

#### Alloy Collector configuration

Alloy is Grafana's distribution of the OpenTelemetry Collector with additional features and capabilities. It uses HCL (HashiCorp Configuration Language) syntax instead of YAML and offers advanced data processing features like relabeling, filtering, and transformation.

Create a `collector.alloy` file:

```hcl
// OTLP Receiver
otelcol.receiver.otlp "default" {
  grpc {
    endpoint = "0.0.0.0:4317"
  }

  http {
    endpoint = "0.0.0.0:4318"
  }

  output {
    metrics = [otelcol.processor.batch.default.input]
    traces  = [otelcol.processor.batch.default.input]
    logs    = [otelcol.processor.batch.default.input]
  }
}

// Batch Processor
otelcol.processor.batch "default" {
  timeout             = "10s"
  send_batch_size     = 10
  send_batch_max_size = 100

  output {
    metrics = [
      otelcol.exporter.datadog.default.input,
      otelcol.exporter.otlphttp.newrelic.input,
      otelcol.exporter.otlp.dash0.input,
      otelcol.exporter.otlphttp.fr_prod.input,
      otelcol.exporter.otlphttp.grafana_metrics.input,
    ]
    traces = [
      otelcol.exporter.datadog.default.input,
      otelcol.exporter.otlphttp.newrelic.input,
      otelcol.exporter.otlp.dash0.input,
      otelcol.exporter.otlphttp.fr_prod.input,
      otelcol.exporter.otlphttp.grafana_traces.input,

    ]
    logs = [
      otelcol.exporter.datadog.default.input,
      otelcol.exporter.otlphttp.newrelic.input,
      otelcol.exporter.otlp.dash0.input,
      otelcol.exporter.otlphttp.fr_prod.input,
      otelcol.exporter.otlphttp.grafana_logs.input,
    ]
  }
}

// Datadog Exporter
otelcol.exporter.datadog "default" {
  api {
    site = "datadoghq.eu"
    key  = env("DD_API_KEY")
  }

  sending_queue {
   enabled = true
  }
}

// New Relic Exporter
otelcol.exporter.otlphttp "newrelic" {
  client {
    endpoint = "https://otlp.eu01.nr-data.net:4318"
    headers = {
      "api-key" = env("NEW_RELIC_KEY"),
    }
  }
}

// Dash0 Exporter
otelcol.exporter.otlp "dash0" {
  client {
    endpoint = "ingress.eu-west-1.aws.dash0.com:4317"
    headers = {
      "Authorization" = "Bearer " + env("DASH0_TOKEN"),
    }
  }
}

// FusionReactor Production Exporter
otelcol.exporter.otlphttp "fr_prod" {
  client {
    endpoint = "https://api.fusionreactor.io"
    headers = {
      "Authorization" = env("FR_PROD_API_KEY"),
    }
  }
}

// Grafana Metrics Exporter
otelcol.exporter.otlphttp "grafana_metrics" {
  client {
    endpoint = env("GRAFANA_METRICS_ENDPOINT")
    headers = {
      "Authorization" = "Basic " + env("GRAFANA_USER") + ":" + env("GRAFANA_PASSWORD"),
    }
  }
}

// Grafana Traces Exporter
otelcol.exporter.otlphttp "grafana_traces" {
  client {
    endpoint = env("GRAFANA_TRACES_ENDPOINT")
    headers = {
      "Authorization" = "Basic " + env("GRAFANA_USER") + ":" + env("GRAFANA_PASSWORD"),
    }
  }
}

// Grafana Logs Exporter
otelcol.exporter.otlphttp "grafana_logs" {
  client {
    endpoint = env("GRAFANA_LOGS_ENDPOINT")
    headers = {
      "Authorization" = "Basic " + env("GRAFANA_USER") + ":" + env("GRAFANA_PASSWORD"),
    }
  }
}
```

!!! info "Learn more"
    [Grafana Alloy Documentation](https://grafana.com/docs/alloy/)

## Resource Attributes

Resource attributes provide metadata about your application and environment. These attributes are attached to all telemetry data (metrics, traces, and logs) and help you identify and filter data in your observability platform.

### Enabling OTel Resource Attributes

To enable OpenTelemetry resource attributes in FusionReactor:

```bash
OTEL_OPTS="$OTEL_OPTS -Dfr.observability.otel.resource.enabled=true"
```

### Configuring Resource Attributes

You can set custom resource attributes to identify your service:

```bash
OTEL_OPTS="$OTEL_OPTS -Dotel.resource.attributes=service.name=my-app,service.version=1.0.0,deployment.environment=production"
```

### Example configuration

```bash
# Enable OTel resources
OTEL_OPTS="$OTEL_OPTS -Dfr.observability.otel.resource.enabled=true"

# Set resource attributes
OTEL_OPTS="$OTEL_OPTS -Dotel.resource.attributes=service.name=tc91,service.version=1.0.9,deployment.environment=prod"
```

## Disabling signals

You can disable individual signals (metrics, traces, or logs) by setting their exporter to `NONE`:

```bash
# Disable metrics
OTEL_OPTS="$OTEL_OPTS -Dotel.metrics.exporter=NONE"

# Disable traces
OTEL_OPTS="$OTEL_OPTS -Dotel.traces.exporter=NONE"

# Disable logs
OTEL_OPTS="$OTEL_OPTS -Dotel.logs.exporter=NONE"
```

## Security best practices

**Always use environment variables for API keys and authentication tokens.** Never hardcode credentials in configuration files.

```bash
# Good - Using environment variables
OTEL_OPTS="$OTEL_OPTS -Dotel.exporter.otlp.headers=api-key=${NEW_RELIC_KEY}"

# Bad - Hardcoding credentials
OTEL_OPTS="$OTEL_OPTS -Dotel.exporter.otlp.headers=api-key=abc123xyz"
```


## Troubleshooting

#### Verifying Configuration

- Check the [Cloud Status](https://docs.fusionreactor.io/Monitor-your-data/FR-Agent/Agent/Cloud-Status/) page in the FusionReactor UI to verify if OTel shipping settings have been applied and if shipping is successful
- Review the agent startup logs for any configuration errors or warnings

#### Data not appearing
- Verify your endpoint URL is correct.
- Check authentication credentials are set correctly via environment variables.
- Ensure the protocol matches the endpoint (gRPC uses 4317, HTTP uses 4318).
- Check collector logs if using a collector configuration.

#### Connection errors
- Verify network connectivity to the endpoint.
- Check firewall rules allow outbound connections on the required ports.
- Ensure the endpoint supports the protocol you've configured (gRPC or HTTP).

#### Authentication failures
- Verify API keys/tokens are valid and not expired.
- Check the header format matches the provider's requirements.
- Ensure environment variables are set and accessible.

## Additional resources

- [OpenTelemetry Documentation](https://opentelemetry.io/docs/)
- [OpenTelemetry Collector Documentation](https://opentelemetry.io/docs/collector/)
- [Grafana Alloy Documentation](https://grafana.com/docs/alloy/)