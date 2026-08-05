# .NET

This guide demonstrates how to instrument a .NET application with OpenTelemetry to send traces, metrics, and logs to OpsPilot.

## Prerequisites

* **FusionReactor API Key**: Obtain this from **Account Settings > API Keys** in OpsPilot.
* **.NET**: .NET 6.0 or later installed on your system.
* **Telemetry Pipeline**: You must have either an [OpenTelemetry Collector](/Monitor-your-data/OpenTelemetry/Shipping/Collector/) or [Grafana Alloy](/Monitor-your-data/OpenTelemetry/Shipping/Grafana-agent/) configured and running to receive data from your .NET application.

!!! tip "Set up your telemetry pipeline first"
    Before instrumenting your .NET application, ensure you have completed either the [Collector setup guide](/Monitor-your-data/OpenTelemetry/Shipping/Collector/) or [Grafana Alloy setup guide](/Monitor-your-data/OpenTelemetry/Shipping/Grafana-agent/) so your telemetry data has a destination.

## Step 1: Install dependencies

Install the required OpenTelemetry packages using the .NET CLI:

```bash
dotnet add package OpenTelemetry
dotnet add package OpenTelemetry.Exporter.OpenTelemetryProtocol
dotnet add package OpenTelemetry.Extensions.Hosting
dotnet add package OpenTelemetry.Instrumentation.Runtime
```

## Step 2: Create your instrumented application

Create a simple .NET console application. Create a file named `Program.cs`:

```csharp
using System;
using System.Diagnostics;
using System.Threading;
using OpenTelemetry;
using OpenTelemetry.Resources;
using OpenTelemetry.Trace;
using OpenTelemetry.Metrics;

class FibonacciApp
{
    private static readonly ActivitySource activitySource = new("FibonacciApp");

    static void Main(string[] args)
    {
        if (args.Length < 1)
        {
            Console.WriteLine("Usage: dotnet run <iterations>");
            return;
        }

        int iterations = int.Parse(args[0]);

        // Configure OpenTelemetry
        using var tracerProvider = Sdk.CreateTracerProviderBuilder()
            .SetResourceBuilder(ResourceBuilder.CreateDefault().AddService("fibonacci-service"))
            .AddSource("FibonacciApp")
            .AddOtlpExporter(options =>
            {
                options.Endpoint = new Uri("http://localhost:4318/v1/traces");
                options.Protocol = OpenTelemetry.Exporter.OtlpExportProtocol.HttpProtobuf;
            })
            .Build();

        using var meterProvider = Sdk.CreateMeterProviderBuilder()
            .SetResourceBuilder(ResourceBuilder.CreateDefault().AddService("fibonacci-service"))
            .AddRuntimeInstrumentation()
            .AddOtlpExporter(options =>
            {
                options.Endpoint = new Uri("http://localhost:4318/v1/metrics");
                options.Protocol = OpenTelemetry.Exporter.OtlpExportProtocol.HttpProtobuf;
            })
            .Build();

        Console.WriteLine("Starting Fibonacci calculator");
        Console.WriteLine($"Fibonacci by Iteration - {iterations} rounds");

        CalculateFibonacci(iterations);

        Console.WriteLine("Fibonacci complete");
    }

    static void CalculateFibonacci(int iterations)
    {
        using var activity = activitySource.StartActivity("fibonacci-calculation");
        activity?.SetTag("iterations", iterations);

        long prev = 0;
        long current = 1;

        for (int i = 0; i < iterations; i++)
        {
            using var iterationActivity = activitySource.StartActivity($"fibonacci-iteration");
            iterationActivity?.SetTag("iteration", i + 1);
            iterationActivity?.SetTag("value", current);

            Console.WriteLine($"Iteration {i + 1}: {current}");

            long next = prev + current;
            prev = current;
            current = next;

            Thread.Sleep(100); // Simulate work
        }
    }
}
```

### How the code works

**`CalculateFibonacci()` method:**
Calculates the Fibonacci sequence while creating telemetry:
- Creates an outer activity (`fibonacci-calculation`) to trace the entire operation
- Creates inner activities for each iteration
- Records the iteration number and value as tags
- Emits telemetry through the configured providers

**OpenTelemetry configuration:**
Sets up the two OpenTelemetry providers:
- **Tracer Provider** - Sends trace data to the collector
- **Meter Provider** - Sends metrics data (including .NET runtime metrics) to the collector

Both providers use the same service name (`fibonacci-service`), which appears as the `job` label in OpsPilot.

## Step 3: Run locally

Test your instrumented application:

```bash
dotnet run -- 20
```

The application will calculate 20 Fibonacci numbers and send telemetry to your local collector at `localhost:4318`.

!!! warning "Cannot connect to collector?"
    **If you see:** `Failed to send spans` or `No connection could be made`
    **Fix:** Your collector is not running. Start it first using the [Collector setup guide](/Monitor-your-data/OpenTelemetry/Shipping/Collector/).

## Step 4: Verify in OpsPilot

1. Log in to **OpsPilot**
2. Navigate to **Explore**:
   - **Traces**: Select `Resource Service Name = fibonacci-service`
   - **Metrics**: Go to **Explore > Metrics** and search for .NET runtime metrics prefixed with `process_runtime_dotnet` (e.g. `process_runtime_dotnet_gc_collections_count`)

You should see:
- Trace activities showing the execution flow (`fibonacci-calculation` and iterations)
- .NET runtime metrics (GC collections, memory usage, thread counts)

!!! info "Logging"
    This example does not include OTel log export. In .NET, logging integration works best with the hosted service model (ASP.NET Core). See the [Next steps](#next-steps) section for more details.

## Next steps

* Use automatic instrumentation for ASP.NET Core applications with [`OpenTelemetry.Instrumentation.AspNetCore`](https://opentelemetry.io/docs/languages/net/automatic/)
* Instrument HTTP clients with `OpenTelemetry.Instrumentation.Http`
* Instrument database calls with `OpenTelemetry.Instrumentation.SqlClient`
* Create [custom dashboards](/Getting-started/Tutorials/create-dashboard/) in OpsPilot to visualize your .NET application metrics

---

## Related Guides

- **[Configuration Guide](/Monitor-your-data/OpenTelemetry/Configuration/)**: Configure semantic conventions, resource attributes, and sampling strategies
- **[Visualize Your Data](/Monitor-your-data/OpenTelemetry/Visualize/Metrics/)**: Query and visualize your telemetry in OpsPilot
- **[Troubleshooting](/Monitor-your-data/OpenTelemetry/Troubleshooting/)**: Debug common instrumentation issues
- **[FAQ](/Monitor-your-data/OpenTelemetry/FAQ/)**: Common questions about instrumentation

---

!!! info "Learn more"
    [OpenTelemetry .NET Documentation](https://opentelemetry.io/docs/languages/net/)

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.
