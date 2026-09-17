# How to name a transaction 

The transactions you see in FusionReactor will by default use the automatic transaction naming detection in FusionReactor.

The automatic transaction naming uses information about the type of request and framework to create transaction names that will typically provide sufficient details about the transaction.

The order for which automatic transaction naming searches is:

1. FRAPI.setTransactionName
1. Request attribute
1. Supported framework
1. ColdFusion page name
1. JSP class name
1. Servlet init parameter
1. Servlet name
1. Filter init parameter
1. Filter name
1. Default transaction name

If you are running a custom routing mechanism, or unsupported framework the information provided by FusionReactor may not be sufficient, in which case you will need to modify the transaction Naming Settings under the [FusionReactor Menu Settings](/Data-insights/Features/Settings/Main-Menu/).

## Setting the transaction name

### FRAPI.setTransactionName

To set the transaction name with the FusionReactor API (FRAPI), simply call the appropriate method within your code. This method of setting the transaction name takes precedence over all other methods, however it will only affect the single request where this method is called.

```java
FRAPI.setTransactionName("Transaction Name");
```

### Request attribute

To set the transaction name with a request attribute simply add the attribute to the request object. FusionReactor will then use this attribute as the transaction name when the request is complete. This approach will only affect the requests where this attribute is set.

```java
    request.setAttribute("fr.transaction.name", "Transaction Name");
```

### Supported framework

With the supported frameworks of FusionReactor, annotations in the frameworks will be used for application naming.

For example, in Spring boot, the @RequestMapping annotation will be used.

### ColdFusion page name / JSP class name

If you are using a framework that is not yet supported by FusionReactor, then FusionReactor will use the name of the page of JSP class or CFML file as the transaction name.

 For example AddToCart.jsp or AddToCart.cfc.

### Servlet init parameter

To set the transaction name used by FusionReactor as a servlet init parameter, edit the servlet configuration and add the property fr.transaction.name with the value being the name of the transaction. This can be done via the web.xml adding the parameter to the filter definition.

```xml
<servlet>
    <servlet-name>Servlet2</servlet-name>
    <servlet-class>com.intergral.fusionreactor.servlets.Servlet2</servlet-class>
    <init-param>
        <param-name>fr.transaction.name</param-name>
        <param-value>Transaction Name</param-value>
    </init-param>
</servlet>
```

### Servlet name

If you are using servlets to serve your requests and do not use JSP pages or a supported framework. FusionReactor will use the name of the servlet as the transaction name. Unless you have defined the transaction name via the servlet init parameter.

### Filter init parameter

To set the transaction name used by FusionReactor as a filter init parameter, edit the filter configuration and add the property fr.transaction.name with the value being the name of the transaction. This can be done via the web.xml adding the parameter to the filter definition.

```
<filter>
    <filter-name>Filter3</filter-name>
    <filter-class>com.intergral.test.fusionreactor.filters.Filter3</filter-class>
    <init-param>
        <param-name>fr.transaction.name</param-name>
        <param-value>Transaction Name</param-value>
    </init-param>
</filter>
```

### Filter name

If you are using filters to serve your requests and do not use JSP pages or a supported framework. FusionReactor will use the name of the filter as the transaction name. Unless you have defined the transaction name via the filter init parameter.

## Default transaction name

If none of the above methods detect a transaction name, the default transaction name will be used.

## Getting the transaction name via URL parameter

When using the **Parameter** option you are presented two
configuration settings:

-   **Parameter name** - This is the name (or key) for the Request
parameter you would like to use.
-   **SES enabled** - This option allows you to use the SES (Search
Engine Safe) URL options, primarily used in the CFML frameworks.

If you have an application using a custom framework which uses the
parameter **event** to identify the page, class, or function to call when
the request is received, then set the **Parameter name** to be **event**.
FusionReactor will then set the transaction name to the *value* of this
**event** request parameter when the WebRequest is processed.

If **SES Enabled** is not selected, FusionReactor will search the
querystring to find the named parameter. If **SES Enabled** is selected,
it will search the URL for slash-separated values to find the named
parameter. (If you want to name the element by its ordinal/relative
location in the URL, use the **URL Element** option instead.)

You can also use this **Parameter** option when using POST parameters, as
long as you use form-data or x-www-urlencoded form data. These are then
interpreted as request parameters by the web server. However, you cannot
use raw post body data to set the parameters, as this is not interpreted
as a request parameter by the web servers.

### Example: Parameter without SES

If **Parameter name** is set to **event**, SES is disabled and a request comes in as
[http://www.example.com/users?event=newUser](), the transaction name will become **newUser**.

### Example: Parameter with SES

If **SES Enabled** is used, and the request is [http://www.example.com/users/event/newUser](), the URL element after the key word **event** is the name for the transaction: **newUser**.

## Getting the transaction name via URL Element

When using the **URL Element** option, you are given a single additional
configuration field **SES Element Offset**. This is the URL element that
you want to use as the transaction name. A URL element is defined as a
section in the URL that is between a slash ( / ), so with the URL
[http://www.example.com/event/newUser]()
the URL elements would be:

-   **1** - event
-   **2** - newUser

And you would want to use 2 as the **SES Element Offset**, to have
FusionReactor identify the transaction as **newUser**.
