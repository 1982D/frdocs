# Shipping OpenTelemetry data to OpsPilot

Shipping OpenTelemetry (OTel) data to OpsPilot centralizes your observability and enables OpsPilot AI analysis, faster troubleshooting, and cross-tier performance optimization. Using a vendor-agnostic OTLP pipeline ensures your monitoring remains flexible and future-proof.

To send your telemetry data to OpsPilot, you'll need a component that receives data from your instrumented applications and forwards it via OTLP. There are two recommended options:


### 1. [OpenTelemetry Collector](/Monitor-your-data/OpenTelemetry/Shipping/Collector/)

The industry-standard, vendor-neutral service for receiving, processing, and exporting telemetry. Recommended for pure OTel environments and complex data transformation needs.

### 2. [Grafana Alloy](/Monitor-your-data/OpenTelemetry/Shipping/Grafana-agent/)

A comprehensive distribution from Grafana Labs that extends beyond OpenTelemetry. It is fully OTLP-compatible but adds advanced features for users who also utilize Prometheus, Loki, or the wider Grafana ecosystem.



!!! tip "Which should I choose?"
    If you want a **pure, vendor-neutral** setup, choose the **OTel Collector**. If you require **advanced routing** or deep integration with existing Grafana-based tools, choose **Grafana Alloy**.

---

## Related Guides

Before and after setting up your telemetry pipeline, explore these topics:

- **[Instrumentation Overview](/Monitor-your-data/OpenTelemetry/Instrumentation/Overview/)**: Instrument your application to generate telemetry
- **[Configuration Guide](/Monitor-your-data/OpenTelemetry/Configuration/)**: Configure semantic conventions, resource attributes, and sampling strategies
- **[Visualize Your Data](/Monitor-your-data/OpenTelemetry/Visualize/Metrics/)**: Query and visualize your telemetry in OpsPilot
- **[Troubleshooting](/Monitor-your-data/OpenTelemetry/Troubleshooting/)**: Debug common collector and pipeline issues
- **[FAQ](/Monitor-your-data/OpenTelemetry/FAQ/)**: Common questions about shipping telemetry data

---

## Kubernetes Deployment

!!! info "Coming Soon"
    Comprehensive Kubernetes deployment guides for OpenTelemetry Collector and Grafana Alloy are coming soon. This will include:

    - Helm chart configurations
    - DaemonSet and Deployment patterns
    - Service mesh integration
    - Auto-scaling strategies

    Check back for updates on Kubernetes deployment support.

---

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.

