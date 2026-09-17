# Slow Requests

**Requests** &gt; **Slow Request** will show a list of all **Slow
Running** and **Slow Finished** transactions, which have taken longer to
run than the current **Slow Request Threshold**.

!!! note
Be aware that FusionReactor has a default **Slow Request Threshold** set to 8 seconds. Change the threshold to either a lesser or a higher value by going to: <br> [Request Settings](Settings.md) &gt; **WebRequest History** &gt; **Slow Request Threshold**  


The example image below lists any transactions that have gone over the slowest threshold. It also lists any running transactions that haven't increased passed the threshold and are still running.

![](/attachments/245549896/245549980.png)

!!!note
    Slow Requests is the same as [Transaction->Slow Transactions](../Transactions/Slow-Transactions.md) but filtered to only show transactions of WebRequest type.

!!! info "Learn more"
    [Transaction->Slow Transactions](../Transactions/Slow-Transactions.md)

___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.
