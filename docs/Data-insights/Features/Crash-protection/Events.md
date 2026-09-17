
# Crash Protection Events

**Request &gt; Crash Protection Events **shows summary of all requests
that were triggered by the various survival strategies available
in [Protection](/Data-insights/Features/Crash-protection/Crash-Protection/).

Below you can see a image of the Request Quantity Protection. Selected
and showing is :

-   Request Quantity Protection - Rejections

![](/Data-insights/Features/Crash-protection/images/245550088.png)

##Rejections Overview

There are various types of rejection methods, of which graphs are
supported for the following strategies:

|Crash Protection Method|Description|Queue Timeouts|Rejections|Aborts|Notify|
|--- |--- |--- |--- |--- |--- |
|Memory Protection|Triggers when the Memory Threshold is surpassed for a period of time.|/|/||/|
|Request Quantity Protection|Triggers when the already active amount of requests is at the Quantity Threshold.|/|/||/|
|Request Timeout Protection|Triggers when a request takes longer than the Runtime Protection Threshold.|||/|/|

The survival strategies above are defined as the following:

|Trigger Name|Description|
|--- |--- |
|Rejection|The request is rejected prior to starting.|
|Abort|The request is aborted during processing.|
|Queue Time-out|The request is stored until the protection trigger has recovered or until they time-out and are Aborted.|
|Notify|An email notification is sent to the configured recipients.|

## Sorting Rejections

You can change the order in which transaction are displayed on this page
by clicking on any of the column titles. Clicking on a title for a
second time will reverse the order on that column.

There are filters present at the top of the page to modify the requests
shown. These filters are as follows:

|Name|Description|Default|
|--- |--- |--- |
|Apps|The application you wish to view|All Apps|
|Rejection|The type of rejection you wish to view|Request Quantity Protection - Rejections|


## Graphs

For each of the protection types, there will be two graphs at the top of
the page:

### Average Execution Time Graph

This graphs show the average time that it took the requests that were
triggered by the chosen strategy to execute.

![](/Data-insights/Features/Crash-protection/images/245550082.png)

### Activity Graph

This graph shows how much the selected protection type was triggered per
minute.

![](/Data-insights/Features/Crash-protection/images/245550071.png)

##Rejections Table

Below the graphs is a list of the
requests that triggered the selected protection type. This list has the
following columns:  

|Name|Description|
|--- |--- |
|Finished|The time and date at which the request was completed.|
|Status / Type|The final HTTP return code of the request and the type of Protection that it triggered.|
|App / Txn|The application for which the request was for and the transaction location.|
|ID / Thread|The request ID and the name of the thread which is servicing the request.|
|Description|The URL path of the rejection.|
|Time ( ms )|The time that the transaction took to complete. If available then you will also see the amount of actual CPU time that this transaction used below it ( In gray )|

## Managing Requests

Each request listed on this page has two icons next to it. They are:

| Button | Name | Description |
|--- |--- |--- |
| :fa-book: |Details|Clicking this button will redirect you to the Details page for the selected JDBC transaction|
| :fa-ban: |Add to CP|Clicking this button will redirect you to the Protection Restrictions page which will be filled out for this request.|
