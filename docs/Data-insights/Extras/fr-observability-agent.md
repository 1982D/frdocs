# Observability Agent With FRAM

!!! info
    Installation requires FRAM to be licensed with a valid Cloud license.

## Introduction
Starting with FusionReactor 12, the Observability Agent can be installed via FRAM's on-prem UI for a simpler way to configure, and get started with, sending data from non-FusionReactor sources to OpsPilot.

This enables the ability to analyse metrics within **Explore** and **Integration Dashboards**, providing insight into potential issues concerning your data sources.

For advanced use, consider consulting/using the [Observability Agent](/Monitor-your-data/Observability-agent/overview/) directly.

## Supported Operating Systems
The following operating systems are supported:

- Linux
    - Debian
    - RedHat

- Windows
    - Versions with [PowerShell 5.1](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_windows_powershell_5.1?view=powershell-5.1) and above

!!! info "Windows Users"
    FRAM will attempt to run an installation script with the Bypass Execution Policy. More information on [Execution Policies](https://learn.microsoft.com/en-gb/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-5.1) for if this fails.

!!! info "Linux Users"
    FRAM requires root privileges to perform installation.

## Integrations
As part of the configuration, integrations require a connection string to be able to scrape metrics from. Ensure that all displayed characters are entered.

#### MySQL
The MySQL integration uses a DSN (Data Source Name) for connecting. Check [here](https://github.com/go-sql-driver/mysql?tab=readme-ov-file#dsn-data-source-name) for more information concerning the correct format.

Example:
```
username:password@(localhost:3306)/
```

#### MSSQL
Example: 
```
sqlserver://username:password@localhost:1433
```

Larger Example of Full Format: 
```
sqlserver://USERNAME_HERE:PASSWORD_HERE@SQLMI_HERE_ENDPOINT.database.windows.net:1433?encrypt=true&hostNameInCertificate=%2A.SQL_MI_DOMAIN_HERE.database.windows.net&trustservercertificate=true
```

See [here](https://grafana.com/docs/agent/latest/flow/reference/components/prometheus.exporter.mssql/#authentication) for more information on authenticating with Windows credentials instead.

#### Postgres
Example:
```
postgresql://docker:docker@localhost:5432/postgres?sslmode=disable
```

[Full format](https://www.postgresql.org/docs/current/libpq-connect.html#LIBPQ-CONNSTRING)

#### OracleDB

Example:
```
oracle://user:password@localhost:1521/xe
```

Full Format:
```
oracle://user:pass@server/service_name[?OPTION1=VALUE1[&OPTIONn=VALUEn]...]
```

[More info](https://github.com/iamseth/oracledb_exporter/tree/master#running).

#### MongoDB
The MongoDB integration uses a MongoDB node connection URI to connect.  

Example:
```
mongodb://localhost:27017/
```

Full Format:
```
[protocol]://[credentials]@[hostname/IP and port of instance(s)]/?[connection options]
```

[More information](https://www.mongodb.com/docs/manual/reference/connection-string/) on format.

#### Elasticsearch
The Elasticsearch uses an HTTP API address to connect.

Example:
```
http://localhost:9200
```

Full Format:
```
{scheme}://{username}:{password}:{host}:{port}
```

#### Redis
Example:
```
localhost:6379
```

Full Format:
```
{host}:{port}
```

#### Kafka
Example:
```
localhost:9092
```

Full Format:
```
{host}:{port}
```

#### RabbitMQ
RabbitMQ requires the rabbitmq_prometheus plugin to be installed/enabled on the RabbitMQ node in order to expose metrics. [Instructions and info](https://www.rabbitmq.com/prometheus.html#installation)

Example:
```
localhost:15692
```

Full Format:
```
{host}:{port}
```

## Further Configuration
If you desire, you can configure the service after it's installed by editing the configuration file. The service may need to be restarted for changes to apply.

Keep in mind that the configuration file will be deleted when the service is uninstalled via FRAM. You may wish to manually back up the file in another directory.

## Troubleshooting

#### FRAM
FRAM may log (un)installation errors to the `Observability Agent` log within FRAM.

#### Linux
To check the status of the service, use `sudo systemctl status {Linux Service Name}`.

To troubleshoot further, inspect the output of the `sudo journalctl -u {Linux Service Name} -b` terminal/console command.

#### Windows
To check the status of the service, use the Windows Services desktop app to inspect the service.

To troubleshoot further, inspect event logs belonging to the service within [Windows Event Viewer.](https://learn.microsoft.com/en-us/shows/inside/event-viewer)

## Version Information
| FusionReactor Version | Observability Agent Version |      Linux Service Name      |   Linux Config File Location    | Windows Service Name |            Windows Config File Location            |
|:---------------------:|:---------------------------:|:----------------------------:|:-------------------------------:|:--------------------:|:--------------------------------------------------:|
|        12.0.0         |           v0.2.9            | `grafana-agent-flow.service` | `/etc/grafana-agent-flow.river` | `Grafana Agent Flow` | `C:\Program Files\Grafana Agent Flow\config.river` |
|        12.1.0         |           v0.3.0            |       `alloy.service`        |    `/etc/alloy/config.alloy`    |       `Alloy`        | `C:\Program Files\GrafanaLabs\Alloy\config.alloy`  |
