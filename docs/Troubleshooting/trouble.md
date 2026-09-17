# Troubleshooting Cloud connections

## System status
The status of various components of the **OpsPilot** system can be seen [here](https://fusionreactor-status.freshstatus.io/).

## Missing, incomplete or malformed data

### Network issues
FusionReactor is designed to be resilient to connectivity issues when shipping data to **OpsPilot**.

If your instance of FusionReactor has connectivity issues up to 60 mins of data is kept locally, once connectivity has been restored this data will be shipped intelligently in order to refrain from overloading the transport system.

Data will then appear to 'back fill' and gaps in the data will be removed.

### Live functionality not working correctly

Some functionality of **OpsPilot** requires a web socket connection to communicate directly with the FusionReactor instance. Examples of this functionality are recent or running transactions and the live graphing modes.

If you are experiencing issues with these areas of the software then you should refer to the following sections of this guide.

* [Connection issues](trouble.md#connection-issues)
* [Firewall configuration](trouble.md#firewall)
* [Proxy configuration](trouble.md#proxy-configuration)

### Connection issues

The Cloud status icon in the top right corner of FusionReactor shows the current connection status of the FusionReactor instance to the cloud.

![!Screenshot](/Troubleshooting/images/frcloudicon.png)

| Description | State | Icon
|------------ | ------------- | ------------
|Agent connected and last transmission was successful | Connected | ![!Screenshot](/Troubleshooting/images/greenup.png)|
|Agent connected and last transmission was not successful | Degraded | ![!Screenshot](/Troubleshooting/images/cloudamberdown.png)|
|Agent disconnected and last transmission was successful | Degraded | ![!Screenshot](/Troubleshooting/images/cloudiconupload.png)|
|Agent disconnected and last transmission was unsuccessful | Disconnected | ![!Screenshot](/Troubleshooting/images/reddowncloud.png)|

Reasons for connection troubles included: network or internet connection issues, incorrect [firewall](trouble.md#firewall) or [detailed view](trouble.md#proxy) settings or [system failure](trouble.md#system-status).

#### Proxy configuration

If you have a proxy server in place to access the internet, then you can configure it inside FusionReactor.

![!Screenshot](/Troubleshooting/images/fr_proxy_settings.png)

See [Proxy Settings](/Data-insights/Features/Settings/Main-Menu/#proxy-settings) for more information on how to configure your proxy settings.

#### Importing SSL cert

If you’re using FusionReactor with a Cloud license, the client connects to our services via encrypted SSL connections.

The certificate used to secure these connections is issued by DigiCert. Some older operating systems and older versions of Java don’t have the DigiCert certificate in the keystore.

In these cases, you’ll see an SSL error in the console, when FusionReactor tries to connect to the Cloud. Java may also complain about being *unable to build a certificate chain*.

Previously we included our own keystore, but this was problematic as in some cases, it supplanted the JEE container’s own store. The certificates we supplied would also expire eventually, necessitating a forced-update of FusionReactor.

In order to fix this, simply import the DigiCert certificate into your own keystore. 


Below is an example using IBM WebSphere, which supplies its own keystore. Adapt the path to your own keystore.

!!! example

    IBM WebSphere Liberty Profile 9.

    Download the certificate:

    ```bash
    wget https://www.digicert.com/CACerts/DigiCertGlobalRootCA.crt -o /tmp/digicert.crt
    ```

    Import the certificate into the JKS keystore for your server. On our system, for the default WebSphere server, this is done as follows:

    ```bash
    keytool -import -alias digicert-global-root-ca -file /tmp/digicert.crt -keystore /opt/IBM/WebSphere/Liberty/usr/servers/defaultServer/resources/security/key.jks
    ```

### Firewall

Some users run FusionReactor behind restricted firewalls which do not allow all outbound connections. In this case, these users may need to add specific firewall rules to allow FusionReactor to communicate with **OpsPilot**.

#### Using DNS firewall rules

In order to communicate with **OpsPilot**, each FusionReactor instance attempts to connect to the following services, which are identified by their DNS names:

* wss://cc.fusionreactor.io - port tcp/2804
* https://api.fusionreactor.io - port tcp/443

These services require outgoing firewall rules for FusionReactor to communicate with OpsPilot. All communications are protected by SSL cyphers.

!!! tip
    If possible, the firewall should be configured with the DNS names of these services, since they can change in response to scaling events.

If the IP addresses are required, nslookup can be used to find their current values. Most services will yield two addresses: both must be added.

#### Using static IP addresses

If you are unable or unwilling to use the dynamic DNS rules above, we have provided a static IP addresses which can be used for all services.

```
46.137.127.35  -  port tcp/443 and port tcp/2804.
```

After enabling this firewall rule, the following -D options need to be applied to your JVM environment, to instruct FusionReactor to use the single address:

```
-Dfr.gcs.client.endpoint=wss://cc-static.fusionreactor.io:2804/

-Dfr.cloud.endpoint=https://api-static.fusionreactor.io
```

#### Locked-down environments

If you are using a non-standard Java security policy, you may have to add rules to it to allow FusionReactor to connect to these services. The form of these rules is:

```
permission java.net.SocketPermission "cc-static.fusionreactor.io:2804", "connect, accept, resolve";
permission java.net.SocketPermission "api-static.fusionreactor.io:443", "connect, accept, resolve";
permission java.net.SocketPermission "46.137.127.35:443", "connect, accept, resolve";
permission java.net.SocketPermission "46.137.127.35:2804", "connect, accept, resolve";

```
## Debugger compatibility

Java only allows one debugger at a time to be used. If you use JDWP (Java Debug Wire Protocol) you need to disable it to use FusionReactor production debugger. Having two configured will result in a warning from FusionReactor production debugger saying it cannot acquire the capabilities to debug the Java server.

Please remove lines like this from the Java arguments:

```bash
-Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8000
```
OR
```bash
-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=8000
```

!!! note 
    JDWP may be written to the config by the server if you are running **ColdFusion** and have the line debugger enabled. This can be disabled at **Debugging & logging > Debugger settings > Allow Line Debugging** in the ColdFusion admin panel.


## Transaction culling

Master (also known as parent) transactions are selected for shipping to Cloud based on a set of criteria buckets. There is one set of buckets per application. Only the first 100 distinct applications are tracked per minute, and there's also a global limit of 100 master transactions per minute.

 * **Error transactions** - the first 4 transactions to close in error (e.g. web requests resulting in 500-series results) are selected.
 * **Long** - the longest 4 transactions which ran longer than 500ms are selected.
 * **Slow** - the longest 4 transactions which were slower than the threshold set in **FusionReactor > Requests > Settings > WebRequest History > Slow Request Threshold** are selected.

All of the subtransactions of these masters are also kept and transferred.

!!! info "Learn more"
    [Subtransaction trimming](trouble.md#subtransaction-trimming).

### Effect of limits

If a transaction is seen which would fall into one of these buckets, but:

 * it belongs to the 101st or later application to be seen that minute, **or**
 * there are already 100 transactions in all buckets across all applications,

... then that transaction will not be sent to Cloud.

### Subtransaction trimming

Transactions can have a virtually-unlimited quantity of subtransactions. For example: a ColdFusion page (which is tracked as a parent transaction) can perform a CFHTTP call to a REST endpoint. That call will be detected and tracked as a subtransaction on the CF page. This could happen multiple times and they would all be tracked by FusionReactor.

In order to keep the size of shipped data within an acceptable margin, a culling algorithm ensures that at most, **500** subtransactions are shipped to Cloud.

The algorithm looks at culling subtransactions of the long bucket first, then slow, and then error last. We do it in this order so that the error transactions are less likely to be trimmed because they're most important.

If subtransactions were trimmed from the shipped data, this will be indicated in **OpsPilot**.

___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.


