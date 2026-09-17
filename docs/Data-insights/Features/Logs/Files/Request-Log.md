# Request Log



The **Request Log** (`request.log`) consists of simple space-separated files that can be easily imported into FusionAnalytics, databases, or spreadsheet applications. You can adjust the amount of data displayed on the Request Log screen by modifying the **View Size** on the [Request Settings](../../Requests/Settings.md) page. For information on where the logs are stored, see [Log Settings](../Settings.md).



The log file is formatted as follows:

|Field|Number|Description|
|--- |-- |--- |
|Date (Formatted)|1|The date on which this log entry was written.|
|Time (Formatted)|2|The date on which this log entry was written.|
|Date/Time (ms)|3|This is the millisecond time at which this request was started or finished (depending upon the Request Status.)|
|Version|4|Version number of this log entry.|
|Server Startup Time (ms)|5|Startup time of the application server in milliseconds (ms) since epoch.|
|Request ID|6|The FusionReactor Request ID.|
|Request Status|7|The current state of the request. This will tell you if a request has started, finished, was killed, queued, etc...|
|CP Reason|8|The reason given by Crash Protection for the current action.|
|Thread ID|9|The name of the thread responsible for responding to this request.|
|Client IP Address|10|The IP address of the machine making the request.|
|Request Method|11|This will usually be "GET" or "POST"|
|Request URL|12|This is the requested URL. The format of this column will change depending on URL Format key which can be found on the Request Settings page.|
|Execution Time (ms)|13|The amount of milliseconds it took to complete the request. (For incomplete requests, this column will be 0.)|
|Used Memory (percentage)|14|The amount of memory (expressed as a percentage) which was used when this request started or finished.|
|Max Memory (KB)|15|The total amount of physical memory available to this instance.|
|Used Memory (KB)|16|The amount of memory which was used when this request started or finished.|
|Total Memory (KB)|17|The amount of memory which was allocated by the instance when this request started or finished.|
|Free Memory (KB)|18|The amount of free memory (within the allocated block) when this request started or finished.|
|Query String|19|If the URL has any parameters then they will appear here.|
|Return Status Code|20|This is a HTTP return code such as 200 (OK,) 404 (Not found,) or 500 (Internal Server Error.) For "Started:" rows this column will be 200.|
|CPU Time (ms)|21|This is the amount of actual CPU time which this request required. (For incomplete requests, this column will be 0.)|
|AMF Request|22|If AMF decoding is enabled (Request Settings) and there is AMF to decode, then the method names will appear here.|
|JSESSIONID|23|The J2EE Session Id for this request.|
|CFID|24|The CF Id for this request.|
|CFTOKEN|25|The CFTOKEN for this request.|
|JDBC Query Count|26|The number of JDBC queries run by this request at the time of this log.|
|JDBC Total Time (ms)|27|The total amount of time spent running JDBC queries at the time of this log.|
|JDBC Total DB Time (ms)|28|The total amount of time spent by the database running JDBC queries at the time of this log.|
|JDBC Total Rows|29|The total number of rows returned by JDBC queries at the time of this log.|
|Bytes Sent|30 (AD)|The amount of data which was sent back to the client.|
|Time to First Byte (ms)|31|The number of milliseconds it took to deliver the first bit of data.|
|Time to Last Byte (ms)|32|The number of milliseconds it took to deliver the complete content.|
|Time to Stream Open (ms)|33|The number of milliseconds before the data stream was opened.|
|Time to Stream Close (ms)|34|The number of milliseconds until the completed data stream was closed.|
|User Agent String (Optional)|35|A string representing the User Agent from which the request originated. (This option is disabled by default and has to be enabled in the Request Settings)|
|Trace ID|36|The request's trace ID for use in distributed tracing.|
|DB Time (ms)|37|The total time a web request spent in Database (JDBC Request, MongoDB, Redis, Elastic, Cassandra)|
|API Time (ms)|38|The total time a web request spent calling APIs (CFHTTP Tag, HttpClient, OKHttp, Micronaut, Vertx)|
