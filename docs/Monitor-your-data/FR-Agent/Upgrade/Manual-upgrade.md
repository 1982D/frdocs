# Manual



<div style="padding:56.25% 0 0 0;position:relative;"><iframe src="https://player.vimeo.com/video/903306705?badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479" frameborder="0" allow="autoplay; fullscreen; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;" title="Manual upgrade of FusionReactor agent"></iframe></div><script src="https://player.vimeo.com/api/player.js"></script>


Upgrading FusionReactor requires you to replace the FusionReactor installation files within your instance directory with the updated files. To do this you will need to follow these steps:

### **Step 1**: Stop your Application Server

JVM arguments for your Application Server are only read when the server / JRE (Java Runtime Environment) is started. For this reason we recommend that you stop your Application Server before adding or modifying any of your JVM arguments.

### **Step 2**: Download the latest FusionReactor installation files

The installation of FusionReactor requires a javaagent to run the core FusionReactor product when your application starts.

There is also a Debug library that can be optionally added for use of the **Debugger** and **Event Snapshot** features. 

!!! tip
    We recommend installing this argument if you have a trial, ultimate or developer edition to access the full functionality of FusionReactor.

Download the **fusionreactor.jar** file and **Debug library**, [here](https://www.fusion-reactor.com/download-fusionreactor/).


The debug library is a zip file containing the libraries for all supported platforms.

| Library | Platform |
|--- |--- |
| frjvmti_x64.dll | Windows |
| libfrjvmti_x64.so | Linux |
| libfrjvmti_x64.dylib | MacOS |


### **Step 3**: Replace the FusionReactor installation files for your instance
In order to replace the installation files of FusionReactor, you will need to navigate to the instance directory of your FusionReactor and replace both the fusionreactor.jar and debug lib files with the new versions you have downloaded.

If you are using the default installation path, the paths to your instance will be:

| Platform | Path|
|--- |--- |
| **Windows** | ```C:\\FusionReactor\Instance\myInstance``` |
| **Linux** | ```/opt/fusionreactor/instance/myInstance``` |
| **MacOS** | ```/Applications/FusionReactor/instance/myInstance``` |

### **Step 4**: Start your Application Server
Now that the files have been replaced, restart your application server and the newer edition of FusionReactor should be running.

You can confirm that the new edition is running either by examining the FusionReactor block in the application server log or by navigating to the about page of the FusionReactor instance and viewing the revision.
FusionReactor Block:

```
INFO Fusionreactor: --------------------------------------------------------------------------------------
INFO Fusionreactor: FusionReactor - Copyright (C) Intergral GmbH. All Rights Reserved
INFO Fusionreactor: Revision: {version} fusionreactor.xxxxx.xxxxx
INFO Fusionreactor: Date    :  {date}
INFO Fusionreactor: Java    :  {JRE Version}
INFO Fusionreactor: OS      :  {OS Information}
INFO Fusionreactor: --------------------------------------------------------------------------------------
```
Revision in the about page:

![Upgrade Complete](/Monitor-your-data/FR-Agent/Images/Manual-install-complete-version-info.jpg)

___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.