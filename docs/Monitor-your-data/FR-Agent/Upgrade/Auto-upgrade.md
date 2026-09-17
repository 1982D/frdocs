# FRAM



<div style="padding:56.25% 0 0 0;position:relative;"><iframe src="https://player.vimeo.com/video/903320127?badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479" frameborder="0" allow="autoplay; fullscreen; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;" title="Step-by-step guide to upgrading your FusionReactor agent via FRAM"></iframe></div><script src="https://player.vimeo.com/api/player.js"></script>

Upgrading the full installer of FusionReactor requires you to download a newer version of the full installer and run the new installer on the server that currently has FusionReactor installed.

!!! note
    Upgrading the FRAM Service does not upgrade the instances of FusionReactor on your Application Server. This is done to prevent FusionReactor restarting your applications when an upgrade is performed. Go to the Instance Manager and upgrade [each instance](/Monitor-your-data/FR-Agent/Installation/FRAM/) individually.

If FusionReactor is not currently installed on the server, you'll be guided through the full installation process.

When running the installer, you'll first see a **Welcome** screen.

![](/Monitor-your-data/FR-Agent/Images/Upgrade-full-installer-welcome.jpg)

Clicking the **Next** button will proceed with the installation and open the **License Agreement** screen.

![](/Monitor-your-data/FR-Agent/Images/Upgrade-full-installer-license-agreement.jpg)

Carefully review the license agreement before continuing, then choose the **I accept the agreement** option (if you accept the terms and conditions) and click **Next** to proceed. 

Selecting **Cancel** if you do not accept the license agreement will exit the installer.

Clicking **Next** displays the FusionReactor **Update** screen. Here you can choose whether to start the FRAM Service after the upgrade is complete and add a Desktop shortcut (Windows only) for FRAM providing it does not already exist.

![](/Monitor-your-data/FR-Agent/Images/Upgrade-full-installer-confirmation.jpg)

Clicking **Next** will perform the upgrade then display the **Installation Completed** screen.

![](/Monitor-your-data/FR-Agent/Images/Upgrade-full-installer-complete.jpg)

___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.


