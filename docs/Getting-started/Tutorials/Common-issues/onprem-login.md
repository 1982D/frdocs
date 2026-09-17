
# Resetting your On-Premise or FRAM login credentials


If you're unable to log in to the local **on-premise FusionReactor UI** or the **FusionReactor Administration Manager (FRAM)**, you can reset the admin credentials by modifying the instance configuration.


<div style="padding:56.25% 0 0 0;position:relative;"><iframe src="https://player.vimeo.com/video/1084583396?badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479" frameborder="0" allow="autoplay; fullscreen; picture-in-picture; clipboard-write; encrypted-media" style="position:absolute;top:0;left:0;width:100%;height:100%;" title="How to reset your on-premise or FRAM login credentials"></iframe></div><script src="https://player.vimeo.com/api/player.js"></script>

## Step-by-step instructions

### 1. Locate the installation directory

You'll need access to the **installation directory** of the FusionReactor instance you’re having trouble with.


- On Windows: `C:\FusionReactor\Instance\{instance name}\conf`

- On Linux: `/opt/fusionreactor/instance/{instance name}/conf`

Replace `{instance name}` with the name of your actual FusionReactor instance.

### 2. Edit the configuration file

- Inside the `conf` folder, locate the file: `reactor.conf`

- Open this file with a text editor, and remove any line blocks that begin with **user**.

!!! example
    user.admin.name=admin <br>
    user.admin.password=$2a$10$abcdef...

### 3. Save and restart
Once you've edited and saved the `reactor.conf` file, you must restart the instance for the changes to take effect:

!!! info 
    If you're resetting FRAM, restart the service: **FRAMD**. <br>
    If you're resetting a server instance, restart the application server or host machine that runs the instance.


### 4. Set a new password

After restarting:

- Go to the local FusionReactor login page.

- You will be prompted to set a new admin password.

- Follow the on-screen instructions to complete the reset.