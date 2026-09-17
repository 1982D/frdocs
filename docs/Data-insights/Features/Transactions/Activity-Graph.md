# Activity Graph

**Transactions &gt; Activity Graph** is a graph of all transaction
activities currently stored by FusionReactor. 

In the top right of the page next to the **Set Home Page** you can switch graphs quickly by
clicking the **JDBCRequest** button to be switched to the WebRequest
**Transactions &gt; Activity Graph** is a graph of all transaction
activities currently stored by FusionReactor. 

In the top right of the page next to the **Set Home Page** you can switch graphs quickly by
clicking the **JDBCRequest** button to be switched to the WebRequest
graph, this works both ways. In addition you are able to switch to the
**Transactions Time** graph by clicking **Time**.

Below is a sample image of the **JDBC Activity Graph** with the tool-tip
showing.

![](/attachments/245550747/245550763.png)

## JDBCRequest Activity graph

Several time spans are available, with differing resolutions. These will
be filled as data points that are collected by FusionReactor.

Each time varying graphs shows two independent values overlaid: 

<span style="color: rgb(0,128,0);">**JDBCRequest - Activity (Requests/sec) : Green**</span>
    -   This is the number of JDBC transactions completed per second
        since the previous sample on the graph in green, and the number
        of transactions running at the time that the sample is taken. <br>
<br>
<span style="color: rgb(51,153,102);">**JDBCRequest - \#Active
    Requests (Count) : Light Green**</span>
    -    This graph gives you insight into the JDBC Transaction
        activity; if the number of active transactions stays high and
        constant then your database is under load.

Deselect and reselect each independent values by simply
clicking on their respective names. When a value is deselected (Greyed
out) is no longer displayed on the activity graph.

Placing your mouse pointer on a data point within the graph shows a
tool-tip with details about that sample, including:

-   Date and time of the request
-   Activity (Requests / sec)
-   Active Requests (Count) 

When browsing the 1 Hour, 1 Day, and 1 Week activity graphs you can
select time frames by using the slider under the graph to pinpoint
specific days, times and spikes in your JDBC Requests. 

## WebRequest Activity graph

Several time spans are available, with differing resolutions. These will
be filled as data points that are collected by FusionReactor.

Each time varying graphs shows two independent values overlaid: 

<span style="color: rgb(0,128,0);">**WebRequest - Activity (Requests/sec) : Green**</span>
    -   This is the number of web requests transactions completed per
        second since the previous sample on the graph in green, and the
        number of transactions running at the time that the sample is
        taken.<br>
<br>
-<span style="color: rgb(51,153,102);">**WebRequest - \#Active
    Requests (Count) : Light Green**</span>
    -    This graph gives you insight into the server request activity;
        if the number of active transactions stays high and constant
        then your database is under load.

Deselect and reselect each independent values by simply
clicking on their respective names. When a value is deselected (Greyed
out) then that value will no longer be displayed on the activity graph.

Placing your mouse pointer on a data point within the graph will show a
tool-tip with details about that sample, including:

-   Date and time of the request
-   Activity (requests / sec)
-   Active Requests (count) 

When browsing the 1 Hour, 1 Day, and 1 Week activity graphs you can
select time frames by using the slider under the graph to pinpoint
specific days, times and spikes in your Web Requests. 

___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.
