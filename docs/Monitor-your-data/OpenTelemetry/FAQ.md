# OpenTelemetry FAQ

This page answers frequently asked questions about using OpenTelemetry with OpsPilot.

---

## Getting Started

### What is OpenTelemetry and why should I use it?

OpenTelemetry (OTel) is an industry-standard, open-source observability framework that provides a unified way to collect metrics, traces, and logs from your applications. By using OpenTelemetry, you:

* **Avoid vendor lock-in**: Instrument once and send data to any backend
* **Gain standardized observability**: Use consistent APIs and conventions across all services
* **Future-proof your monitoring**: Adopt the industry standard supported by all major observability platforms

### Should I start with automatic or manual instrumentation?

**Start with automatic (zero-code) instrumentation.** It provides broad coverage across common use cases without modifying your source code. Automatic instrumentation captures:

* HTTP requests and responses
* Database queries
* External API calls
* Framework-specific operations

Add manual instrumentation later only when you need to:

* Capture custom business logic
* Track specific events unique to your application
* Add custom attributes for domain-specific analysis

### Do I need an OpenTelemetry Collector?

**Yes, for production environments.** The OpenTelemetry Collector provides essential capabilities:

* **Performance**: Batching and compression reduce network overhead
* **Security**: Centralized secret management keeps API keys out of application configs
* **Data transformation**: Filter, enrich, or scrub sensitive data before it leaves your network
* **Reliability**: Queue and retry mechanisms handle network failures gracefully

For local development and testing, you can send data directly to OpsPilot using OTLP endpoints.

### When should I initialize OpenTelemetry in my application?

Initialize OpenTelemetry **at the very start of your application**, before loading any libraries or frameworks you want to instrument. Late initialization means you'll miss telemetry from libraries that execute during startup.

**Example order:**
1. Application starts
2. OpenTelemetry SDK initialized
3. Frameworks and libraries loaded (now instrumented)
4. Application runs

---

## Instrumentation

### What's the difference between spans, traces, and transactions?

* **Span**: A single unit of work with a start time and duration (e.g., a database query, HTTP request)
* **Trace**: A collection of spans linked together under a unique trace ID, representing a complete request flow through your system
* **Transaction**: FusionReactor's term for a top-level operation, typically mapped to a trace's root span

### How do I see my service name in OpsPilot?

The OpenTelemetry `service.name` resource attribute becomes the `job` label in OpsPilot.

**Set it during initialization:**

```python
# Python example
resource = Resource.create(
    attributes={ResourceAttributes.SERVICE_NAME: 'my-api-service'}
)
```

You'll then query your data using:
```
job="my-api-service"
```

For comprehensive guidance on resource attributes and service naming best practices, see the [Configuration guide](/Monitor-your-data/OpenTelemetry/Configuration/#resource-attributes).

### Can I use both the FusionReactor Agent and OpenTelemetry instrumentation?

Yes. You can run both simultaneously:

* **FusionReactor Agent**: Provides deep JVM/CFML insights, profiling, and error tracking
* **OpenTelemetry**: Captures distributed traces, custom metrics, and standardized telemetry

They complement each other and send data to OpsPilot independently.

### What should I include in span attributes?

Include attributes **relevant to the span's operation**:

✅ **Good attributes:**
* `http.method`, `http.url`, `http.status_code`
* `db.system`, `db.statement`, `db.name`
* Custom business IDs: `order.id`, `user.id`, `transaction.type`

❌ **Avoid:**
* Redundant data already captured by OpenTelemetry conventions
* High-cardinality values (e.g., full SQL queries with literals)
* Sensitive information (passwords, tokens, PII)

Follow [OpenTelemetry Semantic Conventions](https://opentelemetry.io/docs/concepts/semantic-conventions/) for consistency. For more details, see the [Configuration guide](/Monitor-your-data/OpenTelemetry/Configuration/#semantic-conventions).

---

## Data Collection & Shipping

### What's the difference between OTLP gRPC and HTTP?

Both protocols send telemetry data to OpsPilot, but they have different characteristics:

| Feature | gRPC (port 4317) | HTTP (port 4318) |
|---------|------------------|------------------|
| **Performance** | Faster, lower latency | Slightly slower |
| **Compatibility** | May be blocked by firewalls | Better firewall compatibility |
| **Use case** | High-throughput environments | Networks with strict firewall rules |

**Recommendation**: Start with gRPC. Switch to HTTP if you encounter network connectivity issues.

### How does batching affect my telemetry data?

Batching groups multiple telemetry records before sending them over the network. This:

* **Reduces network overhead**: Fewer connections, better throughput
* **Improves reliability**: More efficient use of export queues
* **Adds minimal latency**: Typically milliseconds, negligible for most applications

Configure batching in your Collector:

```yaml
processors:
  batch:
    timeout: 1s        # Send batch every second
    send_batch_size: 1024  # Or when 1024 spans collected
```

### Why is my data not appearing in OpsPilot?

Common causes:

1. **Collector not running**: Check `docker ps` or your deployment logs
2. **Wrong API key**: Verify `FR_API_KEY` in your Collector config
3. **Network issues**: Ensure Collector can reach `https://api.fusionreactor.io`
4. **Application not sending data**: Check application logs for instrumentation errors
5. **Sampling dropped the data**: Review your sampling configuration

See the [Troubleshooting](/Monitor-your-data/OpenTelemetry/Troubleshooting/) page for detailed debugging steps.

---

## Configuration

### What's the memory limiter and why do I need it?

The `memory_limiter` processor prevents the OpenTelemetry Collector from crashing during data spikes. It monitors memory usage and applies backpressure when limits are approached.

**Example configuration:**

```yaml
processors:
  memory_limiter:
    check_interval: 1s           # Check memory every second
    limit_percentage: 75         # Start refusing data at 75% memory
    spike_limit_percentage: 15   # Allow 15% spike above limit
```

Without this processor, sudden traffic increases can exhaust Collector memory and cause crashes.

### Should I use context propagation or baggage?

**Context propagation** (automatic in most cases):
* Passes trace ID and span ID between services
* Enables distributed tracing
* Handled automatically by OpenTelemetry SDKs

**Baggage** (manual, use sparingly):
* Propagates custom key-value pairs across service boundaries
* Useful when downstream services need data only available upstream
* Adds overhead to every request

**Recommendation**: Let instrumentation handle propagation automatically. Use baggage only for specific cross-service data sharing needs.

### What sampling strategy should I use?

Sampling reduces costs by collecting a subset of traces. Common strategies:

**Head sampling** (decides at trace start):
* **Always on**: Captures everything (development only)
* **Probabilistic**: Sample X% of traces (e.g., 10%)
* **Rate limiting**: Cap at N traces per second

**Tail sampling** (decides after trace completes):
* Keep all errors
* Keep slow traces (e.g., > 2 seconds)
* Sample fast, successful requests at lower rate

**Recommendation for production**:
* Start with probabilistic head sampling (10-25%)
* Add tail sampling rules to always keep errors and slow traces
* Adjust sampling rates based on traffic volume and budget

For detailed sampling configurations and strategies by traffic level, see the [Configuration guide](/Monitor-your-data/OpenTelemetry/Configuration/#sampling-strategies).

---

## Visualization & Querying

### How do I query my OpenTelemetry metrics in OpsPilot?

OpsPilot uses PromQL for querying metrics. OpenTelemetry metrics are automatically converted to Prometheus format.

**Metric naming convention:**
* Counter: `<metric_name>_total`
* Gauge: `<metric_name>`
* Histogram: `<metric_name>_bucket`, `<metric_name>_sum`, `<metric_name>_count`

**Example queries:**

```promql
# Query counter metric
fib_iteration_counter_total{job="fib_by_iteration"}

# Calculate rate over 5 minutes
rate(http_requests_total[5m])

# Filter by attributes
http_requests_total{http_method="POST", http_status_code="200"}
```

### Can I create custom dashboards with OpenTelemetry data?

Yes. Navigate to **Dashboards > Create Dashboard** in OpsPilot. You can:

* Query traces using TraceQL
* Query metrics using PromQL
* Query logs using LogQL
* Combine multiple data sources in a single dashboard

See [Create a dashboard](/Getting-started/Tutorials/create-dashboard/) for step-by-step instructions.

### How do I correlate logs with traces?

Include trace context in your application logs:

**Python example:**

```python
from opentelemetry import trace

# Get current trace context
span = trace.get_current_span()
trace_id = span.get_span_context().trace_id
span_id = span.get_span_context().span_id

# Include in log message
logging.info(f"Processing order", extra={
    "trace_id": format(trace_id, '032x'),
    "span_id": format(span_id, '016x')
})
```

In OpsPilot's **Explore** view, click a trace to see correlated logs automatically.

---

## Best Practices

### What are semantic conventions and why do they matter?

Semantic conventions are standardized naming and structure rules for telemetry attributes. They ensure:

* **Consistency**: All services use the same attribute names
* **Interoperability**: Tools and dashboards work across different applications
* **Searchability**: Easy filtering and correlation

**Example**: Use `http.method` instead of `http_method`, `httpMethod`, or `method`.

See the [Configuration guide](/Monitor-your-data/OpenTelemetry/Configuration/#semantic-conventions) for detailed examples and FusionReactor-specific mappings, or refer to the [OpenTelemetry Semantic Conventions](https://opentelemetry.io/docs/concepts/semantic-conventions/) for the complete specification.

### How should I name my services?

Follow these guidelines:

* Use lowercase with hyphens: `checkout-service`, not `CheckoutService`
* Be descriptive and consistent: `payment-api`, not `api-v2`
* Include environment in `deployment.environment.name` attribute, not the service name
* Avoid version numbers in service names (use `service.version` attribute instead)

**Example:**

```yaml
service.name: checkout-api
service.version: 2.3.1
deployment.environment.name: production
```

For more comprehensive service naming guidelines and examples, see the [Configuration guide](/Monitor-your-data/OpenTelemetry/Configuration/#service-naming-best-practices).

### Should I always use span metrics?

**Yes.** Span metrics (also called RED metrics - Rate, Errors, Duration) provide:

* Request rates over time
* Error rates and percentages
* Latency distributions (p50, p95, p99)

Generate span metrics **before tail sampling** to ensure accurate representations, even when sampling is aggressive.

Configure in your Collector:

```yaml
connectors:
  spanmetrics:
    dimensions:
      - name: http.method
      - name: http.status_code
```

---

## Troubleshooting

### Where can I find more troubleshooting help?

See the [OpenTelemetry Troubleshooting](/Monitor-your-data/OpenTelemetry/Troubleshooting/) page for detailed debugging guides, including:

* Collector not receiving data
* Data not exporting to OpsPilot
* Configuration errors
* Performance issues

### Can I test my Collector configuration before connecting applications?

Yes. Use the `telemetrygen` utility to send test data:

```bash
docker run --network host \
  ghcr.io/open-telemetry/opentelemetry-collector-contrib/telemetrygen:latest \
  traces --traces 100 \
  --otlp-endpoint localhost:4317 \
  --otlp-insecure
```

Check OpsPilot's **Explore > Traces** for a service named `telemetrygen` within 60 seconds.

---

## Support

### Where can I get additional help?

* **Documentation**: [Official OpenTelemetry Documentation](https://opentelemetry.io/docs/)
* **FusionReactor Support**: Contact support via the chat bubble in OpsPilot
* **Community**: [OpenTelemetry Community Slack](https://cloud-native.slack.com/archives/CJFCJHG4Q)

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.
