# Request Details

You can get to the **Request Detail** page from any page which lists requests and
pages linked from [Request Metrics](/Data-insights/Features/Metrics/Web-Metrics/).

Clicking the **Request Details** button by a request or clicking on the URL field takes you to a page containing detailed information about that request.

![](/attachments/245550303/245550364.jpg)

## Tab Selection

At the top of the **Request Details** page is a copy of the request line from the page you came from. Underneath are at least 5 tabs, plus 1 for each context on that transaction. 

The available tabs are as follows:

|Name|Applicable Request Types|
|--- |--- |
|**Main**|All types.|
|**Headers**|Web Request, HTTPClient|
|**Trace**|JDBC, MongoDB|
|**Cookies**|Web Request, HTTPClient|
|**JDBC**|Web Request, JDBC|
|**Properties**|Web Request, MongoDB, FRAPI, HTTPClient|
|**Relations**|All types.|
|**Profiler**|All types.|
|**Error**|All types.|
|**Query Plan**|JDBC|
|**AMF**|Web Request|
|**Traces**|Web Request, FRAPI|
|**Aggregates**|JDBC|
|**Json Data**|Web Request, HTTPClient|
|**Logging**|Web Request|
|**Event Snapshot**|Web Request|


## Main

The Main tab shows general information about a request such as script name, execution time, memory levels and flags.

![](/attachments/245550303/245550346.png)

### Headers

The Headers tab shows the HTTP headers for the request and response objects.

![](/attachments/245550303/245550340.png)

### Cookies

The Cookies tab takes the Cookie string from the Headers tab and renders it in a more readable format along with other cookie information such as
maximum age and whether is it secure.

![](/attachments/245550303/245550352.png)

## JDBC

The JDBC tab will show any queries which have been run by your page.This information is controlled by the storage strategy and other settings found on the [JDBC Settings](Settings.md) page.

![](/attachments/245550303/245550382.png)

## Properties

This is a visualization of the properties that are held on the request.ie description, collection, table.

![](/attachments/245550303/245550398.png)

## Relations

Parent and Children requests for the transaction. This tab will only appear if the selected request has a parent or child transaction.

![](/attachments/245550303/245550358.jpg)

![](/attachments/245550303/245550404.png)

## Profiler

FusionReactor Ultimate, Developer and Trial Edition includes an integrated low-overhead [Java Profiler](../Profiler/Profiler.md)  -  which is the
perfect tool for identifying poorly performing code in your production environment.  The profiler shows the percentage and actual time spent within each method call.   When the Profiler is enabled, requests and transactions will be automatically profiled and stored so you can analyze them at your leisure.  

You can profile any requests or transactions which are running on the JVM  -  e.g. Tomcat, JBoss, WildFly, Glassfish, Jetty etc. CFML applications can also be profiled.    

!!! tip
    Click on individual classes or methods, to perform [instant de-compilation](/UI/Overview)  


![](/attachments/245550303/245550322.jpg)

## Error Details

If an error is  detected, then details of this will be displayed in the **Error Details** tab.   This will include the error exception details, as well as a stack trace of where the error happened.

!!! tip
    Click on individual classes or methods, to perform [instant de-compilation](/UI/Overview)  

![](/attachments/245550303/245550316.jpg)

If running in a pure Java environment, scroll down the page to the **Caused By** area to display the stacktrace at the point that the error occurred.

![](/attachments/245550303/245550376.jpg)

## Trace

The trace tab shows a stack trace of the request. Trace can be enabled in [JDBC Settings](Settings.md).

![](/attachments/245550303/245550420.png)

## Query Plan

The query plan tab shows the result of an explain function running on the query.

!!! note
    Not all JDBC-compliant databases support the retrieval of query plans. Examples of those that do are Microsoft SQL Server, MySQL, MariaDB,Oracle and PostgreSQL.

The following SQL statements are used depending on the database type: 

-   **MariaDB and MySQL** 
    -   using 'EXPLAIN EXTENDED'
-   **PostgreSQL** 
    -   using 'EXPLAIN ANALYZE VERBOSE'
-   **Oracle** 
    -   using 'EXPLAIN PLAN' and DBMS\_XPLAN.DISPLAY
-   **MS SQL Server**
    -   using 'SET SHOWPLAN\_TEXT ON/OFF'

Query Plan can be enabled in [JDBC Settings](Settings.md).

![](/attachments/245550303/245550370.png)

## AMF

The AMF tabs displays detailed information about any AMF data that has been used as a part of this request. This data is contributed by the
FusionReactor **AMF Dissector**.  AMF is typically used for data transfer in Flash Remoting and in Flex-based Rich Internet Applications, as well as those using Flash Remoting.

!!! info "Learn more"
    [AMF Dissector Plugin](/Data-insights/Extras/Plugins/FusionReactor-AMF-Dissector-Plugin/)

![](/attachments/245550303/245550436.png)

The AMF Dissector contributes a tree of information to this tab which visualizes the request and (optionally) the response message flow of the
application.

## Traces

This tab displays a list of any FRAPI traces that have been placed on this transaction. These traces can be simple lists or complex maps of information.

Pages instrumented with FusionReactor's API (FRAPI) can contribute messages to this tab.

![](/attachments/245550303/245550328.png)

## Aggregates

The **Aggregates** tab visualizes information contributed in aggregate to the transaction, but (usually) not stored in detail elsewhere.  This
data, commonly used by the JDBC subtransaction type, is **rolled up** and stored on the master transaction.  It is usually composed of individual
contributes from subtransactions.

![](/attachments/245550303/245550334.png)

## Logging

The Logging tab displays log statements captured by the Log Tracker plugin throughout the lifetime of a transaction. This includes timestamps, logging level, the log message, and any exception that was logged.

## Json Data

!!! info "Learn more"
    [Json Data Tracker Plugin](/Data-insights/Extras/Plugins/FusionReactor-Json-Data-Tracker-Plugin/)

## Event Snapshot

!!! info "Learn more"
    [Event Snapshot](/Data-insights/Features/Debugger/Event-Snapshot/) page

___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.