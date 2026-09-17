# System Metrics

This page is intended as an overview of the system metrics gathered by
FusionReactor.

## Graphs

The first part of this page shows some graph metrics for your system,
these graphs are as follows:

* **Network Usage** - which contains the following series:
    * **Net Tx - Total** - This is the total bytes transmitted over
        all networks by this system
    * **Net Rx - Total** - This is the total bytes received over all
        networks.
* **RAM Usage**- which contains the following series:
    * **Cached Memory** - This is the total system memory (RAM) used
        for cache and buffers
    * **Used Memory** - This is the total system memory (RAM) used by
        applications
* **Disk IO**- which contains the following series:
    * **Disk Read - Total** - This is the total bytes read from all
        disks
    * **Disk Write - Total** - This is the total bytes written to all
        disks
* **CPU Usage** - which contains the following series:
    * **Nice** - Percentage of CPU utilization that occurred while
        executing at the user level with nice priority.

    * **User** - Percentage of CPU utilization that occurred while
        executing at the user level (application).

    * **Wait** - Percentage of time that the CPU or CPUs were idle
        during which the system had an outstanding disk I/O request.

    * **System** - Percentage of CPU utilization that occurred while
        executing at the system level (kernel).

Below is an example of it's appearance:

![](/attachments/245554718/245554753.png)

## Overview

This table gives a short summary of the system information.

* **System Up Time** - The total uptime of the server, this is the
    time since the server OS started up. (linux command 'uptime')
* **System Start Time** - This is the time when there OS started.
* **OS** - The operating system, version and architecture
* **Country** - The Local and Time zone running on the server

![](/attachments/245554718/245554763.png)

### Java

This table gives details of the Java version being used by the system.

* **Java** - The name of the Java being used
* **Java Home** - The path to the Java being used
* **Java Vendor** - The vendor of the Java being used
* **Java Version** - The full version of the Java being used
* **Java Runtime** - The Java runtime version being used
* **Java Library Path** - The paths being used for native libraries
* **Java Class Path** - The paths being used for Java classes
* **Java Class Version** - The version of the Java classes used on
    this version of Java

![](/attachments/245554718/245554728.png)

### Users

This table shows the currently logged in users on the system, and the
time they logged in at, as well as the location they logged in from.

![](/attachments/245554718/245554723.png)

### Drives

This table shows details of each disk drive mounted by the system. This
table shows all drives, however to all drives are included in the disk
IO graphs.

* **Name** - The name of the disk
* **Type** - The type and file system of the disk. Type includes
    local, cdrom, network etc.
* **Used** - This is the current used percentage of the disk
* **Size** - This is the current used, and total size of the disk in
    MB

![](/attachments/245554718/245554738.png)

### Swap Info

This table shows the current swap information for the server.

* **Total** - The total size allocated for swap
* **Used** - The total amount of swap space used
* **Free** - The total amount of swap space free
* **Page In** - The total number of pages read from disk
* **Page Out** - The total number of pages written to disk

Page Out: a process hasn't touched a memory page for some defined time,
the memory page is swapped out to disk.

Page In: process touches memory space marked as paged out, the memory page is
swapped into real memory.

**A higher Page In, than Page Out, could indicate that you do not have
sufficient system memory.**

![](/attachments/245554718/245554733.png)

### Network Summary

The network summary table displays an overview of the network
configuration.

* **Host Name** - The host name of system
* **Domain Name** - The domain name of the system
* **Default Gateway** - The IP address of the default gateway for the
    system
* **Primary DNS** - The Primary DNS server for the system
* **Secondary DNS** - The Secondary DNS for the system

![](/attachments/245554718/245554748.png)

### Processor Summary

This table displays the summary of the system processors.

* **Vendor (Model)** -The vendor and model of the processor
* **Cache Size** - The size of the cache on the processor
* **Mhz** - The reported speed of the processor in Mhz

![](/attachments/245554718/245554743.png)
