# Kotlin

This guide demonstrates how to instrument a Kotlin application with OpenTelemetry to send traces, metrics, and logs to OpsPilot.

!!! warning "Beta Status"
    OpenTelemetry Kotlin is currently in **Beta**. APIs may change between releases. Suitable for testing and development, but review release notes carefully before production use.

## Prerequisites

* **FusionReactor API Key**: Obtain this from **Account Settings > API Keys** in OpsPilot.
* **Kotlin**: Kotlin 1.8+ with JVM target installed on your system.
* **Telemetry Pipeline**: You must have either an [OpenTelemetry Collector](/Monitor-your-data/OpenTelemetry/Shipping/Collector/) or [Grafana Alloy](/Monitor-your-data/OpenTelemetry/Shipping/Grafana-agent/) configured and running to receive data from your Kotlin application.

!!! tip "Set up your telemetry pipeline first"
    Before instrumenting your Kotlin application, ensure you have completed either the [Collector setup guide](/Monitor-your-data/OpenTelemetry/Shipping/Collector/) or [Grafana Alloy setup guide](/Monitor-your-data/OpenTelemetry/Shipping/Grafana-agent/) so your telemetry data has a destination.

!!! info "Using Java Agent"
    For JVM-based Kotlin applications, you can use the [Java auto-instrumentation agent](/Monitor-your-data/OpenTelemetry/Instrumentation/Java/) for zero-code instrumentation.

## Step 1: Add dependencies

Add to your `build.gradle.kts`:

```kotlin
dependencies {
    implementation("io.opentelemetry:opentelemetry-api:1.32.0")
    implementation("io.opentelemetry:opentelemetry-sdk:1.32.0")
    implementation("io.opentelemetry:opentelemetry-exporter-otlp:1.32.0")
    implementation("io.opentelemetry.semconv:opentelemetry-semconv:1.21.0-alpha")
}
```

## Step 2: Create your instrumented application

Create `src/main/kotlin/FibonacciApp.kt`:

```kotlin
import io.opentelemetry.api.OpenTelemetry
import io.opentelemetry.api.trace.Tracer
import io.opentelemetry.api.trace.Span
import io.opentelemetry.api.trace.StatusCode
import io.opentelemetry.api.common.Attributes
import io.opentelemetry.sdk.OpenTelemetrySdk
import io.opentelemetry.sdk.resources.Resource
import io.opentelemetry.sdk.trace.SdkTracerProvider
import io.opentelemetry.sdk.trace.export.BatchSpanProcessor
import io.opentelemetry.exporter.otlp.http.trace.OtlpHttpSpanExporter
import io.opentelemetry.semconv.resource.attributes.ResourceAttributes
import kotlin.system.exitProcess

fun initializeOpenTelemetry(): OpenTelemetry {
    val resource = Resource.getDefault()
        .merge(Resource.create(
            Attributes.of(ResourceAttributes.SERVICE_NAME, "fibonacci-service")
        ))

    val spanExporter = OtlpHttpSpanExporter.builder()
        .setEndpoint("http://localhost:4318/v1/traces")
        .build()

    val sdkTracerProvider = SdkTracerProvider.builder()
        .addSpanProcessor(BatchSpanProcessor.builder(spanExporter).build())
        .setResource(resource)
        .build()

    return OpenTelemetrySdk.builder()
        .setTracerProvider(sdkTracerProvider)
        .buildAndRegisterGlobal()
}

fun calculateFibonacci(n: Int, tracer: Tracer) {
    val outerSpan: Span = tracer.spanBuilder("calculate_fibonacci")
        .setAttribute("iterations", n.toLong())
        .startSpan()

    try {
        var prev: Long = 0
        var current: Long = 1

        for (i in 1..n) {
            val span: Span = tracer.spanBuilder("fibonacci_iteration")
                .setAttribute("iteration", i.toLong())
                .setAttribute("value", current)
                .startSpan()

            try {
                println("Iteration $i: $current")

                val next = prev + current
                prev = current
                current = next

                Thread.sleep(100)
            } finally {
                span.end()
            }
        }
        outerSpan.setStatus(StatusCode.OK)
    } catch (e: Exception) {
        outerSpan.setStatus(StatusCode.ERROR, "Error calculating Fibonacci")
        outerSpan.recordException(e)
        throw e
    } finally {
        outerSpan.end()
    }
}

fun main(args: Array<String>) {
    if (args.isEmpty()) {
        println("Usage: kotlin FibonacciApp <iterations>")
        exitProcess(1)
    }

    val iterations = args[0].toIntOrNull() ?: run {
        println("Please provide a valid number")
        exitProcess(1)
    }

    val openTelemetry = initializeOpenTelemetry()
    val tracer = openTelemetry.getTracer("fibonacci-tracer")

    println("Starting Fibonacci calculator")
    println("Fibonacci by Iteration - $iterations rounds")

    calculateFibonacci(iterations, tracer)

    println("Fibonacci complete")

    // Allow time for spans to be exported
    Thread.sleep(2000)
}
```

### How the code works

**`calculateFibonacci()` function:**
- Creates spans with proper error handling using try-finally blocks
- Records exceptions if they occur
- Sets span status to indicate success or failure
- Uses Kotlin's null-safety features

**`initializeOpenTelemetry()` function:**
- Configures the OTLP HTTP exporter
- Registers the tracer provider globally
- Uses Kotlin's builder patterns for clean configuration

## Step 3: Run locally

Compile and run your application:

```bash
./gradlew run --args="20"
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
- Error information if exceptions occurred

## Next steps

* Use the Java agent for automatic instrumentation of Kotlin/JVM applications
* Instrument coroutines with custom spans
* Add instrumentation to Ktor or Spring Boot applications
* Create [custom dashboards](/Getting-started/Tutorials/create-dashboard/) in OpsPilot

---

## Related Guides

- **[Configuration Guide](/Monitor-your-data/OpenTelemetry/Configuration/)**: Configure semantic conventions, resource attributes, and sampling strategies
- **[Visualize Your Data](/Monitor-your-data/OpenTelemetry/Visualize/Metrics/)**: Query and visualize your telemetry in OpsPilot
- **[Troubleshooting](/Monitor-your-data/OpenTelemetry/Troubleshooting/)**: Debug common instrumentation issues
- **[FAQ](/Monitor-your-data/OpenTelemetry/FAQ/)**: Common questions about instrumentation

---

!!! info "Learn more"
    [OpenTelemetry Java Documentation](https://opentelemetry.io/docs/languages/java/) (applies to Kotlin/JVM)

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.
