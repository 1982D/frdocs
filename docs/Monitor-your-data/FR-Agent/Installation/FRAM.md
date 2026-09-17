

# Using FRAM to deploy & manage instances

Once FRAM is installed, you can deploy FusionReactor instances to your application servers. Remember, FRAM itself isn't a full FusionReactor instance; it provides the **Instance Manager** and the [Enterprise Dashboard](https://www.google.com/search?q=../Enterprise-Dashboard/Enterprise-Dashboard.md) to facilitate instance deployment and centralized monitoring.

FRAM's primary purpose is to be used to install instances of FusionReactor on your Application Server and to host a dashboard where your FusionReactor instances are displayed.

## Discovering Application Servers



Before installing FusionReactor instances, the **Instance Manager** needs to detect your installed application servers. You can achieve this by using the **Scan System** feature within FRAM. This involves specifying:

 * **Root Scan Directory:** The starting point for the scan (defaults to `/` for Unix/Linux and `C:\` for Windows).

    !!! tip
        For faster scanning, specify the exact path to your application server's installation directory instead of the entire root.


 * **Scan Depth:** The number of subdirectories to explore during the scan.


    !!! tip
        Keep the scan depth low to minimize scanning time. Scanning the entire file system can be time-consuming.


!!! note
    Ensure the user account running the FRAM service has adequate permissions to access your application server's directory. Insufficient permissions will prevent detection.


During the scan, FusionReactor identifies application servers by looking for specific files. Upon completion, each detected server will be listed in the Instance Manager.


![](/Monitor-your-data/FR-Agent/Images/FRAM-system-scan-no-instances.jpg)


With your application servers now detected, you can proceed with installing FusionReactor.

## Configuring a FusionReactor Instance


To set up a FusionReactor instance on an application server, click the **plus** icon in the Instance Manager. This will open the instance configuration wizard.

### Configure Settings


![Image title](/Monitor-your-data/FR-Agent/Images/FRAM-install-configure-settings.jpg){ width="350" height="250" }

The first tab, **Configure Settings**, allows you to define the instance name and connection details:


 * **FR Instance Name:** Defaults to the application server's name but can be customized.
 * **FR Port:** The port for the [Internal Web Server](/Data-insights/Features/Settings/Main-Menu/#internal-http) (defaults to 8088 and increments if the port is in use).
 * **FR Address:** Optionally binds the FusionReactor port to a specific IP address. If disabled (default), it listens on all available addresses (0.0.0.0).
 * **External web server access:** Disables access to FusionReactor via the [External Web Server](/Data-insights/Features/Settings/Main-Menu/), restricting access solely to the [Internal Web Server](/Data-insights/Features/Settings/Main-Menu/#internal-http).

Click **Next** to proceed to the **Instance Password** tab.


### Instance Password


![](/Monitor-your-data/FR-Agent/Images/FRAM-install-password.jpg){ width="350" height="250" }


Here, you'll set and confirm the password for accessing the FusionReactor instance.

Clicking **Next** will take you to the [Enterprise Dashboard](/Data-insights/Features/Enterprise-Dashboard/Enterprise-Dashboard/) options.


### Enterprise Dashboard

Choose whether to immediately add this instance to your Enterprise Dashboard.

![](/Monitor-your-data/FR-Agent/Images/FRAM-install-enterprise-dashboard.jpg){ width="350" height="250" }


!!! note
    Select **No** if you intend to use the [Ephemeral Data Service](/Data-insights/Features/Enterprise-Dashboard/Enterprise-Dashboard/#ephemeral-data-service).


Click **Next** to access the **Options** tab.


### Options

![](/Monitor-your-data/FR-Agent/Images/FRAM-install-options.jpg){ width="350" height="250" }



This tab lets you configure how FRAM should start and stop the application server to integrate FusionReactor.

Where possible, FusionReactor pre-configures settings to automatically manage your application server for seamless integration. The available **start / stop** options are:

* Use the Windows / Linux service (FRAM will make a call to the service to start, stop or restart the service).

* Use the Application Server run command (FRAM will run the run command to start, stop or restart the Application Server).

* Manually start / stop the server (This option requires you to start and stop the Application Server yourself).


The **install / uninstall** options are:

* Automatically configure the Application Server config file (FRAM will inject the required java arguments into the Application Server configuration).

* Manual configuration (This option requires you to manually add JVM arguments to your Application Server config file).

!!! warning
    If you only have the option to manually start / stop the server and manual configuration this indicates that the FRAM user is unable to execute commands or modify files in the directory of the Application Server. 

   Ensure the user running the FRAM service can read and write to the directory of the Application Server to correct this.


The **restart** server option specifies whether your Application Server should be restarted after the jvm arguments have been configured.

!!! Warning
    It is important to understand that if your Application Server is running and you select ‘No’, the Application Server will be stopped and **NOT** restarted.


Clicking **Next** displays the **Confirm Settings** modal. If you click **Confirm** the instance of FusionReactor will be installed. If successful you will be redirected to the Instance Manager, where you will see a link to the FusionReactor instance.

![](/Monitor-your-data/FR-Agent/Images/FRAM-install-success.jpg)

If any error occurs during installation you'll see a **Start Failed** modal.

![](/Monitor-your-data/FR-Agent/Images/FRAM-install-error.jpg){ width="350" height="250" }

When FusionReactor attempts to start the instance, there is a timeout of 30 seconds in place, if your Application Server takes longer than 30 seconds to start, you may see **Start Failed** and as soon as the server comes online your server will then be running.


!!! tip
    Check the [Instance Manager log file](/Data-insights/Features/Logs/Files/Instance-Manager-Log/) to diagnose why the start command failed. Likely causes for this are:


   * There was a permissions issue starting the Application Server
   * The start up process timed out
   * There was No JRE specified for the Application Server


### Video guide


<div style="padding:56.25% 0 0 0;position:relative;"><iframe src="https://player.vimeo.com/video/928407289?badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479" frameborder="0" allow="autoplay; fullscreen; picture-in-picture; clipboard-write" style="position:absolute;top:0;left:0;width:100%;height:100%;" title="How to install a FusionReactor instance using FRAM"></iframe></div><script src="https://player.vimeo.com/api/player.js"></script>


## Upgrade the FusionReactor instance on your Application Server

Upgrading an installed instance of FusionReactor requires you to first upgrade the FRAM installation:

!!! info "Learn more"
    [Upgrade Full Installer](/Monitor-your-data/FR-Agent/Upgrade/Auto-upgrade/)



Once the FRAM instance has been upgraded, in the Instance Manager you will see an **Upgrade** button appear next to the **Stop, Start/Restart** and **Remove** buttons.


![](/Monitor-your-data/FR-Agent/Images/FRAM-upgrade-button.jpg)

!!! note
    In order to upgrade FusionReactor the Application Server must be restarted, you may need to schedule the upgrade at a period of time where downtime is allowed.


Clicking the **Upgrade** button triggers the upgrade process.

![](/Monitor-your-data/FR-Agent/Images/FRAM-upgrade-configure.jpg){ width="350" height="250" }


In the **Configure Instance** modal, you can specify whether to restart the Application Server.


!!! warning
    It is important to understand that if your Application Server is running and you select **No**, the Application Server will be stopped and NOT restarted.

Clicking **Next** and then **Confirm** upgrades FusionReactor and restart your Application Server.

![](/Monitor-your-data/FR-Agent/Images/FRAM-upgrade-success.jpg)


