# Python

This guide demonstrates how to instrument a Python application with OpenTelemetry to send traces, metrics, and logs to OpsPilot.

## Prerequisites

* **FusionReactor API Key**: Obtain this from **Account Settings > API Keys** in OpsPilot.
* **Python**: Python 3.8 or later installed on your system.
* **Telemetry Pipeline**: You must have either an [OpenTelemetry Collector](/Monitor-your-data/OpenTelemetry/Shipping/Collector/) or [Grafana Alloy](/Monitor-your-data/OpenTelemetry/Shipping/Grafana-agent/) configured and running to receive data from your Python application.

!!! tip "Set up your telemetry pipeline first"
    Before instrumenting your Python application, ensure you have completed either the [Collector setup guide](/Monitor-your-data/OpenTelemetry/Shipping/Collector/) or [Grafana Alloy setup guide](/Monitor-your-data/OpenTelemetry/Shipping/Grafana-agent/) so your telemetry data has a destination.

## Step 1: Install dependencies

Install the required OpenTelemetry packages using pip:

```bash
pip install opentelemetry-api
pip install opentelemetry-sdk
pip install opentelemetry-exporter-otlp-proto-http
```

## Step 2: Create your instrumented application

Create a file named `fib.py` with the following code. This example calculates Fibonacci numbers while sending telemetry data:

```python
# Fibonacci by Iteration
# Example Python code for OpsPilot integration

import sys
import logging

# Instrumentation Libraries
from opentelemetry.sdk.resources import Resource

# Exporters
from opentelemetry.exporter.otlp.proto.http.trace_exporter import OTLPSpanExporter
from opentelemetry.exporter.otlp.proto.http.metric_exporter import OTLPMetricExporter
from opentelemetry.exporter.otlp.proto.http._log_exporter import OTLPLogExporter

# Trace Imports
from opentelemetry.trace import set_tracer_provider
from opentelemetry.sdk.trace import TracerProvider, sampling
from opentelemetry.sdk.trace.export import BatchSpanProcessor
from opentelemetry.semconv.resource import ResourceAttributes

# Metric Imports
from opentelemetry.sdk.metrics.export import PeriodicExportingMetricReader, AggregationTemporality
from opentelemetry.sdk.metrics import MeterProvider, Counter, UpDownCounter, Histogram, ObservableCounter, ObservableUpDownCounter, ObservableGauge
from opentelemetry.metrics import set_meter_provider, get_meter_provider

# Logs Imports
from opentelemetry.sdk._logs import LoggerProvider, LoggingHandler
from opentelemetry.sdk._logs.export import BatchLogRecordProcessor
from opentelemetry._logs import set_logger_provider


def fib(iterations: int):
    """Calculate Fibonacci sequence with OpenTelemetry instrumentation."""
    total: int = 0
    last: int = [0, 1]
    iteration: int = 0

    tracer = TRACER_PROVIDER.get_tracer("fib_tracer")
    meter = get_meter_provider().get_meter("fib_meter")
    iteration_counter = meter.create_counter(
        name="fib_iteration_counter",
        description="The number of iterations"
    )

    # Start an OTEL span to trace the whole execution
    with tracer.start_as_current_span("fib-outer") as span:
        span.set_attribute("iterations", iterations)

        while iteration < iterations:
            with tracer.start_as_current_span('fib-inner') as inner_span:
                inner_span.set_attribute("iteration", iteration)

                iteration += 1
                iteration_counter.add(amount=1)

                # Find the next number in the sequence
                new_number = sum(last)

                # Update the sequence
                last[0] = last[1]
                last[1] = new_number

                logging.info(f'{new_number}')


def initialize_otel(endpoint: str) -> tuple:
    """Initialize OpenTelemetry providers for traces, metrics, and logs."""
    logging.debug("Initializing OpenTelemetry")

    # Define service resource
    resource = Resource.create(
        attributes={ResourceAttributes.SERVICE_NAME: 'fib_by_iteration'}
    )

    # Initialize Tracing
    tracer_provider = TracerProvider(
        sampler=sampling.ALWAYS_ON,
        resource=resource
    )
    set_tracer_provider(tracer_provider)
    tracer_provider.add_span_processor(
        BatchSpanProcessor(
            OTLPSpanExporter(endpoint=endpoint + '/v1/traces')
        )
    )

    # Initialize Metrics
    # OpsPilot is Prometheus-based and requires Cumulative temporality
    cumulative = {
        Counter: AggregationTemporality.CUMULATIVE,
        UpDownCounter: AggregationTemporality.CUMULATIVE,
        Histogram: AggregationTemporality.CUMULATIVE,
        ObservableCounter: AggregationTemporality.CUMULATIVE,
        ObservableUpDownCounter: AggregationTemporality.CUMULATIVE,
        ObservableGauge: AggregationTemporality.CUMULATIVE,
    }
    exporter = OTLPMetricExporter(endpoint=endpoint + "/v1/metrics", preferred_temporality=cumulative)
    reader = PeriodicExportingMetricReader(exporter)
    meter_provider = MeterProvider(metric_readers=[reader], resource=resource)
    set_meter_provider(meter_provider)

    # Initialize Logging
    logger_provider = LoggerProvider(resource=resource)
    set_logger_provider(logger_provider)
    logger_provider.add_log_record_processor(
        BatchLogRecordProcessor(
            OTLPLogExporter(endpoint=endpoint + '/v1/logs')
        )
    )
    handler = LoggingHandler(level=logging.NOTSET, logger_provider=logger_provider)
    logging.getLogger().addHandler(handler)

    return tracer_provider, meter_provider, logger_provider


# Configure logging
logging.basicConfig(level="INFO")
logging.info("Starting Fibonacci calculator")

# Initialize OpenTelemetry (connect to local collector)
TRACER_PROVIDER, METER_PROVIDER, LOG_PROVIDER = initialize_otel("http://localhost:4318")

# Run the Fibonacci calculation
if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python fib.py <iterations>")
        sys.exit(1)

    iters = int(sys.argv[1])
    logging.info(f'Fibonacci by Iteration - {iters} rounds')
    fib(iters)
    logging.info("Fibonacci complete")

    # Flush and shut down providers to ensure all telemetry is exported before exit
    TRACER_PROVIDER.shutdown()
    METER_PROVIDER.shutdown()
    LOG_PROVIDER.shutdown()
```

### How the code works

**`fib()` function:**
Calculates the Fibonacci sequence while creating telemetry:
- Creates an outer span (`fib-outer`) to trace the entire operation
- Creates inner spans (`fib-inner`) for each iteration
- Records the iteration number as a span attribute
- Increments a counter metric for each iteration
- Logs each Fibonacci number

**`initialize_otel()` function:**
Sets up the three OpenTelemetry providers:
- **Tracer Provider** - Sends trace data to the collector
- **Meter Provider** - Sends metrics data to the collector
- **Logger Provider** - Sends log data to the collector

All three providers use the same service name (`fib_by_iteration`), which appears as the `job` label in OpsPilot.

## Step 3: Run locally

Test your instrumented application:

```bash
python fib.py 20
```

The application will calculate 20 Fibonacci numbers and send telemetry to your local collector at `localhost:4318`.

!!! warning "Cannot connect to collector?"
    **If you see:** `Connection refused` or `Max retries exceeded`
    **Fix:** Your collector is not running. Start it first using the [Collector setup guide](/Monitor-your-data/OpenTelemetry/Shipping/Collector/).

## Step 4: Verify in OpsPilot

1. Log in to **OpsPilot**
2. Navigate to **Explore**:
   - **Traces**: Select `Resource Service Name = fib_by_iteration`
   - **Metrics**: Go to **Explore > Metrics**, select `fib_iteration_counter`, and run the query. Filter by `job = fib_by_iteration` to scope to your service.
   - **Logs**: Filter by `job = fib_by_iteration`

You should see:
- Trace spans showing the execution flow (`fib-outer` and `fib-inner`)
- A counter metric showing the total number of iterations
- Log entries for each Fibonacci number calculated

## Next steps

* Add automatic instrumentation for popular frameworks using [`opentelemetry-instrumentation`](https://opentelemetry.io/docs/languages/python/automatic/)
* Instrument HTTP requests with `opentelemetry-instrumentation-requests`
* Instrument database calls with `opentelemetry-instrumentation-sqlalchemy`
* Create [custom dashboards](/Getting-started/Tutorials/create-dashboard/) in OpsPilot to visualize your Python application metrics

---

## Related Guides

- **[Configuration Guide](/Monitor-your-data/OpenTelemetry/Configuration/)**: Configure semantic conventions, resource attributes, and sampling strategies
- **[Visualize Your Data](/Monitor-your-data/OpenTelemetry/Visualize/Metrics/)**: Query and visualize your telemetry in OpsPilot
- **[Troubleshooting](/Monitor-your-data/OpenTelemetry/Troubleshooting/)**: Debug common instrumentation issues
- **[FAQ](/Monitor-your-data/OpenTelemetry/FAQ/)**: Common questions about instrumentation

---

!!! info "Learn more"
    [OpenTelemetry Python Documentation](https://opentelemetry.io/docs/languages/python/)

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.
