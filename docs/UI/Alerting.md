# Email Alerting

This documentation is going to provide you with all the information you
need about all the available **notifications** and **alerting** in
FusionReactor. This documentation is split up into 2 sections, the first
section is about the **Notifications** and the second section is about
**Alerting**.

Both sections contain examples with screenshots and the main goal is to
provide a better understanding of how these features can be configured
and used.

## Enterprise Dashboard

The Enterprise Dashboard contains a number of settings that can be used
in order to create notifications and can be accessed from both FRAM
(FusionReactor administrator manager) and the actual FusionReactor
instance but pressing the globe icon ![](/attachments/245548712/245548747.png)

Please note that the enterprise dashboard feature is only available for
an Enterprise and an Ultimate license.

If you click the small arrow near the globe icon and navigate to
**Settings**, there you can locate a couple of tabs where you can set
notifications. Some examples are listed below.

**Server Shutdown/Start Up Alerts:** You can generate a notification
when your server goes down or when you restart your server.

**Memory:** You can define percentage values of the memory status
(warning, critical) and notify the users when memory has reached an
upper limit based on your configuration.

**Average Request Time:** You can define the milliseconds that took from
a specific request. If the average runtime for this server has reached
the upper limit, then a new notification is going to be created.

**JDBC:** If the average JDBC execution time for this server has reached
the upper limit value, then a new notification is going to be created.

**Crash Protection:** If the number of protections triggered within the
last 60 seconds has reached the upper limit values, then a new
notification is going to be created.

**Slow Requests:** If the number of recent **Slow** pages has reached
the upper limit value, then a new notification is going to be created.

By upper limit we mean the **Critical** value that has been configured
in the settings above.

### Notifications

FusionReactor also provides the ability to create notifications of your
choice. At the moment, notifications can be useful for the Administrator
to notify the other users of changes to settings that have occurred, of
give them warnings. Below you can see a simple example of creating a new
notification.

1.  Access FRAM or the FusionReactor instance.
2.  Click the Notifications button, ![](/attachments/245548712/245548741.png)
3.  Navigate to "Create Notifications".
4.  Create a notification of your choice an press the "Create
    Notification" button.

![](/attachments/245548712/245548753.png)

In the notifications dashboard, you should be able to see your new
notification. See screenshot below.

![](/attachments/245548712/245548759.png)

More information about the notifications can be found here,
[Notifications](Notifications.md).

### System Resources

More system notifications can be found under the **System Resources &gt;
System Resources Settings**. There you will be able to find two tabs,
**Disk **and **CPU**.

![](/attachments/245548712/245548723.png)

As previously mentioned in the Enterprise Dashboard section, you have
the ability to enable notifications based on the values that you want.
More information about the System Resources Settings can be found here,
[System Resource Settings](../System-Resources/Settings.md)

### FusionReactor Deadlock Detector Plugin

The FusionReactor Deadlock plugin polls all Java threads running in the
JVM that your server is running on every 30 seconds. Any Java thread
deadlocks detected are written to a log file and a Notification is
created for that particular deadlock. If the plugin detects a deadlock,
a notification will be created and will contain any relevant information
about the deadlock. More information can be found here,
[FusionReactor Deadlock Plugin](../Plugins/FusionReactor-Deadlock-Plugin.md)</a>.

## Email Alerting

FusionReactor provides you with the feature of email alerting. The email
alerting feature is useful for unattended monitoring via Protection and
is a way to protect your server from various types of load. For example,
you can protect your server from excessive numbers of requests that all
being run at the same time. Also, you can protect your server from
individual requests running for long periods of time and finally, you
can protect your server from requests running when the server is low on
memory. FusionReactor can notify you when any of the above occur using
an email and a FusionReactor Notification.

So, why enabling email alerting? Some of the reasons are listed below.

### Easing Support:

Crash Protection automates the manual process of checking each of your
servers and verifying that they are operating within satisfactory
parameters.

### Request Bursts:

If you have a server which receives bursts of requests all at once,
FusionReactor can using queuing spread that load out over time and so
protect your server from becoming overwhelmed.

### Preventing Crashes:

If you periodically have very resource consuming jobs running,
FusionReactor can stop new requests being run which could potentially
cause the server to become unstable.

### During Development:

If you need to write a page which cannot use more that a fixed amount of
the system resources, crash protection is a good way of tracking where
and when you have problems.

## How can I enable the Crash Protection alerting?

You can access the Crash Protection Settings by following the steps
listed below.

1.  Access your FusionReactor instance.
2.  Navigate to **Protection &gt; Settings.**
3.  There you should be able to locate three main tabs;
    1. WebRequest Quantity Protection
    2. WebRequest Runtime Protection
    3. WebRequest Memory Protection.

Based on your needs and your environment, you have the ability to
configure these options. More information can be found in [Protection Settings](../Crash-Protection/Settings.md).

In order to enable to Crash Protection email alerting, you need to
navigate to **Protection &gt; Settings &gt; Email Settings.** There you
should be able to find the screenshot below.

![](/attachments/245548712/245548735.png)

In the Notification Emails field, you need to change the value to
"**Enabled**" and press the "**Save FusionReactor Settings**". In order
to receive the Crash Protection emails, you also need to configure your
mail server in the general setting of FusionReactor. You can do that by
following the steps listed below.

1.  Access the FusionReactor instance.
2.  Press the small arrow near the FusionReactor icon, ![](/attachments/245548712/245548729.png)
3.  Navigate to **Settings &gt; Email Settings.**

The next step is to configure your mail server settings and after the
configuration ends, you can test the connection to your email server by
pressing the "**Send Test Email** " button. If the configuration is
successful, you should be able to see a green message on the top right
corner of your screen and you should receive the test email. If the
configuration is not successful, the a red error message is going to
appear on the top right corner of your screen. In order to troubleshoot
the issue, please make sure that the mail server setting are correct.
More information about the Email Settings can be found [here](../Settings/Main-Menu.md).
