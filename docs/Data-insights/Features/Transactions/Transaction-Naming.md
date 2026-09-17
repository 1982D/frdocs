# Transaction Naming

Transaction names are important in FusionReactor, because they give
context to the transactions and web requests you are monitoring.
Depending on which framework your application is written in,
FusionReactor may be able to automatically determine the transaction
name e.g. Java Spring Framework or some of the ColdFusion frameworks,
such as ColdBox.

The transaction name (App/Txn) is made visible in various views, such as
the **Transaction or Request History**.

![](/attachments/288489490/288391179.jpg)

In this example App is *Struts 2* and Txn is the actual transaction name
which is extracted from the application URL e.g. *addToCart.action*.
FusionReactor has different methods available to define what determines
the transaction name displayed.

In this example, we are using the Transaction Page Identifier Type = URL
element with the SES (Search Engine Safe) Element Offset = 3, which can
be seen in the example below.

![](/attachments/288489490/288391191.jpg)


## Example using URL Element

When using the **URL Element** option, you are given a single additional
configuration field **SES Element Offset**. This is the URL element that
you want to use as the transaction name. A URL element is defined as a
section in the URL that is between a slash ( / ), so with the following
URL and SES Element Offset = 3  
`http://localhost:8080/struts2/shop/addToCart.action`

The Transaction (Txn) will be shown as

`addToCart.action`

The 3rd element is whatever comes after the third forward slash after
the hostname - domain in the URL.

___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.

