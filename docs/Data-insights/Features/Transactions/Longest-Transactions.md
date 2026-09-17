# Longest Transactions

The **Longest Transaction** page is similar to the [Longest Request](../Requests/Long-Requests.md) page. It displays the transaction of the selected type that are currently stored in the memory that have the longest run time of all the transactions of this type, since the server started (or history was cleared).

![](/attachments/245550793/245550825.png)

## Longest Transaction Table

This is the main content of this page and is a summary list of the currently stored transaction of the selected type.

|Name|Description|
|--- |--- |
|**Finished**|Time at which this transaction finished.|
|**Status / Type**|Status of the transaction, this will typically be Finished. The type of the transaction is also displayed here, as well as any protection contributed statues.|
|**App / Txn**|The application in which the request occurred from or to.|
|**ID / Thread**|Per type transaction ID, and the thread name that this transaction ran on.|
|**Description / URL / Statement**|Description of the transaction defined by the user when the transaction is created for user defined transaction. This column also contains the details of contexts that are held on this transaction.<br><br>Depending on the flavor of the transaction, you see either **Description**, **URL** or **Statement**.|
|**Time (ms)**|The time that the transaction took to complete. If available then you will also see the amount of actual CPU time that this transaction used below it|


## Sub Transactions

At the far left of every row in this table is a small expander arrow,
this arrow is only shown if the transaction has sub transactions.
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

## Sorting Longest Transaction

The order in which requests are displayed can be changed on this page by
clicking on any of the column titles. Clicking on a title for a second
time will reverse the order on that column.

There are filters present at the top of the page, and you can
switch between active transactions and all transactions running. 

|Name|Description|Default|
|--- |--- |--- |
|**Apps**|The applications to monitor requests from for your server.|All Apps|
|**Transaction**|The type of transaction you wish to view (e.g. Root Transactions, All Transaction or specific types like WebRequest, JDBC Requests, etc.)|Root Transactions|
|**SubFlavor**|The type of requests to monitor (e.g. GET, POST, Create, Insert, etc.)|All SubFlavors|


Root Transactions are all top level root transactions, i.e. they have no
parent transactions.  They normally mean that this is the start of some
operation which FusionReactor tracks.

All Transactions are all the transactions which FusionReactor tracks,
this includes Root Transactions and all the child / sub transactions.

## Managing Requests

For each transaction listed on this page there are a possible  two icons next to it. They are:

|Button|Name|Description|
|--- |--- |--- |
| :fa-book: |**Details**|Takes you to the **Request Details** page, allowing you to access all information associated with a request; e.g cookies, JDBC, headers, User Trace Markers and AMF information.|
| :fa-ban: |**Add to CP**|Click this button to be taken to the **Protection Restrictions** page which will be filled out for this request.  Will only appear for WebRequests.|


## Clearing Transaction History

On the menu bar, in the top right of the page there is a **Clear History** button. Upon clicking this button the page you are on will be cleared and any information on it will be deleted.

|Button|Name|Description|
|--- |--- |--- |
| :fa-trash: |**Clear History**|Clicking this button will clear the page of all requests and its history|

___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.