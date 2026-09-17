# Settings

**Request &gt; Settings** allows you to modify various elements and behaviours relating to Requests. The page is broken up into sections,
each containing a table explaining the options that can be chosen in drop down boxes or input into text fields.

## Request Formatting

| Configuration                |Description|Default|
|------------------------------|-- |--- |
| **URL Format**                   |This option changes how URLs are displayed throughout FusionReactor. **Full** includes the hostname, while **Short** just shows the path. Select **Full** if you're dealing with servers which host multiple websites.|Full|
| **Enable Obfuscation**           |This setting will enable Data Obfuscation, which will obfuscate POST parameters. These are the ONLY headers we currently obfuscate. More specifically, if the **Enable Obfuscation** field is set to **Obfuscate Transaction Data**, then the **Request Parameters** field will contain data with a question mark (?). <br> The **Request Parameters** field can be found in the **Transaction Details** > **Headers** > **Request Parameters**.<br><br>Example<br>*Enable Obfuscation* = *Display Transaction Data*<br>![](/attachments/245550276/245550284.jpg)<br>*Enable Obfuscation* = *Obfuscate Transaction Data*<br>![](/attachments/245550276/245550289.jpg)<br>Keep in mind that the Request obfuscation can be enabled or disabled at any point and it will be instantly be reflected on the stored, current, and any newly created  Requests.|Display Transaction Data|
| **Header Names in Summary View** |This setting will display the specified header values within the transaction summary view, under the request URL. This will allow you to gain insight without viewing the transaction details if you use headers for request routing or user information.| NULL |

## Request Logging

|Configuration|Description|Default|
|--- |--- |--- |
|**Request Logging**|If Request Logging is enabled then requests will be written to the request.log as they arrive and complete.|Enabled|
|**View Size (KB)**|This value indicates how much of the log file should be displayed when you view the Request Log from inside FusionReactor.|128KB|
|**Log User-Agent**|When enabled, log messages will contain the user-agent header.|Disabled|
|**File Size**|If the Logging Engine is set to **Centralized Archive and Rotation** then this field does not appear. However, if the Logging Engine is set to **Traditional Per-Log Rotation** then this value dictates then maximum size of the log before it is rotated.|10240KB|
|**File Count**|As above, this value dictates the number of files held in the log history. An incoming log causes the oldest log to be deleted.|5|

## Request Content Capture

| Configuration            | Description                                                                                                               |Default|
|--------------------------|---------------------------------------------------------------------------------------------------------------------------|-- |
| **Request Capture**      | Activating this option tells FusionReactor to store the complete Request and Response objects to disk for later analysis. |Disabled, Requests Only, Requests and Responses, or Responses Only.|
| **Request Capture Type** | Choose which parts of the request/response to capture.                                                                      |Body Only, Headers Only, or Headers and Body.|
| **Capture Path**         | The location where captured requests and responses are stored.                                                            |fusionReactor\<INSTANCE_NAME>\serializer|

!!!WARNING
    Turning on **Request Content Capture** creates multiple .XML files for every request run on a server.
    This may use very large quantities of disk space very quickly. Please be careful
    when enabling this feature and don't leave it enabled if you are not monitoring it closely

## Request History

|Configuration|Description|Default|
|--- |--- |--- |
|**History Size**|This value defines how many requests FusionReactor stores in memory. Once the Request History reaches this value, old requests will be removed when new ones arrive.|100|
|**Slow Request History Size**|This value defines how many requests will be shown on the **Longest Requests** and **Slow Requests** pages.|100|
|**Slow Request Threshold***|This value defines the threshold for the **Slow** Requests page. Once a request has run for longer than specified here, it's considered to be a slow running request.|8 Seconds|
|**Sub Storage Strategy**|This will determine how the sub transactions are stored on their parent. The **Storage Strategies** are defined as follows:<br>**First X**: Store the first X transactions that come in. Where X is the value of **Sub Transaction Limit**<br>**Slower Than X**: Store only those transactions that exceed X. Where X is the 'Slow Request Threshold'<br>**Slowest X**: Store the slowest X transactions. Where X is the value of **Sub Transaction Limit**<br>**Summary Only**: Store only a summary of the transactions. The duration and any aggregates will be stored, but no sub transactions<br><br>*What's a Subtransaction?*<br>A subtransaction is a transaction that occurs within a transaction.  A great example of this is JDBC data access, which usually occurs within the context of a Web Request.<br>In this case, we call the Web Request the parent and the JDBC statement the subtransaction.  The Web Request in this example is actually the top of the transaction tree, so it's also the master transaction.<br>Subtransactions can be viewed by clicking on the cascading arrow next to the transaction ID of their parent transaction.|Slowest X|
|**Per Type Sub Transaction Limit**|This is the maximum number of a single type of transaction that can be stored on each parent transaction.|30|
|**Sub Transaction Limit**|This value defines the total number of sub transactions that can be stored on each parent transaction.|100|


## Transaction History

|Configuration|Description|Default|
|--- |--- |--- |
|**History Size**|This value defines how many transactions FusionReactor stores in memory. Once the Transaction History reaches this value, old transactions will be removed when new ones arrive.|100|
|**Slow Transaction History Size**|This value defines how many transactions will be shown on the **Longest Transactions** and **Slow Transactions** pages.|100|
|**Slow Transaction Threshold**|This value defines the threshold for the **Slow Transactions** page. Once a transaction has run for longer than specified here, it's considered to be a slow running transaction. Any transaction over 8 seconds is considered slow|8 Seconds|

!!!warning
    Be careful when adjusting this value as causes an increase in the amount of memory utilized by FusionReactor.

## Proxy

|Configuration|Description|Default|
|--- |--- |--- |
|**Proxy Header**|Name of the HTTP header field for identifying the originating IP address of a client connecting to a web server through an HTTP proxy or load balancer. This field should only be set if you use a HTTP Proxy or load balancer that correctly sets the header to the originating IP address.<br><br>e.g.<br>*True-Client-Ip*<br>*X-Forwarded-For*|Disabled|


## Stream Metrics

|Configuration|Description|Default|
|--- |--- |--- |
|**Stream Metrics**|Specifies whether FusionReactor should track statistics about how long it took to get a response back to the client. (Time to first byte, time to completion, bytes per second, etc.).|Enabled|


## X-Frame-Options

|Configuration|Description|Default|
|--- |--- |--- |
|**For hosted websites & apps**|Specifies whether the **X-Frame-Options** should be added to any of the response headers for content hosted on the server. You may enter one of the following X-Frame types: **DENY**, **SAMEORIGIN** or **ALLOW-FROM https://www.example.com**. <br> Please note that some web browsers ignore **X-Frame-Options**. With a configuration value of Disabled, the header is not added to the response headers.|Disabled|
|**For FusionReactor's UI**|Specifies whether the **X-Frame-Options** should be added to any of the response headers for FusionReactor's User Interface. You may enter one of the following X-Frame types: **DENY**, **SAMEORIGIN** or **ALLOW-FROM https://www.example.com**. <br>Please note that some web browsers ignore **X-Frame-Options**. With a configuration value of Disabled, the header is not added to the response headers.|Disabled|

## Json Data

|Configuration|Description|Default|
|--- |--- |--- |
|**Enable Json Data Capture**|Specifies whether FusionReactor should capture request and response bodies sent with a ```Content-Type``` header of ```application/json``` or ```application/smile```. This feature is enabled for WebRequest and HTTPClient transactions.|Enabled|
|**Json Data Truncation Limit**|Specifies the max number of bytes to be captured in a Json Data context per request (as input data) and response (as output data). This limit is bytes per request and per response.|1024|
|**Enable Smile Decoding**|Specifies whether Smile-encoded JSON will be decoded before being stored on a transaction.|Enabled|
|**Smile Decoding Limit**|Specifies the maximum number of bytes at which Smile decoding will take place. If the Smile-encoded bytes exceed this limit, none of the Smile body is decoded before being stored on the transaction.|2048|

___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.
