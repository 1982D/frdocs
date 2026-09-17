# Trans. By Mem

**Transactions &gt; Trans. By Mem** (Transactions by Memory) display
a list of all JDBC transaction in a sequential order that have used the
highest amount of memory on this instance.

!!! example "Example: JDBC statement data obfuscated"
    ![](/attachments/245550873/245550904.png)
    
## Highest memory usage transactions table

The **Highest memory usage transactions table** is the main content of this page and is a summary list of the
currently stored transaction of the selected type.

|Name|Description|
|--- |--- |
|**Finished**|Time at which this transaction finished.|
|**Status / Type**|Status of the transaction - typically **Finished**. The type of the transaction is also displayed here, as well as any protection contributed statues.|
|**App / Txn**|The application in which the request occurred from or to.|
|**ID / Thread**|Per type transaction ID, and the Thread name that this transaction ran on.|
|**Description / URL / Statement**|Description of the transaction - defined by the user when the transaction is created for user defined transaction. This column also contains the details of contexts that are held on this transaction. Depending on the flavor of the transaction, it is either **Description**, **URL** or **Statement**.|
|**Memory Used (B**)|The amount of memory that the transaction has used.|


## Clearing transaction history

On the menu bar, at the top right of the page is a **Clear
History** button. Clicking this button deletes all the information on the page.

|Button|Name|Description|
|--- |--- |--- |
| :fa-trash: |**Clear History**|Clicking this button clears the page of all requests and its history|

## Refreshing the page

At the top of the page is the standard page header. Click the refresh button at any time to update the main content.
Alternatively, select a time period from the drop-down selection to update the content automatically. Selecting **None** from
the drop-down box will stop the automatic refresh, and requires a manual refresh of the page to view any new requests.

___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.