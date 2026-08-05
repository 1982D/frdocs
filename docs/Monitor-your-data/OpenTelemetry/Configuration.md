# OpenTelemetry Configuration

This guide covers essential OpenTelemetry configuration topics for OpsPilot, including semantic conventions, resource attributes, service naming, and sampling strategies.

---

## Semantic Conventions

Semantic conventions are standardized naming and structure rules for OpenTelemetry attributes. Following these conventions ensures consistency across your observability stack and compatibility with tools, dashboards, and other systems.

**OpsPilot follows the official OpenTelemetry semantic conventions.** This guide provides common examples and FusionReactor-specific mappings. For the complete specification and all available conventions, refer to the [OpenTelemetry Semantic Conventions documentation](https://opentelemetry.io/docs/concepts/semantic-conventions/).

### Why semantic conventions matter

* **Consistency**: All services use the same attribute names
* **Interoperability**: Dashboards and queries work across different applications
* **Searchability**: Easy filtering and correlation in OpsPilot
* **Best practices**: Leverage community knowledge and tooling

### Common semantic conventions

#### HTTP attributes

Use these standardized attributes for HTTP operations:

| Attribute | Description | Example |
|-----------|-------------|---------|
| `http.method` | HTTP request method | `GET`, `POST`, `PUT` |
| `http.url` | Full request URL | `https://api.example.com/users` |
| `http.status_code` | HTTP response status | `200`, `404`, `500` |
| `http.route` | Matched route pattern | `/users/{id}` |
| `http.target` | Request target | `/users?page=1` |

#### Database attributes

| Attribute | Description | Example |
|-----------|-------------|---------|
| `db.system` | Database type | `postgresql`, `mysql`, `mongodb` |
| `db.name` | Database name | `customers` |
| `db.statement` | Database query | `SELECT * FROM users WHERE id = ?` |
| `db.operation` | Operation type | `SELECT`, `INSERT`, `UPDATE` |

#### Messaging attributes

| Attribute | Description | Example |
|-----------|-------------|---------|
| `messaging.system` | Messaging system | `rabbitmq`, `kafka`, `sqs` |
| `messaging.destination` | Queue or topic name | `orders-queue` |
| `messaging.operation` | Operation type | `send`, `receive`, `process` |

### Custom attributes

For business-specific data, use a namespace prefix:

```
app.user.id = 12345
app.order.type = subscription
app.transaction.amount = 99.99
```

---

## Resource Attributes

Resource attributes describe the entity producing telemetry data (your service, container, host, etc.). These attributes apply to **all** telemetry from that resource.

### Required resource attributes

#### service.name

The most important resource attribute. It identifies your service in OpsPilot.

!!! warning "Important mapping"
    In OpsPilot, `service.name` becomes the `job` label for querying.

**How to set it:**

=== "Python"
    ```python
    from opentelemetry.sdk.resources import Resource, SERVICE_NAME

    resource = Resource.create({
        SERVICE_NAME: "checkout-api"
    })
    ```

=== "Java"
    ```bash
    java -javaagent:opentelemetry-javaagent.jar \
      -Dotel.service.name=checkout-api \
      -jar your-app.jar
    ```

=== "Node.js"
    ```javascript
    const { Resource } = require('@opentelemetry/resources');
    const { SemanticResourceAttributes } = require('@opentelemetry/semantic-conventions');

    const resource = new Resource({
      [SemanticResourceAttributes.SERVICE_NAME]: 'checkout-api',
    });
    ```

=== ".NET"
    ```csharp
    using OpenTelemetry.Resources;

    var resourceBuilder = ResourceBuilder.CreateDefault()
        .AddService(serviceName: "checkout-api");
    ```

#### service.version

Track which version of your service is running.

```python
resource = Resource.create({
    SERVICE_NAME: "checkout-api",
    SERVICE_VERSION: "2.3.1"
})
```

Query in OpsPilot:
```promql
http_requests_total{job="checkout-api", service_version="2.3.1"}
```

### Recommended resource attributes

#### deployment.environment.name

Distinguish between environments (development, staging, production).

```python
from opentelemetry.semconv.resource import ResourceAttributes

resource = Resource.create({
    SERVICE_NAME: "checkout-api",
    SERVICE_VERSION: "2.3.1",
    ResourceAttributes.DEPLOYMENT_ENVIRONMENT: "production"
})
```

!!! tip "Filter by environment"
    In OpsPilot: `job="checkout-api" AND deployment_environment="production"`

#### service.namespace

Group related services logically.

```python
resource = Resource.create({
    SERVICE_NAME: "checkout-api",
    SERVICE_NAMESPACE: "ecommerce"
})
```

Use this to distinguish services with the same name across different teams or products.

#### service.instance.id

Unique identifier for each instance of your service.

```python
import socket

resource = Resource.create({
    SERVICE_NAME: "checkout-api",
    SERVICE_INSTANCE_ID: socket.gethostname()  # or container ID
})
```

Useful for identifying which specific instance handled a request.

### Infrastructure resource attributes

OpenTelemetry SDKs often detect these automatically:

| Attribute | Description | Auto-detected |
|-----------|-------------|---------------|
| `host.name` | Hostname | ✅ |
| `host.id` | Host identifier | ✅ |
| `container.name` | Container name | ✅ (in Docker) |
| `container.id` | Container ID | ✅ (in Docker) |
| `k8s.namespace.name` | Kubernetes namespace | ✅ (in K8s) |
| `k8s.pod.name` | Pod name | ✅ (in K8s) |
| `cloud.provider` | Cloud provider | ✅ (AWS/GCP/Azure) |
| `cloud.region` | Cloud region | ✅ |

---

## Service Naming Best Practices

Consistent service naming improves observability and team collaboration.

### Naming guidelines

✅ **Do:**
* Use lowercase with hyphens: `checkout-api`, `payment-service`
* Be descriptive and specific: `user-authentication-api`
* Use consistent patterns across all services
* Keep names stable over time

❌ **Don't:**
* Include version numbers: ~~`checkout-api-v2`~~ (use `service.version` attribute)
* Include environment names: ~~`checkout-api-prod`~~ (use `deployment.environment.name` attribute)
* Use camelCase or snake_case: ~~`CheckoutAPI`~~, ~~`checkout_api`~~
* Make names too generic: ~~`api`~~, ~~`service`~~

### Example naming structure

```yaml
# Good service naming
service.name: checkout-api
service.version: 2.3.1
service.namespace: ecommerce
deployment.environment.name: production
```

Query in OpsPilot:
```promql
{job="checkout-api", service_namespace="ecommerce", deployment_environment="production"}
```

### Handling microservices

For microservice architectures with many services:

```
# Frontend services
web-frontend
mobile-api
admin-dashboard

# Backend services
user-service
order-service
payment-service
inventory-service
notification-service

# Infrastructure services
auth-gateway
api-gateway
cache-service
```

Use `service.namespace` to group related services:
```yaml
service.namespace: ecommerce
service.namespace: analytics
service.namespace: platform
```

---

## Sampling Strategies

Sampling reduces telemetry volume and costs by collecting a subset of traces while maintaining observability.

### When to use sampling

* **High-traffic applications**: Reduce data volume without losing visibility
* **Cost management**: Control telemetry data costs in OpsPilot
* **Performance**: Reduce overhead on applications and collectors

### Head sampling

Head sampling makes the sampling decision **at the start** of a trace (when the root span is created).

#### Probabilistic sampling

Sample a percentage of all traces.

**Collector configuration:**

```yaml
processors:
  probabilistic_sampler:
    sampling_percentage: 10  # Keep 10% of traces

service:
  pipelines:
    traces:
      receivers: [otlp]
      processors: [probabilistic_sampler]
      exporters: [otlphttp]
```

**SDK configuration (Python):**

```python
from opentelemetry.sdk.trace.sampling import TraceIdRatioBased

sampler = TraceIdRatioBased(0.1)  # 10% sampling rate
tracer_provider = TracerProvider(sampler=sampler)
```

✅ **Pros:**
* Simple to implement
* Low overhead
* Deterministic (same trace ID always gets same decision)

❌ **Cons:**
* May drop important traces (errors, slow requests)
* No visibility into what was dropped

#### Rate limiting sampling

Limit traces to N per second.

```yaml
processors:
  tail_sampling:
    decision_wait: 10s
    policies:
      - name: rate-limit
        type: rate_limiting
        rate_limiting:
          spans_per_second: 100  # Max 100 traces/sec
```

### Tail sampling

Tail sampling makes the decision **after the trace completes**, allowing intelligent decisions based on trace content.

#### Tail sampling policies

**Keep all errors and slow requests:**

```yaml
processors:
  tail_sampling:
    decision_wait: 10s  # Wait for trace to complete
    num_traces: 100000
    expected_new_traces_per_sec: 1000
    policies:
      # Always keep errors
      - name: error-traces
        type: status_code
        status_code:
          status_codes: [ERROR]

      # Keep slow traces (>2 seconds)
      - name: slow-traces
        type: latency
        latency:
          threshold_ms: 2000

      # Sample normal traces at 5%
      - name: normal-traces
        type: probabilistic
        probabilistic:
          sampling_percentage: 5
```

✅ **Pros:**
* Intelligent sampling (keep important traces)
* Always capture errors and slow requests
* Better visibility into issues

❌ **Cons:**
* Higher memory usage (must buffer traces)
* Adds latency (decision wait time)
* More complex configuration

### Composite sampling strategy

Combine head and tail sampling:

```yaml
processors:
  # Head sampling: Reduce volume before tail sampling
  probabilistic_sampler:
    sampling_percentage: 50  # Pre-filter to 50%

  # Tail sampling: Intelligent decisions on remaining traces
  tail_sampling:
    decision_wait: 10s
    policies:
      - name: errors-and-slow
        type: and
        and:
          and_sub_policy:
            - name: errors
              type: status_code
              status_code: {status_codes: [ERROR]}
            - name: slow
              type: latency
              latency: {threshold_ms: 1000}

service:
  pipelines:
    traces:
      receivers: [otlp]
      processors: [probabilistic_sampler, tail_sampling]
      exporters: [otlphttp]
```

### Span metrics (RED metrics)

!!! tip "Generate metrics before sampling"
    Always generate span metrics **before** tail sampling to ensure accurate request rates, error rates, and latency distributions even with aggressive sampling.

```yaml
connectors:
  spanmetrics:
    dimensions:
      - name: http.method
      - name: http.status_code
      - name: service.name

processors:
  tail_sampling:
    # ... tail sampling config

service:
  pipelines:
    traces:
      receivers: [otlp]
      processors: [spanmetrics]  # Generate metrics first
      exporters: [spanmetrics]

    traces/sampled:
      receivers: [spanmetrics]
      processors: [tail_sampling]  # Then sample
      exporters: [otlphttp]

    metrics:
      receivers: [spanmetrics]  # Receive generated metrics
      exporters: [otlphttp]
```

### Recommended sampling strategies

#### Development/Testing
```yaml
# Keep everything for debugging
sampling_percentage: 100
```

#### Low-traffic production (<1000 req/min)
```yaml
# Keep everything or use light head sampling
sampling_percentage: 100  # or 50-75%
```

#### Medium-traffic production (1K-10K req/min)
```yaml
# Tail sampling with error/latency policies
tail_sampling:
  policies:
    - errors: 100%
    - latency >2s: 100%
    - normal: 10%
```

#### High-traffic production (>10K req/min)
```yaml
# Composite: Head (25%) + Tail sampling
probabilistic_sampler: 25%
tail_sampling:
  policies:
    - errors: 100%
    - latency >2s: 100%
    - normal: 5%
# Effective rate: 25% × (errors + slow + 5% normal)
```

---

## Configuration Validation

### Test your configuration

Use `telemetrygen` to send test data to your collector:

```bash
docker run --network host \
  ghcr.io/open-telemetry/opentelemetry-collector-contrib/telemetrygen:latest \
  traces --traces 100 \
  --otlp-endpoint localhost:4317 \
  --otlp-insecure
```

Check OpsPilot's **Explore > Traces** for a service named `telemetrygen` within 60 seconds.

### Verify resource attributes

Query your service in OpsPilot to see resource attributes:

```promql
{job="your-service-name"}
```

Click any trace to inspect attributes in the details panel.

### Monitor sampling effectiveness

Track sampling rates with metrics:

```promql
# Total spans received
rate(otelcol_processor_accepted_spans[5m])

# Spans after sampling
rate(otelcol_exporter_sent_spans[5m])

# Sampling rate
rate(otelcol_exporter_sent_spans[5m]) / rate(otelcol_processor_accepted_spans[5m])
```

---

## Next steps

* [Instrument your application](/Monitor-your-data/OpenTelemetry/Instrumentation/Overview/)
* [Set up the Collector](/Monitor-your-data/OpenTelemetry/Shipping/Collector/)
* [Create custom dashboards](/Getting-started/Tutorials/create-dashboard/)
* [Review FAQ](/Monitor-your-data/OpenTelemetry/FAQ/) for common questions

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.
