# Users
FusionReactor has three user accounts / roles

1.  [Administrator](#administrators)
2.  [Manager](#managers)
3.  [Observer](#observers)

##  Roles

!!!note
    FusionReactor does not have individual users with user names and
    passwords, but three fixed roles each of which has its own password.

    FusionReactor supports three different types (or levels) of user role:

    -   Administrators
    -   Managers
    -   Observers

### Administrators

Administrator is the most powerful type of user role in FusionReactor.
They are able to access all of the functions available in FusionReactor:
(Note: some features are only available on Enterprise licenses and
above)

-   Creating and Maintaining new instances of FusionReactor on a
    computer
-   Configuring the FusionReactor instances visible to the Enterprise
    Dashboard (Enterprise only)
-   Configure Crash Protection and all other settings for an instance of
    FusionReactor
-   Managing All User Accounts
-   Uploading and Activation of License Keys
-   Examine All Request and Metric Data
-   Kill Running Requests

#### Who should use the Administrator Role?

The Administrator should be used by users who need to create and
maintain the instances of FusionReactor on computer, setup and manage
the instances that are visible on any Enterprise Dashboard and maintain
the user roles. For example, in hosting environments this account might
be used by the hosting provider to configure FusionReactor for customers
on their application server instances.

### Managers

Managers are "Instance Administrators". They Manage or Administer a
single instance of FusionReactor. They are able to: (Note: some features
are only available on Enterprise Versions)

-   Configuring the FusionReactor instances visible on this instance's
    Enterprise Dashboard
-   Add instances visible on this instance's Enterprise Dashboard (if
    they have the Administrator account password for the instance they
    wish to add)
-   Online and Offline Servers in the Enterprise Dashboard
-   Configure Crash Protection and all other settings for this instance
    of FusionReactor
-   Managing Their User Account and the Observer Account
-   Examine All Request and Metric Data for this instance
-   Kill Running Requests

#### Who should use the Manager Role?

The Manager account should be used by users who need to manage or
administer an application server. For example, in hosting environments
this account might be used by the customer's application administrator.

### Observers

Observers are only able to view the following information on a specific
instance: (Note: some features are only available on Enterprise
Versions)

-   View the Running Request
-   View the Request History
-   View the Request Log
-   View the Enterprise Dashboard
-   View the System Metrics
-   View the Longest Requests, Slow Request and Longest JDBC Request
    Reports
-   View the Resource Reports and Graphs
-   View the Resource Log, Crash Protection Log and JDBC Log
-   View the Help and About Information

#### Who should use the Observer Role?

The Observer account should be used by users who need to examine the
performance and metrics from an application server. For example, in
hosting environments this account might be used by the customer's
application developers to examine how well the application performs in
production.

### Enterprise Dashboard

When a user clicks on a link on the Enterprise Dashboard for a monitored
server they are transferred to that server instance of FusionReactor
with the same level of user account that they are logged in as. For
example, this means that a Manager on an instance that is monitoring
another instance of FusionReactor will be granted Manager level access
to the other instance of FusionReactor.

See [Enterprise Dashboard](../Enterprise-Dashboard/Enterprise-Dashboard.md)

## Configuration

In FusionReactor 8.2.0 and above the previous **Change Password** page
has been refactored into a more general system for managing access to
FusionReactor.  This system is known as **FusionReactor Identity**, and
supplies functionality for managing access using
the usual **Role/Password **system, as well as allowing us to add
further providers in the future.

Customers with ENTERPRISE licenses
or above now have immediate access to an additional provider,
the **X.500/LDAP Directory Server** system.  See the section below for
more details!

### Global Settings

The **Global Settings** section allows you to select which of the
available providers is used as the primary login mechanism for
FusionReactor.  Use the **Preferred Identity Provider** dropdown to
select this.

By default, the **FusionReactor Role/Password Login** provider is used. 
If you select another provider here, it will be used to authenticate
users.

-   The **FusionReactor Role/Password Login** provider is always
    available, regardless of the **Preferred Identity Provider.  **It is
    accessible on the login page by clicking the link entitled "Log in
    using Role/Password".
-   This is to enable you to log in to the system, even when a provider
    is misconfigured.

### Role/Password Login

This is the login mechanism which was previously available.  The
standard roles (**Administrator, Manager, Observer**) are all managed
from this tab.

-   To **enable a role**, enter a password for it and click **Save Login
    Settings**.
-   To **disable a role**, click on the appropriate **Disable...**
    button.  There is no need to click **Save Login Settings**.
    -   The **Administrator** role cannot be disabled.
-   To **change a role password**, enter the existing password and the
    desired new password twice, and click **Save Login Settings**.

More information about the different Role types can be found [here](#roles).

#### Enabling Accounts

During the installation process you must enter a password for the
Administrator account, but you can also enter a password for the Manager
and Observer accounts. If you do not enter a password for an account
during the installation process, the account will be disabled. 

#### Enabling a User Account

!!!warning
    The Administrator account is always enabled and must have a password
    assigned. Note that when you enter a password and click on the \[Save
    Password\] button the account becomes active immediately.

You can enable the manager and observer accounts at any time by entering a password for the
account on the FusionReactor > Manage Logins screen. When you enter password
and click on the \[Save Password\] button, the account becomes active
immediately.

#### Disabling a User Account

The Manager and Observer accounts can be disabled using the \[Disable
Manager\] and \[Disable Observer\] buttons the FusionReactor > Manage
Logins screen. An account will be
disabled immediately after clicking on the Disable button for the
account. To enable an account again you must enter a password for the
account.

### X.500/LDAP Login


Organizations using an X.500/LDAP-compliant Directory Server (including
Active Directory) can use this provider to manage access to
FusionReactor for their existing users.

The X.500/LDAP Login provider accepts a username and password from the
login page, and uses three
<a href="https://ldap.com/ldap-filters/" class="external-link">LDAP Filters</a>
to attempt to authenticate the user.

![](/attachments/245548444/256213075.png)

*Example X.500/LDAP Login Dialog*

#### Configuration

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

#### Using an X.500/LDAP Fallback Server

An X.500/LDAP Fallback Server, identical to the primary Directory Server, 
should be set up as insurance in the event that the  Directory Server fails. 
FusionReactor will automatically attempt to reroute the connection to the 
Fallback Server upon a Directory Server connection failure. 
Barring the Port settings, the remaining Fallback Server configuration settings 
are likely to be identical to the Directory Server settings.

#### Using LDAP Filters To Validate Users

There is no standard layout for X.500/LDAP Directory Servers.  Many
organizations have tens of thousands of employees, and their methods of
partitioning these employees vary wildly. FusionReactor therefore makes
no assumptions about how users should be assigned roles, and provides
three Filter boxes, so you can use your own LDAP Filters.

#### How FusionReactor X.500/LDAP Login Validates Users

Users are validated using the following workflow.

1.  The user enters their username and password.
2.  FusionReactor connects to the Directory Server.
3.  Each Filter is run in order, until one returns **exactly one
    record**. The text **{{USERID}} **is replaced with the username
    supplied by the user prior to running the query.
4.  The filter which supplied one record is used as the
    proposed **FusionReactor Role.**
5.  The record retrieved by the filter is used in conjunction with the
    supplied password to authenticate the user.
6.  If the authentication succeeds, the user is logged in to
    FusionReactor with the role of the matching filter, and no further
    filters are tried.

Any mapping which does not have any filter text is skipped.

A filter must therefore return either **zero** or **one **record.  A
filter which returns more than one record for a given **{{USERID}}**
constitutes an ambiguity (users muse be unambiguously identified) and
FusionReactor will  stop trying to log the user in in this case, and
return an error (see below).

It is not within the scope of this document to discuss LDAP Filter
syntax.  We recommend using
the <a href="http://www.openldap.org/" class="external-link">OpenLDAP Project</a>'s
command-line `ldapsearch` tool, or
the <a href="https://directory.apache.org/studio/" class="external-link">Apache Directory Studio</a> to
test your filters.

However, we will provide two worked examples, to get you going.

#### Example Filters

*** Directory Tree Match ***

```
(&(objectClass=person)(ou:dn:=operations)(mail={{USERID}}))
```

Selects records from the directory tree which fulfill all the criteria:

 * objectClass=person - we only want to see people, not resources like printers, or meeting rooms.
 * ou:dn:=operations - we only want to see people whose Distinguished Name (their unique position in the directory tree) includes the ou (an Organizational Unit) called "operations".
 * mail={{USERID}} - only selects a person whose mail attribute matches the address entered on the login form.

This example would therefore retrieve the record of anyone in the operations department, provided the entered email address was located.

*** Active Directory ***

```
(&(objectClass=user)(sAMAccountName={{USERID}})(memberof=CN=fradmins,CN=Users,DC=testdomain,DC=com))
```

This is an Active Directory query.

 * objectClass=user - again, only select records whose type includes user.
 * sAMAccountName={{USERID}} - only selects a user whose Active Directory user ID is that supplied by the user at login.
 * memberof=CN=fradmins,CN=Users,DC=testdomain,DC=com - this selects only user records where that user is a member of a specific Active Directory group; in this case fradmins.

Using Active Directory groups like this allows a flexible approach to assigning FusionReactor roles:  simply create three new AD groups and add your Administrators, Managers and Observers to them.

#### Error Codes

If a login fails, FusionReactor will supply some text (in red) to the
user, along with an error code.  Refer to the table below for
more details.

|Code|Title|Explanation|
|--- |--- |--- |
|LD01|Auth failed, no entries.|FusionReactor ran all configured filters, but no record was returned.  The credential may be wrong.  The filters should be tested with a concrete username.|
|LD02|Auth failed, too many entries.|One of the filters returned more than one record.  This is not allowed - users must be unambiguously identified.  The filters should be checked with the attempted username and refined to return only a single record.|
|LD03|Error|A general error was returned from the LDAP API.  The identity.log log file may have more details.|
|LD04|Bind Rejected|FusionReactor couldn't log in to the Directory Server to try the filters.  Check the Bind DN and Bind Password in FusionReactor > Manage Logins > FusionReactor X.500/LDAP Login using the Test Login button.|
|LD05|Test Bind Rejected|The supplied username was used by a filter to retrieve a single record, but the password was not correct.|
|LD06|Role Disabled|The supplied username was used by a filter to retrieve a single record, and the password was validated, but the role to which the filter was attached is disabled.  If you wish this user to log in with this role, enable the role by assigning a password to it in FusionReactor > Manage Logins > FusionReactor Role/Password Login|
