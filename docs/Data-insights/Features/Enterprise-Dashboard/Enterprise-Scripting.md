# Enterprise scripting

FusionReactor Enterprise scripting enhances FusionReactor's
Monitoring capability to enable scripts to be automatically triggered
**when a server's responsiveness status changes**.

!!! info 
    Enterprise scripting is available as part of the FusionReactor **Enterprise** or **Ultimate edition**.

This feature can be used to perform any task which can be launched from
a platform script. 

!!! example "Examples might include:"

    -   Interacting with SNMP or enterprise monitoring/reporting systems.
    -   Performing automated restarts of affected instances e.g. restarting Java or ColdFusion.
    -   Sending custom email messages.
    -   Writing custom log messages.

Since FusionReactor Enterprise scripting is able to launch any platform
executable (shell script, executable binary etc.), it may be tailored to
virtually any environment.

## Intended audience

This technical document is targeted at FusionReactor administrators who
are responsible for monitoring one or more FusionReactor servers using
the FusionReactor **Enterprise Dashboard**. This document will guide the
administrator through the new functionality, illustrating how and when
FusionReactor runs scripts, and the best practices and caveats involved
with automated scripting.

## Enterprise scripting on server state change

If an Enterprise script has been configured (on the Enterprise Dashboard
**Settings** page) - then it will be run (invoked) whenever the
Enterprise monitor detects that a monitored instance has changed state:

-   an instance which was previously available is no longer providing
    Enterprise data
-   an instance which was previously unavailable has begun to provide
    Enterprise data  

!!! note
    Scripts are run only if an instance changes state while it is being observed (monitored).

## Notification alerts & generate email following server startup/shutdown

FusionReactor can also send an email alert or issue a notification alert
if a server changes state.
 

1.  Go to the **Server Shutdown/Start Up Alerts** tab.

    ![](/Data-insights/Features/Enterprise-Dashboard/images/245549013.png)

    -   To send an email when an instance becomes
        unavailable, select **On Shutdown** on the **Send Alert Email** tab.

    -   To send an email when an instance becomes available, select **On Shutdown and Start Up**            
        on the **Send Alert Email** tab.



2.  The **Enable** option must be selected on the **Generate Notification** tab.

    ![](/Data-insights/Features/Enterprise-Dashboard/images/245549019.png)

## Operational impacts of scripting

There are a few points to consider when configuring scripting.

### System restarts & self-monitoring

If FusionReactor is configured to monitor itself, i.e. is monitoring the
same instance in which it is configured, scripting should **not** be
used for operations which affect this instance.  Because the order in
which FusionReactor's subsystems start up, FusionReactor may prematurely
fire a script while the 'self' instance is still starting up.

In these circumstances, we recommend transitioning your environment to a
**High Availability** monitoring solution.  This entails installing a
new J2EE server (Tomcat, for instance), and installing FusionReactor
into that.  This container will be used purely as a FusionReactor host,
and will be used to monitor other containers.

It may be necessary to create scripts which perform system reboots. 
Again, we recommend a careful evaluation of the impacts of this type of
script before implementation.  A script which restarts a system should
not attempt to restart the system on which the monitoring solution runs.

### Manual restarts

If a script is configured for a given instance, it will be fired when
that instance becomes unavailable.  FusionReactor does not differentiate
between overloaded (or failing) instances, and instances which have been
deliberately stopped. Therefore, if you stop an instance manually,
through Windows' Services panel for instance, FusionReactor will fire
the configured script. As an operational matter, the affected instances
should be **offlined** from FusionReactor **before** being shut down. 

!!! tip
    This can be done within the **Enterprise Dashboard**, by clicking the
    **+/-** button on the server icon:

    ![](/Data-insights/Features/Enterprise-Dashboard/images/245549049.png)

    ... or from within **Enterprise &gt; Manage Servers** by selecting the
    **Modify** icon for the affected server, then changing its **Status** to
    **Offline**:

    ![](/Data-insights/Features/Enterprise-Dashboard/images/245549044.png)

FusionReactor will not monitor these systems. When maintenance is
complete, the servers should be online again by reversing the process.

___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.