

# FusionReactor Json Data Tracker Plugin

This plugin captures the Json Data sent as part of a request or response
on WebRequest and HTTPClient transactions. This requires the
`Content-Type` header on the individual request and/or response to be
set as either `application/json` or `application/smile`. This data is
then attached to the transaction as a context.

## Transaction Context

Json Data appears as a transaction context in the history list, as shown
below:

[![](/attachments/245548346/245548358.png)](/attachments/245548346/245548358.png)


The actual data is rendered in a tab in the transaction details view, as
shown below:

[![](/attachments/245548346/245548352.png)](/attachments/245548346/245548352.png)

## Configuration

The configuration options are located in [Requests >
Settings > Json Data](/Data-insights/Features/Requests/Settings/#json-data).
