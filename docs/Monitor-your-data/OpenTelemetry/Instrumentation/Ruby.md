# Ruby

This guide demonstrates how to instrument a Ruby application with OpenTelemetry to send traces and metrics to OpsPilot.

## Prerequisites

* **FusionReactor API Key**: Obtain this from **Account Settings > API Keys** in OpsPilot.
* **Ruby**: Ruby 3.0 or later installed on your system.
* **Telemetry Pipeline**: You must have either an [OpenTelemetry Collector](/Monitor-your-data/OpenTelemetry/Shipping/Collector/) or [Grafana Alloy](/Monitor-your-data/OpenTelemetry/Shipping/Grafana-agent/) configured and running to receive data from your Ruby application.

!!! tip "Set up your telemetry pipeline first"
    Before instrumenting your Ruby application, ensure you have completed either the [Collector setup guide](/Monitor-your-data/OpenTelemetry/Shipping/Collector/) or [Grafana Alloy setup guide](/Monitor-your-data/OpenTelemetry/Shipping/Grafana-agent/) so your telemetry data has a destination.

!!! note "Logs Support"
    OpenTelemetry Ruby currently supports traces and metrics in stable releases. Log instrumentation is in beta.

## Step 1: Install dependencies

Add the required OpenTelemetry gems to your `Gemfile`:

```ruby
gem 'opentelemetry-sdk'
gem 'opentelemetry-exporter-otlp'
gem 'opentelemetry-instrumentation-all'
```

Install the gems:

```bash
bundle install
```

## Step 2: Create your instrumented application

Create a file named `fib_app.rb` with the following code. This example calculates Fibonacci numbers while sending telemetry data:

```ruby
require 'opentelemetry/sdk'
require 'opentelemetry/exporter/otlp'
require 'opentelemetry/instrumentation/all'

# Configure OpenTelemetry
OpenTelemetry::SDK.configure do |c|
  c.service_name = 'fibonacci-service'
  c.use_all() # Enables all available instrumentation

  c.add_span_processor(
    OpenTelemetry::SDK::Trace::Export::BatchSpanProcessor.new(
      OpenTelemetry::Exporter::OTLP::Exporter.new(
        endpoint: 'http://localhost:4318/v1/traces',
        headers: {}
      )
    )
  )
end

tracer = OpenTelemetry.tracer_provider.tracer('fibonacci-tracer')

def calculate_fibonacci(n, tracer)
  tracer.in_span('calculate_fibonacci', attributes: { 'iterations' => n }) do |span|
    prev_num = 0
    current = 1

    n.times do |i|
      tracer.in_span('fibonacci_iteration', attributes: { 'iteration' => i + 1 }) do
        puts "Iteration #{i + 1}: #{current}"

        next_num = prev_num + current
        prev_num = current
        current = next_num

        sleep(0.1) # Simulate work
      end
    end
  end
end

# Main execution
if ARGV.length < 1
  puts "Usage: ruby fib_app.rb <iterations>"
  exit 1
end

iterations = ARGV[0].to_i

puts "Starting Fibonacci calculator"
puts "Fibonacci by Iteration - #{iterations} rounds"

calculate_fibonacci(iterations, tracer)

puts "Fibonacci complete"
```

### How the code works

**`calculate_fibonacci()` function:**
Calculates the Fibonacci sequence while creating telemetry:
- Creates an outer span (`calculate_fibonacci`) to trace the entire operation
- Creates inner spans for each iteration
- Records the iteration number as span attributes
- Automatically captures timing information

**OpenTelemetry configuration:**
Sets up the tracer provider:
- **Service Name** - Identifies the application (appears as `job` in OpsPilot)
- **Span Processor** - Batches and exports spans to the collector
- **Automatic Instrumentation** - `use_all()` enables instrumentation for common Ruby libraries

## Step 3: Run locally

Test your instrumented application:

```bash
ruby fib_app.rb 20
```

The application will calculate 20 Fibonacci numbers and send telemetry to your local collector at `localhost:4318`.

!!! warning "Cannot connect to collector?"
    **If you see:** `Connection refused` or `Failed to export`
    **Fix:** Your collector is not running. Start it first using the [Collector setup guide](/Monitor-your-data/OpenTelemetry/Shipping/Collector/).

## Step 4: Verify in OpsPilot

1. Log in to **OpsPilot**
2. Navigate to **Explore**:
   - **Traces**: Select `Resource Service Name = fibonacci-service`
   - **Metrics**: Search for Ruby runtime metrics (if using instrumentation)

You should see:
- Trace spans showing the execution flow (`calculate_fibonacci` and iterations)
- Span attributes with iteration numbers
- Timing information for each operation

## Next steps

* Instrument Rails applications with [`opentelemetry-instrumentation-rails`](https://opentelemetry.io/docs/languages/ruby/automatic/)
* Add HTTP instrumentation with `opentelemetry-instrumentation-http`
* Instrument database calls with `opentelemetry-instrumentation-active_record`
* Create [custom dashboards](/Getting-started/Tutorials/create-dashboard/) in OpsPilot to visualize your Ruby application metrics

---

## Related Guides

- **[Configuration Guide](/Monitor-your-data/OpenTelemetry/Configuration/)**: Configure semantic conventions, resource attributes, and sampling strategies
- **[Visualize Your Data](/Monitor-your-data/OpenTelemetry/Visualize/Metrics/)**: Query and visualize your telemetry in OpsPilot
- **[Troubleshooting](/Monitor-your-data/OpenTelemetry/Troubleshooting/)**: Debug common instrumentation issues
- **[FAQ](/Monitor-your-data/OpenTelemetry/FAQ/)**: Common questions about instrumentation

---

!!! info "Learn more"
    [OpenTelemetry Ruby Documentation](https://opentelemetry.io/docs/languages/ruby/)

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.
