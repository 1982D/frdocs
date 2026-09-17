title: Breakpoints

# Breakpoints

## Introduction

The **Breakpoint** section displays the **currently configured breakpoints** set up in the FusionReactor Production Debugger ("**Debugger**"). From here, you can **create**, **edit**, **enable/disable**, and **delete** breakpoints, as well as manage them from other areas within FusionReactor's user interface.

Breakpoints are divided into two main components:  

- **Trigger**: The breakpoint configuration that defines when the breakpoint should fire.  
- **Handler**: The action executed when the trigger condition is met.

In addition, breakpoints have global configurations that apply to **all** breakpoints when they fire. The primary configurations are:

- **Conditional configuration**  
- **Rate limiting configuration**

These settings govern whether the trigger should activate the handler for any given breakpoint.

![](/Data-insights/Features/Debugger/images/245552950.png)

The table displays the configured breakpoints.  

- The first column shows the breakpoint icon, indicating the current state of the breakpoint.  
- The second column defines the **trigger**, specifying when the breakpoint should be activated.  
- The third column contains the breakpoint controls.

Clicking the **information button** opens a popup with detailed state information about the breakpoint.

![](/Data-insights/Features/Debugger/images/245552944.png)

The locations section of this window contains the following fields:

| | |
|-|-|
| Location | The full location of the breakpoint. For Example ```java.lang.Thread.run(Thread.java:745)``` |
| Enabled | Indicates whether the breakpoint is enabled or disabled. |
| Installed | Indicates whether the breakpoint has been loaded in the JVM for debugging. |
| Class | Points to the loaded class that the breakpoint is within. For Example, ```java.lang.String``` |
| Class Loader | The class loader that the targeted class belongs to. For Example, ```org.apache.jasper.servlet.JasperLoader@44ffb20e``` |
| Resource | The location of the class file in the file system. For Example,  ```jar:file:/usr/lib/jvm/java-7-oracle/jre/lib/rt.jar!/java/lang/Thread.class``` |


If a breakpoint has been configured, it doesn't necessarily mean that
the class has been loaded or if it's enabled.

If there is an issue with the breakpoint, the icon will change to the
following:

![](/Data-insights/Features/Debugger/images/245552956.png)

The information button's locations section will also change to 'Issues',
and display information about issues with the breakpoint.

![](/Data-insights/Features/Debugger/images/245552938.png)

## Creating breakpoints

To create a new breakpoint you can click on the "New Breakpoint" button
on the top right of the **Debugger** page. A modal dialog will open
allowing you to specify the configuration for the breakpoint.

![](/Data-insights/Features/Debugger/images/245553003.png)

## Breakpoint triggers

The top part of the **New Breakpoint** dialog allows the user to specify
how this breakpoint should be triggered. This can be one of the
following:

-   Source Code File Name and Line Number
-   Exception Thrown / Caught
-   Field Access / Modification
-   Java Method Entry
-   ColdFusion Function Entry

### Source code file name & line number

A breakpoint can be configured to trigger when a specific **line**
number is **hit** in a source file. For this to work, you need to know
the source code file name and the correct line number.

Line numbers with **no bytecode** (like comments) will not trigger a
breakpoint.

For Java classes, the file name is normally the class name + .java. 
E.g. for `java.lang.String` the file name would be `String.java`

For CFML classes, the file name is normally the absolute path to the
cfm/cfc.  E.g.` index.cfm` would be
`/opt/coldfusion10/cfusion/wwwroot/CFIDE/administrator/index.cfm`.
Relative file names will work for CFML files.

### Exception thrown and/or caught

Finally code blocks will appear as a exception caught and re-thrown
which means that exception events may fire more than you expect. A
breakpoint can be configured to trigger when an exception is thrown or
caught. Simply enter the fully qualified exception name and whether it
should trigger on exceptions being thrown, and/or caught.

### Field access and/or modification

A breakpoint can be configured to trigger when **fields** are
**accessed** and/or **modified**. Simply enter the fully qualified class
name with the field name.  E.g. `java.lang.String.value` would monitor
the value field of the `String` class.

You can configure the trigger to fire on access, modification or both.

### Java method entry

Java Method Entry Breakpoints can **not** be configured for **Native
methods**. You will receive a **JVMTI** error in the FusionReactor
Production Debugger Plugin logs if you attempt to.

A breakpoint can be configured to trigger when a specific java method is
called. Simply enter the fully qualified class name with the method
name.  E.g. java.lang.String.toLowerCase would trigger when the
toLowerCase method is called.

### ColdFusion function entry

A breakpoint can be configured to trigger when a specific ColdFusion
function is called. Simply enter the absolute path to the cfc/cfm file
and the cffunction name.

## Conditional configuration

Conditional breakpoints will only fire if the condition evaluates to
either **true**, **none** **null** or **number** which is not zero.

The conditional breakpoint has access to the variables in the function
which is triggering the breakpoint. If a breakpoint is put in CFML code,
then the condition will be evaluated through the CF evaluate function.
All CF scopes are available as well as any additional Java local
variables in the breakpoint.

### Example

```java
    for ( int i = 0; i < 10; i++ ) {
      out.println( i );
    }
```

A condition breakpoint on line 11 with the following condition

```
i == 5
```

will only fire when the `int` variable `i` is `5`.

### Specials

There are some special variables which can be used for the specific
event types. These variables expose attributes from the trigger for the
condition.

#### Field access + modification variables

-   `__frFieldObject` - object whose field is being updated
-   `__frFieldValue` - current the field value

#### Field modification variable

-   `__frFieldNewValue` - new field value (which will be set)

#### Exception variables

-   `__frException` - the Java exception being thrown
-   `__frClassThrowing` - Java class throwing the exception
-   `__frMethodThrowing` - Java reflect method throwing the exception

## Rate Limiting

Breakpoints can be configured to disable themselves after being
triggered *n* times. Simply set the "**Fire Count**" setting to **1**
and the breakpoint will only fire once. The Conditional statement is
evaluated before the fire count check.

## Breakpoint Handlers

The breakpoint handler defines what operation should be performed once
the breakpoint has been triggered and all the preconditions (condition
and rate limit) have been met.

There are 4 supported handlers :

-   **Enable Interactive Debugger - Pause Thread**
-   **Generate Email Stack/Variable Event**
-   **Sampler Graph - Capture Event Data**
-   **Set Field Value**

### Enable Interactive Debugger - Pause thread

The interactive debugger allows you to pause and manually step through a thread’s execution, enabling you to observe variable values as the thread progresses. Any paused threads are displayed in the **Paused Threads** section of the [Debugger](https://Data-insights/Features/Debugger/Overview/) page.

The interactive debugger supports pausing a thread indefinitely or for a specific duration before automatically resuming. If you view the paused thread before the timeout expires, **the thread will remain paused indefinitely**, regardless of the initial timeout setting.

Additionally, the interactive debugger includes a thread rate limiter. You can choose whether to pause **all threads** (every thread that triggers a breakpoint) or **only one thread at a time** (only the first thread that hits the breakpoint).

For example, the following configuration will pause the thread for 60 seconds unless you view the thread in the debugger. It will trigger for all threads that hit the breakpoint.

![](/attachments/245552928/245552998.png)

### Generate email stack/variable event

Email alerts can be triggered when a breakpoint is hit. These emails contain detailed information about the transactions running on the thread, the thread’s status, the stack trace, and all available variables at the time the breakpoint was triggered. The format of this email is similar to the [crash protection email](Debug-Email-Alert.md).

Debugger email alerts also include specific details about the breakpoint that caused the alert, such as the exception being thrown or the field being accessed.

After an email is sent, the debugger can pause the thread in the interactive debugger. If this occurs, the email will include a link to the thread view of the request that paused in the debugger. The email will also indicate when the thread will resume, provided a timeout has been configured.

!!! note
    **Email Settings** must be configured in order to receive email alerts from the Production Debugger.
    
    
!!! info  
    [Email Settings](Settings.md)

### Sampler graph - capture event data

A breakpoint can be configured to generate a sample, enabling you to graph how often a specific breakpoint is triggered. This helps identify patterns in code execution and can highlight when certain issues occur. Once a breakpoint is set to trigger a sampler, the resulting graph will be available on the [Sampler Graphs](/Data-insights/Features/Debugger/Overview/#sampler-graphs) page. The graph series will remain until the breakpoint is deleted by the user.

### Set Field Value

A breakpoint which has been configured to trigger on field modification
can use the **Set Field Value**. This allows the user to override the
value which is being set.  In other words, if the field is set to null, then the
**Set Field Value** handler can be used to set a new non-null value.

## Breakpoints

### Editing breakpoints

![](/Data-insights/Features/Debugger/images/245552992.png)

You can edit the breakpoint by clicking the **Edit** button (the middle button). This opens the same dialog as the one used to create a new breakpoint.

### Breakpoint states - enabling/disabling & invalid

Breakpoints can be enabled and disabled by clicking the breakpoint icon,
to the left of the breakpoint name.

An enabled breakpoint can have one of the following icons:


- A **solid red square** ![](/Data-insights/Features/Debugger/images/245552962.png)
indicates the breakpoint is enabled and properly installed.
- A **broken red square** ![](/Data-insights/Features/Debugger/images/245552956.png) indicates an issue with the breakpoint. You can view the breakpoint's state, including any problems, by clicking the information button next to the breakpoint name.
- A **disabled breakpoint** is represented by this icon:   ![](/Data-insights/Features/Debugger/images/245552980.png)  

When the breakpoint is disabled, it will appear as shown:



![](/Data-insights/Features/Debugger/images/245552986.png)


### Deleting breakpoints

Breakpoints can be deleted by clicking on the red cross. 

!!! warning
    **This cannot be undone**.
