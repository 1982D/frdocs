# How to use FusionReactor via an external web server 

FusionReactor can be used via an external web server, like IIS or Apache. (This refers to the FusionReactor UI as implemented for monitoring your application server, such as ColdFusion, Lucee, Tomcat, JBoss, etc. It cannot typically be used to connect to the FRAM instance, as will be discussed below.)

By default, the FusionReactor UI for monitoring your application server might be accessed as http://127.0.0.1:8088/fusionreactor/findex.htm, but both that IP address and port may not be accessible from a browser off the server itself due to firewall configuration.

!!! note 
    You can typically ALSO access that FusionReactor UI via an external web server, by default, simply by changing the URL to cause it to be processed by that external web server and passed to to your application server. This is assuming you visit a site which has been configured in that web server to pass requests to your application server. 
    
#### Example:

If your web server has been configured so that requests to your site are passed to ColdFusion, then any request for a CFM file extension is passed by that web server to ColdFusion. Assuming that ColdFusion instance is configured to be monitored by FusionReactor, you could access FusionReactor (even from off the server) by changing that FusionReactor URL above just slightly. 

**Step 1:** Remove the port (the 8088 port above points the request to FusionReactor's internal web server). 

**Step 2:** Change the IP address to whatever you need to access the web server site (domain or IP address).

**Step 3:** Add the ".cfm" extension after the word "fusionreactor" in the URL, as in http://[yoursitedomain]/fusionreactor.cfm/findex.htm or http://[youripaddress]/fusionreactor.cfm/findex.htm.

As a working example, notice that the FusionReactor live demo site can be accessed this way: http://demo.fusion-reactor.com/fusionreactor.cfm/findex.htm. 

!!! note 
    While the demo page does not prompt for a password, your default installation of FusionReactor WOULD of course prompt the user for the FusionReactor password.

If you have security concerns about exposing the FR interface via your external web server (even with a password required), this capability of using FusionReactor via an external web server can be enabled or disabled via the **FusionReactor Menu**. It's also presented as an option while configuring a new instance in the FRAM **Instance Manager**.

#### Why can't this be used to access the FRAM instance?

 Because you wouldn't have a site in your external web server configured to pass requests to the FRAM instance, the way you would for your application server. FRAM comes preconfigured with its own built-in web server (accessed at port 8087, by default). If you want to open that web server publicly, you could modify underlying configuration files to choose perhaps a public port.

 !!! note
     You can't have more than one web server listening on a single port (port 80, for instance).

## Configure Web Root & URI Matching

🔎**Find it**: **FusionReactor** > **Settings** > **Web Root**

There are optionally configurable aspects of this feature using the [Web Root](/Data-insights/Features/Settings/Main-Menu/#webroot) and [URI Matching settings](/Data-insights/Features/Settings/Main-Menu/#webroot) in the FusionReactor Settings page, as discussed below.


 ![Screenshot](/Troubleshooting/images/webroot.png)
### Web Root

The first setting here is **Web Root**. This is the root path for FusionReactor requests (whether accessed via an external web server or FusionReactor's own web server). The default web root value is /fusionreactor, but this could be changed, if you prefer. For example, changing this **Web Root** setting to /this/is/fusionreactor will make FusionReactor available from the path http://127.0.0.1:8088/this/is/fusionreactor.

### URI Matching

The next setting controls the file extension (.cfm, .jsp, etc.) which would be used when accessing FusionReactor via the external web server, as discussed at the top of this page. You would use this extension by your appending the **URI Matching** string to the end of the **Web Root**.

## Using UEM via an external web server

When using UEM via an external web server, there are additional considerations. 

!!! info "Learn more"
    [UEM manual](/Data-insights/Features/UEM/User-Experience-Monitoring/#script-examples#using-uem-with-an-external-web-server).
