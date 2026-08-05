# Rust

This guide demonstrates how to instrument a Rust application with OpenTelemetry to send traces, metrics, and logs to OpsPilot.

!!! warning "Beta Status"
    OpenTelemetry Rust is currently in **Beta**. APIs may change between releases. Suitable for testing and development, but review release notes carefully before production use.

## Prerequisites

* **FusionReactor API Key**: Obtain this from **Account Settings > API Keys** in OpsPilot.
* **Rust**: Rust 1.65 or later installed on your system.
* **Telemetry Pipeline**: You must have either an [OpenTelemetry Collector](/Monitor-your-data/OpenTelemetry/Shipping/Collector/) or [Grafana Alloy](/Monitor-your-data/OpenTelemetry/Shipping/Grafana-agent/) configured and running to receive data from your Rust application.

!!! tip "Set up your telemetry pipeline first"
    Before instrumenting your Rust application, ensure you have completed either the [Collector setup guide](/Monitor-your-data/OpenTelemetry/Shipping/Collector/) or [Grafana Alloy setup guide](/Monitor-your-data/OpenTelemetry/Shipping/Grafana-agent/) so your telemetry data has a destination.

## Step 1: Add dependencies

Add the required OpenTelemetry crates to your `Cargo.toml`:

```toml
[dependencies]
opentelemetry = "0.21"
opentelemetry_sdk = { version = "0.21", features = ["rt-tokio"] }
opentelemetry-otlp = { version = "0.14", features = ["http-proto", "reqwest-client"] }
tokio = { version = "1", features = ["full"] }
```

## Step 2: Create your instrumented application

Create or modify your `src/main.rs`:

```rust
use opentelemetry::{global, trace::Tracer, KeyValue};
use opentelemetry_sdk::{trace as sdktrace, Resource};
use opentelemetry_otlp::WithExportConfig;
use std::{thread, time::Duration};

fn init_tracer() -> sdktrace::Tracer {
    opentelemetry_otlp::new_pipeline()
        .tracing()
        .with_exporter(
            opentelemetry_otlp::new_exporter()
                .http()
                .with_endpoint("http://localhost:4318/v1/traces"),
        )
        .with_trace_config(
            sdktrace::config().with_resource(Resource::new(vec![
                KeyValue::new("service.name", "fibonacci-service"),
            ])),
        )
        .install_batch(opentelemetry_sdk::runtime::Tokio)
        .expect("Failed to initialize tracer")
}

fn calculate_fibonacci(n: u32, tracer: &sdktrace::Tracer) {
    let mut prev = 0u64;
    let mut current = 1u64;

    tracer.in_span("calculate_fibonacci", |cx| {
        cx.span().set_attribute(KeyValue::new("iterations", n as i64));

        for i in 0..n {
            tracer.in_span("fibonacci_iteration", |cx| {
                cx.span().set_attribute(KeyValue::new("iteration", i as i64));
                cx.span().set_attribute(KeyValue::new("value", current as i64));

                println!("Iteration {}: {}", i + 1, current);

                let next = prev + current;
                prev = current;
                current = next;

                thread::sleep(Duration::from_millis(100));
            });
        }
    });
}

#[tokio::main]
async fn main() {
    let args: Vec<String> = std::env::args().collect();
    if args.len() < 2 {
        eprintln!("Usage: {} <iterations>", args[0]);
        std::process::exit(1);
    }

    let iterations: u32 = args[1].parse().expect("Please provide a valid number");

    let tracer = init_tracer();

    println!("Starting Fibonacci calculator");
    println!("Fibonacci by Iteration - {} rounds", iterations);

    calculate_fibonacci(iterations, &tracer);

    println!("Fibonacci complete");

    // Ensure all spans are flushed before exit
    global::shutdown_tracer_provider();
}
```

### How the code works

**`calculate_fibonacci()` function:**
- Creates an outer span to trace the entire operation
- Creates inner spans for each iteration
- Records iteration numbers and values as span attributes

**`init_tracer()` function:**
- Configures the OTLP HTTP exporter pointing to the collector
- Sets the service name (appears as `job` in OpsPilot)
- Uses Tokio runtime for async operations

## Step 3: Run locally

Build and run your instrumented application:

```bash
cargo run -- 20
```

The application will calculate 20 Fibonacci numbers and send telemetry to your local collector at `localhost:4318`.

!!! warning "Cannot connect to collector?"
    **If you see:** `Connection refused` or `Failed to export`
    **Fix:** Your collector is not running. Start it first using the [Collector setup guide](/Monitor-your-data/OpenTelemetry/Shipping/Collector/).

## Step 4: Verify in OpsPilot

1. Log in to **OpsPilot**
2. Navigate to **Explore**:
   - **Traces**: Select `Resource Service Name = fibonacci-service`
   - **Metrics**: Search for Rust application metrics

You should see:
- Trace spans showing the execution flow
- Span attributes with iteration numbers and values
- Timing information for each operation

## Next steps

* Add tracing to async operations using `#[tracing::instrument]` macro
* Instrument HTTP servers with `opentelemetry-http` and frameworks like Actix or Axum
* Create [custom dashboards](/Getting-started/Tutorials/create-dashboard/) in OpsPilot to visualize your Rust application metrics

---

## Related Guides

- **[Configuration Guide](/Monitor-your-data/OpenTelemetry/Configuration/)**: Configure semantic conventions, resource attributes, and sampling strategies
- **[Visualize Your Data](/Monitor-your-data/OpenTelemetry/Visualize/Metrics/)**: Query and visualize your telemetry in OpsPilot
- **[Troubleshooting](/Monitor-your-data/OpenTelemetry/Troubleshooting/)**: Debug common instrumentation issues
- **[FAQ](/Monitor-your-data/OpenTelemetry/FAQ/)**: Common questions about instrumentation

---

!!! info "Learn more"
    [OpenTelemetry Rust Documentation](https://opentelemetry.io/docs/languages/rust/)

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.
