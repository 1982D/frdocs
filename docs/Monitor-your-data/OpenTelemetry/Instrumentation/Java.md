# Java

This guide demonstrates how to instrument a Java application with OpenTelemetry to send traces, metrics, and logs to OpsPilot.

## Prerequisites

* **FusionReactor API Key**: Obtain this from **Account Settings > API Keys** in OpsPilot.
* **Java**: Java 8 or later installed on your system.
* **Telemetry Pipeline**: You must have either an [OpenTelemetry Collector](/Monitor-your-data/OpenTelemetry/Shipping/Collector/) or [Grafana Alloy](/Monitor-your-data/OpenTelemetry/Shipping/Grafana-agent/) configured and running to receive data from your Java application.

!!! tip "Set up your telemetry pipeline first"
    Before instrumenting your Java application, ensure you have completed either the [Collector setup guide](/Monitor-your-data/OpenTelemetry/Shipping/Collector/) or [Grafana Alloy setup guide](/Monitor-your-data/OpenTelemetry/Shipping/Grafana-agent/) so your telemetry data has a destination.

## Step 1: Download the OpenTelemetry Java Agent

The OpenTelemetry Java Agent provides automatic instrumentation without code changes. Download the latest version:

```bash
curl -L -O https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/latest/download/opentelemetry-javaagent.jar
```

This agent automatically instruments popular frameworks like Spring Boot, Tomcat, JDBC, and more.

## Step 2: Create your Java application

Create a simple Java application that demonstrates telemetry collection. Create a file named `FibonacciApp.java`:

```java
import java.util.concurrent.TimeUnit;

public class FibonacciApp {

    public static void main(String[] args) throws InterruptedException {
        if (args.length < 1) {
            System.out.println("Usage: java FibonacciApp <iterations>");
            System.exit(1);
        }

        int iterations = Integer.parseInt(args[0]);
        System.out.println("Starting Fibonacci calculator");
        System.out.println("Fibonacci by Iteration - " + iterations + " rounds");

        calculateFibonacci(iterations);

        System.out.println("Fibonacci complete");
    }

    public static void calculateFibonacci(int iterations) throws InterruptedException {
        long prev = 0;
        long current = 1;

        for (int i = 0; i < iterations; i++) {
            System.out.println("Iteration " + (i + 1) + ": " + current);

            long next = prev + current;
            prev = current;
            current = next;

            // Simulate work
            TimeUnit.MILLISECONDS.sleep(100);
        }
    }
}
```

Compile the application:

```bash
javac FibonacciApp.java
```

### How automatic instrumentation works

The OpenTelemetry Java Agent automatically:
- Creates spans for HTTP requests, database calls, and messaging operations
- Captures JVM metrics (CPU, memory, garbage collection)
- Instruments HTTP clients/servers, database calls, and messaging
- Propagates trace context across service boundaries

!!! info "Best suited for web frameworks"
    The Java agent works by auto-instrumenting supported frameworks such as Spring Boot, Tomcat, JDBC, and gRPC. A plain command-line application like `FibonacciApp` will not produce traces since it contains no instrumented code paths. For full trace, metric, and log output, attach the agent to a web service (e.g. Spring Boot) where HTTP requests are the natural instrumentation entry point.

## Step 3: Run with OpenTelemetry Agent

Run your Java application with the OpenTelemetry agent attached:

```bash
java -javaagent:opentelemetry-javaagent.jar \
  -Dotel.service.name=fibonacci-service \
  -Dotel.traces.exporter=otlp \
  -Dotel.metrics.exporter=otlp \
  -Dotel.logs.exporter=otlp \
  -Dotel.exporter.otlp.endpoint=http://localhost:4318 \
  -Dotel.exporter.otlp.protocol=http/protobuf \
  FibonacciApp 20
```

### Configuration options explained

* `-javaagent:opentelemetry-javaagent.jar`: Attaches the OpenTelemetry agent
* `-Dotel.service.name`: Sets the service name (appears as `job` in OpsPilot)
* `-Dotel.exporter.otlp.endpoint`: Points to your local collector
* `-Dotel.exporter.otlp.protocol`: Uses HTTP protocol (port 4318)

!!! warning "Cannot connect to collector?"
    **If you see:** `Failed to export spans` or `Connection refused`
    **Fix:** Your collector is not running. Start it first using the [Collector setup guide](/Monitor-your-data/OpenTelemetry/Shipping/Collector/).

## Step 4: Verify in OpsPilot

1. Log in to **OpsPilot**
2. Navigate to **Explore**:
   - **Traces**: Select `Resource Service Name = fibonacci-service`
   - **Metrics**: Search for JVM metrics like `process.runtime.jvm.memory.usage{job="fibonacci-service"}`
   - **Logs**: Filter by `job = fibonacci-service`

You should see:
- Trace spans showing method executions
- JVM metrics (heap usage, GC activity, thread counts)
- Log entries from your application

## Next steps

* Use the agent with Spring Boot applications for automatic REST endpoint instrumentation
* Configure [agent extensions](https://opentelemetry.io/docs/languages/java/automatic/extensions/) for custom instrumentation
* Add manual instrumentation for business-specific tracing using the [Java SDK](https://opentelemetry.io/docs/languages/java/instrumentation/)
* Create [custom dashboards](/Getting-started/Tutorials/create-dashboard/) in OpsPilot to visualize your Java application metrics

---

## Related Guides

- **[Configuration Guide](/Monitor-your-data/OpenTelemetry/Configuration/)**: Configure semantic conventions, resource attributes, and sampling strategies
- **[Visualize Your Data](/Monitor-your-data/OpenTelemetry/Visualize/Metrics/)**: Query and visualize your telemetry in OpsPilot
- **[Troubleshooting](/Monitor-your-data/OpenTelemetry/Troubleshooting/)**: Debug common instrumentation issues
- **[FAQ](/Monitor-your-data/OpenTelemetry/FAQ/)**: Common questions about instrumentation

---

!!! info "Learn more"
    [OpenTelemetry Java Documentation](https://opentelemetry.io/docs/languages/java/)

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.
