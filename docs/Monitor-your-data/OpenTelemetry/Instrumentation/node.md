# Node.js

This guide demonstrates how to instrument a Node.js application with OpenTelemetry to send traces, metrics, and logs to OpsPilot.

<iframe src="https://player.vimeo.com/video/816527416?h=34c72de814" width="640" height="360" frameborder="0" allow="autoplay; fullscreen; picture-in-picture" allowfullscreen></iframe>
<p><a href="https://vimeo.com/816527416">Instrumenting a Go app using OpenTelemetry</a> from <a href="https://vimeo.com/user109619720">FusionReactorAPM</a> on <a href="https://vimeo.com">Vimeo</a>.</p>

## Prerequisites

* **FusionReactor API Key**: Obtain this from **Account Settings > API Keys** in OpsPilot.
* **Docker Desktop**: [Install Docker Desktop](https://www.docker.com/products/docker-desktop/) to build and run the application container.
* **Telemetry Pipeline**: You must have either an [OpenTelemetry Collector](/Monitor-your-data/OpenTelemetry/Shipping/Collector/) or [Grafana Alloy](/Monitor-your-data/OpenTelemetry/Shipping/Grafana-agent/) configured and running to receive data from your Node.js application.

!!! tip "Set up your telemetry pipeline first"
    Before instrumenting your Node.js application, ensure you have completed either the [Collector setup guide](/Monitor-your-data/OpenTelemetry/Shipping/Collector/) or [Grafana Alloy setup guide](/Monitor-your-data/OpenTelemetry/Shipping/Grafana-agent/) so your telemetry data has a destination.

## Step 1: Set up your project

Create a new directory for your project and add the following files.

**`package.json`** - defines the project and its OpenTelemetry dependencies:

```json
{
  "name": "node-otel-demo",
  "version": "1.0.0",
  "scripts": {
    "start": "node -r ./tracing.js app.js"
  },
  "dependencies": {
    "express": "^4.18.2",
    "@opentelemetry/sdk-node": "^0.57.0",
    "@opentelemetry/auto-instrumentations-node": "^0.57.0",
    "@opentelemetry/exporter-trace-otlp-http": "^0.57.0",
    "@opentelemetry/exporter-metrics-otlp-http": "^0.57.0",
    "@opentelemetry/exporter-logs-otlp-http": "^0.57.0",
    "@opentelemetry/api-logs": "^0.57.0",
    "@opentelemetry/sdk-logs": "^0.57.0",
    "@opentelemetry/sdk-metrics": "^1.30.0",
    "@opentelemetry/resources": "^1.30.0",
    "@opentelemetry/semantic-conventions": "^1.28.0"
  }
}
```

**`Dockerfile`** - builds and runs the application:

```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package.json ./
RUN npm install
COPY tracing.js app.js ./
EXPOSE 3000
CMD ["npm", "start"]
```

## Step 2: Configure OpenTelemetry

Create a file named `tracing.js` to configure OpenTelemetry instrumentation:

```javascript
// tracing.js - OpenTelemetry configuration
const { NodeSDK } = require('@opentelemetry/sdk-node');
const { getNodeAutoInstrumentations } = require('@opentelemetry/auto-instrumentations-node');
const { OTLPTraceExporter } = require('@opentelemetry/exporter-trace-otlp-http');
const { OTLPMetricExporter } = require('@opentelemetry/exporter-metrics-otlp-http');
const { OTLPLogExporter } = require('@opentelemetry/exporter-logs-otlp-http');
const { PeriodicExportingMetricReader } = require('@opentelemetry/sdk-metrics');
const { Resource } = require('@opentelemetry/resources');
const { SemanticResourceAttributes } = require('@opentelemetry/semantic-conventions');

// Configure the OTLP endpoint (local collector)
const COLLECTOR_URL = process.env.OTEL_EXPORTER_OTLP_ENDPOINT || 'http://localhost:4318';

// Define service resource
const resource = new Resource({
  [SemanticResourceAttributes.SERVICE_NAME]: 'node-otel-demo',
  [SemanticResourceAttributes.SERVICE_VERSION]: '1.0.0',
});

// Configure exporters
const traceExporter = new OTLPTraceExporter({
  url: `${COLLECTOR_URL}/v1/traces`,
});

const metricExporter = new OTLPMetricExporter({
  url: `${COLLECTOR_URL}/v1/metrics`,
});

const logExporter = new OTLPLogExporter({
  url: `${COLLECTOR_URL}/v1/logs`,
});

// Initialize the SDK
const sdk = new NodeSDK({
  resource: resource,
  traceExporter: traceExporter,
  metricReader: new PeriodicExportingMetricReader({
    exporter: metricExporter,
    exportIntervalMillis: 5000,
  }),
  logRecordProcessor: new (require('@opentelemetry/sdk-logs').BatchLogRecordProcessor)(logExporter),
  instrumentations: [
    getNodeAutoInstrumentations({
      // Automatic instrumentation for Express, HTTP, etc.
      '@opentelemetry/instrumentation-fs': { enabled: false },
    }),
  ],
});

// Start the SDK
sdk.start();

// Graceful shutdown
process.on('SIGTERM', () => {
  sdk.shutdown()
    .then(() => console.log('OpenTelemetry terminated'))
    .catch((error) => console.error('Error terminating OpenTelemetry', error))
    .finally(() => process.exit(0));
});

console.log('OpenTelemetry initialized');
```

## Step 3: Create your instrumented application

Create a file named `app.js` with a simple Express server:

```javascript
// app.js - Simple Express application with custom instrumentation
const express = require('express');
const { trace, metrics } = require('@opentelemetry/api');
const { logs, SeverityNumber } = require('@opentelemetry/api-logs');

const app = express();
const PORT = process.env.PORT || 3000;

// Get tracer, meter and logger
const tracer = trace.getTracer('node-otel-demo');
const meter = metrics.getMeter('node-otel-demo');
const logger = logs.getLogger('node-otel-demo');

// Helper to emit log records
function logInfo(message, attributes = {}) {
  logger.emit({
    severityNumber: SeverityNumber.INFO,
    severityText: 'INFO',
    body: message,
    attributes,
  });
}

function logError(message, attributes = {}) {
  logger.emit({
    severityNumber: SeverityNumber.ERROR,
    severityText: 'ERROR',
    body: message,
    attributes,
  });
}

// Create custom metrics
const requestCounter = meter.createCounter('http_requests_total', {
  description: 'Total number of HTTP requests',
});

const requestDuration = meter.createHistogram('http_request_duration_ms', {
  description: 'HTTP request duration in milliseconds',
});

// Middleware to track request metrics
app.use((req, res, next) => {
  const startTime = Date.now();

  res.on('finish', () => {
    const duration = Date.now() - startTime;

    requestCounter.add(1, {
      method: req.method,
      route: req.route?.path || req.path,
      status: res.statusCode,
    });

    requestDuration.record(duration, {
      method: req.method,
      route: req.route?.path || req.path,
    });
  });

  next();
});

// Routes with custom spans
app.get('/', (req, res) => {
  const span = tracer.startSpan('handle-root');
  span.setAttribute('http.method', 'GET');
  span.setAttribute('http.route', '/');

  logInfo('Handling root request');
  res.json({ message: 'Hello from OpenTelemetry instrumented Node.js app!' });

  span.end();
});

app.get('/fibonacci/:n', (req, res) => {
  const n = parseInt(req.params.n);
  const span = tracer.startSpan('calculate-fibonacci');
  span.setAttribute('fibonacci.n', n);

  try {
    if (isNaN(n) || n < 0) {
      throw new Error('Invalid input: n must be a non-negative number');
    }

    const result = fibonacci(n);
    logInfo(`Calculated Fibonacci(${n}) = ${result}`, { 'fibonacci.n': n, 'fibonacci.result': result });

    res.json({ n, result });
  } catch (error) {
    span.recordException(error);
    span.setStatus({ code: 2, message: error.message });
    logError(`Error calculating Fibonacci: ${error.message}`, { error: error.message });
    res.status(400).json({ error: error.message });
  } finally {
    span.end();
  }
});

app.get('/health', (req, res) => {
  res.json({ status: 'healthy', timestamp: new Date().toISOString() });
});

// Fibonacci calculation with tracing
function fibonacci(n) {
  const span = tracer.startSpan('fibonacci-calculation');
  span.setAttribute('iteration.count', n);

  let a = 0, b = 1;

  for (let i = 0; i < n; i++) {
    const temp = a;
    a = b;
    b = temp + b;
  }

  span.end();
  return a;
}

// Start server
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
  console.log(`Try: http://localhost:${PORT}/fibonacci/10`);
});
```

## Step 4: Add to Docker Compose

Add the following service to your `docker-compose.yml` alongside the collector:

```yaml
  node-otel-demo:
    build: ./node/otel-demo
    environment:
      - OTEL_EXPORTER_OTLP_ENDPOINT=http://otel-collector:4318
    ports:
      - "3000:3000"
    depends_on:
      - otel-collector
```

!!! warning "Insecure configuration"
    The example above uses an unencrypted connection to the local collector. In production, configure TLS and use secure authentication with your API key.

## Step 5: Run with Docker Compose

Build and start the application:

```bash
docker compose up --build node-otel-demo
```

The application starts an Express server on port 3000. Send some test requests to generate telemetry:

```bash
# Test root endpoint
curl http://localhost:3000/

# Calculate Fibonacci
curl http://localhost:3000/fibonacci/20

# Generate more traffic
for i in {1..10}; do curl http://localhost:3000/fibonacci/$i; done
```

!!! warning "Cannot connect to collector?"
    **If you see:** `ECONNREFUSED` or `connect ECONNREFUSED`
    **Fix:** Your collector is not running. Start it first using the [Collector setup guide](/Monitor-your-data/OpenTelemetry/Shipping/Collector/).

## Step 6: Verify in OpsPilot

1. Log in to **OpsPilot**

2. Navigate to **Explore**:
   - **Traces**: Select `Resource Service Name = node-otel-demo`
   - **Metrics**: Search for `http_requests_total{job="node-otel-demo"}`
   - **Logs**: Filter by `job = node-otel-demo`

You should see:
- Trace spans for each HTTP request and Fibonacci calculation
- Metrics tracking request counts and durations
- Log entries from your console.log statements

## Next steps

* Add database instrumentation with `@opentelemetry/instrumentation-pg` or `@opentelemetry/instrumentation-mongodb`
* Instrument Redis with `@opentelemetry/instrumentation-redis`
* Add custom business metrics using the Metrics API
* Create [custom dashboards](/Getting-started/Tutorials/create-dashboard/) in OpsPilot
* Enable additional auto-instrumentations for your specific frameworks

---

## Related Guides

- **[Configuration Guide](/Monitor-your-data/OpenTelemetry/Configuration/)**: Configure semantic conventions, resource attributes, and sampling strategies
- **[Visualize Your Data](/Monitor-your-data/OpenTelemetry/Visualize/Metrics/)**: Query and visualize your telemetry in OpsPilot
- **[Troubleshooting](/Monitor-your-data/OpenTelemetry/Troubleshooting/)**: Debug common instrumentation issues
- **[FAQ](/Monitor-your-data/OpenTelemetry/FAQ/)**: Common questions about instrumentation

---

!!! info "Learn more"
    [OpenTelemetry Node.js Documentation](https://opentelemetry.io/docs/languages/js/getting-started/nodejs/)

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.
