
# Debugger Email Alert

The Production Debugger Email Alert feature will cause FusionReactor to
send an automated email whenever a breakpoint is fired. The email alert
is an invaluable tool for gaining insight and understanding what is
happening in your production environment.

![](/Data-insights/Features/Debugger/images/245553104.png)

The email includes information about the transactions running on the
thread, the thread information and stack trace as well as all the
variables which are available when the breakpoint was hit. The email is
very similar to the [crash protection email](/Data-insights/Features/Crash-protection/Crash-Protection/#email-alert).

![](/Data-insights/Features/Debugger/images/245553094.png)

The email alerts from the debugger include specific information about
the breakpoint which triggered it. Like the exception being thrown or
the field being accessed.

## Setting up an Email Alert via the Production Debugger Trigger Handler

It is possible to configure the Production Debugger to send an email
alert which includes not only the Stack Trace and environment variables,
but also a link to the Interactive Debugger.

The configuration is shown here:

|Production Debugger Field|Value|Meaning|
|--- |--- |--- |
|Trigger Fire Count|1|Controls how many times the breakpoint will fire.   In this case, only once.|
|Breakpoint Trigger Action|Generate Email Stack/Variable Event|Controls what FusionReactor will do in the event of a breakpoint firing - in this case we should send an Email Alert|
|Thread Pause|Enabled|Tells FusionReactor whether or not to pause the thread.   If this is enabled then the email will contain a link back to the thread view of the request which has paused in the debugger. The email will also say when the thread will resume if its been configured to timeout.|
|Thread Pause Time (in seconds)|Forever|Controls how long the thread will be held.  This can be a value in seconds or setting it to Forever, will hold the thread indefinitely.|
|Thread Pause Execution|Only on one thread at a time|Will cause the engine to halt for a single thread when the breakpoint condition fires.|
