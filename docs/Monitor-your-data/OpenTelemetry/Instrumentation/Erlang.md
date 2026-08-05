# Erlang/Elixir

This guide demonstrates how to instrument an Erlang or Elixir application with OpenTelemetry to send traces and metrics to OpsPilot.

!!! note "Platform Status"
    OpenTelemetry Erlang/Elixir is **stable for traces and metrics**. Logs are in beta. Works with both Erlang and Elixir applications.

## Prerequisites

* **FusionReactor API Key**: Obtain this from **Account Settings > API Keys** in OpsPilot.
* **Erlang/OTP**: 22+ or **Elixir**: 1.11+ installed on your system.
* **Telemetry Pipeline**: You must have either an [OpenTelemetry Collector](/Monitor-your-data/OpenTelemetry/Shipping/Collector/) or [Grafana Alloy](/Monitor-your-data/OpenTelemetry/Shipping/Grafana-agent/) configured and running to receive data from your application.

!!! tip "Set up your telemetry pipeline first"
    Before instrumenting your application, ensure you have completed either the [Collector setup guide](/Monitor-your-data/OpenTelemetry/Shipping/Collector/) or [Grafana Alloy setup guide](/Monitor-your-data/OpenTelemetry/Shipping/Grafana-agent/) so your telemetry data has a destination.

## For Elixir Applications

### Step 1: Add dependencies

Add to your `mix.exs`:

```elixir
def deps do
  [
    {:opentelemetry, "~> 1.3"},
    {:opentelemetry_exporter, "~> 1.6"},
    {:opentelemetry_api, "~> 1.2"}
  ]
end
```

Install dependencies:

```bash
mix deps.get
```

### Step 2: Configure OpenTelemetry

Add to your `config/config.exs`:

```elixir
config :opentelemetry, :resource,
  service: [
    name: "fibonacci-service"
  ]

config :opentelemetry, :processors,
  otel_batch_processor: %{
    exporter: {:opentelemetry_exporter, %{
      endpoints: ["http://localhost:4318/v1/traces"],
      protocol: :http_protobuf
    }}
  }
```

### Step 3: Create your instrumented application

Create `lib/fibonacci.ex`:

```elixir
defmodule Fibonacci do
  require OpenTelemetry.Tracer, as: Tracer

  def calculate(n) do
    Tracer.with_span "calculate_fibonacci", %{iterations: n} do
      Enum.reduce(1..n, {0, 1}, fn i, {prev, current} ->
        Tracer.with_span "fibonacci_iteration", %{iteration: i, value: current} do
          IO.puts("Iteration #{i}: #{current}")
          Process.sleep(100)
          {current, prev + current}
        end
      end)
    end
  end

  def main(args) do
    case args do
      [n_str | _] ->
        n = String.to_integer(n_str)
        IO.puts("Starting Fibonacci calculator")
        IO.puts("Fibonacci by Iteration - #{n} rounds")

        calculate(n)

        IO.puts("Fibonacci complete")
      _ ->
        IO.puts("Usage: mix run -e 'Fibonacci.main([\"20\"])'")
    end
  end
end
```

### Step 4: Run locally

```bash
mix run -e 'Fibonacci.main(["20"])'
```

The application will calculate 20 Fibonacci numbers and send telemetry to your local collector.

!!! warning "Cannot connect to collector?"
    **If you see:** Connection errors
    **Fix:** Your collector is not running. Start it first using the [Collector setup guide](/Monitor-your-data/OpenTelemetry/Shipping/Collector/).

## For Erlang Applications

### Dependencies

Add to your `rebar.config`:

```erlang
{deps, [
    {opentelemetry_api, "~> 1.2"},
    {opentelemetry, "~> 1.3"},
    {opentelemetry_exporter, "~> 1.6"}
]}.
```

### Configuration

Add to `config/sys.config`:

```erlang
[
  {opentelemetry,
   [{resource, #{service => #{name => <<"fibonacci-service">>}}},
    {processors, [
      {otel_batch_processor, #{
        exporter => {opentelemetry_exporter, #{
          endpoints => [<<"http://localhost:4318/v1/traces">>],
          protocol => http_protobuf
        }}
      }}
    ]}
   ]}
].
```

## Step 5: Verify in OpsPilot

1. Log in to **OpsPilot**
2. Navigate to **Explore**:
   - **Traces**: Select `Resource Service Name = fibonacci-service`
   - **Metrics**: Search for application metrics

You should see:
- Trace spans showing the execution flow
- Span attributes with iteration information
- Timing data for operations

## Next steps

* Instrument Phoenix applications with `opentelemetry_phoenix`
* Add Ecto instrumentation with `opentelemetry_ecto`
* Instrument HTTP clients with automatic libraries
* Create [custom dashboards](/Getting-started/Tutorials/create-dashboard/) in OpsPilot

---

## Related Guides

- **[Configuration Guide](/Monitor-your-data/OpenTelemetry/Configuration/)**: Configure semantic conventions, resource attributes, and sampling strategies
- **[Visualize Your Data](/Monitor-your-data/OpenTelemetry/Visualize/Metrics/)**: Query and visualize your telemetry in OpsPilot
- **[Troubleshooting](/Monitor-your-data/OpenTelemetry/Troubleshooting/)**: Debug common instrumentation issues
- **[FAQ](/Monitor-your-data/OpenTelemetry/FAQ/)**: Common questions about instrumentation

---

!!! info "Learn more"
    [OpenTelemetry Erlang/Elixir Documentation](https://opentelemetry.io/docs/languages/erlang/)

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.
