## Menu Settings

The FusionReactor Settings page lets you modify the FusionReactor in order to:

* Configure Email sending
* Configure Access to FusionReactor through specific ports and IP addresses
* Configure the log file size
* Secure the FusionReactor API
* Configure Application and Transaction name detection
* Configure FusionReactor to either track or ignore specific URLS
* Configure a proxy for FusionReactor to contact its external servers for licensing and the OpsPilot
* Configure which error types should be tracked in FusionReactor

!!! note
    These settings are specific to this instance of FusionReactor, but it is possible to copy these settings to a new instance
     by following [Copying FusionReactor Configuration Between Instances](/Monitor-your-data/FR-Agent/FAQs/Copying-FusionReactor-Configuration-Between_Instances/).

### Email Settings

|Configuration|Description|Default|
|--- |--- |---|
|From Address|This will be the email address from which FusionReactor will send the notification emails from. This address does not have to be a real email address but must follow the format ( Example : FusionReactor@FR.com )|N/A|
|To Address|This is the email address which will receive FusionReactor notifications emails. Multiple recipients can be entered, separated by commas.|N/A|
|Mail Server|You can specify an Internet address ( Example : mail.company.com ) or the IP address of the mail server ( Example : 127.0.0.1 ) <br> <br> This field must be filled correctly for FusionReactor to send mail. A blank field does NOT use your default mail server. NOTE: If your SMTP server does not use port 25 ( Default ), you can specify a port number after the server address / IP address ( Example : mail.company.com:587 )|N/A|
|Mail Server Username|If your SMTP server requires authentication, you can specify a username in this text box.|N/A|
|Mail Server Password|If your SMTP server requires authentication, you can specify a password in this text box.|N/A|
|SSL Authentication|Enable if the SMTP server uses SSL Authentication.|Disabled|
|TLS Authentication|Enable If the SMTP server uses TLS Authentication.|Disabled|
|Host Name|You can specify the DNS hostname of this instance to be used to generate URL links in email messages. If not specified, the canonical hostname will be used.|N/A|

Once you have set up your email settings you can send yourself a test
email. This is recommended to ensure the email settings are correct.

### WebRoot

|Configuration|Description|Default|
|--- |--- |--- |
|Web Root|This will be the prefix for FusionReactor requests. If the web root was set to "/fusionreactor/" and you were accessing the internal web server on a local machine over port 8088 then your final URL would look like this: http://127.0.0.1:8088/fusionreactor/|/fusionreactor/|
|URL Matching|The rule or which FusionReactor will match URI filters. .cfm This will allow FusionReactor to be mapped to a ColdFusion server over IIS or Apache. .jsp This will allow FusionReactor to be mapped to a JSP server over IIS or Apache. <br> <br> **Complete** -  This will match only the WebRoot, this will result in FusionReactor not working over IIS or Apache, for anything other than UEM. <br> <br> **StartsWith** This will match any URI filter used on the FusionReactor WebRoot. <br> <br> **Custom** - You can set your own filter here by typing into the field. This will map FusionReactor to that URI filter through IIS or Apache. If using .cfm/.jsp or similar FusionReactor will ONLY answer requests to that url. Example If using .cfm FusionReactor will only answer to /fusionreactor.cfm/|StartsWith|

### Internal HTTP


Please ensure that these settings are correct before you save. If these
settings are not correct you can make FusionReactor inaccessible!

|Configuration|Description|Default|
|--- |--- |--- |
|Enabled|If enabled then the HTTP server is active.|Enabled|
|HTTP Port|The port for the HTTP server to use. The default is 8088, or whatever is set via FusionReactor Administration Manager when the instance is installed|8088|
|Listen Address|The address for the HTTP / HTTPS servers to listen on. Use 0.0.0.0 to listen on all addresses.|0.0.0.0|

### Internal HTTPS

Please ensure that these settings are correct before you save. If these
settings are not correct you can make FusionReactor inaccessible!

|Configuration|Description|Default|
|--- |--- |--- |
|Enabled|If enabled then the HTTPS server is active.|Enabled|
|HTTP Port|The port for the HTTPS server to use.|-1|
|Key Store|The path to the keystore to use for the SSL certificate.|N/A|
|Key Store Password|The password for the key store.|N/A|
|Key Store Key password|The password for the key within the keystore.|N/A|
|Trust Store|The path to the trust store to use.|N/A|
|Trust Store password|The password for the trust store to use.|N/A|

### Instance Name

|Configuration|Description|Default|
|--- |--- |--- |
|Instance Name|This is the name of this FusionReactor instance, as it appears in the UI and Cloud. It may only contain the following characters a-z, A-Z, 0-9, _ . -|N/A|

### Log File

|Configuration|Description|Default|
|--- |--- |--- |
|Reactor Log|Choosing Enabled will allow FusionReactor logs to be written, choosing Disabled will prevent them from being written. For information on FusionReactor logs see the Reactor Log section.|Enabled|
|View Size (KB)|This option allows you to limit the number of KB of log that is displayed in the FusionReactor Log. For information on FusionReactor logs see the Reactor Log section.|128 KB|
|File Size|If the Logging Engine is set to 'Centralized Archive and Rotation' ( By default ) then this field does not appear. However, if the Logging Engine is set to 'Traditional Per-Log Rotation' then this value dictates then maximum size of the log before it is rotated.|10240 KB|
|File Count|As above, this value dictates the number of files held in the log history. An incoming log causes the oldest log to be deleted.|5|

FusionReactor API (FRAPI) Log Clients - Log File Settings

!!! note
    This setting will only appear when the [Logging Engine](Logging.md) is set to **'Traditional Per-Log Rotation'**

|Configuration|Description||
|--- |--- |--- |
|File Size|If the Logging Engine is set to 'Centralized Archive and Rotation' ( By default ) then this field does not appear. However, if the Logging Engine is set to 'Traditional Per-Log Rotation' then this value dictates then maximum size of the log before it is rotated.|10240 KB|
|File Count|As above, this value dictates the number of files held in the log history. An incoming log causes the oldest log to be deleted.|5|


### Application Naming

|Configuration|Description|Default|
|--- |--- |--- |
|Auto Application Naming|When enabled, the Application Name will be set by searching the following sources in order:<br> <br> * FRAPI.setTransactionApplicationName <br> <br> * Request attribute ( fr.application.name ) <br> <br> * Middleware server ( Example : CFAPPLICATION ) <br> <br> * Servlet init parameter ( fr.application.name ) <br> <br> * Filter init parameter ( fr.application.name ) <br> <br> * Web app context parameter ( fr.application.name ) <br> <br> * Web app context name ( display-name ) <br> <br> * Web app servlet context path <br> <br> * The Default Application Name|Enabled|
|Default Application Name|The Default Application Name. If Auto Application Naming is disabled, this name will be used for all transactions.|MyApplication|

### Transaction Naming

|Configuration|Description|Default|
|--- |--- |--- |
|Auto Transaction Naming|When enabled, the Transaction Name will be [Automatically detected](/Troubleshooting/Configuration/Transaction-Naming-Configuration/). |Enabled|
|Default Transaction Name|The Default Transaction Name. If Auto Transaction Naming is disabled, this name will be used for all transactions. |Ungrouped|
|Transaction Page Identifier Type |Enables manual page identification of transactions based specific URL parameters. This can be Disabled, Parameter or URL Element <br> <br> **Parameter** - This allows you to select a Request parameter as the transaction name. <br> <br>   **URL Element** - This allows you to select a section of the URL as the transaction name.|Disabled|
|Parameter Name|Parameter Name is visible when the Transaction Page Identifier Type is set to parameter. <br> <br> Set this to the parameter name that your framework uses to determine what page is being requested. <br> <br> [See Example](/Troubleshooting/Configuration/Transaction-Naming-Configuration/)|<Empty>|
|Enable SES Parameter|Enable this if you need to look for the name of the page in an SES style URL. <br> <br> [See Example](/Troubleshooting/Configuration/Transaction-Naming-Configuration/).|Disabled|
|SES Element Offset|SES Element Offset is visible when the Transaction Page Identifier Type is set to URL element.|1|

The transaction name (App/Txn) is made visible in various views, such as
the Transaction History

### Restrictions

|Configuration|Description|Default|
|--- |--- |--- |
|Restrictions|This value defines how FusionReactor Restrictions behave. <br> <br> Monitor requests that match the rules - By default, no requests will appear in FusionReactor. If a request matches one of the rules defined on the Filter Restrictions page then it will appear. <br> <br> Ignore requests that match the rules -  By default, all requests will appear in FusionReactor. If a request matches one of the rules defined on the Filter Restrictions page then it will be invisible.|Ignore requests that match the rules|

### FR-REST API Access

This is a HTTP based API that is used to communicate commands and
retrieve data from FusionReactor. This API allows FusionAnalytics
Connector system to send logs to FusionReactor Administration ( FRAM )

|Configuration|Description|Default|
|--- |--- |--- |
|FR-REST User|You can input the name of the FR-REST User here, you can change it as you please. It is also recommended that you also set a password, for help doing this see the section below.|restuser|
|Enable FR-REST API|Enable locally, no authentication : This enables the API to work on a local machine with no authentication.
Enable locally with authentication : This enables the API to work on a local machine with authentication. <br> <br> Enable globally, with authentication : This enables the API to work on a global machine (other machine in the network) with authentication. <br> <br> Disable : This disables the FR-REST API from working.


### Change FR-REST Password

|Configuration|Description|Default|
|--- |--- |--- |
|Old FR-REST Password|Enter the current password here. This option only appears if there is already a FR-REST password set.|N/A|
|New FR-REST Password|Type the new FR-REST password.|N/A|
|Confirm New FR-REST Password|Confirm the new FR-REST password.|N/A|

### Proxy Settings

Proxy Considerations

If the system properties http.ProxyHost or http.ProxyPort are set those
values will be used as a default Java proxy configuration options. To
override the configuration use the proxy configuration in the
FusionReactor Settings page.

|Configuration|Description|Default|
|--- |--- |--- |
|Proxy Enabled|Set to enabled to use a proxy server.|Disabled|
|Proxy Hostname/IP Address|Input the hostname or IP address of your proxy server.|N/A|
|Proxy Port|Input the port of your proxy server|1080|
|Proxy Authentication|Choose the Authentication type. Currently available are: <br> <br>  * Basic <br> <br>  * Digest <br> <br>  * NTLM|None|
|Proxy Username|Input the username required by your proxy server if authentication is applicable|N/A|
|Proxy Password|Input the password required by your proxy server if authentication is applicable|N/A|
|Proxy Domain|Used for NTLM authentication. The name of the windows domain to authenticate with.|N/A|
|Proxy Workstation|Used for NTLM authentication. The name of the workstation to authenticate as. This option is optional.|N/A|

### Error Exclusions

|Configuration|Description|Default|
|--- |--- |--- |
|Status Code Inclusions|A comma-separated list of integer ranges of which status codes to accept as errors.|500-599|
|Status Code Exclusions|A comma-delimited list of status codes. Ranges can also  be used. <br> <br>  i.e 400-410,500,505,510 FusionReactor will not flag up and/or track any status code you specify.|404|
|Exception Exclusions|A comma-delimited list of package identifiers. Wildcards can also be used. <br> <br> i.e java.lang.NullPointerException,java.util.* <br> <br>  FusionReactor will not flag up and/or track any exception you specify.|coldfusion.runtime.AbortException|
