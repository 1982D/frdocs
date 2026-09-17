# Security

Debugging allows you to gain additional insight to troubleshoot and errors occurring within an application, but in order to do so it exposes information some may be uncomfortable with. Users with access to the FusionReactor UI can see both the application source code and state during runtime.

## What extra information does the Debugger give you?

### Scope variables

Access the runtime variables for all scopes within the tracked thread

![!Screenshot](/Data-insights/Features/Debugger/images/scope.png)

### The Debugger
The Production Debugger provides the ideal solution for developers to gain insight into how code executes at production runtime. With the Debugger, you have the ability to pause and step through code.

![!Screenshot](/Data-insights/Features/Debugger/images/thread.png)
![!Screenshot](/Data-insights/Features/Debugger/images/thread2.png)

!!! info "Learn more"
    [Debugger](/Data-insights/Features/Debugger/Overview/)

### Event Snapshots

Event Snapshots are generated for specific events that may occur whilst FusionReactor (FR) monitors your application.  Event Snapshots are intended to provide deep level insight whenever a problem, such as an exception or thread latency occurs.

!!! info "Learn more"
    [Event Snapshot](/Data-insights/Features/Debugger/Event-Snapshot/)


### Watches 

The ability to analyze and run functions on variables during runtime.

![!Screenshot](/Data-insights/Features/Debugger/images/watches.png)

## Requirements
You need the agentpath argument installed.

!!! info "Learn more"
    [Install Debug Library](/Monitor-your-data/FR-Agent/Installation/Manual/#step-2-download-the-fusionreactor-installation-files)

### How do I know if the agentpath argument is already enabled?

Navigate to the Debug page and if the agentpath argument is not enabled, the following information will be displayed: 

![!Screenshot](/Data-insights/Features/Debugger/images/debugmissing.png)


## How do I disable the debug capability?

### Within the UI

!!! note
    Be aware that anyone with administrator privileges can log in and turn the debugger back on at any time.

To disable the Debugger:

**Step 1**: Navigate to Debug **Settings** > **General**

**Step 2**: Disable the setting.

![!Screenshot](/Data-insights/Features/Debugger/images/config1.png)

To disable Event Snapshots:

**Step 1**: Navigate to Debug **Settings** > **Event Snapshot**.

**Step 2**: Disable the setting.

![!Screenshot](/Data-insights/Features/Debugger/images/config2.png)


### With Java arguments

!!! note
    If you disable the debugger using this method, it cannot be enabled without restarting and putting the arg back in.

To disable the debugger you need to take out the agentpath:

**Step 1**: Remove the JVM args starting with -agentpath.

**Step 2**: Restart the application server.

!!! note
    Disabling the debugger also disables snapshots.

!!! info "Learn more"
    [Uninstall Debugger](/Monitor-your-data/FR-Agent/Installation/Manual/#step-1-stop-your-application-server)







