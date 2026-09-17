## User Settings

**User Settings** allows you to modify various elements and
behaviors relating to user experience. The page is broken up into
sections, each containing a table explaining the options that can be
chosen in drop down boxes or input into text fields.

## UEM

|Configuration|Description|Default|
|--- |--- |--- |
|UEM EndPoint Filter|The **UEM Endpoint Filter** can be used to set up the correct IIS/Apache filter for your UEM script files.|.cfm|

As a part of the User Experience tracking FusionReactor needs to serve a
JavaScript file to the clients browser. Due to the way the majority of
servers are setup they are not able to server JavaScript files from
behind the IIS or Apache servers without an ISAPI filter.

The **UEM Endpoint Filter** can be used to set up the correct IIS/Apache
filter for your UEM script files.

To use UEM in a web page all that is needed is the inclusion of a call
to the FusionReactor API (FRAPI) method *getUemTrackingScript*. 

!!! example
    [UEM script usage examples](/Data-insights/Features/UEM/User-Experience-Monitoring/#script-examples#script-examples)

## Sessions

|Configuration|Description|Default|
|--- |--- |--- |
|Enabled|Global switch for enabling or disabling session tracking.|Enabled|
|Track Session Per Application|Switch for enabling or disabling session tracking per application.|Enabled|
|Applications to track|Selection of applications to track session for.|Nothing Tracked|

!!! info "Learn more"
    [ColdFusion 10 ISAPI](http://help.adobe.com/en_US/ColdFusion/10.0/Installing/WSc3ff6d0ea77859461172e0811cdec18a15-7ffb.html) <br>
    [Tomcat ISAPI](http://tomcat.apache.org/connectors-doc-archive/jk2/jk/iishowto.html)<br>
    [IIS ISAPI](http://www.iis.net/configreference/system.webserver/isapifilters)<br>
    [Apache ISAPI](http://httpd.apache.org/docs/2.2/mod/mod_isapi.html)<br>



___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.

