title: Deadlock
# FusionReactor Deadlock Plugin

The FusionReactor Deadlock plugin polls all Java threads running in the
JVM that your server is running on every 30 seconds. Any Java thread
deadlocks detected are written to a log file (deadlock.log, see below)
and a [notification](/UI/Notifications/) (see below) is
created for that particular deadlock. 

A deadlock occurs when two or more threads are waiting for each other to
finish. For example Thread-1 may have a hold on Object1, Thread-2 may
have a hold on Object2. In order for Thread-1 to complete it's operation
it needs to access Object2, for Thread-2 to complete it's operation it
needs to access Object1. Both threads are in a deadlock as they cannot
proceed until they get the resource they require, and they cannot as the
other Thread won't give up that resource until they have completed their
operation. Thread-1 may even have a hold on other resources (for example
Object3, Object4 and Object5) that other threads require causing further
deadlocks.
 
[![](/attachments/245548182/245548200.jpg)](/attachments/245548182/245548200.jpg)

There is no specific effect that a deadlock will have on your
application as there are no two identical applications. Some of the
effects of deadlocks can include slow performance and high memory
consumption, in sever cases they can bring your application to a
complete halt. Reading the notifications this plugin generates can help
you pinpoint where deadlocks are occurring in your application, with
this knowledge you can make a decision as to how to proceed.

##Notification


If the plugin detects a deadlock a notification will be created. The
notification contains information about the deadlock, this information
can be used to determine how the deadlock

##Log File - deadlock.log

When a deadlock occurs the plugin generates a file called deadlock.log
and populates it with information which can be used to determine how the
deadlock occurred.

|Field Name|Number|Description|
|--- |--- |--- |
|Date (Formatted)|1|The date the log was written.|
|Time (Formatted)|2|The time the log was written.|
|Date/Time (ms)|3|The number of seconds since epoch.|
|Version|4|Version number of this log entry.|
|Server Start up Time (ms)|5|Start up time of the application server in milliseconds (ms) since epoch.|
|Log Type|6|This will either be "DEADLOCK" or "DEADLOCKRESOLVED", it describes the nature of the entry.|
|Thread Name|7|The thread name of the thread that has entered deadlock.|
|Thread ID|8|The thread ID of the thread that has entered deadlock.|
|Thread State|9|The state of the thread that has entered deadlock.|
|Lock Identity Hash Code|10|The identity hash code of the lock object. For this field to be written to the log file you need to be using Java 1.6 or greater.|
|Lock Name|11|The name of the lock.|
|Lock Owner Name|12|The name of the lock owner.|
|Lock Owner ID|13|The ID of the lock owner.|
|Is Native|14|If the thread that is in deadlock is running native code then this value is set to true, otherwise it is set to false.|
|Is Suspended|15|If the thread that is in deadlock is suspended then this is set to true, otherwise it is set to false.|
|Stack trace|16|This is a full stack trace of the thread that is in deadlock.|
|Threads Locked Monitors|17|This is a list of objects that are currently under lock by the thread. Each entry in the list is separated by a comma . The format for each entry is identity hash code: string representation of the lock, for example "675587393:java.lang.Object@2844a541". For this field to be written to the log file you need to be using Java 1.6 or greater.|
|Threads Locked Synchronizers|18|This is a list of locks that are currently under lock by the thread. Each entry in the list is separated by a comma . The format for each entry is identity hash code: string representation of the lock, for example:<br> "675587393:1475122501:java.util.concurrent.locks.ReentrantLock$NonfairSync@57ec9545".<br>For this field to be written to the log file you need to be using Java 1.6 or greater.|


## Status Log - plugin-fr-deadlock-plugin.log

The Deadlock plugin creates a log file called
plugin-fr-deadlock-plugin.log which contains information on the status
of the plugin, when it started, stopped and if there were any problems.
Below is a table explaining what all the attributes in the log file
mean.

|Field Name|Number|Description|
|--- |--- |--- |
|Date (Formatted)|1|The date on which this log entry was written.|
|Time (Formatted)|2|The time on which this log entry was written.|
|Level|3|Log Level basically means the nature of the log, for example INFO means general information, where as ERROR means an error is being logged. SEVERE means something really bad has happened, this will be typically followed by the a generated exception.|
|Log message|4|Contains a message of an event that occurred such as logging that has started.|
