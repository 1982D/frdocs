# Shipping with Grafana Alloy

Grafana Alloy is a vendor-neutral distribution of the OpenTelemetry Collector. It natively supports OpenTelemetry, Prometheus, and Loki formats within a single agent, making it highly versatile.

For FusionReactor users, Alloy is recommended when you need a highly programmable telemetry pipeline using **Alloy Flow** or a **visual dashboard** to monitor your data pipeline's health in real-time.

## How it works

Alloy acts as a programmable intermediary. It receives OTLP data from your instrumented applications, processes it for efficiency or security, and exports it to OpsPilot using the OTLP protocol.



### Prerequisites

* **FusionReactor API Key**: Obtain this from **Account Settings > API Keys**.
* **Docker Desktop**: Ensure Docker is installed and running.
* **Port Availability**: Ensure ports **4317**, **4318**, and **12345** are not in use by other services (like a standard OTel Collector).

### **Step 1**: Create `config.alloy`

Alloy uses a "Flow" configuration (HCL). Create a file named `config.alloy` and paste the following:

```hcl
// 1. Receive OTLP data from your apps (gRPC and HTTP)
otelcol.receiver.otlp "default" {
  grpc { endpoint = "0.0.0.0:4317" }
  http { endpoint = "0.0.0.0:4318" }

  output {
    metrics = [otelcol.processor.batch.default.input]
    traces  = [otelcol.processor.batch.default.input]
    logs    = [otelcol.processor.batch.default.input]
  }
}

// 2. Batch data for network efficiency
otelcol.processor.batch "default" {
  output {
    metrics = [otelcol.exporter.otlphttp.fusionreactor.input]
    traces  = [otelcol.exporter.otlphttp.fusionreactor.input]
    logs    = [otelcol.exporter.otlphttp.fusionreactor.input]
  }
}

// 3. Export data to OpsPilot
otelcol.exporter.otlphttp "fusionreactor" {
  client {
    endpoint = "https://api.fusionreactor.io"
    headers = {
      "authorization" = sys.env("FR_API_KEY"),
    }
  }
}

```

### **Step 2**: Deploy with Docker

The most reliable way to run Alloy is via Docker Compose. This method allows you to securely inject your API key as an environment variable.

**Create a `docker-compose.yml`:**

```yaml
services:
  alloy:
    image: grafana/alloy:latest
    container_name: fusionreactor-alloy
    restart: unless-stopped
    environment:
      - FR_API_KEY=${FR_API_KEY}  # Set this in your environment or .env file
    ports:
      - "4317:4317"   # OTLP gRPC
      - "4318:4318"   # OTLP HTTP
      - "12345:12345" # Alloy UI Dashboard
    volumes:
      - ./config.alloy:/etc/alloy/config.alloy
    command: [
      "run",
      "--server.http.listen-addr=0.0.0.0:12345",
      "/etc/alloy/config.alloy"
    ]

```

### **Step 3**: Verify Your Pipeline

1. **Start Alloy**: Run `docker-compose up -d` in your terminal.
2. **Access the UI**: Open your browser to `http://localhost:12345` to see a live graph of your pipeline.
3. **Send a Test Signal**: Use the `telemetrygen` utility to confirm data is reaching FusionReactor:
```bash
docker run --network host ghcr.io/open-telemetry/opentelemetry-collector-contrib/telemetrygen:latest traces --traces 100 --otlp-endpoint localhost:4317 --otlp-insecure

```


## Why use Alloy over the standard Collector?

* **Native Prometheus Support**: If you have existing Prometheus scraping jobs, Alloy handles them more natively than the standard OTel Collector.
* **Modular Configuration**: The "Flow" syntax is component-based (similar to Terraform), making it easier to scale and debug complex data routes.
* **Visual Troubleshooting**: The built-in UI allows you to see the health of every component and Live Tail telemetry as it moves through the system.

!!! question "Need more help?"
    Contact support in the chat bubble or check out the [Grafana Alloy Concepts](https://grafana.com/docs/alloy/latest/concepts/) and [OpenTelemetry OTLP Exporter](https://opentelemetry.io/docs/specs/otel/protocol/exporter/) documentation.

