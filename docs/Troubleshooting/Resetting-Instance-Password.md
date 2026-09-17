# Resetting the password of a Instance

Resetting the password for the FusionReactor roles (Administrator, Manager, Observer) requires you to:
 1. Stop your Application Server
 2. Remove the password stored in the FusionReactor configuration file
 3. Restart the Application Server
 4. Input a new password.

!!! note
    This process will reset the password for a single instance of FusionReactor and must be repeated on each instance.

## Step 1: Stop your Application Server

In order to reset the password of FusionReactor, you are required to modify the configuration of FusionReactor. Doing so when
 FusionReactor is running can result in any changes you make being undone.

 For this reason you must first stop the Application Server.

## Step 2: Remove the password stored in the FusionReactor configuration file

If you are using the default installation path, you will be able to find your configuration at:

| Platform | Location |
| --- | --- |
| Windows | C:\FusionReactor\Instance\myInstance\conf\reactor.conf |
| Linux | /opt/fusionreactor/instance/myInstance/conf/reactor.conf |
| MacOS | /Applications/FusionReactor/instance/myInstance/conf/reactor.conf |

1. Open the configuration file in a text editor
1. Remove line user.{X}={Role} from the file
    * In your configuration file, configured users will look something similar to:
        ```
            user.2=Observer,observer,DFDA0D32069B96BF6C4EA352FEFFD1B2
            user.1=Manager,instanceadministrator,1D0258C2440A8D19E716292B231E3190
            user.0=Administrator,administrator,21232F297A57A5A743894A0E4A801FC3
        ```
    * In order to reset the password, these lines should be removed
1. Save the configuration file

## Step 3: Restart your Application Server

Now that the configuration has been saved you can restart your Application Server.

## Step 4: Input a new password

When you go to FusionReactor for the first time, you will be prompted to enter a new password for the Administrator user.

![New Password Dialogue](/Troubleshooting/images/Enter-New-Password.jpg)

You can then navigate to the Manage Users page to set passwords for your Manager and Observer Users.
