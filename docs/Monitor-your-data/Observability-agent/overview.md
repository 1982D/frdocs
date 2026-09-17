## Observability Agent

<iframe src="https://player.vimeo.com/video/838717805?h=1cb026ba2f" width="640" height="363" frameborder="0" allow="autoplay; fullscreen" allowfullscreen></iframe>

Integration allows you to ingest vital metrics to monitor the health of your entire infrastructure, with metrics from all aspects of your application stack.

Metric exporters are libraries that expose integration metrics to an agent. At FusionReactor, we have developed a wrapper for Grafana Alloy called the **Observability Agent** which allows you to ingest metrics with minimal configuration required. 


With our Observability Agent you can ingest any data into the OpsPilot, and visualise your data within the [Integration dashboards](/Data-insights/Features/dashboards/#integration-dashboards).

!!! info
    For local servers, we recommend utilizing FRAM for installing the Observability Agent, while for all other environments, we suggest opting for Docker.

### Exporters

Exporters are available in many forms and allow you to monitor many aspects of your infrastructure including:

🔸Databases 🔸 IIS 🔸Machine system metrics 🔸Nginx 🔸Kubernetes

🔸Kafka & other message busses 🔸Docker 🔸& many more...


!!! note
    Depending on your choice of agent, exporters can be integrated within the agent, or may require scraping periodically.



### Viewing your metrics
Scraped metrics will be available in both **Explore** and the **Integrations Dashboard** within the OpsPilot.

### Getting started


#### **Step 1**: Generate an API key. 


To generate a new API key, go to your account settings page in OpsPilot [Account Settings](https://app.fusionreactor.io/account/settings). 

Under the API keys tab, click generate and create a key.

!!! tip
    If you created an API key for log ingest already, you can reuse this key.

#### **Step 2**: Install the Observability Agent

Install the Observability Agent to monitor your integrations outside of ColdFusion and Java. 
There are currently three install methods:

* [FRAM](/Monitor-your-data/Observability-agent/Installation/FRAM/)

* [Local install using code snippets](/Monitor-your-data/Observability-agent/Installation/Snippets/)

* [Docker](/Monitor-your-data/Observability-agent/Installation/Docker/) 

!!! info
    For local servers, we recommend utilizing FRAM for installing the Observability Agent, while for all other environments, we suggest opting for Docker.



!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.