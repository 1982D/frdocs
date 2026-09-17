title: System Monitor
# FusionReactor System Monitor Plugin

The System Monitor Plugin is covered in detail in the "System
Resources" section of the docs.

The System Monitor plugin is the tool used to gather the data necessary
for that section.

The System Monitor Log's only purpose is to keep track of the status of
the plugin. The only values that will are outputted are as follows:

## Status Log - plugin-fr-system-monitor.log

This plugin creates a log file called **plugin-fr-system-monitor.log** 
which contains information on the status of the plugin, when it started,
stopped, If there were any problems. Below is a table explaining what
all the attributes in the log file mean.

|Field Name|Number|Description|
|--- |--- |--- |
|Date (Formatted)|1|The date on which this log entry was written.|
|Time (Formatted)|2|The time on which this log entry was written.|
|Level|3|Log Level basically means the nature of the log, for example INFO means general information, where as ERROR means an error is being logged. SEVERE means something really bad has happened, this will be typically followed by the a generated exception.|
|Log Message|4|Contains a message of an event that occurred such as logging that has started.|


### Log Message 4The '*Log Message*' can be any of the following:

**If Successful**:

-   'Logging started for *PluginID *(where* PluginID* is a specific name
    for your system monitor plugin)
-   'System Monitor Started'

**If Unsuccessful**:

-   'Error while starting System Monitor'
