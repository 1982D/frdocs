# JDBC Monitoring

## Overview

FusionReactor JDBC Monitoring helps developers and administrators monitor and control database interactions in Java applications. It provides fine-grained metrics and reporting on database activity, including:

**Statement Logging**

- Records all statements executed against the database.

- Useful for:

    - Detecting deadlocks
    - Viewing statements without manual logging
    - Inspecting how Prepared Statements are bound before execution

**Row Limiting**

- Automatically halts read activity after a user-defined number of rows.

- Prevents runaway queries from consuming memory and resources.

**Notifications & Reminders**

- Sends alerts when a specified number of rows has been read.

- Can notify periodically as more rows are processed.

- Helps maintain visibility into data processing volume.

## Automatic monitoring

FusionReactor automatically monitors existing JDBC requests and communicates metric data directly into FusionReactor for easy analysis.


## Options

FusionReactor JDBC monitoring options let you control how metrics are tracked for each data source. These options can be set using:

- JDBC URL parameters, or

- JDBC properties of a data source.

You can use them to:

- Assign a custom name to a data source in FusionReactor.

- Exclude a JDBC data source from monitoring.

- Configure limits, notifications, and logging behavior.


### \_\_fusionreactor\_name

Value*: string*  
Default*: empty*


Assigns a custom name to the data source for reporting in FusionReactor.

- Appears in the JDBC log file (empty if not set).

- Shown in the JDBC tab of the Request Details page.

- Useful for distinguishing queries when using multiple data sources or testing different drivers.

### \_\_fusionreactor\_exclude

Value*: boolean*  
Default*: false*

If `true`, the data source will NOT report SQL metrics to FusionReactor.

### \_\_fusionreactor\_rowLimit

Value*:  integer*  
Default*:  0 (disabled).*

Limits the number of rows returned for a query.

- After the specified number of rows is retrieved, FusionReactor discards the rest.

- Helps prevent runaway queries from consuming resources.

### \_\_fusionreactor\_notifyAfter

Value*: integer*  
Default*: 0 (disabled).*

This option instructs the FusionReactor to output a notification after
'n' rows have been retrieved for the query.

### \_\_fusionreactor\_remindAfter

Value*: integer*  
Default*: 0 (disabled).*

This option instructs the FusionReactor to periodically output a query
reminder every 'n' rows.  If `notifyAfter` is specified, FusionReactor
will only begin reminding after the notification threshold has been
reached.  

!!! example
    notifyAfter=1000, remindAfter=100, actual rowcount 1350. <br> 
    Notification occurs at row 1000, reminders at 1100, 1200 and 1300.

### \_\_fusionreactor\_inhibitReformat

Value*: Boolean*  
Default*: false.*

Controls how queries are logged and displayed:

- By default, FusionReactor reformats queries into single-line form for readability.

- If `true`, queries are not reformatted, allowing multi-line formatting (useful if you want to preserve original formatting).

### \_\_fusionreactor\_logToFusionReactor

Value*: Boolean*  
Default*: true.*

If enabled (default) and FusionReactor is running:

- Query executions are logged to jdbc-X.log (where X is the rolling log number).

- If FusionReactor is not running, this option has no effect.

### \_\_fusionreactor\_interpretObjects

Value*: Boolean*  
Default*: true.*

Controls how `PreparedStatement.setObject(...)` parameters are logged:

- If `true` (default): FusionReactor calls `toString()` on objects for logging/reporting.

    - If the object doesn’t override `toString()`, the default hash code is used.

- If `false`: Parameters are logged as:

    {OBJECT java.class.name xyz}

where `xyz` is the `.toString()` output.

- Makes object type explicit, but less readable.

### \_\_fusionreactor\_autoCommit

Value*: Boolean  
*Default*: true*

If enabled, FusionReactor disables autocommit for all statements from this data source, regardless of current settings.

⚠️ Use with caution:

- Alters default JDBC behavior.

- Provided as a workaround for certain J2EE servers that require autocommit to be disabled.

- Not recommended for general use-must be tested carefully to ensure transactional integrity.

## Specifying JDBC Monitoring Options0

FusionReactor JDBC monitoring options can be configured in two ways:

### 1. Adding Data Source Properties (Preferred)

If your application server supports adding properties to the data source, configure FusionReactor options by:

* Adding a **data source property**
* Using the option name as the property key, and
* Setting the desired value

This is the **recommended approach**.

### 2. Modifying the JDBC URL

If your application server does not support custom data source properties, you can add options directly to the JDBC URL.

!!! example "Example (SQL Server with Microsoft driver):"

    ```
    jdbc:sqlserver://int0007:1433;databaseName=frtest;
    __fusionreactor_notifyAfter=1000;
    __fusionreactor_remindAfter=200;
    __fusionreactor_name=DataWarehouse
    ```

In this example:

* `notifyAfter`, `remindAfter`, and `name` are FusionReactor options.
* `databaseName` is a standard JDBC driver property.

!!! note
    Use data source properties when possible - it’s cleaner and preferred over modifying the JDBC URL.



## Excluding a Data Source from Monitoring

In some situations, you may not want FusionReactor to monitor a specific JDBC data source. You can disable monitoring by using the `__fusionreactor_exclude` option.

### Method 1: Data Source Property (Preferred)

Add the following property to your data source configuration:

```
__fusionreactor_exclude=true
```

### Method 2: JDBC URL

If your application server does not support adding custom properties, append the option directly to the JDBC URL.

!!! example "Example (SQL Server, Microsoft driver):"

    ```
    jdbc:sqlserver://int0007:1433;databaseName=frtest;__fusionreactor_exclude=true
    ```

When set to `true`, FusionReactor will not collect or report SQL metrics for that data source.




## Sample JDBC URLs

Below are sample JDBC URLs wrapped with the FusionReactor Driver Wrapper. These examples show how FusionReactor options can be embedded.

This is not a complete reference for JDBC URL syntax. Always check the documentation for your specific driver. In general, we recommend using vendor-provided drivers whenever possible.

### Oracle (Thin Driver)

Example with the `__fusionreactor_name` and `__fusionreactor_rowlimit` options (expanded syntax allows FusionReactor options to be added):


    jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=192.168.1.56)(PORT=1521))(CONNECT_DATA=(SID=orcl)(__fusionreactor_name=orclthin)(__fusionreactor_rowlimit=12345)))

    

### Oracle (Macromedia)

Using the `__fusionreactor_notifyAfter` option:

    jdbc:macromedia:oracle://int0234:1521;SID=testdb;__fusionreactor_notifyAfter=10000

### MySQL 4/5 (MySQL Commercial)

Using the MySQL commercial driver:

    jdbc:mysql://int00d6.intergral.com:3306/TestApp?tinyInt1isBit=false&__fusionreactor_name=mysqldb

### MySQL 5 Connector/J (MySQL)

Using the MySQL Connector/J driver, downloadable from
mysql.com.

    jdbc:mysql://int00d6.intergral.com:3306/TestApp?__fusionreactor_name=SQLServerDataSource

### MySQL (Macromedia)

Example with the `__fusionreactor_inhibitReformat` option:

    jdbc:mysql://int0003:3306/webshopdb?defaultFetchSize=400;__fusionreactor_inhibitReformat=true

### Microsoft JDBC Driver 4.0 for SQL Server (Microsoft)

Connection string with the `__fusionreactor_name` option:

    jdbc:sqlserver://int00d0:1433;databaseName=AdventureWorks;__fusionreactor_name=testdb

When username and password must be specified directly in the URL:

    jdbc:sqlserver://int00d0:1433;databaseName=AdventureWorks;user=scott;password=tiger;__fusionreactor_name=testdb

### Microsoft SQL Server (Macromedia)

Example using the `__fusionreactor_remindAfter` option and a custom name:

    jdbc:macromedia:sqlserver://int0007:1433;DatabaseName=frtest;__fusionreactor_remindAfter=500;__fusionreactor_name=SQLServerDataSource

### DerbyEmbedded (Apache Derby)

The Derby embedded database runs in-process within the JVM. Because the database starts and stops inside the JVM, you should only use it with a wrapped data source. Mixing wrapped and unwrapped access is not supported (although it may appear to work in some cases).

This example specifies the driver explicitly, along with its JAR, and uses the `__fusionreactor_autocommit` option:


    jdbc:derby:C:/ColdFusion10/cfusion/db/bookclub/;create=false;MaxPooledStatements=300;__fusionreactor_name=bookclubdb;__fusionreactor_autocommit=false


## Interpreting JDBC log data

When FusionReactor outputs data to the  [JDBC log file](../Logs/Files/JDBC-Log.md)
 (located in the FusionReactor instance log directory), the Driver Wrapper writes a series of fields that can be used to:

- Debug JDBC transactions

- Analyze system behavior

- Generate database resource usage statistics

The JDBC log file is space-delimited, with text fields enclosed in double quotes if they contain spaces.

This format can be easily imported into:

- Microsoft Excel

- OpenOffice Calc

- Microsoft SQL Server (via Data Transformation Packages)

### Field Order

The log fields are written left-to-right. Fields marked as “FusionReactor” may be empty if the query was not associated with a tracked request.

### Calendar date

*Value: YYYY-MM-DD*  
*Source: Wrapper*

Specifies the calendar date on which the log message was raised.

### Time

*Value: HH:MM:SS*  
*Source: Wrapper*

Specifies the 24-hour time at which the log message was raised.

### Epoch time

*Value: long millisecond*  
*Source: Wrapper*

Specifies the exact epoch time (millisecond offset from midnight on
January 1<sup>st</sup> 1970 UTC) at which the log message was raised.

### Fusion Request ID

*Value: long integer*  
*Source: FusionReactor*

Specifies the FusionReactor request ID within whose execution this JDBC
interaction occurred.

### Thread

*Value: String*  
*Source: Wrapper*

Specifies the name of the thread in which this JDBC interaction
occurred.

### Client IP

*Value: dotted quad IP address*  
*Source: FusionReactor*

Specifies the IP of the client for whom this request is running.

### HTTP Method

*Value: HTTP 1.X Method (GET / POST / HEAD etc.)*  
*Source: FusionReactor*

Specifies the HTTP method of the request which caused this JDBC
interaction

### URL

*Value: Full or Partial URL*  
*Source: FusionReactor*

Specifies the URL which caused this request to run.  If FusionReactor is
tracking complete URLs (which machine name) this will be a full URL.  If
not, this will be the path element.

### Log Message Type

*Value: One of METRIC, NOTIFICATION or REMINDER*  
*Source: Wrapper*

Specifies the type of this message.  *METRIC* reports the completion of
a JDBC interaction, NOTIFICATION specifies that a Notification threshold
has been reached on the size of the result set, and REMINDER specifies
that a result set size reminder interval has been reached.

### Execution Start Time

*Value: long millisecond*  
*Source: Wrapper*

The start time in milliseconds from the epoch datum (see **Epoch Time**
above) at which the JDBC interaction began (i.e. the time at which the
statement was transferred to the database driver for execution).

### Execution End Time

*Value: long millisecond*  
*Source: Wrapper*

The time at which the underlying database driver finished executing the
statement.

### Result Set Close Time

*Value: long millisecond*  
*Source: Wrapper*

The time at which the result set was closed by the J2EE application
(e.g. ColdFusion etc.).  This interval between this time and the
Execution Start Time is useful as the total processing time for the
query, including database execution time and the time taken for the J2EE
application to fully read and process the result set.

### Execution Elapsed Time

*Value: long millisecond*  
*Source: Wrapper*

The time taken to execute the statement on the database (computed from
Execution Start and End times)

### Result Set Elapsed Time

*Value: long millisecond*  
*Source: Wrapper*

The time taken between sending the statement to the underlying driver
for execution, and the J2EE application actually closing the result set
(computed from the Execution Start time and the Result Set Close Time)

### Rows Read

*Value: long*  
*Source: Wrapper*

Specifies the maximum number of rows read by the J2EE application.  If
the statement is not a DQL command (select etc.), but rather is
DML/DDL/RIGHTS (insert/update, drop/alter/create, revoke/grant etc.)
this value will be 0.

### Is Prepared Statement

*Value: boolean*  
*Source: Wrapper*

Specifies whether this statement was prepared in advance of its
execution.

### Is Row Limited

*Value: boolean*  
*Source: Wrapper*

Specifies whether the Row Limiter activated to stop the query.

### Datasource Name

*Value:  String*  
*Source: Wrapper*

Specifies the name of the datasource (specified by the JDBC **name**
parameter). Blank if the name was not specified.

### Statement

*Value: SQL String*  
*Source: Wrapper*

Specifies the statement which was run during this interaction.  Any
whitespace formatting in the original statement is flattened to allow
the statement to appear on one line.  If the interaction was a batch
execution, individual statements are delimited by \[\[ and \]\] strings.

### Stack Elements

*Value: Comma-separated list of Strings*  
*Source: Wrapper*

If FusionReactor is configured to record stack traces, this field
contains a comma-separated list of stack frames, recorded when the query
completed.  If the debug information is available, this field can be
used to locate the exact line in a script or Java program which caused
the interaction.

### URL Parameters

*Value: String*  
*Source: FusionReactor*

Contains the parameters which were present on the URL associated with
the request in which this statement is running.

### Message

*Value: String*  
*Source: Wrapper*

For NOTIFICATION or REMINDER log messages, this field contains the text
of the notification or reminder.

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.