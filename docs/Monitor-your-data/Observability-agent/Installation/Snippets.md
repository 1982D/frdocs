# Local install using code snippets

## Introduction

The Observability Agent, an [open source](https://github.com/intergral/observability-agent/releases) autoconfiguration and installation tool, is a wrapper for the [Grafana Agent](https://github.com/grafana/agent) that can install the agent,
detect which services are running on your machine, and automatically create a configuration file with integrations for detected services.

<iframe src="https://player.vimeo.com/video/838716806?h=54c2733b94" width="640" height="363" frameborder="0" allow="autoplay; fullscreen" allowfullscreen></iframe>


!!! info
     A Node/Windows exporter integration will be added by default.

!!! note
    If you aim to monitor external systems or script the installation variables, utilizing [environment variables](/Monitor-your-data/Observability-agent/Configuration/) is necessary.


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




