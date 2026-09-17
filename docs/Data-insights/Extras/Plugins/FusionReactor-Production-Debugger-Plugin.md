title: Production Debugger

# FusionReactor Production Debugger Plugin

The Production debugger is only available in the **FusionReactor Ultimate Edition.**

The Production Debugger plugin is a new feature added in FusionReactor 6,
aiding in solving code related problems at production time. More
information on how to use Production Debug can be found
[here](/Data-insights/Features/Debugger/Overview/).

## Log File

The Production Debugger log file, named **plugin-fr-jvmti.log ,** gives
detail on the status of the Production Debugger.

### Handlers

The registration and de-registration of hooks is outputted into the log
to indicate what is being watched on the Threads. These hooks are what
silently monitors the threads of the application server, looking to
trigger the Breakpoints that have been set. These hooks are only
registered if there is a valid Breakpoint type for that hook.

There are several types of hooks:

-   Exception
-   Class Prepare (This handles Source Line and Method Entry
    Breakpoints).
-   Field

An example of such messages are:

    2015-10-22 15:39:55.309 INFO Registering exception hook
    2015-10-22 15:39:55.313 INFO Registering class prepare hook
    2015-10-22 15:41:10.820 INFO Registering field hook

### JVMTI Errors

The JVM Tool Interface which Production Debugger implements has a
variety of standardised error codes. If any of these occur due to
Production Debug, they will be outputted in the log. The error codes
with their appropriate descriptions can be found on the
<a href="http://docs.oracle.com/javase/7/docs/platform/jvmti/jvmti.html#ErrorSection" class="external-link">JVMTI Java Docs</a>.

Below is an example of such an error being outputted:

    --- Beginning Of File ---
    2015-10-22 15:39:55.259 INFO Logging started for com.intergral.fusionreactor.plugin.jvmti.impl.JVMTIComponent@b224c45
    2015-10-22 15:39:55.281 INFO Enabled JVMTI capabilities
    2015-10-22 15:39:55.309 INFO Registering exception hook
    2015-10-22 15:39:55.313 INFO Registering class prepare hook
    2015-10-22 15:41:10.820 INFO Registering field hook
    WARNING com.intergral.fusionreactor.plugin.jvmti.exception.JVMTIException: JVMTI Error JVMTI_ERROR_DUPLICATE 40
            at com.intergral.fusionreactor.plugin.jvmti.api.JvmtiApi.setBreakpoint(Native Method)

If one of these errors occur, it is advised to contact the FusionReactor
Support Team.

## Configuration Dump

This is only supported on
<a href="https://en.wikipedia.org/wiki/POSIX" class="external-link"><strong>POSIX</strong></a>
**Systems.**

It is possible to perform a dump of the Threads and Production Debug
configuration by performing a
<a href="https://en.wikipedia.org/wiki/Unix_signal" class="external-link">SIGQUIT</a>
command on the Application Server.

To do this on a Linux System, run the command in Terminal:

    kill -3 [PID]

where PID is the process ID of the application server (E.G. - Tomcat or
ColdFusion).

Performing this command will output the following sections into the
console.

### Thread Dump

    Full thread dump Java HotSpot(TM) 64-Bit Server VM (24.80-b11 mixed mode):
    "Thread-89" daemon prio=10 tid=0x00007f4884004000 nid=0x64c0 in Object.wait() [0x00007f485fbfa000]
       java.lang.Thread.State: TIMED_WAITING (on object monitor)
        at java.lang.Object.wait(Native Method)
        - waiting on <0x000000072789b670> (a java.lang.Object)
        at EDU.oswego.cs.dl.util.concurrent.LinkedQueue.poll(Unknown Source)
        - locked <0x000000072789b670> (a java.lang.Object)
        at EDU.oswego.cs.dl.util.concurrent.PooledExecutor.getTask(Unknown Source)
        at EDU.oswego.cs.dl.util.concurrent.PooledExecutor$Worker.run(Unknown Source)
        at java.lang.Thread.run(Thread.java:745)
    "Thread-88" daemon prio=10 tid=0x00007f48a4008000 nid=0x64bf in Object.wait() [0x00007f48e3cc7000]
       java.lang.Thread.State: TIMED_WAITING (on object monitor)
        at java.lang.Object.wait(Native Method)
        - waiting on <0x000000072789b670> (a java.lang.Object)
        at EDU.oswego.cs.dl.util.concurrent.LinkedQueue.poll(Unknown Source)
        - locked <0x000000072789b670> (a java.lang.Object)
        at EDU.oswego.cs.dl.util.concurrent.PooledExecutor.getTask(Unknown Source)
        at EDU.oswego.cs.dl.util.concurrent.PooledExecutor$Worker.run(Unknown Source)
        at java.lang.Thread.run(Thread.java:745)

The thread dump will output the name, state, and stack trace of every
thread.



### Heap

    Heap
     PSYoungGen      total 968704K, used 50177K [0x00000007b7100000, 0x00000007f9680000, 0x0000000800000000)
      eden space 949760K, 5% used [0x00000007b7100000,0x00000007ba0f0760,0x00000007f1080000)
      from space 18944K, 5% used [0x00000007f8400000,0x00000007f8510000,0x00000007f9680000)
      to   space 68608K, 0% used [0x00000007f1080000,0x00000007f1080000,0x00000007f5380000)
     ParOldGen       total 148992K, used 104172K [0x0000000725400000, 0x000000072e580000, 0x00000007b7100000)
      object space 148992K, 69% used [0x0000000725400000,0x000000072b9bb2a8,0x000000072e580000)
     PSPermGen       total 33792K, used 33568K [0x0000000720200000, 0x0000000722300000, 0x0000000725400000)
      object space 33792K, 99% used [0x0000000720200000,0x00000007222c80e0,0x0000000722300000)

The Heap section gives an overview of the memory usage in the
Application Server.

### Capabilities

    FusionReactor JVMTI: $Revision: 52719 $ Oct 22 2015 13:07:56
    Capabilities
        can_generate_breakpoint_events=1
        can_access_local_variables=1
        can_get_line_numbers=1
        can_get_source_file_name=1
        can_generate_exception_events=1
        can_generate_single_step_events=1
        can_generate_frame_pop_events=1
        can_get_source_debug_extension=1
        can_get_owned_monitor_stack_depth_info=1
        can_generate_field_access_events=1
        can_generate_field_modification_events=1

The Capabilities section outputs the current abilities of the Production
Debugger. "1" indicates that the Debugger can do the said operation, and
"0" indicated otherwise. These capabilities being turned off may
commonly be the culprit for certain JVMTI errors.

### Hooks

    Hooks
        ClassPrepareHook=Set
        ThreadHook=Set
        BreakpointHook=Set
        ExceptionHook=Set
        FieldHook=Set

The Hooks section output the current status of all the hooks within the
Production Debugger.

### Counters

    Counters
        Breakpoints=5
        FieldAccess=1
        FieldWatch=1

The Counters Section outputs what amount of each Breakpoint and Trigger
type is currently active. A breakpoint must be enabled for it to be
defined as active.

### Thread Events

    Thread Events
        Thread 1 "main" 29440 29440
        Thread 2 "Reference Handler" 29440 29440
        Thread 3 "Finalizer" 29440 29440
        Thread 4 "Signal Dispatcher" 29440 29440
        Thread 12 "GC Daemon" 29440 29440
        Thread 63 "ContainerBackgroundProcessor[StandardEngine[Catalina]]" 0 29440
        Thread 64 "http-bio-8080-Acceptor-0" 29440 29440
        Thread 65 "http-bio-8080-AsyncTimeout" 29440 29440
        Thread 66 "ajp-bio-8009-Acceptor-0" 29440 29440
        Thread 67 "ajp-bio-8009-AsyncTimeout" 29440 29440
        Thread 69 "http-bio-8080-exec-1" 29440 29440
        Thread 71 "http-bio-8080-exec-2" 29440 29440
        Thread 72 "http-bio-8080-exec-3" 29440 29440
        Thread 73 "http-bio-8080-exec-4" 29440 29440

The Thread Events section is an output of all threads being watched by
the Production Debugger.
