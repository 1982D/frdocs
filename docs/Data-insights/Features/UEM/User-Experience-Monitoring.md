title: User Experience
# User Experience Monitoring (UEM)

UEM, or User Experience Monitoring  allows you to monitor the experience
of your users, by getting data on how long the request took to render on
the users browser and how long the request took to transfer to the
client machine, over the network. This data is visible on the requests
as a sub transaction.

![UEM Graph](/attachments/245551537/245551548.jpg)

The image above shows the UEM graph from a live server on the User
Experience page.

## User Experience

User Experience displays a graph of all tracked user experiences. </span>This uses a JavaScript function to track the load times and network time on the clients machine
and sends this information back to FusionReactor to be included as a
transaction on the responsible request. To use the UEM script it is
required to add a FRAPI call to the source of the webpage to be run on
the clients machine.

Below is a sample image of the User Experience Graph with little data.

![ User Experience Graph](/attachments/245551440/245551458.png)

### Activity Graph

From this graph you can see four series :

* **UEM - DB Time (ms)**:  <span style="color:red;font-weight:700;font-size:20px"> Red </span>
    * This is the average database time for all request that track UEM
        data.
* **UEM - WebRequest Time (ms)**: <span style="color:blue;font-weight:700;font-size:20px"> Blue </span>
    * This is the average web request time for all request that track
        UEM data.
* **UEM - Time on Network (ms)**: <span style="color:orange;font-weight:700;font-size:20px"> Orange </span>
    * This is the average network transfer time for UEM requests.
* **UEM - Client Time (ms)**: <span style="color:green;font-weight:700;font-size:20px"> Green </span>
    * This is the average time that it took to render the page on the
        clients device.

Placing your mouse pointer on a data point within the graph shows a
tool-tip with details about that sample, including:

-   Date and time of the request
-   UEM - DB Time (Requests/sec)
-   UEM - WebRequest Time (ms)
-   UEM - Time on Network (ms)
-   UEM - Client Time (ms)

When browsing the 1 Hour, 1 Day, and 1 Week activity graphs you're able
to select time frames by using the slider under the graph to pinpoint
specific days, times and spikes your users experience       a.

-   60 seconds at 1 second
-   1 Hours at 5 seconds
-   1 Day at 1 minute
-   1 Week at 1 hour  

### How UEM works

The UEM system in FusionReactor works by embedding a small amount of
JavaScript from the URL /fusionreactor/UEMJS.cfm into the webpage. This
JavaScript is then run on the client browser to collect the data, it is
lightweight and does very little. This JavaScript will, after collecting
the page data, send the data back to FusionReactor using an
XMLHttpRequest to the URL /fusionreactor/UEM.cfm. This data is then
placed onto the original WebRequest if it is still available and/or into
the graph.

!!! note
    The graph is updated every 1 second and the values are placed into the graph when they are returned to FusionReactor from the JavaScript. This means that it can take some time before the data appears in the graph.

### Information regarding the UEM Cookie

UEM requires the use of a cookie which is sent with all web requests to
track the users page performance. It may be **necessary** to document
that this cookie exists and is used for tracking performance. 

In order to comply with EU Legislation you
'may' be required to provide information to your users regarding what
the cookie is used for, and then ask for consent from users for the
right to store and retrieve information from their computer, tablet, or
smartphone.

!!! info "Learn more"
    <a href="http://www.cookielaw.org/the-cookie-law/" class="uri external-link">http://www.cookielaw.org/the-cookie-law/</a> 


!!! warning
    **Session tracking with Spring**
        The Spring Framework Spring Session Project includes several different implementations of session handling, which are tracked on this page.
        Spring boot applications are tracked using the spring.application.name property that can be set, usually with an application.properties file. Otherwise the default application name value is used.
        For applications using the MongoDB and JDBC session repository implementations, FusionReactor currently does not track session expiry

!!! warning
    **Root session tracking in ColdFusion**
        When tracking sessions in ColdFusion you'll see a session with the name /root. This is caused by the way ColdFusion uses the J2EE sessions. When J2EE sessions are enabled in ColdFusion, the sessions are stored within the tomcat **/root** context.There is also then a ColdFusion session created that wraps this J2EE session.
     By default, ColdFusion sessions will expire based on a worker thread, but the J2EE sessions will expire based on time since last used. So the ColdFusion session can be destroyed by the worker thread, but the J2EE session will remain.
        For example, if a user comes back, a new ColdFusion session is created, but the same J2EE session will be used.

### Script examples

When using the UEM script in your web page it is best to put the FRAPI
call as close to the end of the web page as possible. This is so that
the time of server execution is not included in the client time.


!!! note
    It is safe to cache the FRAPI object to use for other [FRAPI](/Data-insights/Extras/FRAPI/) calls.

#### JSP Script example

```jsp
<%@ page import="com.intergral.fusionreactor.api.FRAPI"%>
<% FRAPI frapi = FRAPI.getInstance(); %>

//===========================================
//    The main page content goes here
//===========================================

<script>
<%
    if(frapi != null)
    {  
        out.print(frapi.getUemTrackingScript());
    }
%>
</script>
```

#### CFML Script example

```cfm
<cfscript>
    FrapiClass = createObject("java","com.intergral.fusionreactor.api.FRAPI");
    frapi = FrapiClass.getInstance();
</cfscript>  
<script>
    <cfoutput>#frapi.getUemTrackingScript()#</cfoutput>  
</script>
```

In the case of ColdFusion/CFML, you could put this code into any single
page. Or to cause it to be sent to all requests in a given application,
you could put it in any sort of header or footer template which you may
CFINCLUDE or may reference by any other form of explicit or implicit
invocation. You could also put it in application.cfm or
onrequestend.cfm, or in the onrequeststart or onrequestend method of
application.cfc.

## Convert static HTML to use UEM

It is not possible at this time to simply embed the UEM script into a
static page such as a simple html page. However it is possible to
convert the basic HTML page into a dynamic page with out making many
changes.

If we have a page index.html that is a static page of links, but we want
to monitor the UEM for this page. We have to convert this into a dynamic
page (e.g. JSP or CFM) and add the UEM script call into the page.

### **Step 1**: Rename the file

First you will have to rename the index.html file to the index.jsp or
index.cfm (depending on your application server).

Renaming a file on the file system can result in link errors if other
pages depend on the extension. Ensure that all links to the
altered file also get updated to use the new extension!

### **Step 2**: Add the UEM script


Now edit the contents of the index.cfm file to include the UEM script
call.
```cfm
<script>
 <cfoutput>#frapi.getUemTrackingScript()#</cfoutput>
</script>
```

### **Step 3**: Done

That is all that is required you will now have a index.cfm file that
should behave the same as it did before but will not be dynamically
generated to include the UEM script.

## Using UEM with an external web server

Just as FusionReactor can be used with an external web
server, so also can UEM to work over IIS or Apache.

The available **UEM EndPoint Filter,** specified in the **[UEM
Settings](Settings.md)** page, which indicates the
extension to be used to map the request back to the application server
which FusionReactor is running on.

For example, if using ColdFusion, this **UEM EndPoint Filter **value
should be .cfm or .cfc. And to confirm that this is working, you can navigate to [http://localhost/fusionreactor/UEMJS.cfm](http://localhost/fusionreactor/UEMJS.cfm), which should display the Javascript used by the UEM feature.

!!! note 
    There is not actually any UEMJS.cfm file (in your web site, or in FusionReactor's files). Rather, FusionReactor responds with the script in response to a page of this name being requested.

If you have configured IIS/Apache security to require authentication
for your web site, you must disable that authentication for the UEM
scripts, as discussed in the following section.

### Authentication Settings

To allow the UEM endpoints to be served while using IIS or Apache
authentication, please follow these steps for your web server to disable
authentication for these endpoints. After following these steps it
should be possible to access the URL (for ColdFusion, as an
example) <a href="http://localhost/fusionreactor/UEMJS.cfm" class="external-link">http://localhost/fusionreactor.cfm/UEMJS.cfm</a>, without
authentication.

### IIS

1.  In IIS, navigate to the web site where you want to enable UEM
    monitoring, that has authentication enabled, which we want to
    disable for the UEM scripts.
2.  Create a virtual directory that matches the FusionReactor
    setting, **Web Root,** discussed above (by default, fusionreactor).
    Point the virtual directory to a blank directory.
3.  Create blank files called UEM.cfm and UEMJS.cfm (where the
    .extension matches your **UEM EndPoint Filter**) and place them
    in that blank directory.
4.  In IIS, click the **Content View~** button at the bottom of IIS, to
    view files in this virtual directory. You should see the two files
    you created.
5.  Right-click on the first of the two files, and select **Features View**. 
    
    !!! note
        This will select just this file within the virtual directory, in the display on the left.

6.  Double click the **Authentication** icon 

    !!! note
        We are not setting this at the virtual directory level, but just for the selected file.

7.  Disable all forms of authentication other than **Anonymous Authentication**, leaving this  enabled.
8.  Repeat from step 5-7 for the other file.

### Apache

1.  Create a file called UEM.cfm and UEMJS.cfm (where the .cfm matches
    your **UEM EndPoint Filter**) and place them under the virtual
    directory that is used to authenticate FusionReactor (**Web
    Root,** discussed above by default, fusionreactor).

2.  Edit the 'mod_jk.conf' file that was created by ColdFusion when
    setting up the connector.
3.  Add a &lt;Files&gt; block for each file, see below:
    (**$FileName** should be the file name UEM.cfm)

```xml
<Files $FileName>
Allow from all
Satisfy Any
</Files>   
```
___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.