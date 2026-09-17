## Buffer Pool

The **Buffer Pool** page shows the
memory samples stored for the direct and memory buffer of your JVM. In
the top right of the page next to the **Set Home Page** you can switch
graphs by clicking the **Direct** drop down button to view other the
Mapped Buffer Pool graph. This works both ways.

Below is a sample image of the **Buffer Pool Graph**, which is currently
set to **Direct**.

![](/attachments/245551730/245551740.png)

Several time spans are available, with differing resolutions. These will
be filled as data points that are collected by FusionReactor.

Each time varying graphs shows two independent values overlaid: 

* [SPACE NAME\] Capacity  
    * This is the current allocated memory for the specified buffer pool</span>
* [SPACE NAME\] Memory Used  
    * This is the currently used memory for the specified buffer pool

### Direct Buffer Pool

Direct buffer is a chunk of memory typically used to
interface Java to the OS I/O subsystems, from which Java can read
directly.  Java will grow this pool as required so the direct capacity is all buffer memory allocated so far.

### Mapped Buffer Pool

The mapped buffer pool is all the memory used by Java for its FileChannel instances.  
Buffer pool space is outside the garbage collector-managed memory.

You're able to deselect and reselect each independent values by simply
clicking on their respective names. When a value is deselected (greyed
out) then that value will no longer be displayed on the activity graph.

!!! tip
    Placing your mouse pointer on a data point within the graph displays a tool-tip with details about that sample.

When browsing the 1 Hour, 1 Day, and 1 Week activity graphs you are able
to select time frames by using the slider under the graph to pinpoint
specific days, times and spikes in your memory. 

___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.