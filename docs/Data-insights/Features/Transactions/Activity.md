#  Activity

This activity page shows which transactions are running when the page was loaded or last
refreshed.   There are 2 specific variations on this page:

* **WebRequest** > **Activity**

* **JDBC** > **Activity**

![Screenshot](/attachments/245550553/245550668.png)

## Running Transactions overview

In the top left, is a summary of the running transactions. It
is displayed in the following two columns:

|Name|Description|
|--- |--- |
|**Running Count**|This is the number of web request transactions currently running on the instance.|
|**Request per Second**|This is the current average number of web request transactions that are completed per second.|


## Memory State overview

In the top right, under the menu buttons is the memory state
overview. It is displayed in the following four columns:

|Name|Description|
|--- |--- |
|**Max**|The amount of memory available to the JVM (this is a hard upper limit).|
|**Alloc**|The amount of memory currently allocated by the JVM for its heap  -  this may grow until the max value is reached.|
|**Free**|The amount of free memory from the currently-allocated heap.|
|**Used (%)**|The amount of memory which is actually in use. This is expressed as a percentage as well as in KB.|

## Running Transactions table

For each request that is active or open at the current time, you will
see the following below in a table:

|Name|Description|
|--- |--- |
|**Started**|The date and time at which the request was received.|
|**Status / Type**|This is the status of the transaction, this will typically be Running. The type of the transaction is also displayed here, as well as any protection contributed statues.|
|**App / Txn**|The application (App) in which the request occurred from or to - shown on the top line The transaction (Txn) shown on the lower line, is based on whichever rules you wish to use for your transaction naming - these rules can be set on the **FusionReactor Menu / Settings** page. <br> Learn more: [Transaction Naming](/Data-insights/Features/Transactions/Transaction-Naming/)|
|**ID / Thread**|The request ID and the name of the thread which is servicing the request.|
|**Description / URL / Statement**|This is the description of the transaction, used for flavors such as MongoDB and FRAPI. Depending on the flavor of the transaction, you will see either Description, URL or Statement.|
|**Time (ms)**|The time that the transaction took to complete. If available then you will also see the amount of actual CPU time that this transaction used below it.|


## Sorting Running Transactions

Change the order in which requests are displayed on this page by
clicking on any of the column titles. Clicking on a title for a second
time will reverse the order on that column.

There are filters present at the top of the page, and you can
switch between active transactions and all transactions running. 

|Name|Description|Default|
|--- |--- |--- |
|**Apps**|The applications to monitor requests from for your server.|All Apps|
|**Transaction**|The type of transaction you wish to view (e.g. WebRequest, JDBC Requests, etc.)|N/A|
|**SubFlavor**|The type of requests to monitor (e.g. GET, POST, etc.)|All SubFlavors|
|**View**|Allows you to view only transactions that are either **Active** or **All**|Active|


## Sub Transactions


At the far left of every row in this table is a small expander arrow,
that is only shown if the transaction has sub transactions.
Clicking this arrow will fetch the sub transaction from the server, or
find the current expanded transactions. The transactions returned are
based on the view mode explained below.

!!! info
    The expander arrow is only shown if that transaction has sub transactions.

When expanding a transaction, a request is made to FusionReactor for the
sub transactions, based on the selected mode. The result of this request
is subject to the transaction still being available from the transaction
history.

The page will stop refreshing when a transaction is expanded, and will
continue when it is collapsed.

## Running Transactions Menu options

On the page, to the right of the filtering options there are two options:


|Button|Name|Description|
|--- |--- |--- |
|:fa-align-left:|**Stack Trace All**|Displays a stack trace of all currently-running requests. The stack trace is colorized to ease recognition of each part.|
|:fa-times:|**Kill ALL**|Allows the user to kill all currently-running requests. There is an intermediate screen which allows the user to select whether the request are to be excluded from tracking (default) or not. See below |

!!! Warning "Kill Instability with Java 1.5+"
    FusionReactor's Request Kill (Accessible via the Kill Request button, the Kill ALL button and via Protection strategies) uses our Transit transaction engine to make two attempts to kill a request.

    **Soft Kill**, this interrupts the request while it's outputting data to the web browser. If the request is not outputting data (It might be stuck in a loop or a Java native method for instance), the Soft Kill will time out.  FusionReactor then proceeds to a Hard Kill.

    **Hard Kill** is FusionReactor's last resort. The thread is interrupted, paused and then stopped.  Any Java synchronizers (Monitors) the threads that are held are immediately released.  However, in Java 5, Sun/Oracle introduced a new type of lock, the Ownable Synchronizer. These locks are much more versatile, but FusionReactor cannot manipulate them, and killing their owning threads may not automatically release them. In this case, a thread kill will almost certainly eventually lead to a system hang, as other threads wait for a lock release that will never happen.

    If FusionReactor detects that the candidate request owns any ownable synchronizers, it will not proceed to a hard kill in order to preserve the integrity of the locking system. If you use the user interface to **Force Thread Death**, FusionReactor will attempt the hard kill, but any locks will not be released (You could end up with a system hang. Use this feature with caution).

    If you're using Protection rules set up to Abort requests  -  for example the Request Runtime Protection, FusionReactor won't automatically proceed to hard kill. You'll be able to identify these requests in the request history lists, because they will have a tab called **Transit - Locks**, listing the locks that the request owned.

## Managing Requests

As described above this page allows you to view all the different
transactions by selecting other types of transactions via the drop down
selector in the top right. Therefore, the following buttons and options
may not appear for all of the transactions.

|Button|Name|Description|
|--- |--- |--- |
|:fa-book:|**Details**|Clicking this button will redirect you to the **Details** page for the selected transaction.|
|:fa-trash:|**Add to CP**|If you click this button then you will be taken to the Protection Restrictions page which will be filled out for this transaction.|
|:fa-align-left:|**Stack Trace**|Takes you to the **Stack Trace** page, allowing you to see the current Java stack trace of the request.|
|:fa-times:|**Kill**|Clicking this button allows you to manually kill any tracked request. You'll be asked if you are sure. Click on **OK** to kill the request.<br>FusionReactor will make two attempts to kill the request. If neither succeed, the system will ask you if you want to Force Thread Death. If you proceed, and the thread holds Ownable Synchronizers, they will not be automatically released by Java, and could lead to a hung system. You should therefore use this feature with caution.<br>If **Stop Tracking This Request** is checked, the request will be exempt from metric tracking - see "Stop Tracking" below.|
|:fa-exclamation-triangle:|**Stop Tracking**|Clicking this button will cause FusionReactor to stop tracking this request for certain metrics (slowest requests, request runtime. request activity). Any JDBC statements currently running will be logged and visible in **Request Details**, but the JDBC Time and Activity graphs, as well as Average DB Time, will not reflect them. <br><br>Once this button has been pressed, it is grayed and disabled.  There is no way to reverse this operation.|
| :fa-clock-o: |**Profile**|Available in FusionReactor Ultimate or Developer Edition. Clicking this button will allow you to start or stop a profile for a transaction. <br>![](/attachments/245550553/245550617.png)<br>More information can be found on the Profiler page.|
| :fa-bug: |**Debug**|Available in FusionReactor Ultimate or Developer Edition. Clicking this button will allow you to pause a thread, causing the icon to change to the debugger icon.<br> ![](/attachments/245550553/245550563.png)<br>Clicking this icon will then direct you to the Debugger, and will open a detailed view of the paused thread.|

___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.
