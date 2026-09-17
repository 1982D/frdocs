# Class Loading Log

The **Class Loading Log** (classes.log) contains information about the java classes being
loaded, unloaded and the total classes in the Java VM.

The log file is formatted as follows:

|Field Name|Column|Description|
|--- |--- |--- |
|Date (Formatted)|1|The date on which this log entry was written.|
|Time (Formatted)|2|The time on which this log entry was written.|
|Date/Time (Milliseconds)|3|This is the millisecond time at which this request was started or finished (depending upon the Request Status.)|
|Version|4|Version number of this log entry.|
|Server Startup Time (ms)|5|Startup time of the application server in milliseconds (ms) since epoch.|
|Total Classes|6|The number of total classes in the Java VM|
|Classes Loaded|7|The number of classes loaded since the last log entry|
|Classes Unloaded|8|The number of classes unloaded since the last log entry|
 
