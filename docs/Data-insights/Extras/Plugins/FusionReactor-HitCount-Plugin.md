title: HitCount
# FusionReactor HitCount Plugin


The HitCount Plugin is a relatively new plugin that was introduced in
6.2.0 version of FusionReactor and is responsible for tracking the
overall application and database performance. It's worth stating that
the HitCount Plugin is only available with an Enterprise/Ultimate
license.

The HitCount Plugin is responsible for the existence of
the **Applications** page listed under the **Requests** section in the
FusionReactor UI.

More details about the Applications page can be found
here, [Applications)[../Requests/Applications.md].

Additionally, the Plugin can be found by navigating to **FusionReactor
&gt; Plugins &gt; All Bundles &gt; FusionReactor HitCount**
plugin. See screenshot below.

[![](/attachments/245548214/245548221.jpg)](/attachments/245548214/245548221.jpg)

## Initial Setup

The HitCount Plugin is **enabled by default** and the users with an
Enterprise/Ultimate license will be able to see data in the Applications
page without the need of any initial configurations.

## Configuration

In versions prior to 6.2.5, the HitCount Plugin wasn't configurable and
the users weren't able to control the collected amount of data. For that
reason, the development team allowed further configuration of the plugin
in the FusionReactor UI.

[![](/attachments/245548214/245548236.png)](/attachments/245548214/245548236.png)

The FusionReactor HitCount Plugin Configuration is accessible by the
**"All Bundles" **area in the FusionReactor UI and allows you to alter
the following:

|||
|--- |--- |
|Max number of Application entries|This setting controls the maximum number of entries for the applications page.
The Default value is set to 1000.|
|Max number of Database entries|This setting controls the maximum number of entries for the database page.
The Default value is set to 500.|
|Max number of External Source entries|This setting controls the maximum number of entries for the external sources page.
The Default value is set to 250.|


If any changes will be implemented in the Configuration area of the
HitCount Plugin, please make sure that you click the "**Save
Configuration**" button in order to save all the changes made.

Please note that if for any reason you want to **stop** the HitCount
Plugin, this can be done by pressing the "Stop" button located in the
"**All Bundles**" area. It's worth stating that if the plugin s stopped
successfully, the "**Applications**" page will be removed from the
"**Requests**" section.

## Troubleshooting

This plugin creates a log file called **FusionReactor HitCount plugin
Log **which contains information on the status of the plugin, meaning
when it started, stopped, if there were any problems. Below is a table
explaining what all the attributes in the log file mean.

||||
|--- |--- |--- |
|Date (Formatted)|1|The date on which this log entry was written.|
|Time (Formatted)|2|The time on which this log entry was written.|
|Level|3|Log Level basically means the nature of the log, for example INFO means general information, where as ERROR means an error is being logged. SEVERE means something really bad has happened, this will be typically followed by the a generated exception.|
|Log message|4|Contains a message of an event that occurred such as logging that has started.|
