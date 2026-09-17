# How to configure offline instance alerts

When instances are added to the **Enterprise Dashboard** either by [manually](/Data-insights/Features/Enterprise-Dashboard/Enterprise-Dashboard/#manage-servers) adding the server, or through the **Instance Manager** by [manually adding instances](/Data-insights/Features/Enterprise-Dashboard/Enterprise-Dashboard/#manually-adding-instancess), you will receive alerts in the form of emails if an instance becomes unavailable.

!!! note
    In order to receive these email alerts you must have the email settings for the instance correctly configured. 
    
!!! info "Learn more"
    [Email configuration guide](/Troubleshooting/Configuration/Email-Configuration/).

In order to detect if a server becomes unavailable, the **Enterprise Dashboard** uses a heartbeat mechanism. This means that by default it will attempt to contact the monitored FusionReactor instance, after three failed attempts we assume that the instance is no longer available.

It is possible to configure both the heartbeat settings and alert settings in the [Enterprise Dashboard Settings](/Data-insights/Features/Enterprise-Dashboard/Enterprise-Dashboard/)

![Screenshot](/Troubleshooting/images/serverstart.png)

Under **Server Shutdown/Startup Alerts** you can disable these alerts entirely, or specify whether to receive emails on shutdown only.

![ED Alert Setting](/Troubleshooting/images/ED_Alert_Setting.jpg)

Under **Heartbeat Settings** you can configure the heartbeat interval, timeout and failure threshold.

![Screenshot](/Troubleshooting/images/heartbeat.png)

While in most cases these settings should provide optimal alerts, it may be that at times your application server stalls and can stop serving requests for a limited time. For example, if a large Garbage Collection is occurring. When this happens it is possible to receive false alarms that your application is unavailable.

![ED Heartbeat Setting](/Troubleshooting/images/ED_Heartbeat_Setting.jpg)

!!! tip
    Increase the heartbeat interval or failure threshold to prevent these false alarms.

___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.