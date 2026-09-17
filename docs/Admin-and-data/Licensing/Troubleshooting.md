title: Troubleshooting

# Troubleshooting license connection issues

In FusionReactor 8, we introduced a new licensing server for better support in dynamic environments and improved stability.

Here’s how FusionReactor interacts with the licensing server:

- FusionReactor instances check the licensing server every minute.
- The licensing server cannot disable an instance from pinging.
- Servers enter an offline state after two minutes of failing to contact the licensing server.
- If an instance is running, it will continue to ping every minute, regardless of the licensing server’s response.
- To stop an instance from trying to activate, click **Deactivate** on the **About** page.

FusionReactor will automatically attempt activation on startup. If your server can contact the licensing server and receive a valid response, there should be no issues.

If FusionReactor cannot contact the server or receive a valid response, you’ll see a banner indicating the problem.

There are three alternative approaches to activate FusionReactor:

1. [Configuring a proxy](/Admin-and-data/Licensing/Troubleshooting/#configuring-a-proxy)
1. [Setting a firewall rule](/Admin-and-data/Licensing/Troubleshooting/#setting-a-firewall-rule) to allow contact to the licensing server.
1. [Performing a manual activation](/Admin-and-data/Licensing/Troubleshooting/#performing-a-manual-activation).

## Configuring a proxy

If you need to use a proxy to connect to external sites, you can configure FusionReactor to route all traffic through your proxy. This will allow FusionReactor to connect to the licensing server and activate automatically.

**Configure Proxy**:  

   - Go to the **About** page in FusionReactor.
   - Click on **Proxy Settings** in the menu.
   - In the settings, enter your proxy location and choose the authentication method: **Basic**, **Digest**, **NTLM**, or **No Authentication**.

**Test the Connection**:  

Once you’ve configured the proxy, click **Test Proxy** to ensure FusionReactor can successfully connect to the licensing server.

If the test is successful, FusionReactor will be able to activate through your proxy.


## Firewall setup options

1. **Allow by Hostname** (Recommended)

       - Configure firewall to allow licensing server hostname.
       - Automatically handles server changes.

2. **Allow by IP Address**

      - Configure static IP in firewall rules.
      - Requires additional application server properties.
      - See [Firewall Configuration Guide](/Admin-and-data/Licensing/Static-Licensing-Endpoints/#using-dns-firewall-rules).

## Manual activation process

For servers without external access:

- Get activation code from restricted server.
- Apply code via FusionReactor portal using an internet-connected machine.
- Required for upgrades and license renewals.

!!! info "Learn more"
    [Manual Activation](/Admin-and-data/Licensing/Manual-Activation/)


