title: Overview
# User Interface Overview

When viewing the FusionReactor user interface, there are several
elements which appear on all pages, discussed below.

As for the various *features* of FusionReactor, as identified in the
following section (Table of Contents), each such feature is described in
detail in its own page of this documentation.

## Using the Table Of Contents (TOC)

The table of contents in FusionReactor provides information and links to
the various areas within it, as well as providing information on the
current status of FusionReactor.

|Icon|Name|Notes|
|--- |--- |--- |
|![](/attachments/245547453/245547570.png)|Metrics||
|![](/attachments/245547453/245547585.png)|Requests||
|![](/attachments/245547453/245547610.png)|Transactions||
|![](/attachments/245547453/245547671.png)|JDBC||
|![](/attachments/245547453/245547595.png)|UEM and Sessions||
|![](/attachments/245547453/245547580.png)|Resources||
|![](/attachments/245547453/245547739.png)|Profiler|Available in FusionReactor Ultimate or Developer Edition.|
|![](/attachments/245547453/245547761.png)|Debug|Available in FusionReactor Ultimate or Developer Edition.|
|![](/attachments/245547453/245547615.png)|Memory|Available in FusionReactor Ultimate or Developer Edition.|
|![](/attachments/245547453/245547605.png)|Protection||
|![](/attachments/245547453/245547590.png)|Logging||
|![](/attachments/245547453/245547745.png)|System Resources|Available in FusionReactor Enterprise, Ultimate or Developer Edition.|

## FusionReactor Menu

By clicking on the FusionReactor Logo, you are able to access the
FusionReactor Menu.

From this menu, you can set the various preferences that you want for
your FusionReactor.

![FusionReactor Menu](/attachments/245547453/245547755.png)

-   **Enable/Disable**: You can choose to turn
    on/off **WebRequest Tracking**, **User
    Experience Tracking**, and **FusionReactor
    external J2EE access** here.
-   **Plugins**: You can view the various
    configurations of plugins from here,
    including logs and the ability to turn off
    plugins.
-   **Settings**: You can modify the base
    settings of FusionReactor here including but
    not limited to **Email Settings**, **Web
    Root**, and **Instance Name**.
-   **Restrictions:** You can add **filters for
    request tracking** at this page. See [Filter Restrictions](/Data-insights/Features/Settings/Filter-Restrictions/)
-   **Change Password**: Change passwords and
    add passwords for the Observer, Manager, and
    Administrator accounts here.
-   **Logs:** A UI-view of the current logs.
-   **About:** Takes you to the **FusionReactor
    About page,** explaining your **license
    information** and **FusionReactor version.**
-   **Help:** Links you to the **FusionReactor Documentation**.
-   **Log Out**.


For additional details on these elements of the main FusionReactor menu,
see the next page in this documentation on the
[Main Menu](/Data-insights/Features/Settings/Main-Menu/) settings,

## Notifications

![](/attachments/245547453/245547509.png)

Notifications created by the [Notifications
Plugin](Notifications.md) in FusionReactor are shown here.
There are three types of notifications - INFORMATION,WARNING and ERROR.

If you click on the Notifications icon, you will open a menu with two
options:

- [Create Notification](Notifications.md#create-notification) : Here you can create a new notification.
- [Notifications](Notifications.md) : View all notifications.

## License Banner Notifications

The License Banner Notification can be displayed in FusionReactor and
FusionReactor Administration Manager. The license banner notification is
a new feature and is based upon the currently existing notification
service but with the added emphasis of appearing as a banner on every
FusionReactor page. Therefore, it shares similar functions, abilities,
and looks, as notifications when viewed.

The system that works out which banner is to be displayed is based on
the banner severity and the time it was created. Therefore, any banner
with severity of INFORMATION can
be overwritten by a WARNING and
these can be overwritten by a ERROR banner. When
in this state any banner that comes after the ERROR banner will
**ONLY** be displayed if it is of severity ERROR and has
a **newer creation date**. However, once a banner is marked as read it
will display the previous banner working in a sequential order until you
get back to the first banner created. 

Only the license system in FusionReactor, can create license
notification banners automatically. This service will display the
following banners dependent upon which has occurred :

|Banner Title ( X is time left on license )|Banner Severity|Reason|
|--- |--- |--- |
|License Expires in X Days/Hours/Minutes/Seconds|WARNING|License is expiring when 14 or less days are left on the active license|
|Maintenance Expires in X Days/Hours/Minutes/Seconds|WARNING|Maintenance license is expiring when 14 or less days are left on the active license|
|Trial License|WARNING|Trial license is active|
|License Deactivated|ERROR|License is deactivated|


When you click on the banner you will get a dialogue box under the
banner which contains :

-   The Banner notification title
-   The Banner notification message
-   'Mark as Read' button
-   'Okay' button 

The Mark as Read button will mark the license banner notification as
read, no longer displaying the banner in the Table Of Contents.

The Okay button will dismiss the message, keeping the banner visible in
FusionReactor.

**Below:** FusionReactor displays a
license expiry banner 13 days before expiration, with its drop-down
message box.

![](/attachments/245547453/245547502.png)

## Enterprise Dashboard

This is only available in **FusionReactor Enterprise Edition or higher**

![](/attachments/245547453/245547496.png)

The Globe Icon is used to access the [Enterprise Dashboard](/Data-insights/Features/Enterprise-Dashboard/Enterprise-Dashboard/) in FusionReactor. This
contains information about any other FusionReactor instances you are
monitoring for other application servers at this location.

The notification counts on the Enterprise Dashboard logo indicate the
total amount of notifications of each type that are unread at every
monitored instance.

If you click on the Enterprise Dashboard icon, you will open a menu with
four options:

-   **Dashboard:** Go to the **Enterprise Dashboard**. **  
    **
-   **Manage Servers:** Go to the **Manage Servers** page. At this page,
    you can add new servers to monitor or edit the details of existing
    ones.
-   **Manage Groups:** Go to the **Manage Groups** page. At this page,
    you can configure groups in which servers can be added to.
-   **Settings:** Go to the **Settings** page. At this page, you can
    configure your preferences for the Enterprise Dashboard.

#### Instance Management

![](/attachments/245547453/245547490.png)

To the right side of the top-menu, there will be the name of your
current instance. If you have online instances in the Enterprise
Dashboard, you will be able to click on this button to open a list of
your Enterprise Dashboard instances. 

If you click on one of these links, you will be directed to the
FusionReactor web page for that instance.

## Debug

This is only available in **FusionReactor Ultimate
Edition.**

![](/attachments/245547453/245547484.png)

With the addition of in FusionReactor 6, there is a now an alert that
appears on the top menu when a thread is paused by a breakpoint being
triggered in the [Production Debugger](/Data-insights/Features/Debugger/Overview/). If you
click on this icon, you are redirected to the
[Debugger](/Data-insights/Features/Debugger/Overview/) page to further debug.

## Home Button

![](/attachments/245547453/245547478.png)

By clicking on the Home icon in the top-right, you will be redirected to
your chosen Homepage (if you have no configured one, this will be the
About page).

To configure your chosen home page:

-   Go to a page with a  ![](/attachments/245547453/245547786.png)
    button. This button will be in the top-right corner of the page.
    Pressing this button will configure your home page to be this page

Not every page can be specified as a home page. Only pages with the

![](/attachments/245547453/245547786.png)
can be configured.

## Cloud Status

The Cloud Status icons are only shown in a Cloud-licensed FusionReactor.

The Cloud status indicator appears to the left of the clock.  The
indicator shows you the current status of the instance's connection to
OpsPilot.

When a Cloud license is installed, FusionReactor will attempt to make
two connection to the Cloud:

-   A **Control Channel **connection, which enables OpsPilot
    to interact directly with this instance.  This allows FusionReactor
    to provide immediate responses to requests for data:  running
    transactions, stack traces etc.
-   A **Metric Transport** connection, which ships historical and
    statistical information to OpsPilot every minute.

|Icon|Status|Meaning|
|--- |--- |--- |
|![](/attachments/245547453/245547665.png)|OK|Both the Control Channel and at least one Datapack Transport are available and successfully connected.|
|![](/attachments/245547453/245547682.png)|Degraded|The Control Channel connection has failed, but at least one Metric Transport is successfully uploading periodic data. OpsPilot will show statistical data, but immediate requests for data will not run successfully, and may time out.|
|![](/attachments/245547453/245547682.png)|Degraded|The Metric Transport is failing to upload data, but a Control Channel connection is established. OpsPilot will not show any new statistical data while in this state.|
|![](/attachments/245547453/245547693.png)|Disconnected|Neither the Control Channel nor any Metric Transport could connect to OpsPilot.|

FusionReactor only starts attempting to transfer periodic information
one minute after startup.  If the Datapack Transport cannot connect, but
the Control Channel **is** able to connect, FR may show as **OK** for up
to a minute after starting up until the first datapack fails.

The Cloud menu item can be dropped down to allow access to:

-   **Configure Cloud**:  The user can turn on data obfuscation for data
    sent to OpsPilot, and enable **Class Decompiling**, which
    allows OpsPilot to request the source code for Java
    classes, where this is available.
-   **Open Cloud:**  Opens the OpsPilot application in a new
    tab or window.
-   **Status: **Shows the status of the two communications channels,
    along with some hints to problem resolution (where applicable) and a
    link to the manual page for the status, which is
    [here](/Monitor-your-data/FR-Agent/Agent/Cloud-Status/).

## Decompilation

Only **Manager** and **Admin** users can use de-compile. Decompile is
also **not** available over the J2EE channel (External Web Port) by
default.

Throughout FusionReactor when ever there are Java Class names or Method
names displayed, they are displayed as links. These links will open a
new modal that will display the decompiled code. In addition to single
Java Class names, if there is a Stack Trace, for example in the [Thread
details page](/Data-insights/Features/Resources/Threads/) the decompiler modal will allow
for easily walking up and down the Stack Frames to assist in navigation.

[![Decompiler UI](/attachments/245554957/245554969.png)](/attachments/245554957/245554969.png)

The top section of the modal contains the class name (and method name).
Then there is a large section that contains the decompiled code, in this
section the current line number is highlighted in light blue, and any
installed break points will be displayed in red. It is possible from
this page to install or remove break point by clicking in the gutter.

The bottom section of the modal contains the Stack Frames (Stack trace).
In here you can select the Java Class name (blue text) to decompile the
whole class, the method name (red text) to decompile only that method in
that Java class (be aware that if multiple methods with the same name
exist on the class all methods will be decompiled). You can also click
the file name/line number (green and purple text) to create a new break
point on that line and class.

Finally, there are 2 buttons (displayed as arrows) that allow you to
move the current selected frame up or down. These buttons will maintain
the current selection of method or class decompilation.

This utility can be used for any stack trace on FusionReactor, but the
most notable locations being:

- In **Resources** , on the viewing a thread
    details or choosing to kill a thread.
- In **Requests**, on viewing the **details of a Request that has an
    HTTP error Code.
- In **Debug**, when debugging a Paused Thread.
- In the **Profiler** view for any profiled thread or web request.

### External Web Server

If you are accessing FusionReactor over the external server and attempt
to decompile a class you will see the following notification:

[![Decompile Error](/attachments/245550524/245550539.png)](/attachments/245550524/245550539.png)

To enable decompilation over the external web server you must add a
system property to your JVM start up properties of your application
server. The system properties for decompilation are listed below.

|Property Name|Default Value|Values Accepted|Since|Description|
|--- |--- |--- |--- |--- |
|fr.decompile.external.enabled|false|true / false|6.0.0|This enables or disables the decompilation when requests come in over the external J2EE connection.|
