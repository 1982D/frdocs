# C++

This guide demonstrates how to instrument a C++ application with OpenTelemetry to send traces and metrics to OpsPilot.

## Prerequisites

* **FusionReactor API Key**: Obtain this from **Account Settings > API Keys** in OpsPilot.
* **C++ Compiler**: C++17 or later (GCC 9+, Clang 10+, or MSVC 2019+)
* **CMake**: Version 3.20 or later
* **Telemetry Pipeline**: You must have either an [OpenTelemetry Collector](/Monitor-your-data/OpenTelemetry/Shipping/Collector/) or [Grafana Alloy](/Monitor-your-data/OpenTelemetry/Shipping/Grafana-agent/) configured and running to receive data from your C++ application.

!!! tip "Set up your telemetry pipeline first"
    Before instrumenting your C++ application, ensure you have completed either the [Collector setup guide](/Monitor-your-data/OpenTelemetry/Shipping/Collector/) or [Grafana Alloy setup guide](/Monitor-your-data/OpenTelemetry/Shipping/Grafana-agent/) so your telemetry data has a destination.

## Step 1: Install dependencies

The easiest way to install OpenTelemetry C++ is using [vcpkg](https://vcpkg.io/):

```bash
# Install vcpkg if you haven't already
git clone https://github.com/Microsoft/vcpkg.git
cd vcpkg
./bootstrap-vcpkg.sh  # On Windows: .\bootstrap-vcpkg.bat

# Install OpenTelemetry C++
./vcpkg install opentelemetry-cpp[otlp-http]
```

Alternatively, you can build OpenTelemetry C++ from source. See the [official documentation](https://github.com/open-telemetry/opentelemetry-cpp) for details.

## Step 2: Configure your build

Create a `CMakeLists.txt` file in your project directory:

```cmake
cmake_minimum_required(VERSION 3.20)
project(otel-cpp-demo)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find required packages
find_package(CURL REQUIRED)
find_package(Protobuf REQUIRED)
find_package(nlohmann_json REQUIRED)
find_package(opentelemetry-cpp CONFIG REQUIRED)

# Create executable
add_executable(otel-demo
    src/main.cpp
    src/otel.cpp
)

# Link OpenTelemetry libraries
target_link_libraries(otel-demo
    PRIVATE
        opentelemetry-cpp::trace
        opentelemetry-cpp::metrics
        opentelemetry-cpp::logs
        opentelemetry-cpp::common
        opentelemetry-cpp::resources
        opentelemetry-cpp::otlp_http_exporter
        opentelemetry-cpp::otlp_http_metric_exporter
        opentelemetry-cpp::http_client_curl
        ${CURL_LIBRARIES}
        ${Protobuf_LIBRARIES}
)

target_include_directories(otel-demo PRIVATE src)
```

## Step 3: Create OpenTelemetry initialization

Create `src/otel.h`:

```cpp
#pragma once

#include <string>
#include <memory>

namespace otel_demo {

// Initialize OpenTelemetry SDK with OTLP exporters
void initOpenTelemetry(const std::string& endpoint, const std::string& service_name);

// Shutdown OpenTelemetry SDK
void shutdownOpenTelemetry();

} // namespace otel_demo
```

Create `src/otel.cpp`:

```cpp
#include "otel.h"

#include "opentelemetry/sdk/trace/tracer_provider.h"
#include "opentelemetry/sdk/trace/batch_span_processor.h"
#include "opentelemetry/sdk/trace/batch_span_processor_options.h"
#include "opentelemetry/exporters/otlp/otlp_http_exporter.h"
#include "opentelemetry/exporters/otlp/otlp_http_exporter_options.h"

#include "opentelemetry/sdk/metrics/meter_provider.h"
#include "opentelemetry/sdk/metrics/export/periodic_exporting_metric_reader.h"
#include "opentelemetry/sdk/metrics/view/view_registry.h"
#include "opentelemetry/exporters/otlp/otlp_http_metric_exporter.h"
#include "opentelemetry/exporters/otlp/otlp_http_metric_exporter_options.h"

#include "opentelemetry/sdk/resource/resource.h"
#include "opentelemetry/sdk/resource/semantic_conventions.h"

#include "opentelemetry/trace/provider.h"
#include "opentelemetry/metrics/provider.h"

#include <iostream>

namespace trace_api = opentelemetry::trace;
namespace trace_sdk = opentelemetry::sdk::trace;
namespace otlp = opentelemetry::exporter::otlp;
namespace metrics_api = opentelemetry::metrics;
namespace metrics_sdk = opentelemetry::sdk::metrics;
namespace resource = opentelemetry::sdk::resource;

namespace otel_demo {

void initOpenTelemetry(const std::string& endpoint, const std::string& service_name) {
    // Create resource attributes
    auto resource_attributes = resource::ResourceAttributes{
        {resource::SemanticConventions::kServiceName, service_name},
        {resource::SemanticConventions::kServiceVersion, "1.0.0"}
    };
    auto resource_ptr = resource::Resource::Create(resource_attributes);

    // Configure OTLP trace exporter
    otlp::OtlpHttpExporterOptions trace_opts;
    trace_opts.url = endpoint + "/v1/traces";
    trace_opts.content_type = otlp::HttpRequestContentType::kJson;

    auto trace_exporter = std::make_unique<otlp::OtlpHttpExporter>(trace_opts);
    auto trace_processor = std::make_unique<trace_sdk::BatchSpanProcessor>(
        std::move(trace_exporter),
        trace_sdk::BatchSpanProcessorOptions{}
    );

    // Create tracer provider
    std::shared_ptr<trace_api::TracerProvider> tracer_provider =
        std::make_shared<trace_sdk::TracerProvider>(
            std::move(trace_processor),
            resource_ptr
        );

    // Set global tracer provider
    trace_api::Provider::SetTracerProvider(tracer_provider);

    // Configure OTLP metric exporter
    otlp::OtlpHttpMetricExporterOptions metric_opts;
    metric_opts.url = endpoint + "/v1/metrics";
    metric_opts.content_type = otlp::HttpRequestContentType::kJson;

    auto metric_exporter = std::make_unique<otlp::OtlpHttpMetricExporter>(metric_opts);

    metrics_sdk::PeriodicExportingMetricReaderOptions reader_options;
    reader_options.export_interval_millis = std::chrono::milliseconds(5000);

    auto metric_reader = std::make_unique<metrics_sdk::PeriodicExportingMetricReader>(
        std::move(metric_exporter),
        reader_options
    );

    // Create meter provider (v1.14+: add reader after construction)
    auto meter_provider_sdk = std::make_shared<metrics_sdk::MeterProvider>(
        std::unique_ptr<metrics_sdk::ViewRegistry>(new metrics_sdk::ViewRegistry()),
        resource_ptr
    );
    meter_provider_sdk->AddMetricReader(std::move(metric_reader));

    // Set global meter provider
    std::shared_ptr<metrics_api::MeterProvider> meter_provider = meter_provider_sdk;
    metrics_api::Provider::SetMeterProvider(meter_provider);

    std::cout << "OpenTelemetry initialized successfully" << std::endl;
}

void shutdownOpenTelemetry() {
    std::cout << "Shutting down OpenTelemetry" << std::endl;
}

} // namespace otel_demo
```

## Step 4: Create your instrumented application

Create `src/main.cpp`:

```cpp
#include "otel.h"

#include "opentelemetry/trace/provider.h"
#include "opentelemetry/metrics/provider.h"
#include "opentelemetry/trace/span_startoptions.h"
#include "opentelemetry/common/attribute_value.h"

#include <iostream>
#include <thread>
#include <chrono>
#include <map>
#include <string>

namespace trace = opentelemetry::trace;
namespace metrics = opentelemetry::metrics;
namespace nostd = opentelemetry::nostd;

// Fibonacci calculation with tracing
// v1.14+: GetTracer() returns nostd::shared_ptr, not std::shared_ptr
uint64_t fibonacci(int n, nostd::shared_ptr<trace::Tracer> tracer) {
    trace::StartSpanOptions options;
    options.kind = trace::SpanKind::kInternal;

    auto span = tracer->StartSpan("fibonacci-calculation", options);
    span->SetAttribute("iteration.count", n);

    uint64_t a = 0, b = 1;

    for (int i = 0; i < n; i++) {
        uint64_t temp = a;
        a = b;
        b = temp + b;
    }

    span->End();
    return a;
}

int main() {
    // Initialize OpenTelemetry
    const std::string endpoint = "http://localhost:4318";
    const std::string service_name = "cpp-otel-demo";

    otel_demo::initOpenTelemetry(endpoint, service_name);

    // Get tracer and meter
    auto provider = trace::Provider::GetTracerProvider();
    auto tracer = provider->GetTracer(service_name, "1.0.0");

    auto meter_provider = metrics::Provider::GetMeterProvider();
    auto meter = meter_provider->GetMeter(service_name, "1.0.0");

    // Create custom metrics
    auto request_counter = meter->CreateUInt64Counter(
        "fibonacci_requests_total",
        "Total number of Fibonacci calculations",
        "requests"
    );

    auto calculation_duration = meter->CreateUInt64Histogram(
        "fibonacci_calculation_duration_ms",
        "Fibonacci calculation duration in milliseconds",
        "ms"
    );

    std::cout << "Starting Fibonacci calculations..." << std::endl;

    // Perform calculations with instrumentation
    for (int i = 1; i <= 20; i++) {
        trace::StartSpanOptions options;
        auto span = tracer->StartSpan("fibonacci-request", options);
        span->SetAttribute("fibonacci.n", i);

        auto start = std::chrono::high_resolution_clock::now();

        // Calculate Fibonacci
        uint64_t result = fibonacci(i, tracer);

        auto end = std::chrono::high_resolution_clock::now();
        auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(end - start);

        std::cout << "Fibonacci(" << i << ") = " << result << std::endl;

        // Record metrics
        // v1.14+: attributes require explicit map type; Histogram::Record requires a Context
        std::map<std::string, opentelemetry::common::AttributeValue> counter_attrs = {
            {"result", std::to_string(result)}
        };
        request_counter->Add(1, counter_attrs);

        std::map<std::string, opentelemetry::common::AttributeValue> hist_attrs = {
            {"n", std::to_string(i)}
        };
        calculation_duration->Record(duration.count(), hist_attrs, opentelemetry::context::Context{});

        span->End();

        std::this_thread::sleep_for(std::chrono::milliseconds(500));
    }

    std::cout << "Calculations complete!" << std::endl;

    // Shutdown OpenTelemetry
    otel_demo::shutdownOpenTelemetry();

    return 0;
}
```

## Step 5: Build and run locally

Build your application:

```bash
mkdir build
cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE=/path/to/vcpkg/scripts/buildsystems/vcpkg.cmake
cmake --build .
```

Run the application (ensure your collector is running on `localhost:4318`):

```bash
./otel-demo
```

The application will send telemetry to your local collector at `localhost:4318`.

!!! warning "Cannot connect to collector?"
    **If you see:** `Connection refused` or connection errors
    **Fix:** Your collector is not running. Start it first using the [Collector setup guide](/Monitor-your-data/OpenTelemetry/Shipping/Collector/).

## Step 6: Verify in OpsPilot

1. Log in to **OpsPilot**

2. Navigate to **Explore**:
   - **Traces**: Select `Resource Service Name = cpp-otel-demo`
   - **Metrics**: Search for `fibonacci_requests_total{job="cpp-otel-demo"}`

You should see:
- Trace spans for each Fibonacci calculation
- Nested spans showing `fibonacci-request` and `fibonacci-calculation`
- Metrics tracking request counts and calculation duration
- Span attributes showing the iteration count

## Next steps

* Instrument HTTP clients using [OpenTelemetry C++ HTTP instrumentation](https://github.com/open-telemetry/opentelemetry-cpp-contrib/tree/main/instrumentation)
* Add gRPC instrumentation with [opentelemetry-cpp-contrib](https://github.com/open-telemetry/opentelemetry-cpp-contrib)
* Implement custom context propagation for distributed tracing
* Create [custom dashboards](/Getting-started/Tutorials/create-dashboard/) in OpsPilot

---

## Related Guides

- **[Configuration Guide](/Monitor-your-data/OpenTelemetry/Configuration/)**: Configure semantic conventions, resource attributes, and sampling strategies
- **[Visualize Your Data](/Monitor-your-data/OpenTelemetry/Visualize/Metrics/)**: Query and visualize your telemetry in OpsPilot
- **[Troubleshooting](/Monitor-your-data/OpenTelemetry/Troubleshooting/)**: Debug common instrumentation issues
- **[FAQ](/Monitor-your-data/OpenTelemetry/FAQ/)**: Common questions about instrumentation

---

!!! info "Learn more"
    [OpenTelemetry C++ Documentation](https://opentelemetry.io/docs/instrumentation/cpp/)

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.
