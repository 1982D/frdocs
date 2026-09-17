With a ColdFusion instance and the Adobe Performance Monitoring Toolset (PMT) FusionReactor users will see web requests for the URL http://localhost/connector appear for the Adobe ColdFusion 2018 application.

These requests are made from the PMT to the ColdFusion server as a “heartbeat” that ensures your ColdFusion server is running.

These requests will not have any effect on the performance of the PMT or the ColdFusion server, the only issue with these requests being tracked will be that as we store by default 100 web requests and these requests can fill your request history so you no longer see as much useful data.

When configuring the PMT you can specify the heartbeat interval which would limit the number of requests you would see in FusionReactor.

It is also possible to navigate to **FusionReactor** (top left) > **Restrictions** and add the following restriction:

![](/Troubleshooting/images/PMT_Restriction_host.png)

````
Match Strategy: Exact Match

Request: localhost/connector

HostName: Check

Parameters: Ignore
````

This will stop FusionReactor from tracking the heartbeat requests from the PMT process so they no longer appear in your history lists.

It is possible for certain configurations of the ColdFusion connector to not have a hostname, this can result in the restriction above not stopping the connector requests being ignored by FusionReactor. If this is the case, we recommend using the restriction below:

![](/Troubleshooting/images/PMT_Restriction_nohost.png)

````
Match Strategy: Exact Match

Request: /connector

HostName: Ignore

Parameters: Ignore
````

!!! info
    This restriction will not check the hostname and ignore any traffic to the /connector url.

___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist. 