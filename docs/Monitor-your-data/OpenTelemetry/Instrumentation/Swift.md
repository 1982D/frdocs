# Swift

This guide demonstrates how to instrument a Swift application with OpenTelemetry to send traces to OpsPilot.

!!! note "Platform Status"
    OpenTelemetry Swift is **stable for traces**. Metrics and logs are in beta. Ideal for iOS, macOS, and server-side Swift applications.

## Prerequisites

* **FusionReactor API Key**: Obtain this from **Account Settings > API Keys** in OpsPilot.
* **Swift**: Swift 5.7 or later installed on your system.
* **Telemetry Pipeline**: You must have either an [OpenTelemetry Collector](/Monitor-your-data/OpenTelemetry/Shipping/Collector/) or [Grafana Alloy](/Monitor-your-data/OpenTelemetry/Shipping/Grafana-agent/) configured and running to receive data from your Swift application.

!!! tip "Set up your telemetry pipeline first"
    Before instrumenting your Swift application, ensure you have completed either the [Collector setup guide](/Monitor-your-data/OpenTelemetry/Shipping/Collector/) or [Grafana Alloy setup guide](/Monitor-your-data/OpenTelemetry/Shipping/Grafana-agent/) so your telemetry data has a destination.

## Step 1: Add dependencies

Add OpenTelemetry Swift to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/open-telemetry/opentelemetry-swift", from: "1.5.0")
],
targets: [
    .target(
        name: "YourApp",
        dependencies: [
            .product(name: "OpenTelemetryApi", package: "opentelemetry-swift"),
            .product(name: "OpenTelemetrySdk", package: "opentelemetry-swift"),
            .product(name: "OtlpHTTPExporter", package: "opentelemetry-swift"),
        ]
    )
]
```

## Step 2: Create your instrumented application

Create your `main.swift`:

```swift
import Foundation
import OpenTelemetryApi
import OpenTelemetrySdk
import OtlpHTTPExporter

func initializeOpenTelemetry() -> TracerProvider {
    let resource = Resource(attributes: [
        "service.name": AttributeValue.string("fibonacci-service")
    ])

    let otlpExporter = OtlpHTTPTraceExporter(
        endpoint: URL(string: "http://localhost:4318/v1/traces")!
    )

    let spanProcessor = BatchSpanProcessor(spanExporter: otlpExporter)

    let tracerProvider = TracerProviderBuilder()
        .with(resource: resource)
        .add(spanProcessor: spanProcessor)
        .build()

    OpenTelemetry.registerTracerProvider(tracerProvider: tracerProvider)

    return tracerProvider
}

func calculateFibonacci(n: Int, tracer: Tracer) {
    let outerSpan = tracer.spanBuilder(spanName: "calculate_fibonacci")
        .setAttribute(key: "iterations", value: AttributeValue.int(n))
        .startSpan()

    var prev: UInt64 = 0
    var current: UInt64 = 1

    for i in 0..<n {
        let span = tracer.spanBuilder(spanName: "fibonacci_iteration")
            .setAttribute(key: "iteration", value: AttributeValue.int(i + 1))
            .setAttribute(key: "value", value: AttributeValue.int(Int(current)))
            .startSpan()

        print("Iteration \(i + 1): \(current)")

        let next = prev + current
        prev = current
        current = next

        Thread.sleep(forTimeInterval: 0.1)

        span.end()
    }

    outerSpan.end()
}

// Main execution
let arguments = CommandLine.arguments
guard arguments.count >= 2, let iterations = Int(arguments[1]) else {
    print("Usage: swift run YourApp <iterations>")
    exit(1)
}

print("Starting Fibonacci calculator")
print("Fibonacci by Iteration - \(iterations) rounds")

let tracerProvider = initializeOpenTelemetry()
let tracer = OpenTelemetry.instance.tracerProvider.get(instrumentationName: "fibonacci-tracer")

calculateFibonacci(n: iterations, tracer: tracer)

print("Fibonacci complete")

// Ensure spans are flushed
Thread.sleep(forTimeInterval: 1)
tracerProvider.shutdown()
```

### How the code works

**`calculateFibonacci()` function:**
- Creates spans for the operation and each iteration
- Sets attributes for tracking iteration numbers and values
- Properly ends spans to ensure they're exported

**`initializeOpenTelemetry()` function:**
- Configures the OTLP HTTP exporter
- Sets up batch span processing for efficient export
- Registers the tracer provider globally

## Step 3: Run locally

Build and run your instrumented application:

```bash
swift run YourApp 20
```

The application will calculate 20 Fibonacci numbers and send telemetry to your local collector at `localhost:4318`.

!!! warning "Cannot connect to collector?"
    **If you see:** Connection errors or export failures
    **Fix:** Your collector is not running. Start it first using the [Collector setup guide](/Monitor-your-data/OpenTelemetry/Shipping/Collector/).

## Step 4: Verify in OpsPilot

1. Log in to **OpsPilot**
2. Navigate to **Explore**:
   - **Traces**: Select `Resource Service Name = fibonacci-service`

You should see:
- Trace spans showing the execution flow
- Span attributes with iteration numbers
- Timing information for each operation

## Next steps

* Instrument iOS/macOS apps with automatic network tracing
* Add custom spans for business-critical operations
* Integrate with SwiftUI for UI performance tracking
* Create [custom dashboards](/Getting-started/Tutorials/create-dashboard/) in OpsPilot to visualize your Swift application metrics

---

## Related Guides

- **[Configuration Guide](/Monitor-your-data/OpenTelemetry/Configuration/)**: Configure semantic conventions, resource attributes, and sampling strategies
- **[Visualize Your Data](/Monitor-your-data/OpenTelemetry/Visualize/Metrics/)**: Query and visualize your telemetry in OpsPilot
- **[Troubleshooting](/Monitor-your-data/OpenTelemetry/Troubleshooting/)**: Debug common instrumentation issues
- **[FAQ](/Monitor-your-data/OpenTelemetry/FAQ/)**: Common questions about instrumentation

---

!!! info "Learn more"
    [OpenTelemetry Swift Documentation](https://opentelemetry.io/docs/languages/swift/)

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.
