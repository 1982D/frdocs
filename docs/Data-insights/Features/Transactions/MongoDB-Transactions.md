# Mongo Transactions

## Standard MongoDB monitoring

**FusionReactor** by will automatically start tracking calls to MongoDB into transactions. These transaction are available in the [Transaction → Transaction History](History.md) page.

![](/attachments/245550990/245550995.png)

As well as detecting the query executed, FusionReactor will also detect the database and collection the query was executed against. This information is displayed both on the **History** pages, and the **Details** page.

![](/attachments/245550990/245551000.png)

## Enhanced MongoDB Monitoring

In addition to the standard MongoDB monitoring **FusionReactor** has an option to enable enhanced MongoDB monitoring.

!!! tip
    Enable enhanced MongoDB via the [Transaction Settings](Transaction-Settings.md) page. 

When enabled, **FusionReactor** is able to track additional information about how the queries are run against MongoDB.
![](/attachments/245551005/245551017.png)

The Enhanced MongoDB transaction include additional information on top of the basic transactions. They are also separated into a few more
transaction to better visualize the path the query took. Additionally, we also include the ability to perform a query plan or explain on the query
being executed, this is controlled by the [MongoDB Explain Threshold](Transaction-Settings.md) setting. 

The results of the query can also be gathered by FusionReactor and stored on a transaction. All the descriptions of MongoDB transactions are limited by the [Mongo Text Limiting](Transaction-Settings.md) settings.

The result of the MongoDB explain is stored on the MongoDB transaction and displays a link as **QueryPlan**.

![](/attachments/245551005/245551012.png)

![](/attachments/245551005/245551027.png)
___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.