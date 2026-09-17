
# FusionReactor Agent Releases

## 2026.1.3 - 29th Jun. 2026

| Issue Type  | Summary                                                             |
|-------------|---------------------------------------------------------------------|
| Improvement | Expose license and data shipping state in FRAPI                     |
| Bug         | Further increase the reliability of the UI tunnel connection.       |
| Bug         | Ensure instance name config changes are reflected in exported data. |
| Bug         | Decrease likelihood of config corruption on unplanned shutdowns.    |


## 2026.1.2 - 26th May 2026

| Issue Type  | Summary                               |
|-------------|---------------------------------------|
| Bug         | Fix cfhttp tracking for Lucee 7       |
| Improvement | Expose more transaction info in FRAPI |
| Improvement | Export Linux meminfo as metrics       |

## 2026.1.1 - 6th May 2026

| Issue Type  | Summary                                |
|-------------|----------------------------------------|
| Improvement | Reduce cardinality of request metrics. |

## 2026.1.0 - 20th Apr. 2026

| Issue Type  | Summary                                                                                      |
|-------------|----------------------------------------------------------------------------------------------|
| New Feature | Add new request metrics for HTTP, database, and messaging transactions.                      |
| New Feature | Add new/improved JVM metrics.                                                                |
| New Feature | Add support for changing metric names and recordings to be more OTel-like.                   |
| New Feature | Add ability to exports JVM metrics similar to Prometheus' JMX exporter.                      |
| Improvement | Add support for sending emails without requiring an SMTP server.                             | 
| Bug         | Fix variables not showing within the debugger, when using Java 21+                           | 
| New Feature | Include ColdFusion DB Pool metrics in the exported metrics.                                  |
| Bug         | Prevent debugger from showing the incorrect Lucee file contents when sources are configured. | 
| Bug         | Separate Lucee classes by filename when different files are compiled to the same class name. | 
| Bug         | Fix thread ID parsing, in the debugger, when the ID is a single digit (<10)                  |
| Improvement | Update support for tracking later versions of Mongo transactions to prevent errors.          |
| Improvement | Capture additional Lucee request errors.                                                     |
| New Feature | Add support for capturing Lucee stack trace on errors.                                       |
| New Feature | Add support for disabling/enabling specific locations on installed breakpoints.              | 
| Bug         | Increase reliability of the UI tunnel connection.                                            |
| Improvement | Add status page for non-cloud users that export data.                                        |
| Bug         | Prevent possible IllegalArgumentException when using Framework One (FW/1)                    |
| New Feature | Add option to add query parameters to request metrics' route label/attribute                 |
| Improvement | Update automatic installer (FRAM) to use correct debug library for Mac ARM64.                |

## 2025.2.1 - 3rd Feb. 2026

| Issue Type | Summary                                                                                         |
|------------|-------------------------------------------------------------------------------------------------|
| Bug        | Prevent quotes in comments from breaking PreparedStatement binding.                             |
| Bug        | Stop metrics being sent with old labels when client ID changes.                                 |
| Bug        | Add support for Jersey classes that use Jakarta to prevent errors.                              |
| Bug        | Prevent possibility of XSS exploit in UI.                                                       |
| Bug        | Update Jetty dependency to support later versions of Java. Prevent use of deprecated functions. | 

## 2025.2.0 - 24th Nov. 2025

| Issue Type  | Summary                                                                                              |
|-------------|------------------------------------------------------------------------------------------------------|
| New Feature | Migrate exported data to OTLP format, allowing greater integration with other environments.          |
| New Feature | Send Crash Protection alerts to cloud for greater visibility and analysis with other tools and data. |
| New Feature | Add OpsPilot integration within the on-prem UI tunnel to include AI analysis within the on-prem UI.  |
| Improvement | Implement new colour themes within the on-prem UI.                                                   |
| New Feature | Support Lucee 7 installation within FRAM.                                                            |
| Improvement | Update the JRE bundled with FRAM.                                                                    |


!!! warning
    If you are upgrading to **FusionReactor 2025.2** and are already using **OTel**, FusionReactor will now automatically use any existing configured endpoints. To ensure you continue receiving data in **FusionReactor Cloud** while using an OTel Collector, you must update your `collector.yaml` configuration file. Please refer to the [documentation linked here](https://docs.fusionreactor.io/Monitor-your-data/FR-Agent/Configuration/OTel-shipping-config/) for the required changes.

## 2025.1.0 - 3rd Mar. 2025


| Issue Type  | Summary                                                                                                |
|-------------|--------------------------------------------------------------------------------------------------------|
| Feature     | Add support for ColdFusion 2025.                                                                       |
| Bug         | Prevent stack overflow when viewing certain transactions in Lucee.                                     |
| Feature     | Ship metric metadata with metrics so that their help info is displayed in cloud.                       |
| Bug         | Fix service name not being set for Deep integration.                                                   |
| Improvement | Update CC websocket port to connect using port 443.                                                    |
| Feature     | Add support for creating web requests via FRAPI.                                                       |
| Feature     | Add support for setting properties on transactions via FRAPI.                                          |
| Improvement | Improve UI elements: Cloud Logging settings button location, FRAM instance name help info.             |
| Improvement | Accessing instances via external port should be disabled by default when installing instances in FRAM. |
| New Feature | Add ability to view transaction profiles in Pyroscope and support traces to profiles linkage in Tempo. |

## 12.1.1 - 26th Sep. 2024

| Issue Type  | Summary                                                  |
|-------------|----------------------------------------------------------|
| Bug         | Certain environments cause an NPE when metrics start up. |

## 12.1.0 - 24th Sep. 2024

| Issue Type  | Summary                                                                                                                  |
|-------------|--------------------------------------------------------------------------------------------------------------------------|
| New Feature | Implement the ability to browse the FR agent UI from FR cloud.                                                           |
| New Feature | Add transaction support for Java 21.                                                                                     |
| New Feature | Add ability to log in to the FR agent with FR cloud credentials.                                                         |
| Bug         | Prevent potential NPE, within the debugger, when a file name is not found.                                               |
| Improvement | Update the version of the integrated Observability Agent.                                                                |
| Bug         | Prevent quick timeouts when adding FR instances to the Enterprise Dashboard.                                             |
| Improvement | Remove `auth_token` label and add `container_id` label to FR agent metrics.                                              |
| Bug         | Prevent potential blocked threads when using JDBC with WebLogic servers by bypassing with JVM args.                      |
| Bug         | Ensure span status is set for ITTs when they weren't initially sampled.                                                  |
| Bug         | Prevent extra Redis calls when it's being used as session storage for ColdFusion 2023                                    |
| Improvement | Add `http.request_content_length` as a span attribute.                                                                   |
| Improvement | Update the version of the integrated Deep client.                                                                        |
| Bug         | Prevent the wrong file being found when a configured source, within the debugger, has multiple files with the same name. |
| New Feature | Add JVM arg to set the minimum log level required for the logs to be sent to FR cloud.                                   |

## 12.0.1 - 12th Mar. 2024

| Issue Type  | Summary                                                                       |
|-------------|-------------------------------------------------------------------------------|
| Bug         | Fix bug in Deep integration that can affect startup on Windows.               |
| Improvement | Improve the Observability Agent welcome screen to increase clarity for users. |

## 12.0.0 - 7th Mar. 2024

| Issue Type           | Summary                                                                                     |
|----------------------|---------------------------------------------------------------------------------------------|
| New Feature          | Integrate the Observability Agent within FRAM.                                              |
| New Feature          | Add ability to attempt an automatic detection of supported application servers within FRAM. |
| New Feature          | Add ability to configure the cloud group of FR instances within FRAM.                       |
| Bug                  | Modify IPUtils to support Java 17 in order to prevent IllegalAccessException errors.        |
| Improvement          | Increase FRAM action timeout duration to reduce likelihood of displaying false errors.      |
| Security/Improvement | Upgrade current version of Protobuf dependency to remove flagged CVE.                       |
| New Feature          | Add support for Lucee 6 within FRAM.                                                        |
| Improvement          | Improve support for Tomcat 10 within FRAM.                                                  |
| Bug                  | Ensure data labels are updated when provided session info is changed.                       |
| Bug                  | Prevent NPEs from occurring when setting span attributes for MongoDB.                       |
| Change               | Change the default compression and endpoint of span export requests.                        |

## 11.0.1 - 1st Nov. 2023

| Issue Type | Summary                                                                         |
|------------|---------------------------------------------------------------------------------|
| Bug        | Sessions tracking no longer working due to bug introduced by changing to Java 8 | 

## 11.0.0 - 2nd Oct. 2023

| Issue Type                   | Summary                                                                                           |
|------------------------------|---------------------------------------------------------------------------------------------------|
| Security / Bug / Improvement | Upgrade dependencies to remove scanned CVEs                                                       |
| New Feature                  | Implement plugin to integrate with Deep                                                           |
| Improvement                  | Add extra information to shipped event snapshots to improve integration with Deep                 |
| New Feature                  | Add support for jakarta servlet, implementing WebRequest support for newer servers in the process |
| New Feature                  | Send the dbpoolstats log to the cloud as part of the metrics group                                |
| Improvement                  | Show user-agent in email notifications by default and raise maximum SQL statement length to 2000  |
| Improvement                  | Add port field to mail server settings page for greater clarity                                   |
| Bug                          | Event Snapshots are sometimes not sent                                                            |
| Bug                          | Relevant tags/labels on metrics aren't updated when the license changes                           |
| Improvement                  | Add callback support for Redisson 3.16.8+                                                         |
| Bug                          | Possible error when retrieving information for Jedis transactions - 2.10.2 and below              |
| Bug                          | Fix Exception that can occur when processing closed transactions                                  |
| Bug                          | Only send cloud data when required to                                                             |

## 10.0.2 - 19th Jul. 2023

| Issue Type  | Summary                                                                                                 |
|-------------|---------------------------------------------------------------------------------------------------------|
| New Feature | Add support for error-history, longest, slow, event snapshot, memory transaction pages in the cloud.    |
| Bug         | Lucee uses incorrect home path for scraping default logs (catalina/application logs).                   |
| Improvement | Request Content Capture: Allow response only capture and ability to only capture headers or body.       |
| Bug         | Disabling observability logging doesn't disable log scraping.                                           |
| Bug         | Mac M1: Observability plugins not starting due to snappy dependency.                                    |
| Bug         | Internal HTTPS configured passwords are removed if settings are saved with no changes to the passwords. |

## 10.0.1 - 22nd Jun. 2023

| Issue Type        | Summary                                                                                                                         |
|-------------------|---------------------------------------------------------------------------------------------------------------------------------|
| New Feature       | Additional Support for Coalesce images.                                                                                         |
| Bug               | Fix the sending of certain cloud data when using a proxy.                                                                       |
| Improvement / Bug | Incorporate telemetry shipper health status into the cloud health status icon.                                                  |
| Improvement / Bug | Make `-Dfrhomepage` the definitive home page for all roles, regardless of configuration. Remove the `Set Home Page` button too. |
| Improvement       | Remove all chat icons when `-Dfr.chat.enabled=false`.                                                                           |
| Improvement / Bug | Disable class transformation attempts when Java version is not supported for that class.                                        |

## 10.0.0 - 18th May 2023

| Issue Type  | Summary                                                                                                                                                       |
|-------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Improvement | Add ability to configure span sampling ratio during runtime.                                                                                                  |
| Bug         | Fix ColdFusion fileExists function when used with S3 and auth/keys.                                                                                           |
| Improvement | Stops shipping profiles logs.                                                                                                                                 |
| Bug         | User role should be passed when visiting ephemeral servers via Enterprise Dashboard.                                                                          |
| Improvement | Add JVM arg (-D) for disabling email notification from reports plugin.                                                                                        |
| Improvement | Add JVM arg (-D) for setting homepage.                                                                                                                        |
| Improvement | Add JVM args (-D) for setting passwords for manager and observer roles.                                                                                       |
| New Feature | Implement transaction tracking for JMS/MDB. See [FusionReactor System Properties](/Monitor-your-data/FR-Agent/Configuration/FusionReactor-System-Properties/) for configuration info. |
| New Feature | Replace datapack with Prometheus Remote Write for sending FR metrics.                                                                                         |
| Bug         | Protect against NullPointerException when detecting CommandBox servers.                                                                                       |
| Improvement | Add JVM arg (-D) for disabling CommandBox server detection.                                                                                                   |                                                                                                      |
| Bug         | Fix host and port detection for OkHttp transactions when host has underscores (EXAMPLE_HOST).                                                                 |
| Improvement | Telemetry shippers retry on 404 and 429 response status codes.                                                                                                |
| Bug         | Fix log shipper only processing the retry queue when new entries are queued.                                                                                  |
| Bug         | Fix telemetry shipper authentication.                                                                                                                         |
| New Feature | Add support for Coalesce Azure image.                                                                                                                         |
| Improvement | Export/ship unsampled ITTs with their child/sub transactions.                                                                                                 |
| New Feature | Support for ColdFusion 2023.                                                                                                                                  |
| New Feature | Add telemetry shippers to cloud status page.                                                                                                                  |

## 9.2.2 - 1st Mar. 2023

| Key    | Issue Type  | Summary                                                                           |
|--------|-------------|-----------------------------------------------------------------------------------|
| FR8400 | Improvement | Prevent JSONInterposer from writing to a byte array when disabled.                |
| FR8401 | Improvement | Set status on spans.                                                              |
| FR8402 | Improvement | Disable CF metrics by default to reduce performance impact.                       |
| FR8403 | New Feature | Implement new ColdFusion metric for the amount of cached queries per application. |
| FR8404 | Bug         | Fix the filepath label which prevents Windows log shipping.                       |
| FR8405 | Improvement | Reduce the size of JDBCRequest spans. Disable db.user by default                  |

## 9.2.1 - 31st Jan. 2023

| Key    | Issue Type  | Summary                                                                                                             |
|--------|-------------|---------------------------------------------------------------------------------------------------------------------|
| FR8397 | Bug         | Fix total requests (last 60 seconds) amount in Web Metrics page.                                                    |
| FR8398 | Improvement | Add property to disable CF query monitoring for Redis cache when property is set to false (set to true by default). |
| FR8399 | Bug         | Fix event snapshots no longer being sent to the cloud.                                                              |

## 9.2.0 - 18th Jan. 2023

| Key    | Issue Type   | Summary                                                                                                                                                                                                                                     |
|--------|--------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| FR8386 | New Feature  | Distributed tracing is now supported by FusionReactor. FusionReactor can link up with other FusionReactor agents and non-FusionReactor agents alike, to provide a complete trace of a request's journey through your entire infrastructure. |
| FR8387 | New Feature  | Transaction support for `<cfthread action="run"></cfthread>` within Lucee. HttpClient transactions are now correctly linked to their parent CFHTTP transaction in this case.                                                                |
| FR8388 | Modification | HttpClient async transactions are now just one transaction instead of the request and callback each having a transaction. This transaction will have request and response data.                                                             |
| FR8389 | Modification | OkHttp async transactions are now just one transaction instead of the request and callback each having a transaction. This transaction will have request and response data.                                                                 |
| FR8390 | Modification | MongoDB advanced transactions are now enabled by default, in the transaction settings. Tracing requires advanced transactions for best results.                                                                                             | 
| FR8391 | Improvement  | Transactions for ColdFusion API endpoints will now have the related method signature as a transaction name.                                                                                                                                 |
| FR8392 | New Feature  | Transactions will be created to track RabbitMQ operations.                                                                                                                                                                                  |
| FR8393 | New Feature  | Transactions will be created to track Kafka Streams operations.                                                                                                                                                                             |
| FR8394 | Improvement  | The CF metrics graphs and CF system metrics graphs now have all metrics in ColdFusion 2021                                                                                                                                                  |
| FR8395 | New Feature  | Support for setting up to 8 custom key-value labels on metrics, logs, and traces.                                                                                                                 |
| FR8396 | Bug          | FR now shows the correct source code for recompiled classes in Lucee.                                                                                                                                                                       | 

## 9.1.0

| Key    | Issue Type  | Summary                                                                              |
|--------|-------------|--------------------------------------------------------------------------------------|
| FR8384 | Improvement | Add system property to configure log scrape path                                     |
| FR8376 | Improvement | Add more logs to be shipped by default from Lucee and ColdFusion                     |
| FR8375 | Improvement | Add LDAP fallback server configuration and functionality                             |
| FR8373 | Improvement | Display the user level of the currently logged in user on the about page             |
| FR8385 | Improvement | Add file path label to scraped logs                                                  |
| FR8374 | Bug         | JDBC and MongoDB transactions showing incorrect Mem Allocated in Trans. By Mem lists |
| FR8372 | Bug         | Fix crash protection error when thread deadlock highlighting set to false            |


## 9.0.0

| Key    | Issue Type | Summary                                                                                                                |
|--------|---|------------------------------------------------------------------------------------------------------------------------|
| FR8358 | New Feature | Implement a Log shipper within FusionReactor                                                                           |
| FR8359 | New Feature | Implement an Exception log with errors tracked on transactions                                                         |
| FR8459 | New Feature | Implement a log scraper within FusionReactor                                                                           |
| FR8265 | New Feature | Implement multiline log block rollup with Regex patterns                                                               |
| FR8277 | New Feature | Implement log obfuscation with Regex patterns                                                                          |
| FR8369 | Improvement | Add UI control for switching on/off exception stack traces log                                                         |
| FR8370 | Improvement | Add UI control for switching on/off FusionReactor log                                                                  |
| FR8368 | Improvement | Allow customer to specify their own labels on logs                                                                     |
| FR8363 | Improvement | Add a group tag to any log sent from the FusionReactor agent if system property is set                                 |
| FR8362 | Improvement | Disable the shipping of FR agent generated logs by default and add options to send different types of logs with config |
| FR8367 | Bug | Prevent Synthetic Transactions Having a Negative Duration in the FusionReactor Cloud                                   |
| FR8366 | Bug | JDBC Date parameters aren't wrapped in quotes when passed in as Lucee cfqueryparam.                                    |
| FR8371 | Bug | Query parameters are not obfuscated in Crash Protection emails                                                         |

## 8.8.0

!!! warning "Upon upgrade, only FusionReactor 8.8.0 Enterprise Dashboards can monitor 8.8.0 instances"
  - This will only affect users with Enterprise and Ultimate licences using the Enterprise Dashboard feature
  - You must now ensure that the server which you wish to add to the Enterprise Dashboard is online.
  - You can add an 8.7.7 instance and below to an 8.8.0 dashboard, but you cannot add an 8.8.0 instance to an 8.7.7 and below dashboard.

| Key | Issue Type | Summary |
|---|---|---|
| FR8364 | New Feature | CF metrics are now sent to the cloud. |
| FR8358 | Improvement | Send specified request or response headers to the cloud. |
| FR8357 | Improvement | Row Count is now displayed in JDBC history lists. |
| FR8356 | Improvement | Implemented the ability to view graphs as smoothed/averaged. |
| FR8354 | Improvement | Increased the security of user passwords, using a PBKDF-2 algorithm. |
| FR8345 | Improvement | DB and API time columns added to the table view of request log in the archive viewer. |
| FR8344 | Improvement | DB and API time summary now included on the main tab of a transaction. |


## 8.7.7
| Key    | Issue Type  | Summary                                                                    |
|--------|-------------|----------------------------------------------------------------------------|
| FR8340 | Improvement | Added DB and API time to WebRequest summaries in Crash Protection emails   |
| FR8341 | Improvement | Added Entries for DB and API time in the request log                       |
| FR8342 | Bug | Fixed NullPointerException that occurs when using GraphQL with Spring-Boot |

## 8.7.6
| Key | Issue Type | Summary |
|---|---|---|
| FR8309 | Improvement | In web request details, service time has been renamed to API time |
| FR8307 | Improvement | Included CFHTTP in the request API time |

## 8.7.5
| Key | Issue Type | Summary |
| --- | --- | --- |
| FR8301 | Improvement | Added the ability to preview Headers in the transaction history summary views via a settings page |
| FR8287 | Bug | Added limits for linked transactions to protect against increased memory usage |
| FR8285 | Bug | Added support for ColdFusion 2021 solr |

## 8.7.4
| Key | Issue Type | Summary |
| --- | --- | --- |
| FR8258 | Improvement | Removed full stack trace from about page on license failure. |
| FR8255 | Improvement | Permissions errors causing the license key to fail to persist now show a warning notification on the About page. |
| FR8254 | Improvement | Add sources in debugger now closes when a source is added. |
| FR8252 | Improvement | When a JDBC request is truncated, a message explaining how to disable or expand truncation limits has been added. |
| FR8250 | Improvement | Added check to debug library not found page to see if the library has been added. |
| FR8235 | Improvement | Included DB Time and service time into the webrequest and transaction summary view - speeding up root cause focus. |
| FR8289 | Bug | Timestamp objects passed in via CF query param honours the timezone set in the data object. |
| FR8288 | Bug | Timestamp objects passed in via CF query param are now wrapped in single quotes when processed by FR. |
| FR8281 | Bug | "No source directories" message in Debugger page no longer gets removed if breakpoints are set. |
| FR7970 | Bug | On the WebRequest activity page, request kill now attempts interrupt before forcefully killing the thread. |


## 8.7.3
| Key | Issue Type | Summary |
| --- | --- | --- |
| FR8253 | Improvement | Enhance error message in email settings page to explain how to debug emails not sending. |
| FR8249 | Improvement | Make Crash Protection emails enabled by default. |
| FR8153 | Improvement | Improve Instance Manager failed install pages. |
| FR8269 | Bug | Upgrade Java.mail library to support newer TLS versions and cyphers. |
| FR8232 | Bug | UI Fix - Debugger does not show breakpoints if debug email alerts are disabled. |

## 8.7.2
| Key | Issue Type | Summary |
| --- | --- | --- |
| FR8259 | Task | Upgrade ASM to 9.2. |
| FR8247 | Improvement | Improvements to support chat user experience. |
| FR8246 | Improvement | Improvements to support chat usability. |
| FR8260 | Bug | Fix an issue where FR causes an exception to occur on startup in the OSGi log. |
| | Bug | Fix a case where MongoDB datasources use an incorrect pivot. |
| | Bug | Fix an issue with a menu entry appearing incorrectly. |

## 8.7.1
| Key | Issue Type | Summary |
| --- | --- | --- |
| FR8175 | Improvement | Support chat improvements. |
| FR8224 | Improvement | Performance and timing improvements to Redisson async tracking. |
| FR8227 | Improvement | In the case where the connection has been lost, queued datapacks are now sent oldest first. |
| FR8231 | Bug | Fix an issue where NPEs are thrown in certain cases with startup delay configured. |
| FR8225 | Bug | Fix an issue where HTTP client connections leak on Lucee servers. |
| FR8223 | Bug | Fix an issue where JDBC connections using the Datastore to establish connections are not tracked. |
| FR8222 | Bug | Fix connection properties not being tracked for DataDirect JDBC driver connections. |
| FR8221 | Bug | Fix CF_SQL_TIME not displaying correctly in FusionReactor. |
| FR8215 | Bug | Fix an issue where the true value of NVARCHAR is not rendered in JDBC requests. |
|  | Bug | Fix OkHttp transactions to not include a port in the description when one is not set. |

## 8.7.0
| Key | Issue Type | Summary |
| --- | --- | --- |
| FR8220 | New Feature | Support Java 16. |
| FR8220 | New Feature | Support Java 15. |
| FR8154 | New Feature | Support ColdBox Elasticsearch (cbElastic 2.0.0+). |
| FR8214 | Improvement | Support running Datadog and FusionReactor in the same Java process. |
| FR8195 | Improvement | Improve debug logging for JDBC tracking. |
| FR8160 | Improvement | Improve HttpClient tracking. |
| FR8194 | Improvement | Add support to track Vertx 4. |
| FR8210 | Improvement | Upgrade ASM to 9.1. |
| FR8219 | Bug | Fix HttpClient tracking JSON POST/PUT data. |
| FR8218 | Bug | Fix an issue where some docker instances were not being detected as "Docker". |
| FR8184 | Bug | Fix an issue where clicking support chat button with no internet connection causes error. |

## 8.6.0
| Key | Issue Type | Summary |
| --- | --- | --- |
| FR8145 | New Feature | Support Adobe ColdFusion 2021. |
| FR8162 | New Feature | Support Adobe ColdFusion 2021 in Instance Manager. |
| FR8156 | New Feature | Support Adobe ColdFusion 2021 CF Metrics, requires perfmon cf module. |
| FR8158 | New Feature | Support running SeeFusion and FusionReactor. |
| FR8101 | New Feature | Add support to track the Jest - Elasticsearch Java Client. |
| FR7615 | New Feature | Add support to track the official Elasticsearch - Java REST Client. |
| FR8090 | Improvement | Add support for Redisson 3.13.1 to 3.13.6. |
| FR8157 | Improvement | Upgrade ASM to 9.0. |
| FR8177 | Improvement | Send Spring Boot transactions to the cloud. |
| FR8155 | Improvement | Make licensing more robust when looking up the hostname and IP address. |
| FR8061 | Improvement | Add Freshchat into FusionReactor (available from the top right navigation bar). |
| FR8167 | Bug | Fix a performance issue where licensing requests can be very slow when reverse DNS is slow. |
| FR8144 | Bug | Fix a UI redraw issue when setting a variable in the debugger or using "CF Set" that would not update the watches value immediately. |
| FR8098 | Bug | Fix a NullPointerException on shutdown from CloudStateLogger. |

## 8.5.0
!!! warning "Upgrading to 8.5.0 or above will cause Internet Explorer to display a blank screen, this browser is no longer supported."

|Key|Issue Type|Summary|
| --- | --- | --- |
| FR8135 | Improvement | Add support to track CFTHREAD tags / threads on Adobe ColdFusion servers. |
| FR8114 | Improvement | Add support to track all http headers on Adobe ColdFusion servers. |
| FR8109 | Improvement | Add support to show Event Snapshots in the Cloud. |
| FR8096 | Improvement | Add support to track http headers on undertow. |
| FR8094 | Improvement | Send profiles information to the Cloud for slow requests. |
| FR8055 | Improvement | Add support for OkHttp 4.4.1 to 4.8 tracking. |
| FR8053 | Improvement | Add support for Micronaut version 2.x APIs.|
| FR8125 | Improvement | Add support for Kafka  2.4.x and 2.5.x tracking |
| FR8140 | Bug | Fix HTTPClient tracking on Adobe ColdFusion servers. |
| FR8130 | Bug | Fix Java 14 memory tracking. |
| FR8126 | Bug | Fix Enterprise Dashboard lookup calls when the instance name contains the string "login". |
| FR8100 | Bug | Fix Memory Overview page when for 1 hour view. |
| FR8079 | Bug | Fix Jedis tracking for version 3.3.0. |

## 8.4.0
|Key|Issue Type|Summary|
| --- | --- | --- |
|FR8083|New Feature|JSON tracking for GET requests.|
|FR8057|New Feature|Add filter to enterprise dashboard.|
|FR8091|Improvement|Allow FR agent to send more than 2 custom metrics.|
|FR8066|Improvement|Add hostname and ipaddress of instances from EDDS.|
|FR8062|Improvement|Remove the final page of the installer and automatically show Instance Manager.|
|FR8060|Improvement|Improce Lucee line performance so it uses<br>pagePoolClear function, rather than resseting the engine, this prevents<br>CFML pages being aborted.|
|FR8054|Improvement|Bump ASM to 8.0.1  -  to support newest Java versions|
|FR7885|Improvement|Enable System Resources when a CF server is running as a non admin user on windows.|
|FR8073|Improvement|Decompililation support for java 10-15|
|FR8085|Bug|Fix data truncation for massive JDBC statements /  BLOBS going to FusionReactor Cloud.|
|FR8071|Bug|LDAP support is available in FRAM,|
|FR8069|Bug|Add setting to enable status code to be removed from WebMetrics page due to C2 Compiler crashing.|
|FR8059|Bug|Fix an issue where an instance is selected in a<br> group in Enterprise Dashboard, the other instances in the group do not<br>update metrics.|
|FR7983|Bug|Fix an IllegalStateException for the MSSQL driver.|
|FR8080|Bug|Fix an UnsupportedOperationException when running on CommandBox/ColdFusion.|


## 8.3.2
|Key|Issue Type|Summary|
| --- | --- | --- |
|FR8032|Bug|Docker discover fails on some AWS deployments.|
|FR8030|Bug|Error Exclusions no longer works on FR.|


## 8.3.0
|Key|Issue Type|Summary|
| --- | --- | --- |
|FR8015|Improvement|Support licensing even when hostname lookup fails.|
|FR8007|Improvement|Enable event snapshot for Adobe ColdFusion servers.|
|FR7959|Improvement|Enable Event Snapshots by default.|
|FR7971|Improvement|Add debug / native library support for ARM 64 bit (aarch64)|
|FR7794|Improvement|Add support for 64-bit ARM (aarch64) system metrics and system CPU.|
|FR7962|Improvement|Improve in the startup performance of FR agent.|
|FR7956|Improvement|The Apple Mac installer is now signed so it can run directly after download, without flagging Gatekeeper.|
|FR7932|Improvement|Improve the profiler scrolling to better fit the browser size.|
|FR7876|Improvement|Improve ColdBox error tracking to track errors handled by Coldbox.|
|FR7749|Improvement|Improve Lucee line performance by using the pagePoolClear function, rather than resseting the engine.|
|FR7423|Improvement|Improved the the datasource information in<br>JDBC details, for Oracle databases when using a TNSnames.ora file, has<br>been resolved.|
|FR740|Improvement|Add CPU Thresholds for Crash Protection|
|FR8010|Bug|Fix an issue where the Lucee Line Performance transformer does not pick up changes to a compiled page.|
|FR7997|Bug|Fix an issue where the License key is not stored into reactor.conf if license/ dir is missing.|
|FR7984|Bug|Fix an issue with a Memory Leak when running CommandBox 4.9 prerelease.|
|FR7979|Bug|Fix an issue with the Lucee ColdBox Transaction naming.|
|FR7964|Bug|Fix an issue where CommandBox environment detected as ServerType UNKONWN.|
|FR7958|Bug|Fix WildFly Session tracking.|
|FR7948|Bug|Fix an issue with proxy support for the Enterprise Dashboard.|
|FR7942|Bug|Fix an issue with the debugger native library not opening on MacOS Catalina (10.15) due to new restrictions on software.|
|FR7934|Bug|Add support for middle click on FR buttons.|
|FR7918|Bug|Corrects an issue detecting Docker when running within a Kubernetes cluster.|
|FR7915|Bug|Fix an issue with FR causing exceptions to occur in the OSGI log.|
|FR7914|Bug|Fix an issue where Debug emails have a link to the OLD debugger UI not the new one.|
|FR7901|Bug|Fix an issue where Edit breakpoints dialog would reset the fire count to 1 and not keep the the selected values.|
|FR7899|Bug|Fixes a bug with Ephemeral Instances where large pages could cause the tunnel to become unresponsive.|
|FR7895|Bug|Fix an issue where the Enterprise Dashboard dials and bars reset from zero every refresh.|
|FR7889|Bug|Fix an NPE adding an FR 8.3 instance to an 8.3 ED instance via manage servers-|
|FR7877|Bug|Fix an issue in the Jedis tracking in FR.|
|FR7872|Bug|Fix an NPE when viewing Stack Trace All.|
|FR7871|Bug|Fix an issue with the ArchiveViewer not working some times.|
|FR7868|Bug|Fix an IllegalArgumentException in cflog tracking.|
|FR7866|Bug|Fix an issue where the Event Snapshots would generate on the incorrect log level.|
|FR7861|Bug|Fix an issue with Redisson PING command tracking.|
|FR7842|Bug|Fix a ClassCastException in Jersey tracking.|
|FR7838|Bug|Fix an issue where the Server Info would should the incorrect build number for ColdFusion after it was updated.|
|FR7826|Bug|Fix an issue where adding the FR agent twice<br>would cause the server being monitored to fail to start (in some cases)<br>due to a race condition.|


## 8.2.3
|Key|Issue Type|Summary|
| --- | --- | --- |
|FR7953|Improvement|Track RMI calls in java 6  -  8.|
|FR7952|Bug|Fix the Enterprise Dashboard proxy so that it honors the ‘use proxy’ setting for local connections.|
|FR7951|Bug|Fix an ArrayIndexOutOfBounds exception in licensing on some RedHat operating systems.|


## 8.2.2
|Key|Issue Type|Summary|
| --- | --- | --- |
|FR7937|Improvement|Improve performance of the status code part of the WebMetrics page.|
|FR7945|Bug|Fix an issue detecting Docker when running within a Kubernetes cluster.|
|FR7941|Bug|Fix an issue with the Enterprise Dashboards<br>Ephemeral Instances where large pages could cause the tunnel to become<br>unresponsive.  This occurred when viewing long logs in FusionReactor.|
|FR7925|Bug|Fix an issue where the OSGI log would contain errors when using JSON Content-Type but returning none JSON content.|


## 8.2.1
|Key|Issue Type|Summary|
| --- | --- | --- |
|FR7887|Bug|Fix a performance issue with System Monitor<br>and Session tracking on ColdFusion servers which have Redis session<br>store enabled.   This issue could cause high CPU usage.|
|FR7858|Bug|Fix an issue whereby LDAP roles could checked<br>in a random order.   This could mean the user could log in as Observer<br>when they are in the Admin group too.|
|FR7850|Bug|Fix an issue where Redisson PING command tracking would create transactions with empty descriptions and 0ms time.|


## 8.2.0
|Key|Issue Type|Summary|
| --- | --- | --- |
|FR7262|New Feature|Added support for LDAP user authentication and group management.|
|FR7818|Improvement|Add support for Microsoft SQL driver 7.2.2 / Java 11 driver.|
|FR7768|Improvement|Add support for Spring Boot REST apis.|
|FR7763|Improvement|Add support for Micronaut REST server.|
|FR7720|Improvement|Add tracking for okHTTP client.|
|FR7795|Bug|Fix a NullPointerException in the heartbeat plugin which sometimes occurs on startup (very rarely).|
|FR7839|Bug|Fix a NullPointerException on shutdown in the json tracking.|
|FR7831|Bug|Fix the debugger so that it correclty displays classes in the default package.|
|FR7830|Bug|Fix an issue where the debugger breakpoint<br>window would not update the state of the breakpoint when a breakpoint is<br> triggered.|
|FR7829|Bug|Fix an issue where the debugger breakpoint window doesnt update the state when stepping over or continuing.|
|FR7808|Bug|Fix an issue where the debugger classes and source tree would reset for not reason.|
|FR7804|Bug|Fix an issue where Event Snapshot files could<br>become corrupt if the same error occurred at the exact same time on more<br> than 1 thread.|
|FR7786|Bug|Fix kafka tracking for kafka clients 2.3.0.|
|FR7784|Bug|Fix a Lucee 5.2.8+ session tracking where session creation was tracked twice when SessionRotate function was used.|
|FR7777|Bug|Fix an issue where Redisson CONNECT commands were not tracked in FR.|
|FR7766|Bug|Fix an issue where Jedis tracking would display the passwords in FR.|
|FR7750|Bug|Fix an issue where Redisson time tracked was incorrect due to async handling.|
|FR7546|Bug|Fix an html injection issue when viewing variables some object types in the debugger (toString() method had to return HTML).|


## 8.1.1
|Key|Issue Type|Summary|
| --- | --- | --- |
|FR7828|Bug|Fix transaction naming with ColdBox 5.5.|
|FR7821|Bug|Fix a NullPointerException with AMF requests.|
|FR7812|Bug|Fix the Debug UI when using IE11.|
|FR7801|Bug|Fix a race condition in the Debug UI which could cause certain sections to not update.|
|FR7800|Bug|Fix instance manager so that it works when using IE 11.|


## 8.1.0
|Key|Issue Type|Summary|
| --- | --- | --- |
|FR7678|Obsolete|FusionReactor has removed its 32 bit installers for 8.1.0, we only support manual install steps on 32bit operating systems.|
|FR7286|New Feature|Add support for Ephemeral Instances, like docker, to auto register with the Enterprise dashboard.|
|FR7679|New Feature|Enterprise EDDS:  Status page for client and server|
|FR7701|Improvement|Improve the Debugger UI so that it looks more<br>like an IDE and is easier to use.  This allows the loaded classes to be<br>decompiled making it easier to set breakpoints aswell as many more<br>improvements.|
|FR7164|Improvement|Upgrade Highcharts to version 7.|
|FR7662|Improvement|Upgrade jQuery to version 3 as older versions are vulnerable to Cross-site Scripting (XSS) attacks-|
|FR7698|Improvement|Improve the time to switch license from a cloud license to a none cloud license.|
|FR7702|Improvement|Improve the transaction details page so that the event snapshot and profiler results have more space on the page.|
|FR7683|Improvement|Ensure licensing changes reset the session_id used for licensing requests.  This improves license handling on the server side.|
|FR7762|Improvement|Improve the rendering of transactions in the top of the transaction details when no query params exist.|
|FR7677|Improvement|Add a link to the License Connection banner to include a link to a technote to help resolve issues.|
|FR7642|Improvement|Stop tracking FR resources in the PageUsageTracker on real FR pages.|
|FR7635|Improvement|Use the fernflower decompiler for java 8 or newer.  This compiler is faster and more reliable for new class files.|
|FR7293|Improvement|Improve the HTTPClient transactions to include session information and other meta data.|
|FR7734|Improvement|Change the default fire count to 1 for the debuggers default instead of always.|
|FR7735|Improvement|Ensure HTTPClient calls that return 50x codes<br>are tracked as errors same as FusionRequests and appear in the correct<br>Errors page.|
|FR7733|Improvement|Add a white list entry to fr-osgi.conf to support debugging FR code with nerdvison java client.|
|FR7610|Improvement|Allow the decompile from the cloud to use the CFML source if the FR instance can find it.|
|FR5416|Improvement|Fix a performance issue with the decompiler where it was very slow on some files.|
|FR7637|Improvement|Fix a performance issue where the logging pointcuts would cause class loading performance issues.|
|FR7582|Improvement|Fix a performance issue where the ED menu (top right) would take a long time to be built.|
|FR7633|Improvement|Fix a performance issue where the ‘stackTrace<br>all’ for the running requests is slower than the complete ‘stacktrace<br>all’ for all threads.|
|FR6118|Improvement|Fix a performance issue where large uploads would be a lot slower with FR installed compared to without.|
|FR7631|Bug|Fix a bug in  Json Data Tracker Plugin where it showed empty data when application/json header is set for a get request-|
|FR7630|Bug|Fix a bug in the  Json Data Tracker Plugin where it would not handle smile compressed data.|
|FR7772|Bug|Fix a bug in Json Data Tracker Plugin where it would handle invalid json of a single byte.|
|FR7693|Bug|Fix a bug where Json Data Tracker Plugin would look for exact content type and ignore any with character set at the end.|
|FR7765|Bug|Fix a bug where Java would get stuck in java.util.zip.Inflater.inflateBytes(Native Method) when handling invalid Json Data.|
|FR7571|Bug|Fix a bug where FR would break when you have a Cookie header and no value|
|FR7545|Bug|Fix a bug where the debugger didnt show the classname for fields, variables in some cases.|
|FR7544|Bug|Fix a bug where the debugger would break with some Lucee versions as CGI scope .size() throws an NullPointerException.|
|FR7747|Bug|Fix an issue where the datasource name is very<br> large for CFMAIL tags and can cause issues for both memory and sending<br>the data to the cloud.|
|FR7730|Bug|Fix a bug where JDBC transactions would never<br>close the underlying Statement.  This could cause memory leaks with some<br> JDBC drivers (DB2).|
|FR7728|Bug|Fix a bug where the daily, weekly and monthly reports would still be sent if if the license expired.|
|FR7725|Bug|Fix a ConcurrentModificationException bug in<br>the licensing request code which could cause the first license request<br>after startup to fail.|
|FR7724|Bug|Fix a UI issue in IE11 where the top menu (About/Logs/Plugins) wouldn’t work.|
|FR7719|Bug|Fix an issue in the Enterprise Dashboard where<br> you would get a Javascript error when the last ED instance stopping was<br> removed.|
|FR7716|Bug|Remove the license key, which was visible to observer user, from the odl.log file.|
|FR7710|Bug|Fix a bug where FR upgrade banner warning is not dismissable-|
|FR7708|Bug|Fix an issue where the start_ts has been removed from licensing requests in FR 8.0.1 + 8.0.2.|
|FR7676|Bug|Fix a bug where the Kafka mixin would fail with NoSuchField on Kafka 2.2.0.|
|FR7632|Bug|Fix an issue where the legacy JDBC Wrapper<br>only loads on Java 8 and not on Java 9, 10, 11.  This could affect some<br>fallback logic if customers had to enable the legacy wrapper instead of<br>the default, faster, mixins.|
|FR7711|Bug|Fix a NullPointerException in the thread list, if the thread finished at the correct time.|
|FR7462|Bug|Fix a NullPointerException on Transaction<br>History page when viewing all transactions but filtering on a subflavor<br>which JDBC requests doesn’t understand.|


## 8.0.2
|Key|Issue Type|Summary|
| --- | --- | --- |
|FR7689|Improvement|Add support for FusionReactors licensing notifications showing HTML links.|
|FR7688|Improvement|Ensure the license session_id is cleared when the license key changes.|
|FR7687|Improvement|Add a link to the support documentation in the the License Connection notification.|
|FR7681|Improvement|Increase ASM version to 7.1|
|FR7665|Improvement|Add link to FR 8 specific Third Party License agreement, but its currently the same as FR 7.|
|FR7690|Bug|Fix an issue where, after upgrading to FR 8<br>with a manual activated license, FR would become active (for a short<br>period) when it should not.|
|FR7682|Bug|Fix Kafka tracking with Kafka version 2.2.0.|
|FR7674|Bug|The JSON capture feature of FR is showing empty data when application/json header is set but no body exists.|
|FR7654|Bug|Fix the debuggers Resume Thread button so it works on Windows.|


## 8.0.1
|Key|Issue Type|Summary|
| --- | --- | --- |
|FR7641|Bug|Fix an issue where the debuggers UI would scale incorrectly after moving the slider / separators.|
|FR7640|Bug|Fix a performance issue where the logging capture feature in FusionReactor could cause ColdFusion startup slowness.|


## 8.0.0
|Key|Issue Type|Summary|
| --- | --- | --- |
|FR7247|New Feature|Support the monitoring of Spring Sessions.|
|FR7443|New Feature|Support the capturing of variables of the stack when transactions fail.|
|FR7137|New Feature|Support for filtering the stacktrace all based on the locks currently being held or waited on.|
|FR7279|New Feature|Support capture of JSON request and responses.|
|FR7477|New Feature|Support for Java 11 (Oracle and OpenJDK).|
|FR7474|New Feature|Capture log statements of slf4j, apache commons and log4j frameworks and CFLOG tags.|
|FR7589|New Feature|Capture log statements via CFLOG tags.|
|FR7313|New Feature|Add a new cloud status page to help support and customer track down connection issues.|
|FR7611|New Feature|Add support for tracking Jedis v2 and v3.|
|FR7473|New Feature|Support for MongoDB drivers > 3.8.0|
|FR7408|Improvement|UI pages with tabs maintain the selection on refresh.|
|FR7623|Improvement|Improve the text fields on the debugger dialog to add more meaning to possible options.|
|FR7332|Improvement|Improve the internal logging of Cloud based requests (IRs) to include more meta data.|
|FR7442|Improvement|Use CF 2018 Monitor class to track all CF metrics.|
|FR7436|Improvement|About page to show the licensing exceptions (in full) to the user.|
|FR7378|Improvement|Add additional information to the Web Metrics summary tables to show Recent WebRequest count, JDBC count and error count.|
|FR7371|Improvement|Improve the email alerts from the enterprise<br>dashboard when a server comes online to include much more information<br>about the server.|
|FR7204|Improvement|Improve the robustness of the Cloud datapack shipping so that it can handle errors more effectively.|
|FR6775|Improvement|Improve licensing so that the license server<br>handles all state and messages so that these can be changed and updated<br>without needing new client functionality or changes.|
|FR7561|Improvement|Improve the debugger exception error messages when the debugger doesn’t have exception support enabled.|
|FR7560|Improvement|Add support for Amazon Corretto 8.|
|FR7513|Improvement|Show the Max MetaSpace value if its been set for the JVM.|
|FR7512|Improvement|Add the actual exception type to the history<br>pages so that the user can see what type of exception occurs without<br>needing to use transaction details page.|
|FR7534|Improvement|Make the server discovery code discover FRAM instances as FRAM server type instead of UNKNOWN.|
|FR6548|Improvement|Improve the left menu of FR so that uncommon entries moved into sub menus and the main menu is more compact.|
|FR7548|Improvement|Include ENV variables in license request data so that the cloud can filter based on this data.|
|FR7404|Improvement|Make threads holding locks now have direct links to their stack trace via lock / thread ID.|
|FR7531|Bug|Fixed a lock contention issue where JDBC, with no memory tracking enabled, would block on the JDBC by Memory series.|
|FR7509|Bug|Fixed an issue where the debugger would not<br>always show all locks currently held by a thread when using the “Suspend<br> Thread” functionality.|
|FR7506|Bug|Fixed a NullPointerException in FusionReactor when viewing profiles via the Cloud UI.|
|FR7507|Bug|Fixed an issue where the Request Content Capture feature would affect ColdFusion AJAX request.|
|FR7494|Bug|Fixed an issue where the “Stack Trace All” Plain view showed ‘blocked’ threads when the ‘waiting’ filter was active.|
|FR7492|Bug|Fixed an issue with the licensing debug page ‘ODL Information’ Copy to Clipboard button throws a JavaScript TypeError.|
|FR7466|Bug|Fixed an issue where ColdFusion requests could be stuck due to the line performance tool even when it is disabled.|
|FR7444|Bug|Fixed an issue where the profiler would break on any java thread which doesn’t have a stack trace.|
|FR7420|Bug|Fixed an issue where pressing the start profiler button could result in incorrect profiling of the thread.|
|FR7421|Bug|Fixed an issue where the duration of running profiles didn’t update until the thread was profiled. I.e at each sample.|
|FR7413|Bug|Fixed an issue with the decompiler breaking StringConcatFactory but never informing the user why if failed.|
|FR7409|Bug|Fixed an issue with CFHTTP calls in CF 2016<br>which would throw a NoSuchFieldError when FusionReactor attempted to<br>read the query_string property.|
|FR7533|Bug|Fixed an issue where manually installing<br>FusionReactor (outside of the normal install process) would cause the<br>license activation to fail with a NullPointerException.|
|FR7498|Bug|Fixed a ConcurrentModificationException which<br>could occur if a new tracked statistical series became visible while<br>FusionReactor was preparing a Cloud datapack for upload.|
|FR7481|Bug|Fixed an issue with CFMAIL ColdFusion tag where the from and to addresses would be swapped around.|
|FR7472|Bug|Fixed an issue where internal debug checks were<br> enabled in the release version of FusionReactor which would then break<br>CFPOP CFIMAP tags in ColdFusion.|
|FR7461|Bug|Fixed a NullPointerException in the Cloud Retry<br> thread which could occur when we log the internal state changes of the<br>connection.|
|FR7416|Bug|Fixed a ConcurrentModificationException in the Enterprise Dashboard when servers are registered and deregistered automatically.|
|FR7402|Bug|Fixed the tracking of ColdFusion ASYNC requests in ColdFusion 2018.|
|FR7388|Bug|Fixed an issue where ColdBox transaction names are tracked as index.cfm rather than using event name.|
|FR7338|Bug|Fixed an issue where the description HTTP Client calls was incorrect with some versions.|
|FR7601|Bug|Fixed an issue where the number of transactions sent to the cloud were unlimited.|
|FR7530|Bug|Fixed an issue where the Debugger throws NumberFormatException when using the next frame button in the UI.|
|FR7482|Bug|Fixed an issue where conditional breakpoints fail on CF 2018 because CFEVALUATE signature changed slightly.|
|FR7425|Bug|Fixed a StringIndexOutOfBoundsException when FusionReactor tracks Mongo operations.|
|FR7426|Bug|Fixed Crash Protection and Debug emails when triggered from Grizzly and Jersey WebRequests.|
|FR7412|Bug|Fixed a java.lang.AbstractMethodError when monitoring using WebSockets in WildFly 13.|
|FR7406|Bug|Fixed an issue where stack traces would show the incorrect hash code for a lock under ownable synchronizers.|
|FR7400|Bug|Fixed an issue where the Docker truncated container ID in the license activation message is sometimes discovered incorrectly.|
|FR7382|Bug|Fixed an issue where the host in the description on mongo transaction is sometimes null.|
|FR7207|Bug|Fixed an issue where the profiler would show<br>very short profile times when the profiler kicks in just as the<br>transaction finishes.|
|FR7590|Bug|Fixed an issue where Request would not be filtered / limited when running recent / history IR from the Cloud.|
|FR7455|Bug|Fixed the HitCount data (application / database) information when its sent to cloud. It could sometimes contain partial data.|
|FR7417|Bug|Fixed an issue where transactions do not have the correct application name for some transactions.|
|FR7617|Bug|Fixed an issue where the Request detail from the Cloud would return invalid json.|
|FR7613|Bug|Fixed an issue where the Database page would<br>display negative memory allocations when the setting was disabled for<br>sub transactions.|
|FR7427|Bug|Fixed an issue where the sigar library (native<br>system metrics library) cannot be loaded on IBM I and ARM operating<br>systems and would cause FusionReactor to fail to start.|
|FR7626|Bug|Fixed an issue where the Stack Trace All button would show the label twice due to a UI refresh timing problem.|
