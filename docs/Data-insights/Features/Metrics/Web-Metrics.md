

# Web Metrics

The **Web Metrics** page presents data recorded by FusionReactor related to your application server and its request load, organized into easy-to-analyze graphs and tables.

## Graphs

By default, this page displays six graphs:

| Graph                   | Description                                                                                                                          |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| **WebRequest Activity** | Shows the number of completed and active requests at a given time. Errors are also tracked.                                          |
| **WebRequest Time**     | Displays the average time of all completed and active requests. Also tracks the runtime of requests that ended in error.             |
| **JDBC Activity**       | Shows the number of completed and active JDBC requests at a given time. Errors are also tracked.                                     |
| **JDBC Time**           | Displays the average time of all completed and active JDBC requests. Also tracks the runtime of JDBC statements that ended in error. |
| **Memory (MB)**         | Reports memory usage of your server, showing **Max Memory**, **Allocated Memory**, and **Used Memory**.                              |
| **CPU (%)**             | Tracks CPU load for both your **server** and your **application server instance**.                                                   |



![](/attachments/245549190/245549269.png)

### Customizing graphs

The Web Metrics graphs can be customized in several ways to better fit your monitoring needs.

![](/attachments/245549190/245549208.png)

- **Change time range**: Use the time controls at the bottom-right of each graph to adjust the range of data displayed.
    

- **Open graph settings**: Click the ![](/attachments/245549289/245549295.png) icon next to a graph to open a customization modal (pop-up form).

This modal allows you to change titles, colors, and data series for the selected graph.

![](/attachments/245549289/245549301.png)


### Title

| Field                    | Description                                                            |
| ------------------------ | ---------------------------------------------------------------------- |
| **Graph Name**           | The title of the graph, shown under the graph on the Web Metrics page. |
| **Reset Graph Defaults** | Resets the graph to its original configuration.                        |


### Series X

| Field             | Description                                                                                                                                                                                                                                     |
| ----------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Select Series** | Choose which data series to display. If the series has not yet been detected, an ID path will appear instead of a friendly title (e.g., `/transit/txntracker/JDBCRequest/history/activity` instead of *JDBCRequest  -  Activity (Requests/sec)*). |
| **Fill Color**    | Sets the fill color of the series in the graph.                                                                                                                                                                                                 |
| **Line Color**    | Sets the line color of the series in the graph.                                                                                                                                                                                                 |



### Add series

Click **Add Series** at the bottom of the modal to add another data series. This duplicates the last series in the list, which you can then adjust.

!!! tip
    There is no limit to how many series can be added to a graph.

!!! info
    Adding many series may reduce page performance.

### Remove series

Click **Remove Series** on the series you want to delete.

!!! note
    The first series cannot be removed.


### Enlarging graphs

Click a graph’s title (below the graph) to open an enlarged view of that graph on a separate page.

![](/attachments/245549190/245549214.png)


## Tables

### Overview Table

The **Overview** table provides general statistics about the application server.

![](/attachments/245549190/245549236.png)

| Field                                        | Description                                                                              |
| -------------------------------------------- | ---------------------------------------------------------------------------------------- |
| **Server Started**                           | The time when the application server was started.                                        |
| **Server Up-Time**                           | The duration that the application server has been running.                               |
| **Current Web-Request Count**                | The number of active requests at the current moment.                                     |
| **Queued Request Count (Due to Protection)** | The number of requests currently waiting in the queue for processing (see *Protection*). |
| **Total Web Request Count**                  | The total number of web requests handled by the application server.                      |
| **Average Request Time (ms)**                | The average processing time for web requests.                                            |
| **Used Memory (KB)**                         | The amount of memory currently in use.                                                   |
| **Allocated Memory (KB)**                    | The amount of memory allocated to the application server.                                |
| **Maximum Memory (KB)**                      | The maximum memory available to the application server.                                  |
| **Free Memory (KB)**                         | The memory currently available for use.                                                  |
| **Total JDBC Queries**                       | The total number of JDBC queries executed.                                               |
| **Average JDBC Time (ms)**                   | The average processing time for JDBC queries.                                            |



### Counts Table

The **Counts** table provides a snapshot of **Web Requests** and **JDBC Requests** handled by the application server in the last 60 seconds.

![](/attachments/245549190/245549281.png)

| Field                                      | Description                                                                               |
| ------------------------------------------ | ----------------------------------------------------------------------------------------- |
| **WebRequest  -  Errors**                    | Number of Web Requests with errors in the last 60 seconds.                                |
| **WebRequest  -  Slow Requests**             | Number of Web Requests that exceeded the slow request threshold in the last 60 seconds.   |
| **WebRequest  -  Average Request Duration**  | Average processing time of Web Requests in the last 60 seconds.                           |
| **WebRequest  -  Total Requests**            | Total number of Web Requests processed by the application server in the last 60 seconds.  |
| **JDBCRequest  -  Errors**                   | Number of JDBC Requests with errors in the last 60 seconds.                               |
| **JDBCRequest  -  Slow Requests**            | Number of JDBC Requests that exceeded the slow request threshold in the last 60 seconds.  |
| **JDBCRequest  -  Average Request Duration** | Average processing time of JDBC Requests in the last 60 seconds.                          |
| **JDBCRequest  -  Total Requests**           | Total number of JDBC Requests processed by the application server in the last 60 seconds. |



### Recent Table

The **Recent** table lists detailed information about individual **Web Requests** and **JDBC Requests** that occurred within the last minute.




![](/attachments/245549190/245549253.png)


The following values are displayed in this table:

| Field                                                     | Description                                                                                                                                      |
| --------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| **WebRequest  -  Recent Slow Pages (within 60s)**           | Lists any Web Requests in the last 60 seconds that exceeded the threshold defined in **Transactions → Settings** and were classified as *slow*.  |
| **WebRequest  -  Recent Performance Average (within 60s)**  | The average duration of *slow* Web Requests in the last 60 seconds.                                                                              |
| **JDBCRequest  -  Recent Slow Pages (within 60s)**          | Lists any JDBC Requests in the last 60 seconds that exceeded the threshold defined in **Transactions → Settings** and were classified as *slow*. |
| **JDBCRequest  -  Recent Performance Average (within 60s)** | The average duration of *slow* JDBC Requests in the last 60 seconds.                                                                             |



### Protection Table

The **Protection** table displays statistics from [Crash Protection](/Data-insights/Features/Crash-protection/Crash-Protection/), showing which protection type caused a request to be aborted or queued.

![](/attachments/245549190/245549275.png)

Each value includes both the **last 60 seconds** count and the **total since the application server started**.

| Field                                            | Description                                                                                                                         |
| ------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------- |
| **Memory Protection  -  Page Aborts**              | Number of requests aborted because the JVM heap exceeded the configured threshold for the configured duration.                      |
| **Memory Protection  -  Queue Timeouts**           | Number of requests queued because the JVM heap exceeded the configured threshold for the configured duration.                       |
| **Request Quantity Protection  -  Page Aborts**    | Number of requests aborted because the number of running requests exceeded the configured limit.                                    |
| **Request Quantity Protection  -  Queue Timeouts** | Number of requests queued because the number of running requests exceeded the configured limit.                                     |
| **Request Timeout Protection  -  Page Aborts**     | Number of requests aborted because they exceeded the configured maximum execution time. Values are shown as **(last 60s / total)**. |



### Return Code Table

The **Return Code** table lists all HTTP return codes returned by the application server. Each code is a clickable link that displays all requests from the current request history with that specific return code.



![](/attachments/245549190/245549242.png)

## Garbage collection

Garbage collection in Java is not always instantaneous, as it depends on how the Java Garbage Collector operates.

![](/attachments/245549190/245549220.png)

A **Garbage Collection** button is available at the bottom-right of the graphs on this page. Clicking this button will trigger a manual garbage collection and display a toast notification showing how much memory was reclaimed.

Garbage collection works by freeing memory previously occupied by objects that are no longer in use by the program. This helps increase the amount of available memory and improve overall resource efficiency.

___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist. 