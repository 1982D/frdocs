

The **Threads** page shows all threads within the Java Virtual
Machine (JVM) for this server. Each thread is listed with its Thread ID,
Thread Group, Thread Name and Status. The **Threads** page allows you to
generate a stack trace for each individual thread or generate a stack
trace for all threads at once.

![](/attachments/245551947/245551980.png)

## Threads Table

The threads table has the following columns:

|Name|Description|
|--- |--- |
|Thread Id|The thread ID is a number generated when this thread was created. The thread ID is unique and remains unchanged during its lifetime. When a thread is terminated, this thread ID may be reused.|
|Group|The thread group to which this thread belongs. This can be 'Unknown' if this thread has died (been stopped).|
|Name|The verbose name of the thread.| 

After these three named columns there is a status indicator for the
threads state: 

|Thread State|Description|
|--- |--- |
|![](/attachments/245551947/245552030.png)|A thread which is ready to execute, or is actually executing in the Java virtual machine is in this state.|
|![](/attachments/245551947/245552025.png)|A thread that is waiting indefinitely for another thread to perform a particular action is in this state.  This state corresponds to an Object Wait/Notify condition becoming satisfied. These conditions are often used to signal explicit interprocess communication, and java Lock semantics.|
|![](/attachments/245551947/245552040.png)|A thread that is waiting for another thread to perform an action (with explicit timeout) is in this state.|
|![](/attachments/245551947/245552065.png)|A thread that is blocked waiting for a monitor (in order to enter a synchronized block) is in this state.|
|![](/attachments/245551947/245551970.png)|A thread in this state indicates it is waiting for a monitor to become free, but FusionReactor has calculated this will never occur due to the state of one or more other threads.|
|![](/attachments/245551947/245552015.png)|A thread that has exited is in this state,  i.e. it ran to completion.|


!!! info "Learn more"
    [Oracle JavaDoc - Thread State](https://docs.oracle.com/javase/7/docs/api/java/lang/Thread.State.html)
     
It is possible for threads to be in a **NEW** state. A thread that
has been created but not yet started is in this state.  FusionReactor
does not show new threads.  It only shows threads which have actually
started.

## Managing Threads

If any threads are active when they shouldn't be, or are taking up to
many resources on the server, then you can kill the thread from this
page.

Each thread listed on this page has two buttons next to it. They are:

|Button|Name|Description|
|--- |--- |--- |
|![](/attachments/245551947/245551960.png)|Stack Trace|Clicking this button will redirect you to the Stack Trace page which lets you see exactly what is currently going on inside the thread.|
|![](/attachments/245551947/245551975.png)|Kill Thread|Clicking on this link will start the process to kill the thread. <br> <br> There are 2 stages to this process. If step 1 fails, you can try step 2. <br> <br> Step 1: Interrupt the thread. <br> <br> Step 2: Force Thread Death. <br> <br> Warning - Kill Thread <br> <br> The "Kill" button does not give a request the opportunity to complete in it's own time (See Warning below). All JVM threads are listed in this page, including those pertaining to the JVM system and J2EE container functions.  Killing a thread is a last resort to solving problems and we must caution you that, while FusionReactor does allow you to stop any thread, it is highly inadvisable to stop any threads in the "system" thread group, or any threads integral to the running of your J2EE container. <br> <br> Warning - Kill Instability with Java 1.5+ <br> <br> FusionReactor's Request Kill (Accessible via the Kill Request button, the Kill ALL button and via Protection strategies) uses our Transit transaction engine to make two attempts to kill a request. <br> <br> Soft Kill, this interrupts the request while it's outputting data to the web browser. If the request is not outputting data (It might be stuck in a loop or a Java native method for instance), the Soft Kill will time out.  FusionReactor then proceeds to a Hard Kill. <br> <br> Hard Kill is FusionReactors last resort. The thread is interrupted, paused and then stopped.  Any Java synchronizers (Monitors) the threads that are held are immediately released.  However, in Java 5, Sun/Oracle introduced a new type of lock, the Ownable Synchronizer. These locks are much more versatile, but FusionReactor cannot manipulate them, and killing their owning threads will not automatically release them. In this case, a thread kill will almost certainly lead to a system hang, as other threads wait for a lock release that will never happen. <br> <br> If FusionReactor detects that the candidate request owns any ownable synchronizers, it will not proceed to a hard kill in order to preserve the integrity of the locking system. If you use the user interface to "Force Thread Death", FusionReactor will attempt the hard kill, but any locks will not be released (You could end up with a system hang. Use this feature with caution).|

## Threads Menu Options

On the page, to the right of of the refresh option, there is a option to
stack trace all threads.

|Button|Name|Description|
|--- |--- |--- |
|![](/attachments/245549501/245549592.png)|Stack Trace All|Displays a Stack Trace of all currently-running threads. The stack trace is colorized to ease recognition of each part.|

## Refreshing the page

At the top of the page you will see the standard page header. At any
time you can click the refresh button to update the main content.
Alternatively, you can select a time period from the drop-down selection
to be able to update the content automatically. Selecting **None** from
the drop-down box will stop the automatic refresh, and will require you
to manually refresh the page to see any new requests.

___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.
