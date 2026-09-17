

This page contains detailed information about each process. At the top
of the page you should be able to see the **name** of the process and
the **following details**.

The table provides a quick summary of the process details, showing the
following information:

* **Process Name**: The name of the process or executable file name.
* **PID**: The process ID.
* **Mem**: This shows the total system memory usage percentage (in the
    column header). The percentage of system memory used by this process
    and the current size in MB of the process working set.
* **CPU**: The total current system CPU usage (in the column header).
    The current CPU usage for this process.

![](/attachments/245554779/245554789.png)

Additionally, on the top right corner you are able to see the following;

* **Running Processes**
* **CPU**
* **Memory**

The '**Running Processes**' field contain the total number of the
running process. The **'CPU**' and the '**Memory**' fields contain the
usage of the system.

### Tabs

Under the table of the general details of the process, you are going to
find two tabs, the '**General**' and the '**Environment**' tab.

### General

The General tab includes all the general information about this process.
It is split into five sub-sections, of which all contain information
regarding to the process. These 5 sub-sections are as follows:

### User

This table shows the following:

* **Group:** The User Group that this process is owned by.
* **User:** The actual User that owns this process.

![](/attachments/245554779/245554784.png)
### Started

This table shows the following:

* **Start Time**: The time the process started.
* **Running for**: The amount of time the process has been running.

![](/attachments/245554779/245554804.png)

### Memory

This table shows the following:

* **Resident**: The size of the resident working set in bytes.
* **MajorFaults**: The number of major faults for this process.
* **MinorFaults**: The number of minor faults for this process.
* **PageFaults**: The number of page faults for this process.
* **Share**: The size of the shared memory in bytes.
* **Size**: The size of the total process virtual memory in bytes.

![](/attachments/245554779/245554819.png)
### Parent Process

This table shows the following:

* **Parent PID:** The parent process ID.
* **Parent Name:** The name of the parent process.
* **Parent Exe:** The directory of the parent process.

![](/attachments/245554779/245554814.png)

### Process State

This table shows the following:

* **Name:** The name of the current process.
* **Exe:** The directory of the process.
* **Priority:** The priority of the process.
* **State:** The state of the process, running/stopped/waiting.
* **Number of Threads:** The number of threads under that process.

![](/attachments/245554779/245554829.png)

### Arguments

This section shows the entire argument list that is appended with the
process. it is shown in a text box, as a continuous string.

![](/attachments/245554779/245554824.png)

### Modules

This section presents a list of modules used by the process. They are
provided as a list, with each module being separated with a new line.
The text box being used to represent the Modules has a max-height, so it
may become scrollable if there are a large amount of modules.

![](/attachments/245554779/245554839.png)

### Environment

The Environment tab includes information specific to the process
arguments, it's modules, and the environment variables linked with the
process. These are displayed in the following forms:

This section holds a table that describes what environment variables are
created/used by this process. This table can get quite long with large
processes that use a lot of environment variables.

The table has the following format:

* **Key** - The key of the environment variable. 
* **Value **- The actual value that the environment variable key
    represents.

![](/attachments/245554779/245554834.png)