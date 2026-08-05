# Go

This guide demonstrates how to instrument a Go application with OpenTelemetry to send traces and metrics to OpsPilot.

<iframe src="https://player.vimeo.com/video/816527416?h=34c72de814" width="640" height="360" frameborder="0" allow="autoplay; fullscreen; picture-in-picture" allowfullscreen></iframe>
<p><a href="https://vimeo.com/816527416">Instrumenting a Go app using OpenTelemetry</a> from <a href="https://vimeo.com/user109619720">FusionReactorAPM</a> on <a href="https://vimeo.com">Vimeo</a>.</p>

## Prerequisites

* **FusionReactor API Key**: Obtain this from **Account Settings > API Keys** in OpsPilot.
* **Go**: Go 1.21 or later installed on your system.
* **Telemetry Pipeline**: You must have either an [OpenTelemetry Collector](/Monitor-your-data/OpenTelemetry/Shipping/Collector/) or [Grafana Alloy](/Monitor-your-data/OpenTelemetry/Shipping/Grafana-agent/) configured and running to receive data from your Go application.

!!! tip "Set up your telemetry pipeline first"
    Before instrumenting your Go application, ensure you have completed either the [Collector setup guide](/Monitor-your-data/OpenTelemetry/Shipping/Collector/) or [Grafana Alloy setup guide](/Monitor-your-data/OpenTelemetry/Shipping/Grafana-agent/) so your telemetry data has a destination.

## Step 1: Install dependencies

Create a new Go module and add the required OpenTelemetry dependencies:

```bash
go mod init example.com/otel-demo
go get go.opentelemetry.io/otel
go get go.opentelemetry.io/otel/sdk
go get go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracehttp
go get go.opentelemetry.io/otel/exporters/otlp/otlpmetric/otlpmetrichttp
```

## Step 2: Configure OpenTelemetry

Create a `main.go` file and add the following imports and configuration:

```go
package main

import (
	"context"
	"fmt"
	"log"
	"time"

	"go.opentelemetry.io/otel"
	"go.opentelemetry.io/otel/attribute"
	"go.opentelemetry.io/otel/exporters/otlp/otlpmetric/otlpmetrichttp"
	"go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracehttp"
	"go.opentelemetry.io/otel/metric"
	"go.opentelemetry.io/otel/propagation"
	sdkmetric "go.opentelemetry.io/otel/sdk/metric"
	"go.opentelemetry.io/otel/sdk/metric/metricdata"
	"go.opentelemetry.io/otel/sdk/resource"
	sdktrace "go.opentelemetry.io/otel/sdk/trace"
	"go.opentelemetry.io/otel/trace"
	semconv "go.opentelemetry.io/otel/semconv/v1.17.0"
)

var (
	endpoint       = "localhost:4318"
	serviceName    = "test-go-server-http"
	serviceVersion = "0.1.0"
	environment    = "dev"
)
```

### Initialize the Metric Provider

Add a function to configure metrics export:

```go
func setupMetrics(ctx context.Context) (*sdkmetric.MeterProvider, error) {
	exporter, err := otlpmetrichttp.New(
		ctx,
		otlpmetrichttp.WithInsecure(),
		otlpmetrichttp.WithEndpoint(endpoint),
		// OpsPilot is Prometheus-based and requires Cumulative temporality
		otlpmetrichttp.WithTemporalitySelector(func(kind sdkmetric.InstrumentKind) metricdata.Temporality {
			return metricdata.CumulativeTemporality
		}),
	)
	if err != nil {
		return nil, err
	}

	// Define resource attributes common to all metrics
	res := resource.NewWithAttributes(
		semconv.SchemaURL,
		semconv.ServiceNameKey.String(serviceName),
		semconv.ServiceVersionKey.String(serviceVersion),
		attribute.String("environment", environment),
	)

	mp := sdkmetric.NewMeterProvider(
		sdkmetric.WithResource(res),
		sdkmetric.WithReader(
			// Export metrics every 5 seconds
			sdkmetric.NewPeriodicReader(exporter, sdkmetric.WithInterval(5*time.Second)),
		),
	)

	otel.SetMeterProvider(mp)
	return mp, nil
}
```

### Initialize the Trace Provider

Add a function to configure trace export:

```go
func setupTracing(ctx context.Context) (*sdktrace.TracerProvider, error) {
	exporter, err := otlptracehttp.New(
		ctx,
		otlptracehttp.WithInsecure(),
		otlptracehttp.WithEndpoint(endpoint),
	)
	if err != nil {
		return nil, err
	}

	// Define resource attributes common to all traces
	res := resource.NewWithAttributes(
		semconv.SchemaURL,
		semconv.ServiceNameKey.String(serviceName),
		semconv.ServiceVersionKey.String(serviceVersion),
		attribute.String("environment", environment),
	)

	tp := sdktrace.NewTracerProvider(
		sdktrace.WithBatcher(exporter),
		sdktrace.WithResource(res),
	)

	otel.SetTracerProvider(tp)

	// Set up trace context propagation
	otel.SetTextMapPropagator(
		propagation.NewCompositeTextMapPropagator(
			propagation.TraceContext{},
			propagation.Baggage{},
		),
	)

	return tp, nil
}
```

!!! warning "Insecure configuration"
    The examples above use `WithInsecure()` for simplicity. In production, configure TLS and use secure authentication with your API key.

## Step 3: Create your application

Add the main function that initializes OpenTelemetry and creates sample telemetry:

```go
func main() {
	log.Printf("Starting OpenTelemetry demo...")

	ctx := context.Background()

	// Initialize metrics
	mp, err := setupMetrics(ctx)
	if err != nil {
		panic(err)
	}
	defer mp.Shutdown(ctx)

	// Initialize tracing
	tp, err := setupTracing(ctx)
	if err != nil {
		panic(err)
	}
	defer tp.Shutdown(ctx)

	// Create a tracer
	tracer := otel.Tracer(serviceName)

	// Create a meter and counter
	meter := otel.Meter(serviceName)
	counter, err := meter.Int64Counter(
		"demo.counter",
		metric.WithDescription("Counts iterations of the demo loop"),
	)
	if err != nil {
		panic(err)
	}

	// Define custom trace attributes
	commonAttrs := []attribute.KeyValue{
		attribute.String("demo.type", "example"),
		attribute.String("demo.version", "1.0"),
	}

	// Start a trace span
	ctx, span := tracer.Start(
		ctx,
		"demo-operation",
		trace.WithAttributes(commonAttrs...),
	)
	defer span.End()

	// Simulate work with nested spans
	for i := 1; i <= 30; i++ {
		_, childSpan := tracer.Start(ctx, fmt.Sprintf("iteration-%d", i))
		log.Printf("Processing iteration %d / 30\n", i)

		// Increment the counter
		counter.Add(ctx, 1, metric.WithAttributes(
			attribute.String("iteration", fmt.Sprintf("%d", i)),
		))

		time.Sleep(time.Second)
		childSpan.End()
	}

	log.Printf("Demo complete!")
}
```

!!! warning "Cannot connect to collector?"
    **If you see:** `connection refused` or `dial tcp: connect: connection refused`
    **Fix:** Your collector is not running. Start it first using the [Collector setup guide](/Monitor-your-data/OpenTelemetry/Shipping/Collector/).

## Step 4: Run the application

Run your instrumented application:

```bash
go run .
```

## Step 5: Verify in OpsPilot

1. **View in OpsPilot**:
   - Navigate to **Explore > Traces** to see your Go application traces
   - Navigate to **Explore > Metrics** and search for `demo_counter` to see the counter metric
   - Your service should appear as `test-go-server-http`

## Next steps

* Instrument HTTP handlers using `go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp`
* Add database instrumentation with `go.opentelemetry.io/contrib/instrumentation/database/sql/otelsql`
* Create [custom dashboards](/Getting-started/Tutorials/create-dashboard/) in OpsPilot to visualize your Go application metrics

---

## Related Guides

- **[Configuration Guide](/Monitor-your-data/OpenTelemetry/Configuration/)**: Configure semantic conventions, resource attributes, and sampling strategies
- **[Visualize Your Data](/Monitor-your-data/OpenTelemetry/Visualize/Metrics/)**: Query and visualize your telemetry in OpsPilot
- **[Troubleshooting](/Monitor-your-data/OpenTelemetry/Troubleshooting/)**: Debug common instrumentation issues
- **[FAQ](/Monitor-your-data/OpenTelemetry/FAQ/)**: Common questions about instrumentation

---

!!! info "Learn more"
    [OpenTelemetry Go Documentation](https://opentelemetry.io/docs/languages/go/)

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.
