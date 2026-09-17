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


