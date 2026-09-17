title: Heartbeat
# FusionReactor Heartbeat Plugin

Constantly logs whether or not a specific instance is up (running).

!!!note
    Increasing the value of the Heartbeat Metrics Fetch Interval will lower
    the refresh rate of the metric data shown on the Enterprise Dashboard.
    Decreasing this value may cause heartbeat failures. It is NOT
    recommended to set this value below 5 seconds.

## Configuration

This plugin can be configured in [Enterprise Settings](/Data-insights/Features/Enterprise-Dashboard/Settings/).

|Configuration|Description|
|--- |--- |
|Heartbeat Metrics Fetch Interval (seconds)|This interval tells FusionReactor how long to wait between each fetch of a monitored instance's metric data (its heartbeat). The heartbeat contains the data that is shown on the Enterprise Dashboard.|
|Heartbeat Timeout (seconds)|This timeout governs how long FusionReactor will wait for a heartbeat from a monitored server instance. If no heartbeat is received within this time or a network connection failure occurs, FusionReactor will count it as a heartbeat failure.|
|Heartbeat Failure Threshold|This setting tells FusionReactor how many times the heartbeat may fail on a monitored server instance before considering it to be DOWN. FusionReactor will then report the server instance as [CONN] on the Enterprise Dashboard and will run the self-healing script for the instance (if configured). If you are receiving monitoring emails and log messages for instances known to be available, try increasing this value. A value of zero will cause the first missing heartbeat to signal the server instance is DOWN.|

##Log File - heartbeat.log

The plugin generates a log file called **heartbeat.log**, this contains
heartbeat information that could be very useful when diagnosing server
problems.

|Field Name|Number|Description|
|--- |--- |--- |
|Date (Formatted)|1|The date the log was written.|
|Time (Formatted)|2|The time the log was written.|
|Date/Time (ms)|3|The number of seconds since epoch.|
|Version|4|Version number of this log entry.|
|Server Start up Time (ms)|5|Start up time of the application server in milliseconds (ms) since epoch.|
|Beat|6|If the server is up the value is 1, if not it will be 0. When your server starts up it read read 1, any other entry after that will read 0.|
|Up|7|If the server has started up this value will be 1, if not it it will be 0.|
|Down|8|If the server is shutdown this value will be 1, if not it will be 0.|
|Dirty Shutdown / Start up|9|If a dirty shutdown or start up occurred in a server this value will be 1 when the server next starts.|
|Date/Time|9|The date and time the entry was written according to ISO 8601 standards.|

## Status Log - plugin-fr-heartbeat-plugin.log


The Heartbeat plugin creates a log file called
plugin-fr-heartbeat-plugin.log which contains information on the status
of the plugin, when it started, stopped, if there were any problems.
which contains information on the status of the plugin, when it started,
stopped, if there were any problems. Below is a table explaining what
all the attributes in the log file mean.

|Field Name|Number|Description|
|--- |--- |--- |
|Date (Formatted)|1|The date on which this log entry was written.|
|Time (Formatted)|2|The time on which this log entry was written.|
|Level|3|Log Level basically means the nature of the log, for example INFO means general information, where as ERROR means an error is being logged. SEVERE means something really bad has happened, this will be typically followed by the a generated exception.|
|Log message|4|Contains a message of an event that occurred such as logging that has started.|
