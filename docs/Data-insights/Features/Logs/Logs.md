


FusionReactor provides real-time graphs and metrics to help you monitor system performance. These graphs also show short-term history based on the available data. But what happens if your server crashes?

Since much of this data is stored in memory for reporting within the FusionReactor Administrator, it is lost during a restart. However, all of it is also written to FusionReactor’s extensive log files.

These logs can almost always be used in **post-mortem analysis** to identify the source of system issues. Beyond troubleshooting, they are also valuable for analyzing usage patterns, spotting trends, and deriving long-term aggregate data.

Starting with **FusionReactor 4.0**, two styles of logging are supported. You can switch between them on the [Log Settings](/Data-insights/Features/Logs/Settings/) page.






## Centralized Archive & Rotation

When installing FusionReactor from scratch, **Centralized Archive and Rotation** is the default logging mechanism.

This method organizes logs into **timestamped folders** within the Log Directory specified on the [Log Settings](/Data-insights/Features/Logs/Settings/) page. Each folder contains a complete set of log files for a specific period.

You can configure:

* **Rotation frequency:** create a new folder every *n* minutes, or rotate logs at a specific daily time
* **Retention:** limit how much log data is saved by disk usage, time period, or keep all logs if storage allows

The key advantage over the older Traditional method is that it’s easier to batch a complete set of logs for a defined period-useful for comparing logs over time.

All settings are configurable on the [Log Settings](/Data-insights/Features/Logs/Settings/) page.





## Traditional Per-Log Rotation

If you upgrade from an older version of FusionReactor, **Traditional Per-Log Rotation** will be your default logging mechanism. This was the standard logging method in all versions prior to 4.0.

With this method, you can configure each log file’s **maximum size** and the **number of files** to retain. For example, setting a 10MB log size with a history of 5 files allows a maximum of 50MB of logs at any time.

All log files are stored in the Log Directory specified on the [Log Settings](/Data-insights/Features/Logs/Settings/) page. Each log type (e.g., `request.log`) will have numbered files (`request-0.log`, `request-1.log`, … `request-4.log`). When `request-0.log` fills up, all files are renamed, a new `request-0.log` is created, and the oldest file (`request-4.log`) is deleted. This ensures that `request-0.log` always contains the latest log entries.

Settings for **file size** and **file count** are available on the corresponding settings pages (e.g., [Requests Settings](../Requests/Settings.md) for `request.log`).

We recommend switching to **Centralized Archive and Rotation** for greater control and easier log management.


## Log Page


The **Log View** page in FusionReactor provides insight into the logs currently being written. You can access it from the **FusionReactor** tab in the top-level menu.



![](/attachments/245548584/245548591.png)

### Options

![](/attachments/245548584/245548596.png)

-   From the page buttons, you have the options to select other log
    files that might be in the current directory.

!!! note
    In FusionReactor 7.3.0 the dropdown functionality was changed to only
    show files that are currently existing within the log directory.
    Non-existent files will no longer show up here.

-   The Tail button will make sure that the scroll bar is stuck towards
    the end of the log file, this can be used to monitor log output as
    it is happening in real time.
-   The Delete button will delete the selected log file from
    FusionReactor's log directory, use this with caution!
-   The Archive Viewer button is a redirect to the Archive Viewer Page,
    this might be handy if your log file was rotated and is not
    currently visible on the Logs page.
-   The refresh button will attempt to load any new changes to the log
    file, this is useful when you do not necessarily want to tail the
    file.


## Logs Files



These logs capture server data such as requests, query results, CPU/memory usage, and more. Note that the log names in the FusionReactor **User Interface** may differ; this is indicated in the table below under the **UI Name** column.

Clicking a log name opens a dedicated page for that log, explaining each column and providing additional useful information.


|File Name|UI Name|Log Type|
|--- |--- |--- |
|classes.log|Class Loading Log|DATA|SYSTEM|
|cloud-state.log|Cloud State Log|DATA|PLUGIN|
|cputhread.log|CPU Thread Log|DATA|SYSTEM|
|crashprotection.log|Crash Protection Log|DATA|SYSTEM|
|datapack-transport.log|Cloud Transport Log|DATA|PLUGIN|
|dbpoolstats.log|DB Pool Stats Log|DATA|PLUGIN|
|deadlock.log|Deadlock Log|DATA|PLUGIN|
|fr-jrun-event.log|Jrun Event Log|DATA|PLUGIN|
|fr-probi.log|Probi Log|STATUS|SYSTEM|
|gc-G1-Young-Generation.log|G1 Garbage Collection Log|DATA|SYSTEM|
|gc-[TYPE].log|Garbage Collection [TYPE] Log|STATUS|SYSTEM|
|heartbeat.log|Heartbeat Log|DATA|PLUGIN|
|hitcountstats.log|Hit Count Stats Log|DATA|PLUGIN|
|HTTP.log|HTTP Log|RAW|SYSTEM|
|ir-audit2.log|Cloud IR Audit Log|DATA|PLUGIN|
|jdbc.log|JDBC Log|DATA|SYSTEM|
|juli-[TYPE].log|JULI [TYPE]|RAW|RAW|
|memory[TYPE].log|[TYPE] Log|DATA|SYSTEM|
|memorysummary.log|Memory Summary Log|DATA|SYSTEM|
|notification.log|Notifications Log|DATA|SYSTEM|
|odl.log|ODL Log|DATA|SYSTEM|
|osgi.log|OSGi Log|STATUS|SYSTEM|
|plugin-[name]-plugin.log|Log for the [name] plugin|STATUS|PLUGIN|
|reactor.log|Reactor Log|STATUS|SYSTEM|
|realtimestats.log|Real Time Stats Log|DATA|PLUGIN|
|request.log|Request Log|DATA|SYSTEM|
|resource.log|Resource Log|DATA|SYSTEM|
|stacktrace.log|Stacktrace Log|DATA|SYSTEM|
|stdout.log|Standard Out Log|RAW|SYSTEM|
|stderr.log|Standard Error Log|RAW|SYSTEM|
|thread-state.log|Thread State Log|DATA|SYSTEM|

### Log Type

|Word|Definition|
|--- |--- |
|DATA|Data related to the server memory, CPU, response time etc.|
|STATUS|Data related to a PLUGIN or the SYSTEM. The information is brief and  only covers the state of the PLUGIN or SYSTEM.|
|RAW|Raw logs are logs which FusionReactor capture from other sources and redirections.  The format is unknown to FusionReactor and is simply a clone of the stream|

## Log File Format

All logs are space-delimited. This allows you to easily [import the
files into spread
sheets](Importing-and-Graphing-Data-in-Excel.md) such as
Microsoft excel and openoffice as well as databases, allowing you to
view/analyze/graph the logs as you may prefer.

Below is a (fictional) example of a log file and how a table for the log
would explain its columns.

### Example log file and table

Below is an example log file line:

```
SERVER1 70 5 21
```

This log file line contains the column values SERVER1, 70, 5, and 21.
Below is the table that would explain the log file.

|Field Name|Number|Description|
|--- |--- |--- |
|Server Name|1|The server's name.|
|Efficiency(percentage)|2|How efficient the server is.|
|Downtime (hours)|3|The downtime of the server.|
|Uptime (hours)|4|The up time of the server.|

### Exceptions to the typical log file format

There are several log files which also contain a plain text message
(e.g. reactor.log). In this case, the
space-delimited format applies for first few columns, until the last
one, the 'message' value, where everything to the end of the line is
considered the value of that last field.

## External Capturing

FusionReactor 7.3.0 introduces further improvements to how information
from application servers is captured. Much like the Apache Commons log
files, FusionReactor will intercept log files from the Apache's JULI
logging API and include them in its log directory. This can be
beneficial for individuals with application deployment issues.

In addition to this, FusionReactor will capture the standard output from
the Java runtime and put this into two new files: Standard Out Log and
Standard Error Log.

### Tomcat Log Capturing

Any log files that have been retrieved from Apache's JULI API will be
prefixed with "juli" on the file level. These files can vary between
hostmanager or per-app log files, for example.

!!!Note
    It is important to note that Tomcat's catalina.out differs from our
    juli-catalina.log. FusionReactor will separate the standard out/error
    print statements into a completely different file (see below), however
    catalina.out contains both the catalina log messages in addition to the
    standard out/error.

### Standard Out & Standard Error Capturing



FusionReactor captures the **standard output (stdout)** and **standard error (stderr)** of the Java process generated by Java methods or bytecode. It does **not** include messages written by native libraries.

Stdout and stderr are captured from the **start of the Java process**. During FusionReactor startup, up to **500 lines** of each log are temporarily stored before being written to the FusionReactor log directory.



