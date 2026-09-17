title: Log Tracker
## FusionReactor Log Tracker Plugin

This plugin captures log statements throughout the life of a
transaction, and attaches these statements to the transaction as a
context.

This can be seen as part of the [request details](/Data-insights/Features/Requests/Request-Details/).

## Supported Logging

|Type|Description|
|--- |--- |
|Log4J2|The plugin is able to track log statements made using the Log4J2 framework.|
|SLF4J|The plugin is able to track log statements from implementations of the SLF4J Logger. This is WARN and ERROR level only.|
|CFLOG Tags|The plugin is able to track <cflog> tags in ColdFusion and Lucee.|


## Configuration

To change the Log Tracker settings, click the drop down and select a log
capture level.

![](/attachments/245548311/245548338.png)

This setting defines the level at which the plugin will track log
statements (and more specific).

For example, a setting of ERROR will track ERROR and FATAL log
statements.

A setting of FATAL will only track FATAL logs.

Setting the plugin to WARN will track WARN, ERROR and FATAL log
statements.

OFF disables log capturing.  

Click **Save Configuration** on the right side of the window to save your
configuration.
