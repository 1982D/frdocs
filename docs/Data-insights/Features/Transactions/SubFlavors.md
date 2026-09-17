# SubFlavors

**FusionReactor** monitors many requests and transactions of different
types. Through the use of Transit, **FusionReactor** is able to split these
requests and transactions into their different categories. These
categories are known as flavors. It is possible to break down these
flavors even further to sub-categories based on the different purposes
of the request. These categories are in turn, known as **subflavors.**

## SubFlavor examples

### Example 1: Subflavors for Web Requests

!!! example 

    -   **Web** would be the **flavor** of the request.
    -   Different **subflavors** of this would be the **HTTP methods** of
        the Web Request, such as:
        -   **GET**
        -   **POST**
        -   **DELETE**
        -   **OPTIONS**
        -   **PUT**
        -   **CONNECT**

### Example 2: Subflavors for JDBC Requests

!!! example
    -   **JDBC** would be the **flavor** of the request.
    -   Different **subflavors** of this would be the statement types, such
        as:
        -   **CREATE**
        -   **UPDATE**
        -   **INSERT**
        -   **DELETE**

These subflavors can be monitored by **FusionReactor** to give an even
further breakdown of what is happening on an application server.

!!! info
    New flavors and subFlavors will only appear after a page refresh. Using the refresh timer will not show any new subflavors as they are detected by **FusionReactor**.

### Custom SubFlavors

Through [FusionReactor's API (FRAPI)](/Data-insights/Extras/FRAPI/), it is possible to
create your own flavors and subflavors. Use the code below:

```java
final BaseTransaction transaction = FRAPI.getFRAPI().createTransaction("flavor");

transaction.setSubFlavour("subFlavor");

transaction.close();
```
___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.