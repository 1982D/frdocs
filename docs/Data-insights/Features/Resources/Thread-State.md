

The **Thread State** page displays a graph of samples currently stored
in memory by FusionReactor.

![](/attachments/245551896/245551912.png)

If you're running a large number of threads this sampler could impact
performance. This graph can be disabled in [Resource Settings](Settings.md)

Thread state allows you to see if any bad requests are causing long
waits or deadlocking your system.

## Thread State Graph

Several time spans are available, with differing resolutions. These will
be filled as data points that are collected by FusionReactor.

Each time varying graphs shows four independent values overlaid : 

**Thread State - RUNNABLE**: <span style="color:green;font-weight:700;font-size:20px"> Green </span>

* The number of threads in a RUNNABLE state

**Thread State - TIMED\_WAITING**: <span style="color:blue;font-weight:700;font-size:20px"> Blue </span>

*  The number of threads in a TIMED\_WAITING state


***Thread State - WAITING**:<span style="color:orange;font-weight:700;font-size:20px"> Orange </span>

* The number of threads in a WAITING state

**Thread State - BLOCKED**: <span style="color:yellow;font-weight:700;font-size:20px"> Yellow </span>

* The number of threads in a BLOCKED state

To deselect and reselect each independent value, simply
click on their respective names. When a value is deselected (greyed
out) then that value will no longer be displayed on the activity graph.

Placing your mouse pointer on a data point within the graph will show a
tool-tip with details about that sample, including:

* Date and time of the request
* Thread State - RUNNABLE
* Thread State - TIMED\_WAITING
* Thread State - WAITING
* Thread State - BLOCKED

When browsing the 1 Hour, 1 Day, and 1 Week activity graphs you are able
to select time frames by using the slider under the graph.

___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.
