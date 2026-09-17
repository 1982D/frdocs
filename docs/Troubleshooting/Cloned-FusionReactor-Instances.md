# How to fix cloned FusionReactor instances

## What is a clone?

All FusionReactor instances have a unique identifier assigned to them when they are first created, in the context of FusionReactor this is called the FRUID. Throughout the versions of FusionReactor, how this FRUID was generated and stored has been altered but the concept of having a FRUID has been consistent.

There is also a GRUID or globally unique identifier assigned to each instance, this is used by external sources such as the **Enterprise Dashboard**, **FusionAnalytics** and the **OpsPilot**.

Cloning FusionReactor refers to two instances of FusionReactor having the same FRUID or GRUID, so they are identified as the same unique instance although there are two distinct copies.

- In FusionReactor versions 5 and 6 the FRUID and GRUID were both generated in the FusionReactor instance itself and stored in a configuration file on the disk. This seemed like the best solution as it made copying the FusionReactor configuration file from one instance to another so that the instance settings are the same cause a cloned instance to occur.
- In FusionReactor versions 7 and 8 the FRUID and GRUID values are stored in memory, but if the values already exist on disk they will be used. Along with this a new de-cloning mechanism was introduced, allowing the license server of FusionReactor to change the FRUID and GRUID pair of an instance from the duplicated values in the configuration file to a new pair of unique values. The problem with this solution is that although when an instance is started we can fix the FRUID and GRUID this does not always permanently fix the configuration file.

!!! example
    If you have a virtual machine image with a cloned reactor.conf file, each type you spin up a new machine based on this image a cloned instance will occur. 
    
!!! tip
    We recommend the base virtual image be fixed so that it will not cause cloned instances to occur.


While with a cloned instance both instances with the same FRUID and GRUID pair will appear to operate as normal, in our external servers such as our licensing server, the **FusionAnalaytics** target and the **OpsPilot** will see your two or more distinct instances as one single instance.

When this is the case the following will occur:

- Our licensing server will not be able to store the correct information about your instances, so in the FusionReactor portal you will not be able to see the correct information
 
- In **FusionAnalytics** all data from multiple instances is merged so you won't know if one particular instance is experiencing issues as your metrics will be inaccurate.

- In the **OpsPilot**, rather than seeing and being able to analyze all your instances, you will only have access to some of your data under one single instance and the rest will not be available to you.

## How to stop instances becoming cloned

To stop an instance from being detected as a clone the configuration file that contains the FRUID and GRUID values must be modified and the FRUID and GRUID values must be removed. To do this the application server (ColdFusion, Lucee, Tomcat…) must be stopped to stop your changes from being overwritten.

The steps below show the exact process to remove a clone:

1. Stop your Application Server.
1. Navigate to your FusionReactor conf directory: {FusionReactor Directory}/instance/{Instance Name}/conf
1. Open the reactor.conf file in a text editor.
1. Remove the lines beginning with "FRUID=" and "GRUID=".
1. Start your Application Server.


___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist. 