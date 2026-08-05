# Instrumentation Overview

Instrumentation enables your application to generate and send telemetry data (traces, metrics, and logs). OpenTelemetry provides two primary approaches: **Zero-code** and **Manual**.

### 1. Zero-code (Automatic) Instrumentation

This is the recommended starting point for most users. It allows you to gather telemetry without modifying your application's source code.

* **How it works:** A language-specific agent or Kubernetes Operator injects observability into your application at runtime.
* **Benefits:** Instant visibility into HTTP requests, database queries, and external API calls without code changes.
* **Best for:** Java, Python, .NET, Node.js, PHP, and Go (via eBPF).

!!! info "Learn more"
    [Automatic Instrumentation](https://opentelemetry.io/docs/concepts/instrumentation/automatic/)

### 2. Code-based (Manual) Instrumentation

Manual instrumentation captures specific business logic or custom events that automatic tools cannot detect.

* **How it works:** Use the OpenTelemetry API in your source code to create spans, record custom metrics, or add specific attributes to logs.
* **Benefits:** High-precision data tailored to your business requirements.
* **Best for:** Custom performance tracking and complex business workflows.

!!! info "Learn more"
    [Manual Instrumentation](https://opentelemetry.io/docs/concepts/instrumentation/manual/)

---

## Supported Languages

OpenTelemetry supports 12+ languages. Select your language below to get started with instrumentation for OpsPilot.

### Production-Ready (Stable)

These languages have stable implementations for traces, metrics, and logs:

| Language | Zero-Code Support | Status | Guide |
|----------|-------------------|--------|-------|
| **C++** | ❌ | ✅ Stable | [View Guide](/Monitor-your-data/OpenTelemetry/Instrumentation/Cpp/) |
| **.NET** | ✅ | ✅ Stable | [View Guide](/Monitor-your-data/OpenTelemetry/Instrumentation/DotNet/) |
| **Java** | ✅ | ✅ Stable | [View Guide](/Monitor-your-data/OpenTelemetry/Instrumentation/Java/) |
| **PHP** | ✅ | ✅ Stable | [View Guide](/Monitor-your-data/OpenTelemetry/Instrumentation/PHP/) |
| **Python** | ✅ | ✅ Stable | [View Guide](/Monitor-your-data/OpenTelemetry/Instrumentation/Python/) |

### Stable for Traces & Metrics

These languages are stable but logs are still in development:

| Language | Zero-Code Support | Status | Guide |
|----------|-------------------|--------|-------|
| **Erlang/Elixir** | ❌ | ✅ Stable (T/M), 🚧 Beta (Logs) | [View Guide](/Monitor-your-data/OpenTelemetry/Instrumentation/Erlang/) |
| **Go** | ✅ | ✅ Stable (T/M), 🚧 Beta (Logs) | [View Guide](/Monitor-your-data/OpenTelemetry/Instrumentation/Go/) |
| **Node.js** | ✅ | ✅ Stable (T/M), 🚧 Beta (Logs) | [View Guide](/Monitor-your-data/OpenTelemetry/Instrumentation/node/) |
| **Ruby** | ❌ | ✅ Stable (T/M), 🚧 Beta (Logs) | [View Guide](/Monitor-your-data/OpenTelemetry/Instrumentation/Ruby/) |
| **Swift** | ❌ | ✅ Stable (Traces), 🚧 Beta (M/L) | [View Guide](/Monitor-your-data/OpenTelemetry/Instrumentation/Swift/) |

### Beta & Experimental

These languages are under active development:

| Language | Zero-Code Support | Status | Guide |
|----------|-------------------|--------|-------|
| **Kotlin** | ❌ | 🚧 Beta | [View Guide](/Monitor-your-data/OpenTelemetry/Instrumentation/Kotlin/) |
| **Rust** | ❌ | 🚧 Beta | [View Guide](/Monitor-your-data/OpenTelemetry/Instrumentation/Rust/) |

!!! note "Status Legend"
    - ✅ **Stable**: Production-ready with full support
    - 🚧 **Beta**: Feature-complete but may have breaking changes
    - T/M = Traces & Metrics only
    - M/L = Metrics & Logs only

---

## Next step: Shipping your data

Once your application is instrumented, the next step is sending that data to OpsPilot.

[Shipping Telemetry Overview →](/Monitor-your-data/OpenTelemetry/Shipping/overview/)

---

## Related Guides

After instrumenting your application, explore these topics:

- **[Configuration Guide](/Monitor-your-data/OpenTelemetry/Configuration/)**: Learn about semantic conventions, resource attributes, and sampling strategies
- **[Visualize Your Data](/Monitor-your-data/OpenTelemetry/Visualize/Metrics/)**: Create dashboards and query your telemetry
- **[FAQ](/Monitor-your-data/OpenTelemetry/FAQ/)**: Common questions and best practices
- **[Troubleshooting](/Monitor-your-data/OpenTelemetry/Troubleshooting/)**: Debug common instrumentation issues

---

## Advanced Instrumentation Options

### eBPF Instrumentation

!!! info "Coming Soon"
    eBPF (Extended Berkeley Packet Filter) instrumentation provides kernel-level observability without code changes or agent installation. This feature is coming soon to OpsPilot.

    eBPF enables:

    - Zero-overhead instrumentation at the kernel level
    - No application restarts required
    - Network and system-level telemetry

    Check back for updates on eBPF support availability.

### Kubernetes Operator

!!! info "Coming Soon"
    The OpenTelemetry Operator for Kubernetes provides automated instrumentation injection for containerized workloads. This feature is coming soon to OpsPilot.

    The Operator enables:

    - Automatic sidecar injection for telemetry collection
    - Simplified configuration via Kubernetes CRDs
    - Cluster-wide instrumentation management

    Check back for updates on Kubernetes Operator support.

### Code Examples Repository

!!! info "Coming Soon"
    A comprehensive code examples repository with ready-to-run sample applications is currently being developed by our content team. Expected availability: Q2 2026.

    The repository will include:

    - Complete example applications for all supported languages
    - Docker Compose configurations for local testing
    - Best practice implementations
    - Common integration patterns

    In the meantime, each language guide includes basic examples to get you started.
