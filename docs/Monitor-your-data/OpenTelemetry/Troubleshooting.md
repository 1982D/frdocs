# OpenTelemetry Troubleshooting

This guide helps you diagnose and resolve common issues when using OpenTelemetry with OpsPilot.

---

## Quick Diagnostics

Before diving into specific issues, run these quick checks:

1. **Verify your telemetry pipeline is running** (Collector or Grafana Alloy)
2. **Check pipeline logs** for errors or warnings
3. **Verify application instrumentation** by checking startup logs for OpenTelemetry initialization messages
4. **Test sending synthetic data** to isolate whether the issue is with your application or pipeline

---

## Data Not Appearing in OpsPilot

### Symptom
You've instrumented your application and configured your telemetry pipeline, but data doesn't appear in OpsPilot.

### Diagnostic Steps

#### 1. Verify your pipeline is receiving data

Enable debug logging in your pipeline configuration to see if telemetry is being received:

**OpenTelemetry Collector:**
```yaml
exporters:
  debug:
    verbosity: detailed
    sampling_initial: 5
    sampling_thereafter: 200

service:
  pipelines:
    traces:
      receivers: [otlp]
      processors: [memory_limiter, batch]
      exporters: [otlphttp/fusionreactor, debug]  # Add debug exporter
```

**Grafana Alloy:**
```alloy
otelcol.exporter.debug "default" {
  verbosity = "detailed"
}
```

Restart your pipeline and examine the logs for entries showing received spans, metrics, or logs.

**If you don't see data in the logs**: The problem is between your application and the pipeline. See [Pipeline Not Receiving Data](#pipeline-not-receiving-data).

#### 2. Verify your pipeline is exporting data

Check your pipeline logs for export errors. Look for keywords like:

* `error`, `failed`, `refused`
* `unauthorized`, `401`, `403`
* `timeout`, `deadline exceeded`

**Common error patterns:**

* **"connection refused"**: Pipeline cannot reach OpsPilot (network issue)
* **"unauthorized"** or **"401"**: Invalid API key
* **"timeout"**: Network latency or connectivity issue

#### 3. Test with synthetic data

Send test traces to verify your pipeline is working correctly:

```bash
# Using telemetrygen (works with any pipeline)
docker run --network host \
  ghcr.io/open-telemetry/opentelemetry-collector-contrib/telemetrygen:latest \
  traces --traces 100 \
  --otlp-endpoint localhost:4317 \
  --otlp-insecure
```

Check OpsPilot (**Explore > Traces**) for a service named `telemetrygen` within 60 seconds.

**If test data appears**: Your pipeline is working correctly. The issue is with your application instrumentation.

**If test data doesn't appear**: The issue is with your pipeline configuration or network connectivity.

### Solutions

#### API Key Issues

Verify your API key is configured correctly in your pipeline:

**OpenTelemetry Collector:**
```yaml
exporters:
  otlphttp/fusionreactor:
    endpoint: "https://api.fusionreactor.io"
    headers:
      authorization: "${FR_API_KEY}"  # Check this is set
```

**Grafana Alloy:**
```alloy
otelcol.exporter.otlphttp "fusionreactor" {
  client {
    endpoint = "https://api.fusionreactor.io"
    headers = {
      authorization = env("FR_API_KEY")  # Check this is set
    }
  }
}
```

To get your API key:
1. Log in to **OpsPilot**
2. Navigate to **User Menu > Account > API Keys**
3. Generate a new key or copy an existing one

#### Network Connectivity

Test connectivity to OpsPilot from your pipeline environment:

```bash
# Test basic connectivity
curl -v https://api.fusionreactor.io

# Test OTLP endpoint (should return 405 Method Not Allowed, which is expected)
curl -v -X POST https://api.fusionreactor.io/v1/traces
```

**Common network issues:**
* **Firewall blocking outbound HTTPS**: Allow traffic to `api.fusionreactor.io` on port 443
* **Proxy required**: Configure proxy in your pipeline config
* **DNS resolution failure**: Verify DNS can resolve `api.fusionreactor.io`

**Proxy configuration example (OpenTelemetry Collector):**

```yaml
exporters:
  otlphttp/fusionreactor:
    endpoint: "https://api.fusionreactor.io"
    headers:
      authorization: "${FR_API_KEY}"
    proxy_url: "http://your-proxy:8080"
```

#### Application Endpoint Configuration

Verify your application is sending data to the correct pipeline endpoint:

**Python:**
```python
# For HTTP (default port 4318)
endpoint = "http://localhost:4318"

# For gRPC (default port 4317)
endpoint = "http://localhost:4317"
```

**Environment Variables (works for many languages):**
```bash
export OTEL_EXPORTER_OTLP_ENDPOINT=http://localhost:4318
export OTEL_EXPORTER_OTLP_PROTOCOL=http/protobuf
```

**If running in containers**: Use the pipeline service name instead of `localhost`:

```yaml
services:
  app:
    environment:
      - OTEL_EXPORTER_OTLP_ENDPOINT=http://otel-collector:4318
```

---

## Pipeline Not Receiving Data

### Symptom
Your application logs show telemetry being sent, but your pipeline logs don't show any received data.

### Diagnostic Steps

#### 1. Verify the pipeline is listening on the correct ports

Check that your receiver is configured to listen on the expected endpoints:

**OpenTelemetry Collector:**
```yaml
receivers:
  otlp:
    protocols:
      grpc:
        endpoint: "0.0.0.0:4317"  # Listen on all interfaces
      http:
        endpoint: "0.0.0.0:4318"
```

!!! warning "Avoid 127.0.0.1"
    Using `127.0.0.1` instead of `0.0.0.0` will prevent connections from containers or remote hosts.

#### 2. Verify the receiver is enabled in the pipeline

Ensure receivers are listed in service pipelines:

```yaml
service:
  pipelines:
    traces:
      receivers: [otlp]  # Must be included
      processors: [memory_limiter, batch]
      exporters: [otlphttp/fusionreactor]
```

#### 3. Check for port conflicts

Verify nothing else is using the required ports. The method depends on your environment:

**Linux/macOS:**
```bash
# Check if ports are in use
lsof -i :4317
lsof -i :4318
```

**Windows:**
```powershell
netstat -ano | findstr :4317
netstat -ano | findstr :4318
```

### Solutions

#### Port Configuration

If ports are in use by another process, either:
* Stop the conflicting process
* Use different ports in both pipeline and application configs

**Example with custom ports:**

```yaml
# Pipeline config
receivers:
  otlp:
    protocols:
      http:
        endpoint: "0.0.0.0:14318"  # Custom port
```

```python
# Application config
endpoint = "http://localhost:14318"
```

#### Network Connectivity Between Application and Pipeline

If your application and pipeline are in different network contexts (containers, VMs, etc.), ensure they can communicate:

**Test connectivity:**
```bash
# From application environment, test pipeline endpoint
nc -zv pipeline-host 4318
# or
curl http://pipeline-host:4318
```

**Docker Compose example** (shared network):
```yaml
services:
  otel-collector:
    networks:
      - app-network

  your-app:
    environment:
      - OTEL_EXPORTER_OTLP_ENDPOINT=http://otel-collector:4318
    networks:
      - app-network  # Must be same network

networks:
  app-network:
```

---

## Configuration Errors

### Symptom
Pipeline fails to start, crashes immediately, or logs show configuration errors.

### Common Configuration Issues

#### 1. Invalid YAML Syntax

**Error message:**
```
error decoding 'receivers': yaml: line X: mapping values are not allowed in this context
```

**Cause**: YAML indentation or syntax error.

**Solution**: Use a YAML validator (like [yamllint.com](https://www.yamllint.com/)) and ensure proper indentation:

```yaml
# ❌ Wrong - inconsistent indentation
receivers:
  otlp:
  protocols:
    grpc:

# ✅ Correct - consistent 2-space indentation
receivers:
  otlp:
    protocols:
      grpc:
        endpoint: "0.0.0.0:4317"
```

#### 2. Null/Empty Configuration Values

**Error message:**
```
error decoding 'processors': yaml: null map
```

**Cause**: Using bare colons for empty values.

**Solution**: Use empty braces `{}` instead:

```yaml
# ❌ Wrong
processors:
  batch:

# ✅ Correct
processors:
  batch: {}
```

#### 3. Missing Environment Variables

**Error message:**
```
authorization header cannot be empty
```

**Cause**: Required environment variable (like `FR_API_KEY`) is not set or not accessible to the pipeline.

**Solution**: Ensure environment variables are set and accessible:

```bash
# Set environment variable
export FR_API_KEY=your-api-key-here

# Verify it's set
echo $FR_API_KEY

# Start your pipeline
./otelcol --config=config.yaml
```

#### 4. Component Not Found

**Error message:**
```
error: unknown receiver type "otlp"
```

**Cause**: Using a component not available in your distribution.

**Solution**:
* Ensure you're using the correct distribution (e.g., `otel/opentelemetry-collector-contrib` for additional components)
* Check component is available in your version
* Review the [OpenTelemetry Registry](https://opentelemetry.io/ecosystem/registry/)

---

## Application Instrumentation Issues

### Python: No Telemetry Generated

#### Symptom
Python application runs without errors, but no telemetry is sent.

#### Diagnostic Steps

1. **Enable debug logging**:
   ```python
   import logging
   logging.basicConfig(level=logging.DEBUG)
   # Look for OpenTelemetry initialization messages
   ```

2. **Verify providers are configured**:
   ```python
   from opentelemetry import trace, metrics

   tracer_provider = trace.get_tracer_provider()
   meter_provider = metrics.get_meter_provider()

   print(f"Tracer provider: {tracer_provider}")
   print(f"Meter provider: {meter_provider}")
   ```

#### Common Causes

**Cause 1: Late initialization**
* OpenTelemetry initialized after frameworks/libraries loaded
* **Solution**: Move initialization to the very top of your entry point file, before any other imports

**Cause 2: Mismatched exporter and endpoint**
* Using HTTP endpoint with gRPC exporter (or vice versa)
* **Solution**: Match exporter type to endpoint

```python
# For HTTP (port 4318)
from opentelemetry.exporter.otlp.proto.http.trace_exporter import OTLPSpanExporter
exporter = OTLPSpanExporter(endpoint="http://localhost:4318/v1/traces")

# For gRPC (port 4317)
from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter
exporter = OTLPSpanExporter(endpoint="http://localhost:4317")
```

**Cause 3: No instrumented operations**
* Application code doesn't trigger instrumented operations (HTTP requests, database calls, etc.)
* **Solution**: Verify your code includes operations that automatic instrumentation captures, or create manual spans

### Node.js: Module Not Found Errors

#### Symptom
```
Error: Cannot find module '@opentelemetry/sdk-node'
```

#### Solution

Install required dependencies:

```bash
npm install @opentelemetry/sdk-node \
  @opentelemetry/auto-instrumentations-node \
  @opentelemetry/exporter-trace-otlp-http
```

### Go: Spans Not Exported

#### Symptom
Go application creates spans, but they're never sent to the pipeline.

#### Cause
Missing `Shutdown()` call on tracer provider, so spans remain in buffer.

#### Solution

Always defer shutdown to flush remaining spans:

```go
func main() {
    tp, err := initTracer()
    if err != nil {
        log.Fatal(err)
    }
    defer func() {
        ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
        defer cancel()
        if err := tp.Shutdown(ctx); err != nil {
            log.Printf("Error shutting down tracer: %v", err)
        }
    }()

    // Your application code
}
```

---

## Performance Issues

### High Memory Usage

#### Symptom
Pipeline uses excessive memory or crashes with out-of-memory errors.

#### Solutions

1. **Configure memory limiter** (OpenTelemetry Collector):
   ```yaml
   processors:
     memory_limiter:
       check_interval: 1s
       limit_percentage: 75
       spike_limit_percentage: 15
   ```

2. **Reduce batch sizes**:
   ```yaml
   processors:
     batch:
       timeout: 1s
       send_batch_size: 512  # Reduced from default 8192
   ```

3. **Increase available memory** (if running in containers):
   ```yaml
   services:
     otel-collector:
       deploy:
         resources:
           limits:
             memory: 1G
   ```

### High CPU Usage

#### Symptom
Pipeline consumes excessive CPU.

#### Solutions

1. **Reduce telemetry volume at source**:
   * Implement sampling in applications
   * Filter unnecessary instrumentation

2. **Optimize batch configuration**:
   ```yaml
   processors:
     batch:
       timeout: 10s  # Increase batch window (fewer exports)
       send_batch_size: 2048  # Increase batch size
   ```

3. **Use gRPC instead of HTTP**:
   gRPC is more CPU-efficient for high-throughput scenarios

### Slow Data Ingestion

#### Symptom
Telemetry data takes several minutes to appear in OpsPilot.

#### Causes & Solutions

**Cause 1: Large batch timeout**
```yaml
processors:
  batch:
    timeout: 60s  # Too long - data waits 60s before export
```
**Solution**: Reduce timeout to 1-5 seconds for faster data delivery

**Cause 2: Network latency**
* Test latency: `ping api.fusionreactor.io`
* Consider deploying pipeline closer to applications or OpsPilot

**Cause 3: Exporter queue backlog**
```yaml
exporters:
  otlphttp/fusionreactor:
    sending_queue:
      enabled: true
      queue_size: 1000  # Increase if needed
```

---

## Data Quality Issues

### Missing Spans or Incomplete Traces

#### Symptom
Traces appear fragmented or missing expected spans.

#### Causes & Solutions

**Cause 1: Aggressive sampling**
* Probabilistic sampling drops spans randomly
* **Solution**: Review and adjust sampling configuration, or use tail sampling to keep complete traces

**Cause 2: Context propagation failure**
* Spans created but not linked to parent trace
* **Solution**: Ensure HTTP headers include trace context (W3C Trace Context format)

**Cause 3: Asynchronous operations not instrumented**
* Background tasks create separate, unlinked traces
* **Solution**: Manually propagate context to async functions:

```python
from opentelemetry import context, trace

def background_task():
    # Attach parent context
    token = context.attach(parent_context)
    try:
        with tracer.start_as_current_span("background-work"):
            # Work here
            pass
    finally:
        context.detach(token)
```

### Duplicate Metrics or Traces

#### Symptom
Same telemetry appears multiple times in OpsPilot.

#### Causes & Solutions

**Cause 1: Multiple exporters in application**
* Application configured to send to both pipeline and OpsPilot directly
* **Solution**: Send only to your pipeline, let it forward to OpsPilot

**Cause 2: Multiple pipeline instances**
* Duplicate pipelines ingesting same data
* **Solution**: Check for multiple running instances and stop duplicates

---

## Debugging Tools

### Enable Pipeline Debug Logging

**OpenTelemetry Collector:**

```yaml
exporters:
  debug:
    verbosity: detailed
    sampling_initial: 5
    sampling_thereafter: 200

service:
  telemetry:
    logs:
      level: debug
  pipelines:
    traces:
      receivers: [otlp]
      processors: [memory_limiter, batch]
      exporters: [otlphttp/fusionreactor, debug]
```

### Use Extensions for Live Debugging

**zPages Extension** (OpenTelemetry Collector):

```yaml
extensions:
  zpages:
    endpoint: "0.0.0.0:55679"

service:
  extensions: [zpages]
```

Access at: `http://localhost:55679/debug/tracez`

**What you can see:**
* Active spans being processed
* Latency statistics
* Error rates
* Exporter queue status

### Monitor Internal Telemetry

**OpenTelemetry Collector:**

```yaml
service:
  telemetry:
    metrics:
      address: "0.0.0.0:8888"
```

Access metrics at: `http://localhost:8888/metrics`

**Key metrics to monitor:**
* `otelcol_receiver_accepted_spans`: Spans received
* `otelcol_exporter_sent_spans`: Spans exported successfully
* `otelcol_exporter_send_failed_spans`: Export failures
* `otelcol_processor_dropped_spans`: Spans dropped by processors

---

## Common Error Messages

### "connection refused"

**Full error:**
```
failed to export: connection refused
```

**Cause**: Pipeline cannot reach OpsPilot endpoint.

**Solution**:
1. Verify endpoint URL in exporter config
2. Check network connectivity: `curl https://api.fusionreactor.io`
3. Review firewall rules allowing outbound HTTPS

### "context deadline exceeded"

**Full error:**
```
failed to export: rpc error: code = DeadlineExceeded desc = context deadline exceeded
```

**Cause**: Export request timed out.

**Solution**:
1. Increase timeout in exporter config:
   ```yaml
   exporters:
     otlphttp/fusionreactor:
       timeout: 30s  # Increase from default
   ```
2. Check network latency to `api.fusionreactor.io`
3. Reduce batch size to send smaller payloads

### "unauthorized" or "401"

**Full error:**
```
failed to export: 401 Unauthorized
```

**Cause**: Invalid or missing API key.

**Solution**:
1. Verify API key in OpsPilot: **User Menu > Account > API Keys**
2. Check API key is correctly set in your pipeline configuration
3. Ensure no extra spaces or characters in the API key

### "bad request" or "400"

**Full error:**
```
failed to export: 400 Bad Request
```

**Cause**: Malformed telemetry data or incorrect protocol.

**Solution**:
1. Verify you're using OTLP protocol (not Prometheus, Zipkin, etc.)
2. Check endpoint URL includes protocol version (e.g., `/v1/traces`)
3. Enable debug exporter to inspect data format

---

## Getting Help

### Collect Diagnostic Information

When contacting support, provide:

1. **Pipeline configuration** (redact API keys)
2. **Pipeline logs** showing the error
3. **Application instrumentation code** (initialization section)
4. **OpenTelemetry SDK versions** used
5. **OpsPilot account region** (US or EU)

### Contact Support

* **FusionReactor Support**: Use the chat bubble in OpsPilot
* **Community Forum**: [FusionReactor Community](https://community.fusionreactor.io/)

### Additional Resources

---

## Related Guides

- **[OpenTelemetry Collector Setup](/Monitor-your-data/OpenTelemetry/Shipping/Collector/)**: Initial collector configuration and setup
- **[Grafana Alloy Setup](/Monitor-your-data/OpenTelemetry/Shipping/Grafana-agent/)**: Alternative telemetry pipeline configuration
- **[Configuration Guide](/Monitor-your-data/OpenTelemetry/Configuration/)**: Semantic conventions, resource attributes, and sampling strategies
- **[Instrumentation Overview](/Monitor-your-data/OpenTelemetry/Instrumentation/Overview/)**: Language-specific instrumentation guides
- **[FAQ](/Monitor-your-data/OpenTelemetry/FAQ/)**: Common questions and best practices

---

## Additional Resources

* [OpenTelemetry Collector Troubleshooting](https://opentelemetry.io/docs/collector/troubleshooting/)
* [Grafana Alloy Troubleshooting](https://grafana.com/docs/alloy/latest/troubleshoot/)

---

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.
