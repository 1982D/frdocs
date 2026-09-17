##  Memory Heap/Non Heap

The **Memory Heap** page displays a graph of the memory samples
currently stored in memory by FusionReactor.

Below is a sample image of the **Heap/Non Heap Memory Graph**.

![](/attachments/245549160/245551670.png)

This graph is very efficient as it allows you to quickly analyze non
heap memory, heap memory and a combination of both. Not only that but,
because it can cover larger periods of time, you can see if anything is
becoming critical meaning you can act before it is to late. This kind of
trend is much more difficult to spot if you are only checking the system
periodically and are only looking at the health of the system right at
this point in time.

### Heap vs Non Heap

The graph shows the breakdown of heap vs. non heap memory.  Heap memory
is (usually) the bigger allocation of the two areas, and is used to
store most new objects.  When objects are no longer required, they
remain on the heap until they are garbage collected.  The memory thus
freed is returned to the heap and is available again for new
allocations.

The non-heap are is used to store objects pertaining to much less
dynamic types of object (like information about loaded classes).

The Java memory and garbage collection model is very sophisticated and
is updated frequently.

Several time spans are available, with differing resolutions. These will
be filled as data points that are collected by FusionReactor.

Each time varying graphs show two independent values overlaid: 

**Non- Heap + Heap (Used)**

* Shows the total used memory in both Heap and Non-Heap spaces

**Memory - Non-Heap - Used (MB)**  

* Shows the used memory in Non-Heap memory spaces.  
        

To deselect and reselect each independent value, simply
click on their respective names. When a value is deselected (greyed
out) then that value will no longer be displayed on the activity graph.

Placing your mouse pointer on a data point within the graph shows a
tool-tip with details about that sample, including:

* Date and time of the request
* Non-Heap + Heap (Used)
* Memory - Non-Heap - Used (MB)

When browsing the 1 Hour, 1 Day, and 1 Week activity graphs you can select time frames by using the slider under the graph to pinpoint specific days, times and spikes in your memory.

___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.
