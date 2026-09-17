# How to enable and disable FusionReactor

🔎**Find it**: **FusionReactor** > **Enable/Disable**

To **enable** or **disable** parts of FusionReactor, simply select the
FusionReactor dropdown located in the top left hand corner of the FusionReactor UI. 

![Screenshot](/Troubleshooting/images/enabledisable.png)

The following screen is displayed:

![Screenshot](/Troubleshooting/images/enabledisable2.png)

This page contains three different **Enable / Disable** settings.

|Configuration|Description|Default|
|--- |--- |--- |
|**FusionReactor WebRequest Tracker**|If **disabled**, FusionReactor will no longer track WebRequests or User Experience Management (UEM) data. JDBC Requests and other transaction types will still be tracked.<br>(Note: The FusionReactor UI will still be available over the external web server)|Enabled|
|**FusionReactor User Experience Management Tracker**|If **enabled**, User Experience Management (UEM) data will be processed, even if external access to the FusionReactor UI is disabled.<br>If **disabled** UEM data will not be processed by FusionReactor.<br>(Note: See additional documentation for Using UEM with an external web server.)|Enabled|
|**FusionReactor UI access on the external web server**|If **enabled**, the FusionReactor UI will be accessible over the external web server.<br>If **disabled** the FusionReactor UI will not be accessible externally, however metrics will still be tracked and the FusionReactor UI will still be available over the internal server (if configured).|Enabled|

## Need more help?

<div style="padding: 15px; border: 1px solid transparent; border-color: transparent; margin-bottom: 20px; border-radius: 4px; color: #3c763d; background-color: #dff0d8; border-color: #d6e9c6;"> Contact support in the chat bubble and let us know how we can assist. </div> 