# JDBC Log

The **JDBC Log** (which are a set of rotating files which you can configure
from the [JDBC Settings](../../JDBC/Settings.md) page) are simple
space separated files, so they can be easily imported into database or
spreadsheet applications. The log is called **jdbc.log**, the bottom
part of the page tells you where you can locate this file on your hard
drive.

The log file is formatted as follows:

|Field Name|Number|Description|
|--- |--- |--- |
|Date (Formatted)|1|The date on which this log entry was written.|
|Time (Formatted)|2|The time on which this log entry was written.|
|Date/Time (Milliseconds)|3|This is the millisecond time at which this request was started or finished (depending upon the Request Status.)|
|Version|4|Version number of this log entry.|
|Server Startup Time (ms)|5|Startup time of the application server in milliseconds (ms) since epoch.|
|Request ID|6|The FusionReactor Request ID.|
|Thread ID|7|The name of the thread responsible for responding to this request.|
|Client IP Address|8|The IP address of the person making the request.|
|Request Method|9|Specifies the HTTP method used during the request. This will usually be "GET" or "POST"|
|Request URL|10|This is the requested URL. The format of this column will change depending on URL Format setting which can be found on the Request Settings page.|
|Log Type|11|One of: "METRIC", "NOTIFICATION" or "REMINDER"|
|DB Start Time|12|The time (in milliseconds) at which the JDBC query began.|
|DB End Time|13|The time (in milliseconds) at which the DB finished with the query.|
|Total End Time|14|The time (in milliseconds) at which the query was completely finished (after results were transferred back etc.).|
|DB Time|15|The amount of time (in milliseconds) this JDBC query spent in the DB.|
|Total Time|16|The total amount of time (in milliseconds) it took to complete this query.|
|Row Count|17|The number of rows returned by this query.|
|Prepared Statement|18|This is a simple TRUE/FALSE value to tell you if this statement had already been prepared prior to its execution.|
|Row Limited|19|This is a simple TRUE/FALSE value to tell you if this query was row limited.|
|DataSource|20|If you have assigned a name to your data source wrapper then it will appear here. To find out how to name your data sources, please refer to page 14 of the JDBC Monitoring.|
|Statement|21|The actual statement which was run.|
|Stack Trace|22|This is the stack trace which was stored when the query was run. You can turn on or off this feature from the JDBC Settings page and alter the stack trace information from the Stack Trace Filter page.|
|Query String|23|This is the query string from the request running the JDBC statement.|
|Message|23|For Notifications and Reminders, this will contain the notification or reminder message.|


!!! note
    Depending on the type of log message, not all columns will have values.
