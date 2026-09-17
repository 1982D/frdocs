# ColdFusion & databases

![!Screenshot](/Best-Practices/Installation/Images/CF guide.png)

## Step 1: Install FRAM (FusionReactor Administration Manager)

Install FRAM on your machine and then navigate to port 8087 to open the FRAM in your browser.

| Full installer | 
|  :---:  |
| [Windows](https://download.fusionreactor.io/FR/Latest/FusionReactor_windows-x64.exe) |
| [Linux](https://download.fusionreactor.io/FR/Latest/FusionReactor_linux-x64.sh)  |
| [MacOS](https://download.fusionreactor.io/FR/Latest/FusionReactor_macos.dmg) | <br>


<div style="padding:56.25% 0 0 0;position:relative;"><iframe src="https://player.vimeo.com/video/930599280?badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479" frameborder="0" allow="autoplay; fullscreen; picture-in-picture; clipboard-write" style="position:absolute;top:0;left:0;width:100%;height:100%;" title="Quick and Easy Installation of FusionReactor Administration Manager (FRAM) on Windows"></iframe></div><script src="https://player.vimeo.com/api/player.js"></script>
<br>

## Step 2: Install FusionReactor in Coldfusion using FRAM

!!! note
    Each instance of Cold Fusion requires one FusionReactor installed.

Use the auto discovery tool to scan your server and automatically locate your ColdFusion instances. Once FusionReactor is installed on each CF, data will be sent to the cloud automatically provided you have a Cloud Licence Key. 

 <div style="padding:56.25% 0 0 0;position:relative;"><iframe src="https://player.vimeo.com/video/928407289?badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479" frameborder="0" allow="autoplay; fullscreen; picture-in-picture; clipboard-write" style="position:absolute;top:0;left:0;width:100%;height:100%;" title="How to install a FusionReactor instance using FRAM"></iframe></div><script src="https://player.vimeo.com/api/player.js"></script>



!!! info
    If the auto discovery tool  doesn't pick up the instance you can then specify the file path to find it yourself.

!!! tip 
    This is a manual process so if you have over 100 servers,  we recommend manual  activation or [scripting](/Best-Practices/Installation/scripted1/) to install FR. to install FR.
<br>

## Step 3: Install the Observability Agent using FRAM

To monitor the machine running Coldfusion itself and any databases (eg Redis, MySQL, MSSQL etc) you need to use FRAM to install the Observability Agent. You can specify any external database or any database on the machine, it will support either and will automatically monitor the machine it is running on.  

!!! info
    This setup doesn't require enabling the OTel collector or log shipper in the Observability Agent.

<div style="padding:56.25% 0 0 0;position:relative;"><iframe src="https://player.vimeo.com/video/928407325?badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479" frameborder="0" allow="autoplay; fullscreen; picture-in-picture; clipboard-write" style="position:absolute;top:0;left:0;width:100%;height:100%;" title="How to install the Observability Agent using FRAM"></iframe></div><script src="https://player.vimeo.com/api/player.js"></script>



!!! note
    If you have more than one server, don’t monitor the same database multiple times as this sends excess data to the Cloud.

!!! info "Learn more" 
    [Observability Agent](/Monitor-your-data/Observability-agent/overview/)



