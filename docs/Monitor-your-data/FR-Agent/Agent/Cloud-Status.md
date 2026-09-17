# Cloud Status

The **Cloud Status** page (available for Cloud-licenses only) is
accessed via the Cloud menu in the upper notification area, and
selecting **Status**. The page shows you the current status of
FusionReactor's cloud connections.

![](/Monitor-your-data/FR-Agent/Agent/cloudstatusexample.png)

The page is split into a **Health Check** section and two subsections:
one for the **Control Channel** and one for the **Telemetry Shippers.**

### Logging

There is a log available which records changes of cloud state.  It's
described [here](/Data-insights/Features/Logs/Files/Cloud-State-Log/).

## Health Check

The **Health Check** gives you a larger version of the cloud icon in the
upper notification area, as well as some text to help you resolve any
problems which may occur.

There are two failures detected by this section. We'll specify them in
more detail later.  They are:

-   A failure of the Control Channel only - leading to a **Degraded**
    indication
-   One or more of the Telemetry Shippers are in retry mode - leading to
    a **Degraded **indication

When the Control Channel and all the Telemetry Shippers fail, the status of
the system changes from Degraded to **Failed**.

## Control Channel

The **Control Channel **is used to provided a two-way communications
channel between FusionReactor and OpsPilot.  It's used to
provide immediate, accurate information to the Cloud and is the basis
for real-time functionality like **Stack trace**, **Running
Requests **etc.

This channel is established between FusionReactor and OpsPilot when the instance starts.  FusionReactor tries to keep this
channel open as long as the instance is running, and will attempt to
reconnect it if it becomes unavailable.

### Displayed Data

Not all fields are always displayed.  See the **Appears** column for
when you can expect to see that item.

|Text|Appears|Description|
|--- |--- |--- |
|Status|Always|A short description about the state of the connection.|
|Endpoint|Always|A URL describing the server, protocol and port used by this instance to establish a connection to OpsPilot|
|Connected Since|Connected|A date/time string representing the instant at which the connection was established.|
|Disconnected Since|Disconnected|A date/time string representing the instant at which the connection was lost.|
|Attempting to Reconnect|Disconnected|Yes/No. Indicates whether the Control Channel system is attempting to reconnect. This should normally be Yes. Some types of forced disconnect may result in No, however. If this is the case, FusionReactor will attempt to reestablish the connection only on the next instance restart.|
|Last Exception|Always if an Exception has been caught|If the Control Channel system has encountered any exceptions during operation, the last one is displayed here, along with its causes (if any).|

### Troubleshooting

|Failure Mode|Presentation|Meaning and Resolution|
|--- |--- |--- |
|Network - DNS|An exception of the form "Can't resolve xx.yy"|The endpoint couldn't be resolved from a name into an IP address. <br><br>Ensure the instance is configured to use a DNS server that can resolve standard IP4 internet addresses.<br>Ensure the instance is connected to the network.|
|Network - Connection|An exception of the form "Couldn't connect to xx.yy" or "Timed out connecting to xx.yy"|The endpoint couldn't be contacted.<br><br>Ensure the instance is connected to the network.<br>Ensure the instance can connect through your firewall to the Control Channel. Information on required firewall punches and static routing (if required) can be found in technote [FRS-418] FusionReactor Cloud Firewall DNS and Static IP address rules.
OpsPilot may be experience network connectivity issues. In this case, the connection will be periodically retried by FusionReactor, and will reconnect up to a maximum of one minute after OpsPilot becomes available.|

## Telemetry Shippers

The **Telemetry Shippers** periodically collect useful information, such as metrics, logs and spans/traces (transactions),
gathered by the FusionReactor agent, packages them
into the appropriate form and sends them to the Cloud.  OpsPilot then ingests this data and makes it
available to you in various useful forms.

PrometheusRemoteWriteShipper is responsible for metrics, LogShipper for logs and SpanShipper for spans/traces (transactions).

The Telemetry Shippers are **reliable** in that any data requests that can't be
transferred are stored in a queue (one for each shipper).  These queues have a maximum size limit. If this limit is exceeded, 
earlier data requests are dropped to make room for newer ones.

When the connection returns, the Telemetry Shippers sends any queued requests.  During the period of outage, you
may see holes appearing in data within OpsPilot.  Once
these messages start flowing again, these void areas should close.  While this backfill
occurs, you may see a **Metric Lag Warning** on this page.

The connections used by the Telemetry Shippers are **not** **permanent** but are
established every time a data request is ready to be sent, and are only alive for as long as it takes to
transport the data. Only
when the first transmission is attempted can the status of a
connection be definitively known.

### Displayed Data

Not all fields are always displayed.  See the **Appears** column for
when you can expect to see that item.

| Text                              | Appears                                               | Description                                                                                                     |
|-----------------------------------|-------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------|
| Enabled                           | Always                                                | Whether the shipper is enabled or not. Information is collected and shipped to cloud when enabled.              |
| Endpoint                          | Always                                                | The URL endpoint - where the data is sent to.                                                                   |
| Compression                       | Always                                                | The compression used for the request.                                                                           |
| Collect Rate (ms)                 | Always if the shipper has a collect task              | How often information is collected in milliseconds. A value of 5000 means data is sent every 5 seconds.         |
| Ship Rate (ms)                    | Always                                                | How often information is sent to the cloud in milliseconds. A value of 5000 means data is sent every 5 seconds. |
| Queued Requests                   | Always                                                | How many data requests are queued to be sent to the cloud.                                                      |
| Is Retrying Failed Request        | Always                                                | If the shipper is attempting to send a previously failed request.                                               |
| Last Request Succeeded            | Always once a data request has been attempted         | Whether the last requests was successful or not.                                                                |
| Last Request Completed At         | Always once a data request has been attempted         | Timestamp of when the last request was sent.                                                                    |
| Last Compressed Body Size (bytes) | Always once data has been collected into a request    | The size (in bytes) of the last data packet compressed.                                                         |
| Last Request Response Code        | If the last request received a response.              | The status code received in response to the last sent request.                                                  |
| Last Request Error Message        | If the last request caused an exception to be caught. | Message related to the exception caught. Read logs if more information is needed.                               |


### Troubleshooting

The failure modes for this transport are similar to the Control Channel
above.
Again, <a href="http://www.fusion-reactor.com/support/kb/frs-418/" class="external-link">FRS-418</a>
may be helpful if your firewall is not allowing outbound connections
from FusionReactor.  

## Support Functions

There are two support functions available at the top of the page. 
**Automatic Refresh** can be set using the dropdown at the top right,
and **Copy to Clipboard** will copy all displayed information into the
clipboard, in a format our support team can use to help you diagnose
issues.  
