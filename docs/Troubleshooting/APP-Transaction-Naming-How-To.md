# How to set application or transaction names with FRAPI

In most cases the default **application** and **transaction** names will suffice when using FusionReactor, however if you run into any issues or want to customize the names yourself, you can use FRAPI.

The application and transaction name can both be set by FRAPI for use in ColdFusion and Lucee, which will be prioritized over any other names. Auto application/transaction naming is enabled by default in FusionReactor and will prioritize FRAPI application/transaction names.

!!! info "Learn more"
    [Application](/Troubleshooting/Configuration/Application-Naming-Configuration/) & [Transaction naming](/Troubleshooting/Configuration/Transaction-Naming-Configuration/)


## Application

To set an application name in ColdFusion and Lucee, use the following CFML code and change application name as required:

```
<cfset frapiClass = createObject("java", "com.intergral.fusionreactor.api.FRAPI")> <cfset frapi = frapiClass.getInstance()> <cfset dateClass = createObject("java", "java.util.Date")>

<cfscript>
FRAPI.setTransactionApplicationName("Application Name");
</cfscript>

```


## Transaction
To set a transaction name in ColdFusion and Lucee, use the following CFML code and change transaction name as required:

```
<cfset frapiClass = createObject("java", "com.intergral.fusionreactor.api.FRAPI")> <cfset frapi = frapiClass.getInstance()> <cfset dateClass = createObject("java", "java.util.Date")>

<cfscript>
FRAPI.setTransactionName("Transaction Name");
</cfscript>
```


Any change to the application or transaction name is reflected in FusionReactor as shown below:

![!Screenshot](/Troubleshooting/images/apptxn1.png)

![!Screenshot](/Troubleshooting/images/apptxn2.png)

In this example the application name was set to “Application Query”, and transaction name was set to “Transaction Query”.

## Reducing cardinality through appropriate name choice

In order to identify applications and transactions efficiently in Cloud, it is important to choose an appropriate name as the choice of name can lead to high cardinality which is undesirable. 

### Application naming tips

The application name acts as a fundamental identifier for a specific application or service within the monitoring environment. By choosing a descriptive and consistent application name, users can effortlessly differentiate between different applications and modules, providing valuable context for performance analysis. Moreover, a well-chosen application name enables effective grouping of related transactions and requests, simplifying data aggregation and reducing cardinality. This reduction in cardinality optimizes data storage, processing, and resource utilization, ensuring a more efficient monitoring experience.


!!! example "Application names"
    MyApp ❌ <br>
    AppU1234abdc ❌<br>
    MyShop ✅

### Transaction naming tips

Choosing appropriate transaction names is crucial for effective monitoring and analysis in FusionReactor. A well-chosen transaction name provides meaningful insights into the flow of requests and aids in pinpointing bottlenecks or performance issues. It enhances the clarity of data representation and simplifies the navigation through large volumes of transactional data. Selecting appropriate transaction names can help reduce cardinality in the monitoring data. When transaction names are not well-chosen or are overly granular, each unique operation or request can be treated as a separate transaction, even if they are functionally similar. This can result in a large number of unique transaction names, leading to higher cardinality. 

!!! example "Transaction names"
    MyTxn ❌ <br>
    /products/product1234 ❌<br>
    products/{product.ID} ✅


____

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.



