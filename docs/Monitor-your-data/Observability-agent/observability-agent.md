# Observability Agent

## Introduction

The Observability Agent, an [open source](https://github.com/intergral/observability-agent/releases) autoconfiguration and installation tool, is a wrapper for the [Grafana Agent](https://github.com/grafana/agent) that can install the agent,
detect which services are running on your machine, and automatically create a configuration file with integrations for detected services.

<iframe src="https://player.vimeo.com/video/838716806?h=54c2733b94" width="640" height="363" frameborder="0" allow="autoplay; fullscreen" allowfullscreen></iframe>


!!! info
     A Node/Windows exporter integration will be added by default.


## Prerequisites

For **Unix** machines, the script will have to be run with root privileges, otherwise you will be prompted for your password during execution.

**Windows** machines must have Powershell 5.1 or later installed.

**MacOS** is not currently supported.

The script will automatically detect what is running on your machine and add integrations to the config file. Each service requiring an integration must be running on its default port. These are:

|**Integration**| **Default port**|
|--- |--- |
|MySQL|  3306 |
|MSSQL | 1433 |
|Postgres |5432 |
|RabbitMQ	| 5672 |
|RabbitMQ Exporter	| 15692 |
|Redis |	6379 |
|Kafka	| 9092 |
|ElasticSearch	| 9200 |
|Mongo | 27017 |
| Oracle | 1521 |


## Procedure

!!! note
    The [Static Mode](https://grafana.com/docs/agent/latest/static/) installer has been deprecated in favour of a [Flow Mode](https://grafana.com/docs/agent/latest/flow/) installer.

!!! info
    [Latest release](https://github.com/intergral/observability-agent/releases)

### Linux 

To download and run the installer, in a terminal, run:


````
curl -O -L "https://github.com/intergral/observability-agent/releases/latest/download/observability-agent-autoconf.sh"
chmod a+x "observability-agent-autoconf.sh"
sudo /bin/bash observability-agent-autoconf.sh
````

### Windows

To download and run the installer, open powershell admin terminal, navigate to your desired download folder and run: 

````
Invoke-WebRequest -Uri "https://github.com/intergral/observability-agent/releases/latest/download/observability-agent-autoconf.ps1" -OutFile "observability-agent-autoconf.ps1"
.\observability-agent-autoconf.ps1
````


!!! info
    The installer for Windows assumes you are installing Grafana Alloy in the default location on the C drive. This is required for the config file to be placed in the correct location for Grafana Alloy to read it.

### Options

Agent installation is enabled by default. 

#### Run without the agent installed

To run without installing the agent, add `--install false` to the end of the run command. 



!!! example
    ````
    sudo path/to/observability-agent-autoconf.sh --install false`
    ````
   

#### Modify a pre-existing config file

To modify a pre-existing config file, add `--config.file`, followed by the path to the file, to the end of the run command. 



!!! example
     ````
     sudo path/to/observability-agent-autoconf.sh --config.file path/to/configfile`
     ````

!!! info
    A backup of your original file will be created.

#### Using both install & config.file options 

It is possible to use both `--install` and `--config.file` options in the same run command - the order is irrelevant. 

!!! example
     ````
     sudo path/to/observability-agent-autoconf.sh --install false --config.file path/to/config 
    
     sudo path/to/observability-agent-autoconf.sh --config.file path/to/config --install false
     ````

## Docker

<iframe src="https://player.vimeo.com/video/827268952?h=0f2c0e8fad" width="640" height="360" frameborder="0" allow="autoplay; fullscreen; picture-in-picture" allowfullscreen></iframe>


When running in [Docker](https://docs.docker.com/engine/reference/commandline/run/#env), you will **not** be prompted for any information. Therefore, you must specify an API key before running. Additionally, you must set the relevant [environment variables](/Cloud/integrations/observability-agent/#environment-variables), for whichever services you have running, so they can be configured. 

To run in Docker, we provide prebuilt images in our Docker Hub repository. 

!!! info "Learn more"
    [Docker Hub](https://hub.docker.com/r/intergral/observability-agent) 




## Environment variables

To add integrations without being prompted for credentials, there are several environment variables you can use:

### Ingest


| **Variable**                | **Type**      |**Description**                                                   |
|--------------------------|----------|---------------------------------------------------------------|
| `api_key`           | `string` | API Key to authenticate with your OpsPilot Account. [Generate an API key](/Monitor-your-data/Observability-agent/overview/#step-1-generate-an-api-key).              |
|`metricsEndpoint`   | `string` | Default: `https://api.fusionreactor.io/v1/metrics`            |
| `logsEndpoint`      | `string` | Default: `https://api.fusionreactor.io/v1/logs`               |
| `logs_user`	| `string` |	Username to authenticate with your OpsPilot Account (observability-agent-flow only)|




### Metric exporters

| **Variable**              | **Type**     | **Description**                                                   |
|-----------------------|----------|----------------------------------------------------------------|
| `mysql_user`          | `string` | User for the local Mysql database                              |
| `mysql_password`      | `string` | Password for the local Mysql database                          |
| `mysql_disabled`      | `bool`   | Enables/Disables the Mysql exporter (enabled by default) |
| `mssql_user`          | `string` | User for the local Mssql database                                                               |
| `mssql_password`      | `string` | Password for the local Mssql database                                                               |
| `mssql_disabled`      | `bool`   | Enables/Disables the Mssql exporter (enabled by default)                                                                               |
| `postgres_user`       | `string` | User for the local Postgres database                                                               |
| `postgres_password`   | `string` | Password for the local Postgres database                                                              |
| `postgres_disabled`   | `bool`   |    Enables/Disables the Postgres exporter (enabled by default)                                                            |
|`rabbitmq_disabled`	|`bool`	|Enables/Disables the RabbitMQ exporter (enabled by default)|
|`redis_disabled`	| `bool`	|Enables/Disables the Redis exporter (enabled by default)|
|`elasticsearch_user`	| `string` |	User for the ElasticSearch instance (observability-agent-flow incompatible)|
|`elasticsearch_password` |	`string` |	Password for the ElasticSearch instance (observability-agent-flow incompatible)|
| `mongodb_user`           | `string` | User for the local Mongo database       |
| `mongodb_password`       | `string` | Password for the local Mongo database |
| `oracledb_user`          | `string` | User for the local Oracle database                          |
| `oracledb_password`      | `string` | Password for the local Oracle database       

### Exporting metrics from external machines

To replace these with a custom connection string, there are several environment variables you can use:

| **Variable**                       | **Type**     | **Example (Defaults)**                                     |
|--------------------------------|----------|--------------------------------------------------------|
| `mysql_connection_string`      | `string` | `<username>:<password>@(<host>:3306)/`                 |
| `mssql_connection_string`      | `string` | `sqlserver://<username>:<password>@<host>:1433`        |
| `postgres_connection_string`   | `string` | `postgresql://<username>:<password>@<host>:5432/shop?` |
| `rabbitmq_scrape_target`	 | `string`	| `<host>:15692`                  |
| `redis_connection_string` | `string`	| `<host>:6379`                   |
| `kafka_connection_string`	| `string`	| `["<host>:9092"]`               |
| `elasticsearch_connection_string` | `string`| `http://<username>:<password>@<host>:9200` |
| `mongodb_connection_string`  | `string` | `mongodb://<username>:<password>@<host>:27017/`        |
| `oracledb_connection_string` | `string` | `oracle://<username>:<password>@<host>:1521/ORCLCDB`       |

RabbitMQ requires an internal exporter to be enabled. 

!!! info "Learn more"
    [RabbitMQ](https://www.rabbitmq.com/prometheus.html)

`mongo_connection_string` is incompatible with static.

### Log exporters

If you wish to enable log collection, the following environment variables must be set:

| Variable           | Type     | Description                                     |
|--------------------|----------|-------------------------------------------------|
| `log_collection`   | `bool`   | Enables log collection                          |
| `service_name`     | `string` | Set a name for your log collection service       |
| `log_path`         | `string` | Set a file path for your log collection service |

### Scraping from additional exporters

At present, there are some integrations we don't support out-the-box. Use of these integrations is via a scrape endpoint. To scrape these exporters, you can use the following environment variables to set a list of exporters and their corresponding endpoints to be scraped. 

!!! note
    The list must be wrapped in double quotes and each value must be separated by a comma and a space.

| Variable         | Type     | Example                                  | Description                         |
|------------------|----------|------------------------------------------|-------------------------------------|
| `scrape_targets` | `string` | `"nginxexporter:9113, iisexporter:1234"` | List of endpoints for the exporters |


### .Env files

If you wish to use an environment file to set environment variables, rather than setting them as system environment variables, name the file ".env" and place it in the same directory as the "observability-agent-autoconf" script.

#### Example ".env" file:


```
api_key=1234567890
mysql_connection_string=root:my-secret-pw@(mysql:3306)/
log_collection=true
service_name=service
log_path=path
```

### Custom integrations

We plan to continually add integrations. Should you require a specific integration, please contact us through the chat bubble and we'll see what we can do.
___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.



