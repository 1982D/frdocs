title: Transaction Logger
# FusionReactor Transaction Logger Plugin

The FusionReactor Transaction Logger Plugin is used to log transactions to a log file.
These transactions logged can be filtered from logging by their type and duration. These
log file entries can be used keep record of certain transactions (as an
example either transactions of a certain flavor or transactions that
have run for a long time). This information can be useful when trying to
inspect the performance of certain parts of your application, or to keep
a record of any long running requests for further analysis.

## Log Format

Log entries are in a standard format which is shown below:

*&lt;Local-Date/Time of log entry&gt;
&lt;*UTC *StartTime of
Transaction *(in ms)*&gt;
&lt;LogFile Version&gt; &lt;*UTC *ServerStart Timestamp (in ms)&gt; &lt;Duration *(in ms)*&gt; &lt;Transaction Global
ID&gt; &lt;Transaction Per Type ID&gt; &lt;Parent Transaction Global
ID&gt; &lt;Parent Transaction Per Type ID&gt; &lt;Transaction Type&gt;
&lt;Transaction Description + QueryString/Sql Statement&gt;*

**Note**: Any field that is not present
in a transaction log entry will be indicated by **""**.

Below can be seen an example excerpt
from a transaction log:

![](/attachments/245548275/245548292.png)


As can be seen from this example these are two connected transactions.
The parent transaction is WebRequest and it has a child HTTPClient
transaction. This relationship is indicated by the *>Parent Transaction Global ID & Parent
Transaction Per Type ID *fields
on the HTTPClient transaction which match the *Transaction Global ID & Transaction Per Type
ID *fields of the WebRequest. In
this way the two transactions are linked together.

To
define the meaning of these two different fields: *Global ID* is the the
unique ID of the Transaction within the pool of all transactions, of all
types. In contrast the Transaction* Per Type ID *is the ID of the
Transaction in the pool of transactions of that type. To illustrate the
above image shows that the HTTPClient is the 17th transaction to have
been recorded by FusionReactor, but it is the 1st HTTPClient transaction
in the system.

Below is another example which shows a
JDBC transaction and its parent:

[![](/attachments/245548275/245548286.png)](/attachments/245548275/245548286.png)

This excerpt shows a parent WebRequest transaction with its child JDBC
transaction. Note how the final field changes for the JDBC transaction
entry to show the SQL Statement executed rather than the URL of a
WebRequest transaction.

**Note:** The log entries will appear back to front when looking at
Parent & Child transactions. This is due to the fact that the log entry
is not written until the transaction is finishing. As all of the Child
transactions must finish before the Parent itself can be finished;
Children will always be displayed above the Parent.

## Configuration

The Transaction Logger | Configuration (accessible from
the [Active Plugins](Overview.md#active-plugins) page)
allows you to alter the following settings:

|Configuration|Description|
|--- |--- |
|Enable/Disable Transaction Logger|This allows you to enable/disable whether or not the email is sent.|
|Transaction Type Whitelist|The Whitelist of transaction types that should be tracked.|
|Transaction Type Blacklist|The Blacklist of transaction types that should not be tracked.|
|Runtime threshold for transactions (ms)|This setting effects the threshold of how long a transaction must be run for, for it to be logged.|


### Initial Setup

The plugin has a default configuration which is as follows:

-   **Disabled **and will not log transactions until it is enabled. 
-   **Runtime-threshold **is set to 100ms, and no transactions that run
    for a shorter duration than this will be logged.
-   **Whitelist **is blank by default and this means that all
    transaction types will be logged (if the plugin is enabled, the
    transaction duration is above the configured threshold and the
    transaction **is not** in the Blacklist).
-   **Blacklist** is blank by default and this means no transaction
    types will be omitted from the Transaction Log.

### Whitelist/Blacklist Rules


The Whitelist & Blacklist are
both **case-insensitive**, **comma-separated **lists
of transaction types. The rules for filtering transactions are as
follows:

-   **Whitelist:** Any type in the Whitelist **will be** logged. Default
    is blank and will log any transaction type that is not found in the
    Blacklist.

-   **Blacklist: **Any type found in the Blacklist will **not** be
    logged, regardless of it is also in the Whitelist.

#### Example Whitelists/Blacklists

-   **Whitelist:**
    WebRequest,HTTPClient,JDBCRequest
-   **Blacklist:** HTTPClient

The above example will log only WebRequest & JDBCRequest transactions.
HTTPClient transactions **will not** be logged as this type is found on
the Blacklist.

-   **Whitelist:** 
-   **Blacklist:** WebRequest

This example will log all transaction
types **except for** WebRequest transactions as this type is found in
the Blacklist.

### Transaction Types

There are a number of FusionReactor defined transaction types:

-   WebRequest
-   HTTPClient
-   JDBCRequest
-   CFHTTP
-   MongoDB - *(All MongoDB transaction types)*
-   MongoDB**:**&lt;Operation Name&gt;
    -   e.g. MongoDB**:**find - Will only filter MongoDB Find
        transactions.
