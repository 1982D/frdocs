

# Static endpoints

Some users run FusionReactor behind restricted firewalls which don't allow all outbound connections. In this case, these users may need to add specific firewall rules to allow FusionReactor to communicate with OpsPilot.

## Using DNS firewall rules

In order to communicate with the FusionReactor infrastructure, each FusionReactor instance attempts to connect to the following services, which are identified by their DNS names:

* wss://cc.fusionreactor.io  -  port tcp/2804 (FR 12 and below)
* https://api.fusionreactor.io  -  port tcp/443


### Firewall configuration

- Allow outbound SSL traffic to OpsPilot services.
- Configure rules using DNS names (recommended) for automatic updates.
- If using IP addresses, verify current values with `nslookup`.

!!! note
    Add all returned IP addresses to firewall rules (typically two per service).



## Using static IP addresses

If you're unable or unwilling to use the dynamic DNS rules above, we've provided a static IP addresses which can be used for all services.

* 46.137.127.35  -  port tcp/443 and port tcp/2804

After enabling this firewall rule, the following -D options need to be applied to your JVM environment, to instruct FusionReactor to use the single address:

```
-Dfr.gcs.client.endpoint=wss://cc-static.fusionreactor.io:2804/
-Dfr.cloud.endpoint=https://api-static.fusionreactor.io
```

## Locked-down environments

If you're using a non-standard Java security policy, you may need to add specific rules to allow FusionReactor to connect to these services.

The form of these rules is:

```
permission java.net.SocketPermission "cc-static.fusionreactor.io:2804", "connect, accept, resolve";
permission java.net.SocketPermission "api-static.fusionreactor.io:443", "connect, accept, resolve";
permission java.net.SocketPermission "46.137.127.35:443", "connect, accept, resolve";
permission java.net.SocketPermission "46.137.127.35:2804", "connect, accept, resolve";
```
