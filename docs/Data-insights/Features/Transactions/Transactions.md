# Transactions

**FusionReactor** tracks many types of instrumentation data, which can
broadly be broken down into metrics:

### Resource information 

!!! example
    memory spaces and  CPU information 

### JDBC related information 

!!! example
    DB time and rows returned  

### Transaction information 

!!! example
    WebRequests.

Transactions track the start and end of an operation as well as
additional meta data associated with the operations.  


!!! example "Example transactions"
    WebRequests, JDBC transactions, MongoDB and Hibernate calls etc.


## FR tracked lists

**FusionReactor** tracks these unique types (flavors of transactions) into
discrete lists.  This allows the user to view the transactions of a
specific type.


**FusionReactor** tracks two unified lists of transactions (new as of
FusionReactor 7.1.0.)  These lists are defined as:

### Root Transactions 

**Root Transactions** are all top level / root transactions, i.e. they
have no parent transactions.  This usually denotes that this is the
start of an operation which FusionReactor monitors.

### All Transactions 

**All Transactions** are all the transactions which FusionReactor tracks,
this includes Root Transactions and all their child / sub transactions.


![](/attachments/245550549/288882712.jpg)

___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.