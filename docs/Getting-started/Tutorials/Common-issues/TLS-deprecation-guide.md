
# TLS Deprecation Guide

As of 2025, support for **TLS 1.0 and 1.1 has been deprecated** across many platforms and JVMs. FusionReactor requires a modern TLS connection to activate and communicate securely.  

The **TLS Probe** helps you test whether your system can successfully establish a secure HTTPS connection, and it shows the encryption method (cipher suite) being used.  

---

## Running the TLS Probe

<div style="padding:56.25% 0 0 0;position:relative;"><iframe src="https://player.vimeo.com/video/1122905061?badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479" frameborder="0" allow="autoplay; fullscreen; picture-in-picture; clipboard-write; encrypted-media; web-share" referrerpolicy="strict-origin-when-cross-origin" style="position:absolute;top:0;left:0;width:100%;height:100%;" title="TLS Success Example"></iframe></div><script src="https://player.vimeo.com/api/player.js"></script>


1. Download the `tls-probe.jar` file [here](https://download.fusionreactor.io/tools/tls-probe.jar).
2. From a command line or terminal in the folder containing the JAR file, run:

   ```bash
   java -jar tls-probe.jar

   ```

---


## Understanding the results

### ✅ Successful connection

Example output:

```
✓ TLS_AES_128_GCM_SHA256
```

![!Screenshot](/Troubleshooting/images/tlsProbeSuccess.png)

This means your system successfully connected over HTTPS.
The text shown is the **TLS cipher suite** (the encryption method used for the connection).



!!! Note
    On some consoles, the checkmark (**✓**) may appear as a question mark (**?**) due to font or encoding differences. This does not affect the result.
    <div style="padding:56.25% 0 0 0;position:relative;"><iframe src="https://player.vimeo.com/video/1122910525?badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479" frameborder="0" allow="autoplay; fullscreen; picture-in-picture; clipboard-write; encrypted-media; web-share" referrerpolicy="strict-origin-when-cross-origin" style="position:absolute;top:0;left:0;width:100%;height:100%;" title="Untitled design (1)"></iframe></div><script src="https://player.vimeo.com/api/player.js"></script>



---

### ❌ Failed connection

<div style="padding:56.25% 0 0 0;position:relative;"><iframe src="https://player.vimeo.com/video/1123171388?badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479" frameborder="0" allow="autoplay; fullscreen; picture-in-picture; clipboard-write; encrypted-media; web-share" referrerpolicy="strict-origin-when-cross-origin" style="position:absolute;top:0;left:0;width:100%;height:100%;" title="TLS Failure"></iframe></div><script src="https://player.vimeo.com/api/player.js"></script>

If the connection cannot be established (e.g. unsupported TLS version, network restrictions, configuration issues), the probe will display a Java error trace instead of a cipher suite.

Example:

```
Exception in thread "main" javax.net.ssl.SSLHandshakeException: no cipher suites in common

```

![!Screenshot](/Troubleshooting/images/tlsProbeFail.png)

This means the TLS handshake failed and no secure connection was established.

---

## Fixing TLS failures

If your system fails the TLS probe, you have three main options:

| Path                                 | Pros                             | Cons                                     | Typical Time |
| ------------------------------------ | -------------------------------- | ---------------------------------------- | ------------ |
| [**1. Upgrade the JVM (recommended)**](/Getting-started/Tutorials/Common-issues/TLS-deprecation-guide/#path-1-upgrade-the-jvm-preferred) | Future-proof, faster, fewer CVEs | May require application re-testing       | ~30 min      |
| [**2. Retrofit your current JVM**](/Getting-started/Tutorials/Common-issues/TLS-deprecation-guide/#path-2-retrofit-your-current-jvm)    | No code changes                  | Must repeat per host; still legacy       | ~10 min      |
| [**3. Manual / Offline activation**](/Getting-started/Tutorials/Common-issues/TLS-deprecation-guide/#path-3-manual-offline-activation)   | Works even on very old Java (5+) | No auto-renew; manual process per server | ~5 min       |

---

### Path 1  -  Upgrade the JVM (Preferred)

1. Install Java **8u121+, 11, 17, or 21**.
2. Point your service to use the new JVM.
3. Restart your Application Server.

Done.

---

### Path 2  -  Retrofit your current JVM

1. Download **ISRG Root X1 and X2** certificates from [Let’s Encrypt](https://letsencrypt.org/certificates/).

2. Import the roots into your JVM keystore:

    ```
    keytool -import -alias isrgrootx1 -keystore $JAVA_HOME/jre/lib/security/cacerts \
           -file isrgrootx1.pem -storepass changeit -noprompt

    keytool -import -alias isrgrootx2 -keystore $JAVA_HOME/jre/lib/security/cacerts \
           -file isrgrootx2.pem -storepass changeit -noprompt
    ```
   


3. Force TLS 1.2 (for Java 7 / early 8) by adding this line to:

    ```
    $JAVA_HOME/jre/lib/security/java.security
    ```

    ```properties   
    jdk.tls.client.protocols=TLSv1.2
    ```

4. For **Java 6 only**, install [BouncyCastle JSSE](https://www.bouncycastle.org/):

   * Copy `bcprov` and `bctls` JARs to `$JAVA_HOME/lib/ext`
   * Add this to `java.security`:

     ```
     security.provider.1=org.bouncycastle.jsse.provider.BouncyCastleJsse
     ```
     
!!! info "Learn more"
    [Retrofitting your existing Java JVM](https://fusion-reactor.com/blog/retrofitting-your-existing-java-jvm-for-tls-1-2-lets-encrypt/)

---

### Path 3  -  Manual / Offline Activation

Use this if you cannot enable TLS 1.2 or add Let’s Encrypt roots.

1. In the **FusionReactor On-Premise UI**, go to **About → Manual Activation**.
2. Copy the activation code.
3. On an internet-connected machine, open [https://fusion-reactor.com/manual](https://fusion-reactor.com/manual).
4. Paste the activation code and click **Activate**.
5. Copy the generated activation key.
6. Back in the FusionReactor UI, paste the activation key and click **Activate**.


!!! info "Learn more"
    [Goodbye TLS 1.0/1.1: How to keep your FusionReactor install secure in 2025 and beyond](https://fusion-reactor.com/blog/goodbye-tls-1-0-1-1-how-to-keep-your-fusionreactor-install-secure-in-2025-and-beyond/)

---
