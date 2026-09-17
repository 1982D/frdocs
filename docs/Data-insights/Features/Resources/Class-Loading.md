# Class Loading

The **Class Loading** page shows a graph of samples currently stored
in memory by FusionReactor. Class loading shows the number of classes
being loaded and unloaded.

![](/attachments/245551820/245551835.png)
## Why would I want to see Class Loading?


This graphs aids can help find performance issues caused by excessive
time spent loading classes.  This may further point to issues where
dynamically-created classes are being manipulated excessively.

## Class Loading Graph


Several time spans are available, with differing resolutions. These will
be filled as data points that are collected by FusionReactor.

Each time varying graphs shows two independent values overlaid: 

**Classes Loaded - Count**: <span style="color: rgb(51,102,255);"> **Blue**</span> <br>

- This shows the number of classes loaded since the last sample.

**Classes Unloaded - Count**: <span style="color: rgb(51,153,102);"> **Green**</span>  

- This shows the number of classes unloaded since the last sample.

You're able to deselect and reselect each independent values by simply
clicking on their respective names. When a value is deselected (greyed
out) then that value will no longer be displayed on the activity graph.

Placing your mouse pointer on a data point within the graph displays a
tool-tip with details about that sample, including:

-   Date and time of the request
-   Classes Loaded - Count
-   Classes Unloaded - Count 

When browsing the 1 Hour, 1 Day, and 1 Week activity graphs you're able
to select time frames by using the slider under the graph.


___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.