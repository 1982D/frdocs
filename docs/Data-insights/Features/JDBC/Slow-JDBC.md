# Slow Transactions: JDBCRequest

**JDBC &gt; Slow Transactions** will show a list of all **Slow Running** and **Slow Finished** transactions, which have taken longer to
run than the current Slow Request Threshold.

!!! note
    FusionReactor has a default Slow Request Threshold set to 3 seconds. You are able to change the threshold to either a lesser or a higher value and can find the setting: 

-   [JDBC+Settings](Settings.md) &gt; **History** &gt; **Slow Request Threshold**

The example below shows the page with statement data obfuscated. The image lists:

- Transactions that have exceeded the slowest threshold.

- Transactions that are still running and have already passed the threshold.

![](/attachments/245551232/245551252.png)

!!!note
    The Slow Transactions: JDBCRequest is the same as [Transaction->Slow Transactions](../Transactions/Slow-Transactions.md) but filtered to only show transactions of JDBC type.

!!! info "Learn more"
    [Transaction->Slow Transactions](../Transactions/Slow-Transactions.md)



!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.
