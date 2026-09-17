# Longest Transactions: JDBCRequest

**JDBC &gt; Longest Transactions** shows a list of the all JDBC
longest transactions in a sequential order that have taken the highest
amount of time to complete on this instance.

!!! note
    FusionReactor retains only a fixed number of transactions in memory.  
    If the "Longest Transactions" list grows too large, or if the application server is restarted, older transactions will be discarded.



## Changing the Size of the JDBC Longest Transactions List

You can adjust the size of the JDBC Longest Transactions list via:

**JDBC Settings** → **History** → **Slow Request History Size**

The example below shows the configuration page (with statement data obfuscated). Statements are listed in order of longest execution time.


![](/attachments/245551176/245551225.png)

!!! note
    The Longest Requests : JDBCRequest is the same as [Transaction->Long Transactions](../Transactions/Longest-Transactions.md) but filtered to only show transactions of JDBC type.

!!! info "Learn more"
    [Transaction->Long Transactions](../Transactions/Longest-Transactions.md)
    

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.

