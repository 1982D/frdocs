## Event Snapshot

<iframe src="https://player.vimeo.com/video/847319269?h=3d705fc41b" width="640" height="363" frameborder="0" allow="autoplay; fullscreen" allowfullscreen></iframe>

FusionReactor (FR) automatically generates **Event Snapshots** for critical events during application monitoring. These snapshots provide in-depth diagnostic information for issues like exceptions or thread latency, enabling rapid problem isolation.

An Event Snapshot captures:

- Source code context
- Scope variables at the point of the event
- The complete stack trace
- Relevant logging information

Event Snapshots bridge the gap between basic error tracking (stack traces) and the full interactive Debugger, offering a comprehensive view without requiring step-through debugging or variable modification.

**Triggers**: Event Snapshots are created automatically when:

- A logged error (tracked by FR) occurs.
- An exception is thrown within a tracked transaction.
- An error is caught by the ColdFusion error handler.

**Dependency**: The native Debug library is essential for Event Snapshots, as it provides the API necessary to inspect Java local variables on the call stack. This library captures variable values and the thread stack trace at the time of the triggering event.

**Installation**: The automated FusionReactor installer includes the native [Debug library](https://www.fusion-reactor.com/download-fusionreactor/). For [manual installations](/Monitor-your-data/FR-Agent/Installation/Manual/), this library must be installed separately.


## Rate Limiting for Event Snapshots

To optimize storage, FusionReactor (FR) employs rate limiting by sharing Event Snapshots for identical errors within web requests. The first occurrence of an error generates the full snapshot, and subsequent identical errors simply reference this original file.

!!! note
    Due to this sharing mechanism, the UI might display variable states from the initial web request, which may not precisely reflect the state of subsequent requests experiencing the same error.

This sharing strategy ensures that for recurring issues, the snapshot generation overhead is incurred only once, significantly improving performance when transactions fail repeatedly in quick succession.


## Log Event Snapshots

FusionReactor automatically captures the last n (default: 100) log messages at a specified level or higher (defaults to ERROR) from log4j, slf4j, and Apache Commons Logging. 

!!! note
    Java Util Logging is **not** tracked.

An [Exception Snapshot](#exception-snapshots) is triggered on the **first** log ERROR call. This snapshot captures the call stack and all stack variables at the moment the error is logged, providing context for the log event.

!!! info 
    See [Debug \> Settings](Settings.md) for configuration options.


## Exception Snapshots

FusionReactor can generate Event Snapshots when an error is tracked. The first time a specific error causes a page or transaction failure, FR records it. The **second** time this same exception occurs, an Event Snapshot is automatically generated.

This snapshot captures the variables and stack trace at the exact point the exception is thrown (the "first chance" exception). This differs from FR's standard error tracking, which only records errors that propagate up to be displayed to the user.


### Variable Capture Details

When an Event Snapshot is created, it captures the local variables and stack trace of the relevant thread. Variables are collected for each stack frame, **excluding** those belonging to the `java`, `javax`, `sun`, or `com.intergral` packages.

For each applicable stack frame, local variables, including object fields, are captured up to a depth of 5 levels in the variable/field hierarchy.

To prevent excessively large snapshots, a hard limit of **500 unique variables** is enforced. Once this limit is reached, no further variables are captured. For collections (Lists, Maps, Arrays, etc.), only the first 5 objects within the structure are tracked. This limitation prevents large data structures from quickly exceeding the variable limit and rendering the snapshot less useful.

#### CFML Variable Scopes Included

The Event Snapshot includes the following CFML variable scopes when applicable: `application`, `cffile`, `cfthread`, `cgi`, `client`, `cookie`, `file`, `form`, `request`, `server`, `session`, `variables`, and `url`.



#### Why are Some Variables Not Displayed?

In scenarios where the relevant operation (e.g., socket connect) occurs within low-level Java code where variable capture is disabled, the initial stack frames may not show any variables. In such cases, it is necessary to select the first stack frame that contains captured variables (e.g., `org.postgresql.core.v3.ConnectionFactoryImpl`). The variables displayed in this frame reveal the parameters used for the operation, such as the database name (`testdb`), host specification (`localhost:5432`), and user (`nwightma`). These objects can be expanded to inspect their fields.

Selecting a stack frame corresponding to application code might initially show limited information, as illustrated below:

![](/Data-insights/Features/Debugger/images/245553125.png)

However, expanding relevant fields, such as the `'ds'` field in this example, can reveal further details:

![](/Data-insights/Features/Debugger/images/245553120.png)

### Enabling Support for Event Snapshots

Event Snapshot (Exception) Support can be switched on by configuring the
following system property in the JVM arguments file:

```   
-Dfr.jvmti.enable.exceptions=true
```

Once enabled, Event Snapshots will be triggered when exceptions occur,
otherwise snapshot generation will not trigger on exceptions/errors.  

## ColdFusion Snapshots

ColdFusion Snapshots are snapshots fired specifically when an error is thrown within a CFM file within a tracked ColdFusion Application. These snapshots only fire when Exception support is unavailable

The Reason ColdFusion has an alternate way of tracking errors is that enabling Exception support could have a potential performance impact on the ColdFusion server. More information on this is available [here](Overview.md#exception-support).

With ColdFusion Snapshots, variable information is only available in the top stack frame. All other stack frames will appear greyed out, and selecting them will display the message: "There is no content for this section."



### Variables in CFCs

As variables are only captured in the CFM, any snapshot generated on an error in a ColdFusion component (CFC) will still only have the variables from the triggering request to a CFM.

For example:

```
component {
  function example(string var1) {
    foo = "bar";
    WriteOutput( arg );
  }
}
```

In the following code var1 would be a tracked variable if it was generated in the CFM, but foo would not be tracking in FusionReactor

In order th track variables for every stack frame including within and CFC's you must [enable exception support](#enabling-support-for-event-snapshots)

## User Interface

![](/Data-insights/Features/Debugger/images/245553130.png)

The image above illustrates the Event Snapshot user interface. This specific Event Snapshot was generated due to a second attempt to connect to PostgreSQL. The initial connection attempt triggered an error that was tracked on a transaction. Subsequently, the second connection attempt resulted in an exception being thrown, which then triggered the Event Snapshot generation at the moment the exception occurred.

The Event Snapshot UI bears a strong resemblance to the Interactive Debugger UI.

The top section of the UI provides context, indicating the event that caused the snapshot generation and the reason. In this example, the trigger was an exception being thrown.

The lower section mirrors the Interactive Debugger, displaying the source code, stack trace frames, and any captured variables.

