# Ingesting data into the OpsPilot. 


<iframe src="https://player.vimeo.com/video/810456295?h=3294f36424" width="640" height="353" frameborder="0" allow="autoplay; fullscreen; picture-in-picture" allowfullscreen></iframe>
<p><a href="https://vimeo.com/810456295">Ingest data into FusionReactor using Grafana Alloy in Docker</a> from <a href="https://vimeo.com/user109619720">FusionReactorAPM</a> on <a href="https://vimeo.com">Vimeo</a>.</p>

## Setting up Grafana Alloy

This is a simple procedure that gives additional insight into your product and the metrics it produces, so you can quickly investigate and pinpoint issues. Scraped metrics are available in both **Explore** and the **Integrations Dashboards** within the **OpsPilot**.


!!! example "Example: Using Docker with two containers (one for Grafana Alloy, and the other with the MySQL database)"

!!! note 
    The Docker example below uses files from the Grafana source code [GitHub](https://github.com/grafana/agent). 

## Configure Grafana Alloy 

### **Step 1**: Access your agent.yaml configuration file

Navigate to the directory containing your agent.yaml configuration file.

### **Step 2**: Open file in text editor

Open the file in a text editor and add the following section to this file:

```yaml
metrics:
  global:
    scrape_interval: 1m
    remote_write:
        - url: "https://api.fusionreactor.io/v1/metrics"
          authorization:
            credentials: 7f5e1598e67524aacf90da7d8479a16f1236fe01095b081f0b684eae7570e54c4c5660b2b8adae573f860c2bca3b98b5ffe4237de2980e26d8951324ed4a9ee1
  configs:
    - name: nginx
      scrape_configs:
        static_configs:
        - targets: ['{nginx-collector}:9113']
    - name: mssql
      scrape_configs:
        static_configs:
            - targets: ['{mssql-collector}:4000']        
integrations:
  node_exporter:
    enabled: true

  mysqld_exporter:
    enabled: true
    data_source_name: {user}:{pw}@({mysql-host}:3306)/
    relabel_configs:
        - source_labels: [__address__]
          target_label: instance
          replacement: server-a
```

!!! tip
    This code allows the agent to scrape and write metrics to OpsPilot. Copy the indentation correctly as the yaml syntax is very sensitive.

### **Step 3**: Authenticate with our ingest endpoints.

Replace the **credentials** under **authorization** with your API key to authenticate with our ingest endpoints.

!!! info
    To generate a new API key, go to **OpsPilot** > **Account Settings** > **API Keys** > **Generate**. Copy this key and paste it under **credentials**.


### **Step 4**: Create the containers 

Create Grafana Alloy container and the MySQL container with the following code:

```yaml
services:

  agent:
    image: grafana/agent
    volumes:
      - type: bind
        source: ./agent/data
        target: /etc/agent/data
      - type: bind
        source: ./agent/config/agent.yaml
        target: /etc/agent/agent.yaml

  mysql:
    image: cfmysqldemo
    ports:
      - "3306:3306"
```

The above example involves volume mounting the agent config file.  Alternatively, add the config to your docker image.

!!! tip
    Amend the file path under **source** to point to the location of the agent.yaml file and rename the MySQL image to your own.

!!! info "Learn more"
    [Further detail on metric integrations](/Monitor-your-data/Observability-agent/overview/)

### **Step 5**: Run “docker-compose up -d” 

Run “docker-compose up -d” to bring up the containers. 

### **Step 6**: Navigate to OpsPilot 

Navigate to OpsPilot to access the many features available such as Dashboards, without needing any additional configuration. 

### **Step 7**: Display the Metrics browser 

Select the **MySQL integrations dashboard** > **Explore** > **Code** to display the Metrics browser. 

!!! tip
    Selecting, for example, **mysql_up query** > **use query** > **run query** will show the agent is now receiving data from Grafana Alloy.


Grafana Alloy is a powerful tool to pull metrics from your servers, and this is just one example of the many implementations to use Grafana with FusionReactor. 

## Local Grafana Agent example

The following video demonstrates how to set up Grafana Alloy so that it can be used to ingest data into the OpsPilot. The example uses Linux with Grafana Alloy already installed, but the agent is also usable on Docker, Windows and MacOS.

<iframe src="https://player.vimeo.com/video/810501529?h=3294f36424" width="640" height="353" frameborder="0" allow="autoplay; fullscreen; picture-in-picture" allowfullscreen></iframe>
<p><a href="https://vimeo.com/810501529">Ingest data into FusionReactor using a local Grafana Agent.</a> from <a href="https://vimeo.com/user109619720">FusionReactorAPM</a> on <a href="https://vimeo.com">Vimeo</a>.</p>

___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.