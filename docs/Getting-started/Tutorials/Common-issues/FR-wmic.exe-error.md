
# FusionReactor  -  `wmic.exe cannot be found` Error

When installing FusionReactor on some Windows servers, you may encounter the error:

````
java.lang.IllegalStateException: wmic.exe cannot be found
````

This happens because **`wmic.exe` is disabled or removed** in newer Windows builds (Windows 10/11 and Server 2022+). FusionReactor relies on `wmic.exe` to query system information, so the absence of this utility prevents it from running correctly.


## Resolution

### 1. Check if `wmic.exe` exists

- Open **Command Prompt**.  
- Run:

   ````sh
   where wmic
   ````

- If no path is returned, `wmic.exe` is missing.

---

### 2. Enable `wmic.exe` via Optional Features

- Open **Windows Settings → Apps → Optional Features**.
- Click **Add a feature**.
- Search for:

     - **RSAT: Windows Management Instrumentation (WMI)** or
     - **WMIC** (availability may differ by Windows build).

- Install the feature.

---

### 3. Verify installation

- Open **Command Prompt** again.
- Run:

   ```sh
   wmic cpu get caption
   ```

- If a CPU description is returned, `wmic.exe` is working.

---

### 4. Restart FusionReactor

1. Restart the **FusionReactor installer**.
2. The installation should now complete without the `wmic.exe` error.


