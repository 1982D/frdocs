# How to configure email settings

To use features such as **Reporting**, **Debug** alerts, **Enterprise dashboard** alerts and **Crash protection**, first configure the email settings in FusionReactor.

 The settings in FusionReactor are per instance, so if you have five instances of FusionReactor they each have their own settings.
 
 To copy the configuration of FusionReactor from one instance to another:

!!! info "Learn more"
    [Copying FusionReactor configuration between instances](/Monitor-your-data/FR-Agent/FAQs/Copying-FusionReactor-Configuration-Between_Instances/). 
 
 With this approach you can configure one instance of FusionReactor then copy the configuration across all five instances.

## Configure email settings


**Step 1:** To configure the email settings in FusionReactor, access the [Email Settings](/Data-insights/Features/Settings/Main-Menu/#email-setting) by navigating to: **FusionReactor menu** (on the top left hand side) >  **Settings**.

![Screenshot](/Troubleshooting/images/settingsemail.png)

**Step 2:** Configure the SMTP settings for your chosen mail server. 


!!! tip
    To retrieve the SMTP configuration on most public mail servers, simply Google: *SMTP server gmail/gmx/outlook/etc...*.

 **Step 3:** Once your SMTP server details have been entered, save the settings and select **Send Test Email**.

 **Step 4:** Sending a test email, should display the following green banner:

  ![Email Success](/Troubleshooting/images/Email-success.jpg)
 
 You will now start to receive [Reporting](/Data-insights/Extras/Plugins/FusionReactor-Reports-Plugin/) and [Enterprise dashboard alerts](/Data-insights/Features/Enterprise-Dashboard/Enterprise-Dashboard/) and can configure [Crash protection](/Data-insights/Features/Crash-protection/Crash-Protection/) and [Email breakpoints](/Data-insights/Features/Debugger/Debug-Email-Alert/).



## What to do if the test email fails to send

![Email_Failure](/Troubleshooting/images/Email-Failure.jpg)

There are many reasons that sending an email from FusionReactor may fail, including:

* The protocol being used is incorrect
* The authentication credentials to the mail server are incorrect
* The mail server configuration is correct
* The mail server blocks emails from the specified from address

!!! warning
    FusionReactor is only able to detect a send failure if its attempt to send a mail to the SMTP server fails. 
    
    
It may be that we are able to send a mail to the SMTP server, but the mail server itself rejects the email. In this case we are unable to detect that the operation failed.

If this is the case we will show **Email sent successfully**, but the email may never arrive in your mailbox. Please contact your mail server administrator.

Any error FusionReactor sees when an attempt to send an email is stored in the [reactor.log](/Data-insights/Features/Logs/Files/Reactor-Log/). In this log file you will see the cause of the send failure and be able to diagnose what is stopping emails from being sent.

## Configuring Gmail with FusionReactor

If you are using Gmail either on a personal or business account, you can configure emails with a configuration similar to:

![Email Gmail Example](/Troubleshooting/images/Email-Gmail.jpg)

The fields from the screenshot above are represented in a table below:

| Field | Value |
|--- |--- |
| From Address | tomcat@myDomain.com |
| To Address | nyName@gmail.com |
| Mail Server | smtp.gmail.com |
| Mail Server Username | nyName@gmail.com |
| Mail Server Password | password |
| SSL Authentication | Disabled |
| TLS Authentication | Enabled |
| Host Name | Not specified |

!!! Note
    You may be required to enable less secure app access on your Google account. To do this, go to the security tab on your Google Account page, then scroll to the **Less secure app access** section.

## Need more help?

<div style="padding: 15px; border: 1px solid transparent; border-color: transparent; margin-bottom: 20px; border-radius: 4px; color: #3c763d; background-color: #dff0d8; border-color: #d6e9c6;"> Contact support in the chat bubble and let us know how we can assist. </div> 