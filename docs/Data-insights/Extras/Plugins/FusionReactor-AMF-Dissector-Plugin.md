title: AMF Dissector
# AMF Dissector Plugin

The Action Message Format (AMF) Dissector provides a means to see the
AMF messages being sent to and from the server from within
FusionReactor’s Request Detail page. AMF is a binary format used to
serialize ActionScript objects. It is used primarily to exchange data
between an Adobe Flash application and a remote service, usually over
the internet. The AMF tab can be found under the [Request Details Page](/Data-insights/Features/Requests/Request-Details/).

FusionReactor makes it easy by decoding your streaming AMF connections
to help you debug your applications.

![](/attachments/245547840/245547850.png)

**Figure 1: Decoded AMF details.**

## Configuration


The AMF Dissector Plugin | Configuration (accessible from the [Active
Plugins](Overview.md#active-plugins) page) allows you to alter the
following:

|Field Name|Description|
|--- |--- |
|Dissector Mode|This allows you to record either Input AMF, Output AMF, Both or None. Decoded AMF data can be viewed by going on Request History and clicking the detail button (  ) and then clicking on the tab that is named "AMF" (as seen in Figure 1).|
|Buffer Size (bytes)|This is the buffer size you can allocate to each message. It is advisable that you select a reasonable size otherwise data may get rejected by the dissector.|
|Number of Messages|This is the number of messages in an AMF stream that can be stored per transaction.|
|Streaming Message Store Mode|**Store First Messages** - When the buffer is full the most recent messages will be discarded.<br>**Store Latest Messages** - When the buffer is full the older messages will be discarded.|
|Message Display Ordering|This allows you too choose the order that messages are displayed, choosing Newest First means that the most recent messages are displayed first. Choosing Oldest First means that the oldest messages will be displayed first.|


## Log File

No log files about captured data are generated from this plugin.

## Status Log - plugin-fr-amf-decorator-plugin.log

This plugin creates a log file called
**plugin-fr-amf-decorator-plugin.log** which contains information on the
status of the plugin, when it started, stopped, if there were any
problems. Below is a table explaining what all the attributes in the log
file mean.

|Field Name|Number|Description|
|--- |--- |--- |
|Date (Formatted)|1|The date on which this log entry was written.|
|Time (Formatted)|2|The time on which this log entry was written.|
|Level|3|Log Level basically means the nature of the log, for example INFO means general information, where as ERROR means an error is being logged. SEVERE means something really bad has happened, this will be typically followed by the a generated exception.|
|Log message|4|Contains a message of an event that occurred such as that logging has started.|
