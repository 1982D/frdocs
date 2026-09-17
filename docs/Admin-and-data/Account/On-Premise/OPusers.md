# Users

FusionReactor has three user accounts / roles

1.  [Administrator](#administrator)
2.  [Manager](#manager)
3.  [Observer](#observer)

##  Roles

!!! note
    FusionReactor uses three fixed roles instead of individual user accounts. Each role has its own password rather than per-user credentials.

   

### Administrator

The Administrator role in FusionReactor provides complete system access and control.

Administrators can:

- Manage FusionReactor instances, including creation, configuration, and maintenance.
- Configure Enterprise Dashboard visibility and integration (Enterprise edition).
- Set up Crash Protection and adjust all instance settings.
- Control user accounts and access permissions.
- Manage license keys and activation.
- Monitor all system metrics and request data.
- Terminate running requests when needed.
 


!!! note
    Some features require an Enterprise license or higher.

#### Best for
- DevOps teams managing multiple server instances.
- System administrators requiring full system control.
- Organizations needing centralized FusionReactor management.
- Teams deploying enterprise-wide monitoring solutions.


!!! example
    In hosting environments this account might be used by the hosting provider to configure FusionReactor for customers on their application server instances.


### Manager

Managers are instance-level administrators who can manage a single FusionReactor installation.

Capabilities:

- Configure instance settings in Enterprise Dashboard.
- Add new instances (with admin credentials).
- Control server online/offline status.
- Configure Crash Protection and instance settings.
- Manage user accounts (Manager and Observer).
- Access all request and metric data.
- Kill running requests.


#### Best for

Application server administrators who need full control over a single FusionReactor instance.

!!! example
    In hosting environments this account might be used by the customer's application administrator.

### Observer

Observers have read-only access to view:

- Current and historical requests.
- System metrics and logs.
- Resource usage and reports.
- Enterprise Dashboard data.
- JDBC activity and logs.

!!! note
    Some features require Enterprise Edition


#### Best for
Developers and analysts who need to monitor application performance metrics.

!!! example
    Development teams often use Observer access to analyze production performance.

### Enterprise Dashboard

Clicking any server link on the Enterprise Dashboard automatically logs you into that server's FusionReactor instance with your current user permissions.

!!! example
    A Manager on an instance monitoring another instance of FusionReactor will also be granted Manager-level access to the monitored instance.  

!!! info "Learn more"
    [Enterprise Dashboard](/Data-insights/Features/Enterprise-Dashboard/Enterprise-Dashboard/)

## Access management configuration
FusionReactor Identity manages system access through role-based authentication. It replaces the previous password management system in versions 8.2.0 and above.
Authentication Providers

- Role/Password System (Default): Available to all users
- X.500/LDAP Directory Server: Available with Enterprise licenses


### Global settings

The **Global Settings** section allows you to select which of the
available providers is used as the primary login mechanism for
FusionReactor.  Use the **Preferred Identity Provider** dropdown to
select this.

By default, the **FusionReactor Role/Password Login** provider is used. 
If you select another provider here, it will be used to authenticate
users.

!!! note
    The Role/Password login remains available as a fallback option even when another provider is set as primary. Access it via "Log in using Role/Password" on the login page.

### Role/Password login

This is the login mechanism which was previously available.  The
standard roles (**Administrator, Manager, Observer**) are all managed
from this tab.

-   To **enable a role**, enter a password for it and click **Save Login
    Settings**.
-   To **disable a role**, click on the appropriate **Disable...**
    button.  There is no need to click **Save Login Settings**

!!! info
    Administrator role cannot be disabled.

-   To **change a role password**, enter the existing password and the
    desired new password twice, and click **Save Login Settings**.

!!! info "Learn more"
    [Roles](/Admin-and-data/Account/On-Premise/OPusers/#roles)



## Account activation

### Initial setup

- Administrator password is required during installation.
- Manager and Observer passwords are optional.
- Accounts without passwords remain disabled.

### Enable accounts

Navigate to **FusionReactor > Manage Logins** to enable accounts:
1. Enter a password for the desired role.
2. Click **Save Password** to activate immediately.

!!! note
    The Administrator account must always have an active password and cannot be disabled.




### Disable accounts

From **FusionReactor > Manage Logins**:

- Click **Disable Manager** or **Disable Observer**to deactivate accounts
- Disabling takes effect immediately.
- Re-enable accounts by setting a new password.


!!! note
    The Administrator account cannot be disabled.


## X.500/LDAP login


Organizations using an X.500/LDAP-compliant Directory Server (including
Active Directory) can use this provider to manage access to
FusionReactor for their existing users.

The X.500/LDAP Login provider accepts a username and password from the
login page, and uses three
<a href="https://ldap.com/ldap-filters/" class="external-link">LDAP Filters</a>
to attempt to authenticate the user.

![](/attachments/245548444/256213075.png)

*Example X.500/LDAP Login Dialog*

### Configuration

| Field | Description |Example |
|--- |--- |--- |
||**General Settings**||
|Login Header |Shown as a bold title over the first login field.  Not shown if empty.	|Dewey, Cheatem & Howe, Attorneys at Law|
|Login Help | Shown italicized under the Log In button. Not shown if empty. | Trouble logging in? Call IT on 4242! |
|Label for Username Input Box | Used to label the upper (usually username or email address) input box.  "Username" by default.|	DCH Corporate Email Address|
|Label for Password Input Box|	Used to label the lower input box.  "Password' by default.	|Password|
||**Directory Server Settings**||
|X.500/LDAP Server Hostname	|The hostname of the server on which the LDAP/X.500 directory server runs. 	|ds1.dch.com|
|X.500/LDAP Server Port |The port at which the directory server is listening.  Customarily, this is 389 for unsecured and 636 for secured (TLS) connections	|389|
|Use TLS/SSL Encrypted Connection|	Whether FusionReactor should attempt to encrypt the connection.  This requires explicit TLS support in the sever.	|Disabled|
|X.500/LDAP Bind DN	|The Distinguished Name (DN) of a user which is able to run LDAP Search Requests against the server|	uid=admin,ou=system|
|X.500/LDAP Bind Password|	The password for this user.	|pencil|
|X.500/LDAP Search Base DN|	The DN describing the LDAP Search Base. Queries will start at this point in the X.500 tree. No objects above this base will be matched.	|dc=dch,dc=com|
| Test Login| This button uses the information from the Directory Server settings to try to log in.  The success or failure of the login is displayed, along with any additional information. If the configuration is valid, click Save Login Settings to make it permanent.||
||**Fallback Server Settings**||
|X.500/LDAP Server Hostname for the fallback server|The hostname of the server on which the LDAP/X.500 fallback server runs.|ds1.dch.com|
|X.500/LDAP Server Port for the fallback server|The port at which the fallback server is listening.  Customarily, this is 390 for unsecured and 637 for secured (TLS) connections	|390|
|Use TLS/SSL Encrypted Connection|	Whether FusionReactor should attempt to encrypt the connection.  This requires explicit TLS support in the sever.|Disabled|
|X.500/LDAP Bind DN	for the fallback server|The Distinguished Name (DN) of a user which is able to run LDAP Search Requests against the fallback server|uid=admin,ou=system|
|X.500/LDAP Bind Password for the fallback server|The password for this user.|pencil|
|X.500/LDAP Search Base DN for the fallback server|	The DN describing the LDAP Search Base. Queries will start at this point in the X.500 tree. No objects above this base will be matched.	|dc=dch,dc=com|
||**Role to User Mapping**||
|Administrator,Manager,Observer| These are LDAP filters and have a specific syntax.  For more examples see the next section.<br>If present in the filter, the text {{USERID}} is replaced with the users' username.||
|Validate Filters|	This button checks the syntax of three filter boxes above.  If they are valid, click Save Login Settings to make them permanent.||

### LDAP authentication setup

#### Fallback server
Configure a backup LDAP server to ensure continuous access if the primary server fails:

- Uses same configuration as primary server.
- Automatic failover on connection issues.
- May require different port settings.

#### Role assignment
Customize LDAP filters to match your organization's directory structure:

- Separate filters for Administrator, Manager, and Observer roles.
- Flexible mapping to accommodate any directory layout.
- Supports complex organizational hierarchies.

### LDAP authentication process

#### Login flow
1. User provides username and password.
2. System connects to Directory Server.
3. Executes role filters sequentially.
   - Replaces `{{USERID}}` with entered username.
   - Stops at first filter returning exactly one record.
4. Authenticates user credentials against matched record.
5. Grants access with the corresponding FusionReactor role.

#### Filter requirements
- Must return zero or one record.
- Empty filters are skipped.
- Multiple matches trigger an error (ambiguous identity).

!!! info "Learn more"
    For help with LDAP filter syntax, use [OpenLDAP's](http://www.openldap.org/) `ldapsearch` tool or [Apache Directory Studio](https://directory.apache.org/studio/).



#### Example filters


**Directory Tree Filter**

```
(&(objectClass=person)(ou:dn:=operations)(mail={{USERID}}))
```
Matches users who:
- Are people (not resources).
- Belong to the operations department.
- Have a matching email address.

**Active Directory Filter**

```
(&(objectClass=user)(sAMAccountName={{USERID}})(memberof=CN=fradmins,CN=Users,DC=testdomain,DC=com))
```
Matches users who:
- Have a user account type.
- Match the provided login ID.
- Belong to the specified AD group (e.g., fradmins).

!!! tip
    Create separate AD groups for Administrators, Managers, and Observers to simplify role management.



#### Error codes

If a login fails, FusionReactor will supply some text (in red) to the
user, along with an error code:


|Code|Title|Explanation|
|--- |--- |--- |
|LD01|Auth failed, no entries.|FusionReactor ran all configured filters, but no record was returned.  The credential may be wrong.  The filters should be tested with a concrete username.|
|LD02|Auth failed, too many entries.|One of the filters returned more than one record.  This is not allowed - users must be unambiguously identified.  The filters should be checked with the attempted username and refined to return only a single record.|
|LD03|Error|A general error was returned from the LDAP API.  The identity.log log file may have more details.|
|LD04|Bind Rejected|FusionReactor couldn't log in to the Directory Server to try the filters.  Check the Bind DN and Bind Password in FusionReactor > Manage Logins > FusionReactor X.500/LDAP Login using the Test Login button.|
|LD05|Test Bind Rejected|The supplied username was used by a filter to retrieve a single record, but the password was not correct.|
|LD06|Role Disabled|The supplied username was used by a filter to retrieve a single record, and the password was validated, but the role to which the filter was attached is disabled.  If you wish this user to log in with this role, enable the role by assigning a password to it in FusionReactor > Manage Logins > FusionReactor Role/Password Login|


