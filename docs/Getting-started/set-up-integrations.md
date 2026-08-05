# Set up integrations

Welcome to the **Set up integrations** guide. This page introduces the **Observability Agent**, a powerful tool to help you ingest and monitor vital metrics from across your infrastructure.



## Observability Agent overview

The **Observability Agent** by FusionReactor is built as a wrapper around **Grafana Alloy**, providing a simplified way to forward metrics from various parts of your tech stack to **OpsPilot** - all with minimal configuration.



### Key features

- **Centralized Monitoring**: Collect metrics from across your entire stack - ColdFusion, Java, databases, servers, containers, and more.
- **Simple Installation**: Deploy quickly using **FRAM**, **Docker**, or install snippets.
- **Cloud Dashboards**: Visualize data in **Explore** and the **Integration Dashboards** in OpsPilot.



### Supported exporters

You can monitor a wide variety of infrastructure components using supported exporters, such as:

-  **Databases** (e.g., MSSQL)
-  **Web Servers** (IIS, Nginx)
-  **System Metrics** (CPU, memory, etc.)
-  **Containers** (e.g., Docker)
-  **Orchestration Platforms** (e.g., Kubernetes)
-  **Messaging Systems** (e.g., Kafka)

!!! info 
    *Exporters may be embedded within the agent or require scraping, depending on the setup.*



### Getting started

#### **Step 1**: Generate an API Key

Head to your [OpsPilot Account Settings](https://app.fusionreactor.io/account/settings) to create an API key.


#### **Step 2**: Install the Observability Agent

Choose the appropriate installation method:

- [**FRAM** (Recommended for local servers)](/Monitor-your-data/Observability-agent/Installation/FRAM/)
- [**Code Snippets** (for manual installation)](/Monitor-your-data/Observability-agent/Installation/Snippets/)
- [**Docker** (Recommended for remote/cloud environments)](/Monitor-your-data/Observability-agent/Installation/Docker/)

!!! info
    *For local servers, we recommend FRAM. For all other environments, Docker is preferred.*



### Viewing your metrics

Once installed, your metrics will appear in:

- **Explore**
- **Integration Dashboards** inside **OpsPilot**


