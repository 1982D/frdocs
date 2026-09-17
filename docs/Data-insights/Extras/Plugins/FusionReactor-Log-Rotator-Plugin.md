title: Log Rotator
# FusionReactor Log Rotator Plugin

Manages the maintenance of log files within FusionReactor. Features
include:-

-   Two types of mode - *Centralized Archive and Rotation* and *Per-Log
    Rotation* mode
-   Rotates log files on a given schedule (either at a given time every
    day, or periodically)
-   Transfer of rotated log collection as a zip file to a central
    location
-   Management of log files (purge) based on age or size target (oldest
    first)


## Configuration


This configuration page allows you to locate logs that are archived and kept in the archive
directory in FusionReactor.

Logs that are archived can be located at
/FusionReactor/instance/\[your\_instance\_name\]/log.

The following data can be archived and transferred or just archived:

-   CPU/Thread Log
-   Memory Detailed (Fine)
-   Memory Summary (Coarse)
-   Reactor Log
-   Request Log
-   Resource Log
-   Plugin Log
-   Crash Protection Log
-   JDBC Log
-   System Heartbeat
-   Default

## Status Log - plugin-fr-logrotator.log

This plugin creates a log file called **plugin-fr-logrotator.log** which
contains information on the status of the plugin, when it started,
stopped, if there were any problems. Below is a table explaining what
all the attributes in the log file mean.

|Field Name|Number|Description|
|--- |--- |--- |
|Date (Formatted)|1|The date on which this log entry was written.|
|Time (Formatted)|2|The time on which this log entry was written.|
|Level|3|Log Level basically means the nature of the log, for example INFO means general information, where as ERROR means an error is being logged. SEVERE means something really bad has happened, this will be typically followed by the a generated exception.|
|Log message|4|Contains a message of an event that occurred such as logging that has started.|
