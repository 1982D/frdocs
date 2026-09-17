title: Overview
# Plugin Overview

## Plugins

 - [AMF Dissector](FusionReactor-AMF-Dissector-Plugin.md)
 - [ColdFusion Line Performance Profiler](FusionReactor-ColdFusion-Line-Performance-Profiler.md)
 - [ColdFusion](FusionReactor-ColdFusion-Plugin.md)
 - [Deadlock](FusionReactor-Deadlock-Plugin.md)
 - [Heartbeat](FusionReactor-Heartbeat-Plugin.md)
 - [HitCount](FusionReactor-HitCount-Plugin.md)
 - [JRun](FusionReactor-JRun-Plugin.md)
 - [JSON Data Tracker](FusionReactor-Json-Data-Tracker-Plugin.md)
 - [Log Rotator](FusionReactor-Log-Rotator-Plugin.md)
 - [Log Tracker](FusionReactor-Log-Tracker-Plugin.md)
 - [Lucee and Railo Line Performance](FusionReactor-Lucee-and-Railo-Line-Performance-Plugin.md)
 - [Notification Generator](FusionReactor-Notification-Generator-Plugin.md)
 - [Production Debugger](FusionReactor-Production-Debugger-Plugin.md)
 - [Reports](FusionReactor-Reports-Plugin.md)
 - [System Monitor](FusionReactor-System-Monitor-Plugin.md)
 - [Transaction Logger](FusionReactor-Transaction-Logger-Plugin.md)

## Active Plugins

The Active Plugins page located at **FusionReactor &gt; Plugins &gt;
Active Plugins** lists all plugins that are active and currently running
on FusionReactor and the following information about them.

|Name|Description|
|--- |--- |
|Plugin Information|This contains a brief description of the plugin as well as the name of the jar file that is the plugin.|
|Version|The version of the plugin as well as the name of the plugin.|
|Type|Lists the bundle framework (OSGi) and the type of plugin.|
|Actions|Logfile: Contains information about when the plugin was started up and shutdown.<br>Configuration: Clicking this allows you to configure the plugin.  Refer to the individual plugin definitions for details regarding Plugin configuration|


## OSGi
FusionReactor uses an OSGi based plugin architecture to enable new
features to be seamlessly deployed.  This architecture allows us to
deploy plugins (coming in the form of bundles for deployment), which can
be remotely installed, started, stopped, updated and uninstalled.

### OSGi Bundle Inventory

|Name|Description|
|--- |--- |
|Bundle Information|Contains a link to a website which contains further information about the bundle, a brief description of the plugin and the name of the jar file that is the bundle.|
|Version|Contains the version of the bundle as well as the name of the bundle.|
|ID|Contains the ID assigned to each bundle, the number can vary from execution to execution.|
|Type|Lists if the software is a bundle or a bundle and a plugin.|
|Start Level|Each bundle is executed starting from the lowest value to the highest.|
|Status|If the status reads ACTIVE then the plugin is running, if it reads RESOLVED it isn't running however it has the necessary files to be able to run.|
|Actions|Stop: Stops execution of the plugin.<br>Start: Starts execution of the plugin.<br>Logfile: Contains information about when the plugin was started up and shutdown.<br>Configuration: Clicking this allows you to configure the plugin, see the FusionReactor Plugins page for a guide on different plugin configurations.<br><br>Not all actions are available for all bundles.|


### OSGi Environment

|Name|Description|
|--- |--- |
|Framework|The framework that the OSGi uses.|
|Started|The date when the OSGi environment began execution.|
|Current Run Level|The current run level.|
|Properties|Various properties about the OSGi environment, this is mostly used for debugging.  When technical support is required this information may be requested from you.|


### Status Log - osgi.log

As OSGi is responsible for the deployment of plugins this log contains
information relating to that as well as the state of OSGi itself. Below
is a table describing what all the attributes mean in the log file
(**osgi.log**).

|Field Name|Number|Description|
|--- |--- |--- |
|Date (Formatted)|1|The date on which this log entry was written.|
|Time (Formatted)|2|The time on which this log entry was written.|
|Level|3|Log Level basically means the nature of the log, for example INFO means general information where as ERROR means an error is being logged. SEVERE means something really bad has happened, this will be typically followed by the a generated exception.|
|Log message|4|Contains a message of an event that occurred such as logging that has started.|
