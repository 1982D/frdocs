# Crash Protection Log

The Crash Protection Logs (crashprotection.log) are a set of rotating files which you can
configure from the [Protection Settings](/Data-insights/Features/Crash-protection/Settings/) page.

The log file is formatted as follows:

|Field Name|Number|Description|
|--- |--- |--- |
|Date (Formatted)|1|The date on which this log entry was written.|
|Time (Formatted)|2|The time at which this log entry was written.|
|Date/Time (ms)|3|The number of milliseconds since the epoch.|
|Version|4|Version number of this log entry.|
|Server Startup Time (ms)|5|Startup time of the application server in milliseconds (ms) since epoch.|
|CP Type|6|The type of Crash Protection which caused this log entry to be written.|
|Action|7|The action which was carried out on this request by Crash Protection.|
|Memory Percentage|8|The percentage of free memory at the time of this log entry.|
|Memory Threshold|9|The threshold percentage of free memory set up in Crash Protection settings.|
|Request Count|10|The number of currently running requests at the time of this log entry.|
|Request Threshold|11|The threshold number of currently running requests set up in Crash Protection settings.|
|Execution Time|12|The current execution time of this request at the time of this log entry.|
|Execution Threshold|13|The threshold execution time set up in Crash Protection settings.|
|Server ID|14|The ID of the server for Server Up / Down notifications|
|Script|15|The script that you set up in the Crash Protection settings (including passed parameters if available).|
|Date/Time (ms)|16|This is the millisecond time at which this request was started or finished (depending upon the Request Status.)|
|Version|17|Version number of this log entry.|
|Server Startup Time (ms)|18|Startup time of the application server in milliseconds (ms) since epoch.|
|Request ID|19|The FusionReactor Request ID.|
|Request Status|20|The current state of the request. This will tell you if a request has started, finished, was killed, queued, etc...|
|CP Reason|21|The reason given by Crash Protection for the current action.|
|Thread ID|22|The name of the thread responsible for responding to this request.|
|Client IP Address|23|The IP address of the machine making the request.|
|Request Method|24|This will usually be "GET" or "POST"|
|Request URL|25|This is the requested URL. The format of this column will change depending on URL Format key which can be found on the Request Settings page.|
|Execution Time (ms)|26|The amount of milliseconds it took to complete the request. (For incomplete requests, this column will be 0.)|
|Used Memory (percentage)|27|The amount of memory (expressed as a percentage) which was used when this request started or finished.|
|Max Memory (KB)|28|The total amount of physical memory available to this instance.|
|Used Memory (KB)|29|The amount of memory which was used when this request started or finished.|
|Total Memory (KB)|30|The amount of memory which was allocated by the instance when this request started or finished.|
|Free Memory (KB)|31|The amount of free memory (within the allocated block) when this request started or finished.|
|Query String|32|If the URL has any parameters then they will appear here.|
|Return Status Code|33|This is a HTTP return code such as 200 (OK,) 404 (Not found,) or 500 (Internal Server Error.) For "Started:" rows this column will be 200.|
|CPU Time (ms)|34|This is the amount of actual CPU time which this request required. (For incomplete requests, this column will be 0.)|
|AMF Request|35|If AMF decoding is enabled (Request Settings page) and there is AMF to decode, then the method names will appear here.|
|JSESSIONID|36|The J2EE Session Id for this request.|
|CFID|37|The CF Id for this request.|
|CFTOKEN|38|The CFTOKEN for this request.|
|JDBC Query Count|41|The number of JDBC queries run by this request at the time of this log.|
|JDBC Total Time (ms)|42|The total amount of time spent running JDBC queries at the time of this log.|
|JDBC Total Execution Time (ms)|43|The total amount of time spent by the database running JDBC queries at the time of this log.|
|JDBC Total Rows|44|The total number of rows returned by JDBC queries at the time of this log.|
|Bytes Sent|45|The amount of data which was sent back to the client.|
|Time to First Byte (ms)|46|The number of milliseconds it took to deliver the first bit of data.|
|Time to Last Byte (ms)|47|The number of milliseconds it took to deliver the complete content.|
|Time to Stream Open (ms)|48|The number of milliseconds before the data stream was opened.|
|Time to Stream Close (ms)|49|The number of milliseconds until the completed data stream was closed.|

## Enterprise Dashboard Scripts

When FusionReactor fires a script, an appropriate message is written to
the [Crash Protection log](Crash-Protection-Log.md), located in 
../<instance_name>/log/<timestamp>/crashproteciton.log.
This log is shared with other CrashProtection messages, and not all
fields are used by Enterprise scripting.

|Field Name|Description|
|--- |--- |
|Date|Formatted date|
|Time|Formatted time, to millisecond precision|
|Time (Epoch)|Absolute time, measured in milliseconds from midnight on January 1st 1970|
|Server State| **ServerUP** or **ServerDOWN** - The triggering state for this script invocation|
|Script State<br>One of:|**RUNSCRIPT** - Script successfully called<br>**SCRIPTREADFAILED** - Script not found, or not readable<br>**SCRIPTEXCEPTION** - Script found and readable, but an exception occurred during run|
|6 Unused Fields||
|Server ID|Server ID of the affected instance, configured within Server Manager|
|Script|Full command and arguments launched by FusionReactor|
|Unused Fields|The remainder of the log string is unused.|

!!! error 
    For the exceptional cases **SCRIPTREADFAILED** and **SCRIPTEXCEPTION**,
    FusionReactor will log the message associated with the exception to the
    FusionReactor log.
