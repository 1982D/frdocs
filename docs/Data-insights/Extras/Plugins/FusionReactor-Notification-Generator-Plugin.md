title: Notification Generator
#FusionReactor Notification Generator Plugin

The Notification Generator plugin allows you to create notifications
whilst logged into FusionReactor. See
the [Notifications](/UI/Notifications/) page for
information on what a notification is.

## Usage

To create a notification navigate to **FusionReactor &gt; Notifications
&gt; Create Notification.**

|Field|Description|
|--- |--- |
|Notification Title|The notification title, for example it might be "The server is being shutdown"|
|Notification Type|The type of notification. Types include Information, Warning or Error. This allows you to communicate the intent of the notification to observers. For example if you were restarting your server you would set the Notification Type to Information.|
|Notification Message|The notification message, for example it might be "The server is being shutdown for maintenance"|


Once you are satisfied click the button titled Create Notification and
the notification will be created.

## Status Log - plugin-fr-notification-generator-plugin.log

The Notification Generator plugin creates a log file called
plugin-fr-notification-generator-plugin.log which contains information
on the status of the plugin, when it started, stopped and if there were
any problems. Below is a table explaining what all the attributes in the
log file mean.

|Field Name|Number|Description|
|--- |--- |--- |
|Date (Formatted)|1|The date on which this log entry was written.|
|Time (Formatted)|2|The time on which this log entry was written.|
|Level|3|Log Level basically means the nature of the log, for example INFO means general information, where as ERROR means an error is being logged. SEVERE means something really bad has happened, this will be typically followed by the a generated exception.|
|Log message|4|Contains a message of an event that occurred such as logging that has started.|
