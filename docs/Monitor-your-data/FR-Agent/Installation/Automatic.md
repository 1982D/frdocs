# Automatic installation

FusionReactor can be installed using either a full installer (recommended) or preconfigured archives. The full installer includes a Java Runtime Environment (JRE) and provides options for customizing the installation path, runtime user, password, and port. Preconfigured archives require an existing JRE on your server and use default settings.

## Download options

* Full Installer (Recommended): [Download](/Latest-updates/Downloads/) directly from the FusionReactor download page or use the direct links below:
    * [Windows](https://download.fusionreactor.io/FR/Latest/FusionReactor_windows-x64.exe)
    * [Linux](https://download.fusionreactor.io/FR/Latest/FusionReactor_linux-x64.sh)
    * [MacOS](https://download.fusionreactor.io/FR/Latest/FusionReactor_macos.dmg)

* Preconfigured Archives: Available as a Windows zip file and a Tarball for MacOS and Linux. These assume default configurations and require your own JRE.

![!Screenshot](/Monitor-your-data/FR-Agent/Images/Full-Installer-download.jpg){  width="350" height="250" } 

![!Screenshot](/Monitor-your-data/FR-Agent/Images/Pre-Configured-Installers.jpg){  width="350" height="250" } 
    



Both the full installer and preconfigured installations include the FusionReactor Administration Manager (FRAM), and the setup typically takes only a few minutes.




## Using the full installer
There is a separate installer for each support platform.

!!! note
    As of FusionReactor version 8.1.0, 32-bit installers are no longer available. For 32-bit systems, please refer to the [manual installation guide](/Monitor-your-data/FR-Agent/Installation/Manual/).

| Platform | Installer name | To run |
| --- | --- | --- |
| Windows |FusionReactor_windows-x64.exe | Run FusionReactor_windows-x64.exe as an Administrator user |
| Linux | FusionReactor_linux-x64.sh | Run FusionReactor_linux-x64.sh as root |
| MacOS | FusionReactor_macos.dmg | Run FusionReactor_macos.dmg as root |

The installer must be executed with elevated privileges (Administrator/root). Insufficient permissions will cause the installer to exit with a warning. Only one instance of FusionReactor can be installed on a single server.



## Installation steps
Running the installer for the first time, you will have the option to configure your installed FRAM (FusionReactor Administration Manager) service. You can only have one copy of FusionReactor installed on a single server.


1.  **Welcome:** The installer starts with a welcome screen. Click **Next**.

    ![!Screenshot](/Monitor-your-data/FR-Agent/Images/Full-installer-welcome.jpg){ width="350" height="250" } 

2.  **License Agreement:** Review the agreement, select "**I accept the agreement**", and click **Next**. Clicking **Cancel** will exit the installer.

    ![!Screenshot](/Monitor-your-data/FR-Agent/Images/Full-installer-license-agreement.jpg){ width="350" height="250" }

3.  **Destination Directory:** Choose the installation directory. Default paths are:

    | Platform  | Default Path                             |
    | :-------- | :--------------------------------------- |
    | **Windows** | `C:\FusionReactor\Instance\myInstance`   |
    | **Linux** | `/opt/fusionreactor/instance/myInstance` |
    | **MacOS** | `/Applications/FusionReactor/instance/myInstance` |

    Click **Next** to continue.

    ![!Screenshot](/Monitor-your-data/FR-Agent/Images/Full-installer-directory.jpg){ width="350" height="250" }


4.  **FusionReactor Configuration (Port):** The default HTTP port for the FusionReactor Administrator is 8087. The installer checks for availability. Click **Next**.

    ![!Screenshot](/Monitor-your-data/FR-Agent/Images/Full-installer-port.jpg){ width="350" height="250" }

5.  **FusionReactor Configuration (Password):** Set the password for the Administrator user and confirm it. The password must be at least five characters and match the confirmation.

    ![!Screenshot](/Monitor-your-data/FR-Agent/Images/Full-installer-password.jpg){ width="350" height="250" }

6.  **(Linux/MacOS Only) FusionReactor Configuration (Runtime User):** Specify the user and group for the FusionReactor daemon. It's recommended to use the same user and group as your application servers. Click **Next**.

    ![!Screenshot](/Monitor-your-data/FR-Agent/Images/Full-installer-unix-runtime-user.jpg){ width="350" height="250" }

7.  **Confirm Settings:** Review your configuration. On Windows, you can choose to create a desktop shortcut and start the FRAM service after installation.
    ![!Screenshot](/Monitor-your-data/FR-Agent/Images/Full-installer-confirmation.jpg){ width="350" height="250" }

    !!! tip
        Deselect **Create Desktop Shortcut to FusionReactor Administration Manager** to skip shortcut creation.

    !!! tip
        Deselect **Start FusionReactor Service** if you prefer to start FRAM manually later.

    Click **Next** to begin the installation, **Back** to modify settings, or **Cancel** to exit.

8.  **Installation Completed:** Once finished, the **Installation completed** screen appears. Click **Start configuring instances** or navigate to `http://{hostname}:{FRAM port}` to access the Instance Manager.

    ![!Screenshot](/Monitor-your-data/FR-Agent/Images/Full-installer-complete.jpg){ width="350" height="250" }

!!! warning
    Installing the FRAM service is only the first step. You must use the Instance Manager (accessible via the provided link or URL) to install FusionReactor onto your application servers. Refer to [Configuring a FusionReactor instance in FRAM](/Monitor-your-data/FR-Agent/Installation/FRAM/) for the next steps.


### Video guide

<div style="padding:56.25% 0 0 0;position:relative;"><iframe src="https://player.vimeo.com/video/930599280?badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479" frameborder="0" allow="autoplay; fullscreen; picture-in-picture; clipboard-write" style="position:absolute;top:0;left:0;width:100%;height:100%;" title="Quick and Easy Installation of FusionReactor Administration Manager (FRAM) on Windows"></iframe></div><script src="https://player.vimeo.com/api/player.js"></script>

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.