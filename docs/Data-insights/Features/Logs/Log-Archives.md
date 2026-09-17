# Log Archives

This page allows you to view FusionReactor log archives and perform various actions on the logs.

## Table Column Headings

|Name|Description|
|--- |--- |
|Archive File|The name of the archive file stored on disk.|
|Size|The size of the archive file (measured in megabytes)|
|Created|The date when the archive file was created.|
|Source|The name of the server that the logs are based on.|
|Archive Comment|If the text reads Don't Keep then that archive will be removed after a purge has taken place. If it reads Keep then the archive will remain on the drive after a purge has taken place. Simply click the text to change between the two.|
|Keep|If the text reads Don't Keep the archived will be removed from disk after the purge, if it reads Keep it will remain on disk after the purge has taken place.  To change it click on the text and will will change to the other option.|


## Table Buttons


Each row contains the following two buttons on the left hand side, the
effects of clicking them is described below.

|Button|Description|
|--- |--- |
|![](/attachments/245554491/245554511.png)|Clicking this will display additional information about the archive.  The page is split into two different sections, one contains information about the archive file and the other contains information about how the file was created. Below is two lists summarizing the key points from both sections of the page.<br><br>Top section:<br><br>Archive Filename : The absolute file path of the archive.<br>Original File: The name of the archive file.<br>Timezone: The timezone used by FusionReactor.<br>Date : Date the archive was created.<br>Source System : The software used to capture the files for the archive and to create it.<br>Subsystem : The software component within the Source System (FusionReactor) used to perform an action.<br>Message : This is a brief description of the action that the Subsystem performed.|
|![](/attachments/245554491/245554526.png)|Clicking this will remove the archive from FusionReactor and the machine that it is stored on.|


## Rotate Logs

Clicking Rotate Now generates a new archive containing all log data collected since the last archive. The archive is written to disk, and a fresh set of logs is created in the working log directory. All subsequent log entries are then written to these new logs.

## Purge Now

Clicking the Purge Now button will purge (remove) archives based on
rules that have be created by the user. Information about purging can be
found in the [Log Settings](Settings.md) section.

## Clear All Archives

To delete all archives, click **Clear All Archives**. You’ll be asked to confirm-select Yes to remove every archive from the instance’s archive folder.

!!! warning
    Make sure you are 100% sure before
    removing all archives as doing so may compromise your system.</span>

## View Logs From a Different Date


Using the date picker at the top of the page you can select to view the
logs from different dates.

## Download Log Archives

Archive downloading is enabled by default. Disable this option if you do not want log archives to be downloadable.

When enabled, the **Archive File** column displays a download link instead of plain text.

![](/attachments/245554325/245554352.png)

To download logs, right-click the link and choose Save Link As... (or the equivalent option in your browser).

 
