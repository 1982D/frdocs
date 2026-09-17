# FusionReactor API (FRAPI)

## What is FRAPI?

FRAPI is the FusionReactor API and it gives you the ability to access
FusionReactor functionality from directly within your application code
and web pages.

!!! info "Learn more"
    [FusionReactor API JavaDoc](https://fusion-reactor.com/frapi/8_0_0/)    
    [FusionReactor API JavaDoc 2026.1.2](../frapi-2026.1.2)
    [FusionReactor API JavaDoc 2026.1.3](../frapi-2026.1.3)

## FRAPI Examples in ColdFusion

The FRAPI lets you call FusionReactor methods directly from your
ColdFusion pages. 

Lets first start with some simple examples though...

This is one of the simplest FRAPI calls:

```cfm
<cfset frapiClass = createObject("java", "com.intergral.fusionreactor.api.FRAPI")>
<cfset frapi = frapiClass.getInstance()>

<cfoutput>Is FR Running?: #frapi.isFusionReactorRunning()#</cfoutput>
```

This page simply outputs a YES/NO value depending on the running state
of FusionReactor.

E.g.
```
Is FR Running?: YES
```

### Using FRAPI to look at running requests

Now for something a little more interesting.

```cfm
<cfset frapiClass = createObject("java", "com.intergral.fusionreactor.api.FRAPI")>
<cfset frapi = frapiClass.getInstance()>
<cfset dateClass = createObject("java", "java.util.Date")>

<!--- Loop over each running request --->

<cfset requestArray = frapi.getRunningRequests()/>
<hr>
<cfloop index="i" from=1 to=#ArrayLen(requestArray)#>

   <cfset dateObject = dateClass.init(requestArray[i].getStartTimeMillis())>
   <cfoutput>
      ID: #requestArray[i].getFusionRequestId()#<br/>
      URL: #requestArray[i].getRequestUrl()#<br/>
      Start: #dateObject.toString()#<br/>
      <hr>
   </cfoutput>

</cfloop>

<!--- Sleep for 5 seconds --->

<cfobject type="java" action="create" class="java.lang.Thread" name="Thread">

<cfscript>
    Thread.sleep( JavaCast( "long", 5000 ) );
</cfscript>
```

This bit of code will print out a list of all requests currently
running. (We've added a wait at the bottom so we can run it several
times and get a result something like this:

![](/Data-insights/Extras/frapi2.png)

### The FusionRequestSurrogate

Calling frapi.getRunningRequests()returns an array of
FusionRequestSurrogates. These objects contain proxied information from
an internal FusionRequest (web request). It is safe to store references
to this object, since the data it encapsulates is copied from the
underlying FusionRequest. There is a lot of data that you can get about
a request:

```cfm
<cfscript>
  frapiClass = createObject("java", "com.intergral.fusionreactor.api.FRAPI");
  frapi = frapiClass.getInstance();
</cfscript>

<table border="1">

<tr>
 <td title="getBytes()"                              >Bytes</td>
 <td title="getCfid()"                               >Cfid</td>
 <td title="getCftoken()"                            >Cftoken</td>
 <td title="getCpuUsage()"                           >CPU</td>
 <td title="getCrashProtection()"                    >CP</td>
 <td title="getCrashProtectionStatus()"              >CPStat</td>
 <td title="getExecutionTime()"                      >ETime</td>
 <td title="getFusionRequestId()"                    >FRid</td>
 <td title="getIpAddress()"                          >IP</td>
 <td title="getJavaSessionId()"                      >JSid</td>
 <td title="getMethod()"                             >Met</td>
 <td title="getOutputCompressorState()"              >OCS</td>
 <td title="getQueryString()"                        >QS</td>
 <td title="getRequestId()"                          >Rid</td>
 <td title="getRequestStatus()"                      >RS</td>
 <td title="getRequestUrl()"                         >RURL</td>
 <td title="getRuntime()"                            >RTIME</td>
 <td title="getStartTimeMillis()"                    >STM</td>
 <td title="getStatusCode()"                         >SC</td>
 <td title="getThread()"                             >Tid</td>
 <td title="getThreadCpuTime()"                      >TCPU</td>
 <td title="getTimeClosed()"                         >CLOSE</td>
 <td title="getTimeOfDeath()"                        >Dead</td>
 <td title="getTimeOpened()"                         >OPEN</td>
 <td title="getTtfb()"                               >Ttfb</td>
 <td title="getTtlb()"                               >Ttlb</td>
 <td title="isImmortal()"                            >I</td>
 <td title="jdbcGetRunningStatement()"               >JRS</td>
 <td title="jdbcGetRunningStatementDatasource()"     >JDS</td>
 <td title="jdbcGetRunningStatementStartTimeMillis()">JRST</td>
 <td title="jdbcTotalExecutionTime()"                >TET</td>
 <td title="jdbcTotalQueryCount()"                   >TQC</td>
 <td title="jdbcTotalRows()"                         >TR</td>
 <td title="jdbcTotalTime()"                         >RR</td>
 <td title="wasQueued()"                             >Q</td>
</tr>

<cfset requestArray = frapi.getRunningRequests()/>

<cfloop
 index = "i"
 from = 1
 to = #ArrayLen(requestArray)#>

 <cfoutput>
 <tr>
    <td>#requestArray[i].getBytes()#</td>
    <td>#requestArray[i].getCfid()#</td>
    <td>#requestArray[i].getCftoken()#</td>
    <td>#requestArray[i].getCrashProtection()#</td>
    <td>#requestArray[i].getCrashProtectionStatus()#</td>
    <td>#requestArray[i].getExecutionTime()#</td>
    <td>#requestArray[i].getFusionRequestId()#</td>
    <td>#requestArray[i].getIpAddress()#</td>
    <td>#requestArray[i].getJavaSessionId()#</td>
    <td>#requestArray[i].getMethod()#</td>
    <td>#requestArray[i].getOutputCompressorState()#</td>
    <td>#requestArray[i].getQueryString()#</td>
    <td>#requestArray[i].getRequestId()#</td>
    <td>#requestArray[i].getRequestStatus()#</td>
    <td>#requestArray[i].getRequestUrl()#</td>
    <td>#requestArray[i].getRuntime()#</td>
    <td>#requestArray[i].getStartTimeMillis()#</td>
    <td>#requestArray[i].getStatusCode()#</td>
    <td>#requestArray[i].getThread()#</td>
    <td>#requestArray[i].getThreadCpuTime()#</td>
    <td>#requestArray[i].getTimeClosed()#</td>
    <td>#requestArray[i].getTimeOfDeath()#</td>
    <td>#requestArray[i].getTimeOpened()#</td>
    <td>#requestArray[i].getTtfb()#</td>
    <td>#requestArray[i].getTtlb()#</td>
    <td>#requestArray[i].isImmortal()#</td>
    <td>#requestArray[i].jdbcGetRunningStatement()#</td>
    <td>#requestArray[i].jdbcGetRunningStatementDatasource()#</td>
    <td>#requestArray[i].jdbcGetRunningStatementStartTimeMillis()#</td>
    <td>#requestArray[i].jdbcTotalExecutionTime()#</td>
    <td>#requestArray[i].jdbcTotalQueryCount()#</td>
    <td>#requestArray[i].jdbcTotalRows()#</td>
    <td>#requestArray[i].jdbcTotalTime()#</td>
    <td>#requestArray[i].wasQueued()#</td>
 </tr>
 </cfoutput>

</cfloop>

</table>
```

### Setting a request's crash protection timeout

The following code will change the timeout setting for Crash Protection
for this request:

```cfm
<cfset frapiClass = createObject("java", "com.intergral.fusionreactor.api.FRAPI")>
<cfset frapi = frapiClass.getInstance()>

<!--- Force Crash Protection to 10 seconds for this page --->
<cfset frapi.setPageTimeout( 10000 )>
```

### Create transaction trace markers

We also have the ability to set traces in pages. For example:

```cfm
<cfset frapiClass = createObject("java", "com.intergral.fusionreactor.api.FRAPI")>
<cfset frapi = frapiClass.getInstance()>

<!--- Set a marker --->
<cfset frapi.trace( "Hello World!" )>
```

After this page has run, if we go into FusionReactor you will see a
Traces link underneath the URL on the request row. Alternatively the
traces can be viewed on the Traces tab of the request details.

The ability to set traces within your pages has many useful purposes
including following the path of execution, measuring execution time or
simply outputting debug information without changing the final output or
needing to read through log files.

### Example of changing the FusionReactor Configuration via FRAPI

It's possible using FRAPI to change pretty much anything in
FusionReactor's configuration. In the example below we toggle an
Enterprise Dashboard monitored remote server online/offline
programmatically.

In the reactor.conf file the keys "remoting.server.X.\*" control the ED
monitored servers. The key of interest is "remoting.server.X.online"  - 
you'll have to figure out what "X" is in your case; it's just a serial
number. Once you have that, you can use FRAPI to toggle the online
state. Here's some CF to do it: \*NB you must not have reactor.conf
still open in your editor, otherwise the FRAPI code won't be able to
change it and you'll get an error, that'll require a restart to clear

If you're in CF and monitoring from within a CFM instance, the following
CF code will toggle remoting server 0's state (online/offline)

```cfm
<cfscript>
frapiClass = createObject( "java", "com.intergral.fusionreactor.api.FRAPI" );
frapi = frapiClass.getInstance();
configuration = frapi.getRunningConfiguration();
if( configuration.getStringValue( "remoting.server.0.online" ) == "true" )
{
    configuration.setValue( "remoting.server.0.online", "false" );
}
else
{
   configuration.setValue( "remoting.server.0.online", "true" );
}
frapi.setRunningConfiguration( configuration );
</cfscript>
```

If you want to change FRAM's configuration you will need to look at
FRAM's reactor.conf ( /FusionReactor/instance/FRAM/conf/reactor.conf) to
get the remoting server number. Then place the following JSP in
/FusionReactor/tomcat/webapps/ROOT, and run it as
<a href="http://localhost:8087/enterprise-toggle.jsp" class="uri external-link">http://localhost:8087/enterprise-toggle.jsp</a>

### Getting the FusionReactor Request ID for the current request

It's possible using FRAPI to get the FusionReactor Request ID of the
current running page or request. This can be done by looping over the
list of current tracked requests and matching the thread name of the
request thread with the thread name on tracked of the FusionReactor
request surrogate.

The following code example is written in cfscript:

```cfm
<cfscript>
frapiClass = createObject("java","com.intergral.fusionreactor.api.FRAPI");
frapi = frapiClass.getInstance();
requestArray = frapi.getRunningRequests();
writeoutput("<h2>Current Request</h2>");
myThreadName =  createObject("java","java.lang.Thread").currentThread().getName();
for (i=1; i LTE ArrayLen(requestArray); i=i+1)
    {
    if (requestArray[i].getThread() eq myThreadName) 
    {
         writeoutput("ID: #requestArray[i].getFusionRequestId()#<br/>");
    }
}
</cfscript>
```

### Adding a link to the FusionReactor request for any error with CFML

When running FusionReactor in your ColdFusion / Lucee / Railo server it is possible to add a link to the error handler of your CFML application that will provide you with a link to the errored request in FusionReactor.

This will allow you to access the error details quicker than having to find the request in FusionReactor. This can be done by navigating to Requests > Error History where you will by default see the last 100 errors that occurred.

To do this you can use FRAPI (FusionReactor API) to generate a dynamic link to the direct request. You can add the code below to either a dedicated error handler or inside the catch block of any specific CFML page.

The code:

```cfm
 <cfscript>
    frapiClass = createObject("java","com.intergral.fusionreactor.api.FRAPI");
    frapi = frapiClass.getInstance();
    request.fusionreactor.transactionId = frapi.getActiveTransaction().getTransactionId();
    request.fusionreactor.host = cgi.local_addr;
    request.fusionreactor.port = frapi.getRunningConfiguration().getStringValue('org.osgi.service.http.port');
    request.fusionreactor.protocol =     frapi.getRunningConfiguration().getStringValue('org.osgi.service.http.port.secure') eq -1 ? 'http://' : 'https://';
    request.fusionreactor.reqdetails = request.fusionreactor.protocol & request.fusionreactor.host & ':' & request.fusionreactor.port & '/fusionreactor/findex.htm?p=reqDetails&id=' & request.fusionreactor.transactionId;
    writedump(request.fusionreactor);
</cfscript>
```


### Transaction Surrogate

Introduced in 2026.1.2, ITransactionSurrogate is a new interface that allows you to access more transaction details. IFusionRequestSurrogate extends this interface to provide the same insights.

FRAPI has new methods to retrieve details:
- `getClientID` to return the instance's FR client ID (this can change during runtime)
- `getRunningTransactions` to return an array of running transactions (not just web requests)
- `getRecentTransactions` to return an array of recent, finished transactions (not just web requests)

Usage example:

```cfm
<cfset frapiClass = createObject("java", "com.intergral.fusionreactor.api.FRAPI")>
<cfset frapi = frapiClass.getInstance()>

<cfoutput>
#frapi.getClientId()#
</cfoutput>

<hr>

<cfset txnArray = frapi.getRecentTransactions()/>

<cfloop index="i" from=1 to=#ArrayLen(txnArray)#>

   <cfset txn = txnArray[i]>

   <cfset masterTxn = txn.getMasterTransaction()>
   <cfset parentTxn = txn.getParentTransaction()>
   <cfset deepestActiveChild = txn.getDeepestActiveChild()>
   <cfset directChildren = txn.getDirectChildren()>
   <cfset trappedThrowable = txn.getTrappedThrowable()>

   <cfoutput>
	Description: #txn.getDescription()#<br/>
	Secure Description: #txn.getSecureDescription()#<br/>
	Application Name: #txn.getApplicationName()#<br/>
	Transaction Name: #txn.getTransactionName()#<br/>
	Flavor: #txn.getFlavor()#<br/>
	Sub Flavor: #txn.getSubFlavor()#<br/>
	Full Transaction ID: #txn.getFullTransactionId()#<br/>
	Transaction ID: #txn.getTransactionId()#<br/>
	Per-Flavor Transaction ID: #txn.getPerFlavorTransactionId()#<br/>
	Start Time Millis: #txn.getStartTime()#<br/>
	Start Time Nanos: #txn.getStartTimeNanos()#<br/>
	End Time Millis: #txn.getEndTime()#<br/>
	End Time Nanos: #txn.getEndTimeNanos()#<br/>
	Duration Millis: #txn.getDuration()#<br/>
	Duration Nanos: #txn.getDurationNanos()#<br/>
	Properties Size: #txn.getProperties().size()#<br/>
	Master Transaction Txn ID: #isNull(masterTxn) ? "no master transaction" : masterTxn.getTransactionId()#<br/>
	Parent Transaction Txn ID: #isNull(parentTxn) ? "no parent transaction" : parentTxn.getTransactionId()#<br/>
	Deepest Active Child Txn ID: #isNull(deepestActiveChild) ? "no deepest active child transaction" : deepestActiveChild.getTransactionId()#<br/>
	Direct Children (count): #ArrayLen(directChildren)#<br/>
	Has Children: #txn.hasChildren()#</br>
	Is Master Transaction: #txn.isMasterTransaction()#<br/>
	Status: #txn.getStatus()#<br/>
	Thread ID: #txn.getThreadId()#<br/>
	Thread Name: #txn.getThreadName()#<br/>
	Is Finished: #txn.isFinished()#<br/>
	Is In Error: #txn.isInError()#<br/>
	Trapped Throwable: #isNull(trappedThrowable) ? "no trapped throwable" : trappedThrowable.getMessage()#<br/>
	Trace ID: #txn.getTraceId()#<br/>
	Span ID: #txn.getSpanId()#<br/>
	Sampled State: #txn.getSampledState()#<br/>
	<hr/>
   </cfoutput>
</cfloop>
```


### Summary

As we hope you can see, the FRAPI is a very powerful new tool which has
a lot of potential. As ever, if you have any feedback or suggestions for
this or any other feature within FusionReactor, please let us know and
we will try our best to include them in upcoming builds.
