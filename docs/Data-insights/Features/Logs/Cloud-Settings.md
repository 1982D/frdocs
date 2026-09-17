## Logging cloud settings

This page is used to alter the log shipper built into FusionReactor. Here you can: 

* alter which log files are shipped from the FusionReactor agent.

* scrape additional logs to be shipped. 

* exclude logs from being shipped.

## Minimum log send level

The minimum log level of logs FusionReactor will ship to the cloud.

| Configuration           | Description                                                                                          | Default |
|-------------------------|------------------------------------------------------------------------------------------------------|---------|
| Minimum Log Send Level  | This setting defines what the minimum log level of log line FusionReactor will be sent to the cloud. | info    |

## Log shipping

Options to enable the shipping of the FusionReactor agent logs to the cloud.

These logs will provide value in the archive viewer and for log analysis locally, but lack value when being sent to the cloud as the log data will essentially be a duplicate of existing metrics or traces.

Metric logs are considered as logs created by the agent to track metrics over time, including:

- `classes.log`
- `fr_thread.log`
- `gc-*.log`
- `memory-*.log`
- `memorysummary.log`
- `thread-state.log`
- `heartbeat.log`
- `resource.log`

Transaction logs are logs of any tracked transaction in FusionReactor. By default, only a request log is created, but [JDBC logging](/Data-insights/Features/Settings/JDBC/#logging-metrics) and [Txn logging](/Data-insights/Extras/Plugins/FusionReactor-Transaction-Logger-Plugin/) can be enabled. Log files include:

- `request.log`
- `jdbc.log`
- `transaction.log`

Support logs are used by the Fusion Support team to diagnose issues. If you have an issue within an instance you may be asked to enable this setting. Logs include:

- `fr-probi.log`
- `identity.log`
- `osgi.log`
- `odl.log`
- `reactor.log`
- `HTTP.log`
- `cloud-state.log`
- `datapack-transport.log`
- `ir-audit*.log`

| Configuration          | Description                                                                | Default |
|------------------------|----------------------------------------------------------------------------|---------|
| Transaction group logs | This setting defines whether transaction logs will send ship to the cloud. | false   |
| Metric group logs      | This setting defines whether metric logs will send ship to the cloud.      | false   |
| Support group logs     | This setting defines whether support logs will send ship to the cloud.     | false   |

## Log scraping

Log scraping allows the FusionReactor agent to scrape content from any log file hosted on the server FusionReactor is installed on.

!!! note
    Sending logs via the FusionReactor agent is simple but not suited for large volumes, as it may slow the application.


!!! note 
    Avoid having multiple FusionReactor instances scrape the same files to prevent duplicate log data.

You can specify a comma separated list of regex file paths including wildcards using the character: ```*```.

!!! warning
    For certain platforms or Java versions you may be required to escape slashes within your paths, so `C:\ColdFusion` would become `C:\\ColdFusion`. 

### Linux examples
To send all logs for a tomcat server:
````/opt/servers/tomcat/tc7/logs/*log````

To send specifically the catalina.out log for a tomcat server:
````/opt/servers/tomcat/tc7/logs/catalina.out````

To send just the CF exception and application log:
````/opt/coldfusion2018/cfusion/logs/exception.log,/opt/coldfusion2018/cfusion/logs/application.log````

To send stdout and stderror:
````/dev/std*````

### Windows examples
To send all logs for a ColdFusion server
````C:\ColdFusion2018\cfusion\logs\*log````

To send just the CF exception and application log on Windows:
````C:\ColdFusion2018\cfusion\logs\exception.log,C:\ColdFusion2018\cfusion\logs\application.log````

To send the system logs
````C:\WINDOWS\system32\config\*log````

!!! tip
    For certain platforms or Java versions you may be required to escape slashes within your paths, so `C:\ColdFusion` would become `C:\\ColdFusion`. 

### Testing your scrape pattern

Testing your scrape pattern displays a list of matching log files that will now be scraped.

!!! info "Learn more" 
    [Logging Regex Pattern Hints](/Troubleshooting/logging-regex-pattern-hints/)

## Log exclusion

Log exclusions can exclude any logs sending to OpsPilot, either for security or to reduce data volume.

Similar to the scrape pattern you can add a regex pattern match for logs that will be blacklisted from sending, with the option of using the wildcard character: ```*```

Example patterns to exclude the osgi and plugin logs of FusionReactor:

````
*/instance/log/*/plugin-*,*/instance/tc7/log/*/osgi.log

/opt/servers/tomcat/tc7/logs/access.log
````

### Testing your exclude pattern

Testing your exclude pattern will display a list of matching log files that will now be excluded from sending to the cloud.

!!! info "Learn more" 
    [Logging Regex Pattern Hints](/Troubleshooting/logging-regex-pattern-hints/)
