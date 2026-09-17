title: JRun Plugin

# FusionReactor JRun Plugin

This plugin allows you to access the JRun log files.

## Configuration

This page allows you to enable or disabled the creation of JRun Event
Log Entries. Enabling this will allow the plugin to log JRun server
events which are then included in the FusionReactor Centralized Log
Rotation when it occurs. The logs can also be used to analyze the
server. The option you choose does not alter the JRun Log Directory
setting.

## Log File - fr.jrun-event.log

This log is called fr.jrun-event.log. **Don't** confuse this with that
status log, the status log displays the state of the plugin (on, off and
error) where as this describes what the plugin is doing (starting
applications etc).

|Field Name|Number|Description|
|--- |--- |--- |
|Date (Formatted)|1|The date on which this log entry was written.|
|Time (Formatted)|2|The time on which this log entry was written.|
|Date (Short)|3|Displays a short version of the date (DD/MM).|
|Log message|4|Contains a message of an event that occurred such as logging that has started.|
|Time (Short)|5|The time the entry was written.|
|Entry|6|The entry that was written. for example the entry might state that a servlet was started up.|


## Status Log - plugin-fr-jrun-plugin.log

This plugin creates a log file called **plugin-fr-jrun-plugin.log** 
which contains information on the status of the plugin, when it started,
stopped, if there were any problems. Below is a table explaining what
all the attributes in the log file mean.

|Field Name|Number|Description|
|--- |--- |--- |
|Date (Formatted)|1|The date on which this log entry was written.|
|Time (Formatted)|2|The time on which this log entry was written.|
|Level|3|Log Level basically means the nature of the log, for example INFO means general information, where as ERROR means an error is being logged. SEVERE means something really bad has happened, this will be typically followed by the a generated exception.|
|Log message|4|Contains a message of an event that occurred such as logging that has started.|
