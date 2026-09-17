# Security


## Sensitive data

By default, the FusionReactor agent captures the following potentially sensitive data which **can be obfuscated** in the On-Prem FusionReactor, and defaults to being obfuscated when sent to the Cloud:

  * **Request parameters**: The agent captures query parameters, but **not** form POST data. (See [JDBC Settings](/Data-insights/Features/JDBC/Settings/))
 
 
  * **SQL**: The agent sets SQL recording to obfuscated, which removes the potentially sensitive numeric and string literal values.
  * **IP address**: The agent captures the remote ip address where WebRequest originated.


The following potentially sensitive data is captured but **cannot** be obfuscated at this time:

  * **JSON capture**: The JSON post and response data is captured as is and may contain potentially sensitive data. 
  * **Query plans**: When enabled, FusionReactor will automatically run the query plan and explain commands to find out why Mongo queries and SQL statements took so long. This data cannot be obfuscated and is not enabled by default.
  * **Decompiler**: When viewing stack traces, profilers, and in other locations, the user can decompile the relevant classes. Decompiling has the ability to see potentially sensitive constants like API keys.
  * **Event Snapshot and Debugger**: These cannot be obfuscated and may contain sensitive information. The Debugger has access to any and all variables/constants in the running application. You can disable the Event Snapshot feature or the whole Debugger.

!!! info "Learn more"
    [Debugger settings](/Data-insights/Features/Debugger/Settings/)

### Disabling data capture & access

To enhance security, you can disable or restrict access to certain features. If using the -D properties, a server restart is required for changes to take effect. Alternatively, settings can be disabled in the FusionReactor UI while the application is running.


#### 1. Disable JSON Capture
Set the following property to disable JSON capture:

```
-Dfr.json.interposer.disabled=true
```
Alternatively, in the FusionReactor on-prem UI:

- Navigate to **Requests**  → **Settings**  → **Json Data**
- Set **Enable Json Data Capture** to **Disabled**

#### 2. Disable Query Plans
In the UI, disable the following settings:

- **JDBC**  → **Settings**  → **Query Plan Settings**  → **Disabled**
- **Transactions**  → **Settings**  → **Mongo Transactions**  → **MongoDB Explain** = **Disabled**

#### 3. Restrict Decompiler Access
Set the following property to disable the decompiler:
```
-Dfr.decompile.enabled=false
```
For Cloud-only environments, use:
```
-Dfr.gcs.client.decompile=false
```
Alternatively, in the Cloud UI:

- Go to the **top-right corner**  → **Configure Cloud**
- Set **Class Decompiling** to **Disabled**

#### 4. Disable Event Snapshot & Debugger
In the UI, disable the following:

- **Debug**  → **Settings**  → **General**  → **Active** = **Disabled**
- **Debug**  → **Settings**  → **Event Snapshot**  → **Enabled** = **Disabled**



## Sending data to OpenAI

OpenAI will not use data submitted by customers via our API to train or improve our models.   

!!! note 
    FusionReactor does not share data with OpenAI for this purpose.

OpenAI retains API data for 30 days for abuse and misuse monitoring purposes. A limited number of authorized OpenAI employees, as well as specialized third-party contractors that are subject to confidentiality and security obligations, can access this data solely to investigate and verify suspected abuse.

The OpenAI API is [SOC 2 Type 2](/Admin-and-data/security/#soc-2-type-2-compliance) compliant and has been audited by an independent third-party auditor against the 2017 Trust Services Criteria for Security.

All customer data is processed and stored in the US. 

!!! info "Learn more"
    [OpenAI](https://openai.com/security)

## SOC 2 Type 2 Compliance

Intergral Information Systems GmbH has achieved SOC 2 Type 2 certification, reinforcing our commitment to data security for all FusionReactor users. This certification validates our stringent access controls, advanced encryption, and regular security audits, ensuring your application performance data and sensitive information remain protected.

!!! info 
    [Visit our Trust Center](https://trust.intergral.com/)

    
## Legal

  * [License](/Admin-and-data/Third-Party-Licenses/licenses/)
  * [Terms of Service](/Admin-and-data/tos/)
  * [Privacy Statement](https://www.intergral.com/privacy-statement/)
  * [GDPR](http://www.intergral.com/GDPR/)
  * [Patents](https://www.fusion-reactor.com/patents/)

___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.
