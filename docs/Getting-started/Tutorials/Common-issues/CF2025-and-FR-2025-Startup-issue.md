
# ColdFusion 2025 & FusionReactor 2025  -  Startup Issue

When installing **FusionReactor 2025** with **ColdFusion 2025**, the server may fail to start if FusionReactor’s JVM arguments are added. This usually occurs because ColdFusion is not resolving the correct Java runtime during startup.

---

## Resolution

To ensure ColdFusion launches correctly with FusionReactor:

### 1. Set the Java Home in ColdFusion’s JVM Config

#### Option A (via Administrator):

-  Open the **ColdFusion Administrator**.  
-  Go to **Server Settings → Java and JVM**.  
-  Set **Java Home** to ColdFusion’s packaged JRE (e.g. `C:\ColdFusion2025\jre` or the equivalent installation path). 

-  Save changes and restart the server.

---

#### Option B (manual edit):

- Locate ColdFusion’s **jvm.config** file, typically in: `C:\ColdFusion2025\cfusion\bin\jvm.config`

- Open the file in a text editor.  

- Update the `java.home` property to point to ColdFusion’s packaged JRE, for example:  `java.home=C:/ColdFusion2025/jre`

- Save the file and restart the server.

---

### 2. Update Windows Environment Variables

- Open **System Properties → Environment Variables**.  
- Under **System variables**, set: `JAVA\_HOME = C:\ColdFusion2025\jre`
- Edit the **Path** variable:  
    - Move the ColdFusion JRE bin directory (e.g. `C:\ColdFusion2025\jre\bin`) to the top of the list.
    
---
### 3. Verify JVM `java.home` and Environment Variables

If done correctly, your JVM config `java.home` path and Windows Environment Variables should resemble the image below.

![!Screenshot](/Troubleshooting/images/jre.png)


---

### 4. Restart ColdFusion

After updating both the JVM config and environment variables, restart the **ColdFusion service**.  

ColdFusion should now start successfully with FusionReactor enabled.  

If any issues persist, please reach out via the blue chat bubble or email **support@fusion-reactor.com**.

