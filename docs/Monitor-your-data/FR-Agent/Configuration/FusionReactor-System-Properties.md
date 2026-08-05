---
search:
  boost: 3
---

# System Properties

FusionReactor has a number of [system properties](https://docs.oracle.com/javase/tutorial/essential/environment/sysprop.html) that can be set to configure FusionReactor.

These arguments should be added to your JVM configuration. 

!!! info "Learn more"
    [Manual Configuration Examples](/Monitor-your-data/FR-Agent/Installation/Configuration-examples/).

!!! note 
    The options below should be prefixed with '-D', for example:

    ```
    -Dfrlicense=XXXXX-XXXXX-XXXXX-XXXXX-XXXXX.

    ```
    _Info: These are also referred to as `-D flags` or `JVM flags`._


    
## Agent Authentication

Property | Default value | Values accepted | Version added | Description
--- | --- | -- |---------------| ---
`fradminpassword` | Not defined | password value | 6.0.0         | Sets default/starting admin password.
`frmanagerpassword` | Not defined | password value | 10.0.0        |Sets default/starting manager password. This enables the manager user role.
`frobserverpassword` | Not defined | password value | 10.0.0        | Sets default/starting observer password. This enables the observer role.

## Applications and Transactions

Property | Default value |  Version added | Description
--- | --- | -- |---------------
`fr.application.name`|	MyApplication	|6.0.0	|Defines the Default Application Name. If auto application naming is disabled this system property will define the application name for the entire application.																			
`fr.application.auto_naming`|		true|	6.0.0.	| When true, FusionReactor will name the application automatically by searching various sources (e.g. Servlet Config).	
`fr.transaction.name`| 	Ungrouped |	6.0.0	|Defines the Default Transaction Name. If auto transaction naming is disabled this system property will define the transaction name for all transactions.
`fr.transaction.auto_naming`|	true|	6.0.0|	When true, FusionReactor will name the transaction automatically by searching various sources (e.g. Servlet Config).																					
`fr.thread.allocated.memory.enabled`|	true|	7.0.0	| Allows all the thread allocated memory information to be turned off.																				
`fr.transaction.http.client.header.request.count`|	15|	8.1.0|	Defines the number of request headers stored on the HTTP Client transaction.																				
`fr.transaction.http.client.header.response.count`|	15|	8.1.0	|Defines the number of response headers stored on the HTTP Client transaction.	

## ColdFusion Metrics

!!! warning
    Enabling these ColdFusion metrics for ColdFusion (2018 and later) may incur performance issues and be unsafe. User issues reported include memory leaks and server slowdown.

!!! tip
    We recommend testing in a staging environment before deploying these changes to production.

Property | Default value | Values accepted  | Version added | Description                                                                                                                                      
--- |---------------|------------------|---------------|--------------------------------------------------------------------------------------------------------------------------------------------------
 `fr.coldfusion.monitor.request.enabled` | `false` | true/false | 9.2.2        | Enables monitoring request hitcounts and some request metrics. Disabled if PMT is active.     |
 `fr.coldfusion.monitor.memory.enabled`| `false` | true/false | 9.2.2         | Enables memory monitoring for scopes size.                  |
  `fr.coldfusion.monitor.query.enabled`  | `false` | true/false | 9.2.2         | Enables monitoring cached queries in CF metrics for CF 2021 | CF 2023 |
`fr.coldfusion.monitor.query.app.enabled`| `false` | true/false | 9.2.2         | Enables monitoring cached queries per app/server. Requires monitor.query.enabled=true  |

## Decompilation

Property | Default value | Values accepted | Version added | Description
--- | --- | --- | --- | ---
`fr.decompile.external.enabled` | false | true/false | 6.0.0 | This enables or disables the decompilation when requests come in over the external J2EE connection.
`fr.decompile.show.line.numbers` | false | true/false | 6.0.0 | 	This setting enables the procyon line number as comments inside the decompile output.  This is very good to track down line number issues in decompiled code.

## Enterprise Dashboard/Ephemeral Data Service

The following properties should be added to the instance hosting the Enterprise Dashboard

Property | Default Value | Values Accepted | Version Added | Description
--- | --- | --- | --- | ---
fr.ed.ds.enable | false | true/false | 8.1.0 | If provided, specifies the server port binding.
fr.ed.ds.listen | 0.0.0.0:2106 | hostname:port | 8.1.0 | Specifies the listening IP address and port on the server
fr.ed.ds.polltimeout | 1000 | Integer (ms) | 8.1.0 | Specifies the time EDS will wait after attempting to poll data from the client before marking the client as offline.
fr.ed.ds.maxdatasize | 20 | Integer (MB) | 8.2.2 | The maximum size of a page or other data transfer that will be accepted over the tunnel.

The following properties should be added to the instance connecting to the Enterprise Dashboard

Property | Default Value | Values Accepted | Version Added | Description
--- | --- | --- | --- | ---
fr.ed.ds.target | Not defined | hostname:port | 8.1.0 | If specified, causes the instance to attempt to auto-register with the EDS system at the specified address
fr.ed.ds.groups | Not defined | Comma-separated list | 8.1.0 | If provided, the instance will auto-register with the ED DS, specifying it is a part of the given groups.


## OpsPilot

Property | Default value | Values accepted | Version added | Description
--- | --- | --- | --- | ---
`fr.cloud.group` | Not defined | Comma-separated list | 6.1.0 | Specifies the group your FusionReactor instance will register to in the cloud.
Additionally all metrics, logs and traces will be appened with the group label.
`fr.gcs.client.obfuscate.data`| true| true/false| 6.0.0| Obfuscates TXN details over the live data tunnel.

## FusionReactor Logging

Property | Default value | Values accepted | Version added | Description
--- | --- | --- | --- | ---
`fr.observability.log.enabled` | true | true/false | 9.0.0 | This setting enables or disables logs shipping.

## JMS/MDB Tracking

| Property                                            | Default value          | Values accepted                                                 | Version added | Description                                                                                                                  |
|-----------------------------------------------------|------------------------|-----------------------------------------------------------------|---------------|------------------------------------------------------------------------------------------------------------------------------|
| `fr.pointcut.jms.packages`                           | `org/apache/activemq/` | comma-separated list of package prefixes with `/` replacing `.` | 10.0.0        | List of package prefixes to enable JMS tracking within those packages. Accepts `all` to enable tracking within all packages. |
| `fr.observability.trace.jms.jakarta`                  | false                  | true/false                                                      | 10.0.0        | If true, uses the `jakarta.jms` libraries. Uses `javax.jms` otherwise.                                                       |
| `fr.observability.trace.jms.extra_attributes.enabled` | true                   | true/false                                                      | 10.0.0        | If enabled, attempts to set the messageId and conversationId.                                                                |

## Licensing

Property | Default value  | Version added | Description
--- | --- | -- |---------------
`frlicense` | Not defined  | 5.0.0         | This system property will allow you to specify your license key for the instance, making it non-modifiable from within the UI.
`fr.odl.env.regex`|(?i).sudo.|8.0.0| Removes values matching the regex from the env secton of license message.
`fr.odl.prop.regex`|(?i).sudo.|8.0.0| Removes values matching the regex from the -D properties secton of license message.
`fr.license.hostname.lookup` |true|8.6.0| Enable all getHostName() calls in network data provider. This triggers reverse DNS and can be very slow (especially on macOS)

## Logging Level

Property | Default value | Version added | Description
--- | --- | -- |--------------- 
`_FR_DEBUG`| Not defined|1.0.0|Enable debugging logging for FusionReactor. This causes FusionReactor to generate a vast ammount of logs.


## Network Proxy

Property | Default value| Version added | Description
--- | --- | --- | ---
`fr.http.proxyHost`|Not defined	| 6.2.0|	The hostname or IP address of the proxy that you want to connect to.
`fr.http.proxyPort`|Not defined	| 6.2.0	|Proxy server port number for connection.
`fr.http.proxyUser`|Not defined| 6.2.0	|The username required for your proxys authentication configuration.
`fr.http.proxyPassword`|Not defined	| 6.2.0	|The password required for your proxys authentication configuration.
`fr.http.proxyAuthType`|Not defined| 6.2.0| The authentication type to be used for authentication with your proxy. Values include: "None" "Basic" OR "Digest", "NTLM".

## Observability Labels

Property | Default value| Version added | Description
--- | --- | --- | ---
`fr.observability.labels`	|Not defined|	9.2.0	|A comma-separated key-value list of labels to add to all observability types.Format `labelKey1:labelValue1,labelKey2:labelValue2,...` Applies to all metrics, logs and traces generated by FusionReactor.

## Observability Logs	

Property | Default value| Version added | Description
--- | --- | --- | ---
`fr.observability.log.labels`|	Not defined|	9.0.0|A comma-separated key-value list of labels to add a maximum of 8 (by default) to logs. Format  `labelKey1:labelValue1,labelKey2:labelValue2,...`
`fr.observability.log.scrape.path`	|Not defined	|9.1.0	|Set the path(s) for the log scraper. Format `/{directory}/*.log,/{directory}/*.txt`
`fr.observability.log.send.level` | INFO | 12.1.0 | Sets the minimum log level to send/ship to cloud. Case-insensitive. Also available as an evironment variable `FR_OBSERVABILITY_LOG_SEND_LEVEL`. One of `ALL`, `FINEST`, `FINER`, `FINE`, `CONFIG`, `INFO`, `WARNING`, `SEVERE`, `OFF`.
`fr.observability.log.scrape.offsets.persist.rate` | 30000 | 2026.1.3 | How often (ms) the log scraper persists file read offsets to reactor.conf |

## Observability Metrics

Property | Default value| Version added | Description
--- | --- | --- | ---
`fr.observability.metric.labels`	|Not defined|	9.2.0	|A comma-separated key-value list of labels to add a maximum of 8 (by default) to metrics. Format `labelKey1:labelValue1,labelKey2:labelValue2,...`
`fr.observability.metric.prometheus.remotewrite.metadata.enabled` | true | 2025.1.0 | If true, sends metric metadata to be displayed as help text in cloud. Disable if you prefer smaller request size.


## Observability Traces	

Property | Default value| Version added | Description
--- | --- | --- | ---		
`fr.observability.trace.labels`|Not defined|9.2.0|	A comma-separated key-value list of labels to add a maximum of 8 (by default) to traces. Format `labelKey1:labelValue1,labelKey2:labelValue2,...`
`fr.observability.trace.sampling.ratio`|0.05|9.2.0| The ration of tracked transactions that are shipped to the cloud. A sample rate of 1.0 would ship 100% of tracked transactions.
`fr.observability.trace.itt.txn.max`|10|9.2.0	|Max number of ITTs to process as spans within each 60 seconds time window.
`fr.observability.trace.attributes.semantics.obfuscation.enabled`|false|	9.2.0	|If enabled, obfuscates the span attributes: `net.peer.port` `net.peer.name` `net.peer.ip` `db.statement` 'query string in `http.url` `http.client_ip`
`fr.observability.trace.span.child.limit`|100|	9.2.0|	Max number of child spans allowed on a span.
`fr.observability.trace.value.limit`|1024 |9.2.0	|Text limit for certain span string attributes. Anything after this chartacter limit will be replaced with '...'

## Plugins
| Property                                       | Default value | Values accepted | Version added | Description                                                                    |
|------------------------------------------------|---------------|-----------------|---------------|--------------------------------------------------------------------------------|
| `fr.plugin.reports.notifications.email.disabled` | false         | true/false      | 10.0.0        | If true, forces the email notifications to be disabled in the reporting plugin. |

## Production Debugger

Property | Default value |  Version added | Description
--- | --- | -- |---------------
`fr.jvmti.enable.exceptions`|true (false for CF 10+)	|6.2.5	|Enables exception break point support in the debugger. This can have negative impact on CFML compilation times and code which throws lots of exceptions.
`fr.jvmti.enable.fast.stepping`|false	|6.2.5|Enables fast stepping mode which ensures that stepping operations execute as quickly as possible. This can have a negative impact on the JVM's performance.
`fr.jvmti.email.max.variables.count`|	MAX_INTEGER	| 6.0.0|The maximum string length a variable value can be in the email. This reduces the data in case of very large toString() values like lists and json objects.
`fr.jvmti.email.max.variables.length`	|100	|6.0.0	|The maximum string length a variable value can be in the email. This reduces the data in case of very large toString() values like lists and json objects. 

## Startup

Property | Default value  |Version added | Description
--- | --- | -- |--------------
`frstartupinline`|Not Defined| 5.0.0| When defined, FusionReactor will start before the JVM/Application server.
`frstartupdelay`|1000| 5.0.0|The amount of time that FusionReactor sleeps before starting.

## Support Chat

Property | Default value | Values accepted | Version added | Description
--- | --- | --- | --- | ---
`fr.chat.enabled` | true | true/false | 7.0.0 | Enables the support chat.


## UI

Property | Default value | Values accepted | Version added | Description
--- | --- | -- |---------------| ---
`frhomepage` | Not defined | page ID | 10.0.0 | Sets home page for all users without changing config. Set to the value of the page_id. e.g {fusionreactor_url}?p={page_id}.
`fr.request.obfuscate.parameters` | false | true/false | 6.2.6 | This enables/disables obfuscation for master transaction parameters.
`fr.request.obfuscate.file` | Not defined|-| 6.3| Sets the file path for obfuscation values.
`fr.request.obfuscate.variable` |Not defined|-| 6.3| Sets specific variable names which should be obfuscated.
`fr.request.obfuscate.ip` | false| true/false | 7.3.0 |Replaces any numbers in the Request IPs with 0's.
`fr.transactionsummary.showheaders.disabled` | false| true/false | 8.7.5|Disables the ability to show headers on request/transaction summaries.
`fr.transactionsummary.showheaders.request.disabled`| false| true/false | 8.7.5|Disables the ability to show request headers on request/transaction summaries.
`fr.transactionsummary.showheaders.response.disabled` | false| true/false | 8.7.5|Disables the ability to show response headers on request/transaction summaries.



## Weblogic	
Property | Default value  | Version added | Description
--- | --- | --- | ---	
`fr.weblogic.fixup.active=true`|	false	|5.2.0	|Allows Weblogic transactions to be tracked. This must be enabled if FusionReactor is running on Weblogic.
`fr.jdbc.skip_get_connection_parser`| false | 12.1.0 | Can prevent blocked threads when using JDBC but reduces monitoring capability.
`fr.jdbc.connection_parser_type`| MySQL | 12.1.0 | When `-Dfr.jdbc.skip_get_connection_parser=true`, will attempt to parse the connection as the given database type. Currently, only `oracle` and `mysql` are supported. 

## OpsPilot UI Tunnel
| Property           | Default value | Version added | Description                          |
|--------------------|---------------|---------------|--------------------------------------|
| `fr.ui.ws.enabled` | true          | 12.1.0        | Enable/disable the websocket tunnel. |


## Federated Identity Management
| Property               | Default value | Version added | Description                                                                                      |
|------------------------|---------------|---------------|--------------------------------------------------------------------------------------------------|
| `fr.fim.cloud.enabled` | true          | 12.1.0        | If disabled, users will no longer be able to log in with their cloud email address and password. |


## OTel Shipping 

| Property                                 | Default Value | Version Added | Description                                                                                                                                                                                   |
| ---------------------------------------- | ------------- | ------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `fr.observability.otel.resource.enabled` | `false`       | 2025.2.0    | Enables support for custom OTel resource attributes. Must be set to `true` when supplying `otel.resource.attributes`.                                                                         |
| `otel.resource.attributes`               | `null`        | 2025.2.0   | Sets custom OTel resource attributes such as `service.name`, `service.version`, and `deployment.environment`.  |
| `otel.exporter.otlp.endpoint`            | `null`        | 2025.2.0   | Defines a single OTLP endpoint for **all** signals (metrics, traces, logs).                                                                                                                   |
| `otel.exporter.otlp.protocol`            | `grpc`        | 2025.2.0   | Sets the OTLP protocol (`grpc` or `http/protobuf`).                                                                                                                                           |
| `otel.exporter.otlp.headers`             | `null`        | 2025.2.0    | Defines custom authentication or metadata headers for OTLP export (e.g., API keys).                                                                                                           |
| `otel.exporter.otlp.metrics.endpoint`    | `null`        | 2025.2.0    | Metrics-specific OTLP endpoint. Overrides the global OTLP endpoint if set.                                                                                                                    |
| `otel.exporter.otlp.traces.endpoint`     | `null`        | 2025.2.0`    | Traces-specific OTLP endpoint. Overrides the global OTLP endpoint if set.                                                                                                                     |
| `otel.exporter.otlp.log.endpoint`        | `null`        | 2025.2.0    | Logs-specific OTLP endpoint. Overrides the global OTLP endpoint if set.                                                                                                                       |
| `otel.metrics.exporter`                  | `otlp`        | 2025.2.0    | Metrics exporter selection. Use `NONE` to disable metrics shipping.                                                                                                                           |
| `otel.traces.exporter`                   | `otlp`        | 2025.2.0    | Traces exporter selection. Use `NONE` to disable trace shipping.                                                                                                                              |
| `otel.logs.exporter`                     | `otlp`        | 2025.2.0   | Logs exporter selection. Use `NONE` to disable log shipping.                                                                                                                                  |
!!! info 
    For individual examples, see the [OTel Shipping page](https://docs.fusionreactor.io/Monitor-your-data/FR-Agent/Configuration/OTel-shipping-config/).