

## JMX MBeans

FusionReactor’s **JMX functionality** (JMX MBeans, JMX MBean Overview, JMX MBean Graphs, and AWS CloudWatch Metrics) is available **only** in the **FusionReactor Enterprise Edition** and **Ultimate Edition** (both on-premise and Cloud license types).

### Introduction

**Java Management Extensions (JMX)** were introduced in Java 5.0 as a standard technology for monitoring and managing applications.

The **JMX MBean system** provides a way to expose the internals of a software application in a controlled, standardized manner. With the appropriate tools, users can:

* Inspect and, in some cases, modify exposed values.
* Trigger certain operations within the application.
* Subscribe to notifications when values change.

With FusionReactor 7, support was added for reading and writing most types of JMX bean data.



!!! info
    Triggered operations and value notifications are not yet supported.



## JMX MBeans View

Located under **Metrics > JMX MBeans**, the JMX MBeans view consists of:

* A **tree representation** of the current JMX hierarchy on the left.
* **Tab panes** on the right displaying attributes and metadata for the selected MBean.




![](/attachments/245549330/245549375.png)



The tree can be expanded to navigate through the hierarchy of JMX services. Objects that support instrumentation are highlighted in **blue** with an **orange bullet**. Clicking on such an object retrieves and displays its attributes and metadata.

The tree can be fully hidden or revealed using the **Hide All** and **Show All** buttons.

* **Show All:** Recursively retrieves and opens the entire JMX instrumentation hierarchy for the tracked server.




!!! note
    This can take significant time for production Java applications.


## Attributes

Attributes for the selected MBean are displayed in a table:

| Name      | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Name**  | The JMX-registered name of the attribute, often represented in **camelCase**.                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| **Value** | The current value of the attribute. If the value is not a simple type, FusionReactor attempts to display it logically (for example, arrays are shown in square brackets). Values marked as **changeable** by the JMX instrumentation are editable-press **Return** to commit changes back to the server. <br><br>**Caution:** Modifying JMX-instrumented values is not recommended unless you fully understand the effects. These changes are often intended for internal testing and can have unintended consequences if altered incorrectly. |
| **Type**  | The Java type of the tracked attribute.                                                                                                                                                                                                                                                                                                                                                                                                          

### JMX MBean Tracking

FusionReactor can **track and graph JMX values over time**. Simple numeric values are displayed in the **Attributes** tab with a **Play** icon (:fa-play:).

Clicking the **Play** icon starts periodic sampling of the value. The collected data can then be viewed under **Metrics > JMX Bean Graphs**. Once tracking begins, the **Play** icon is replaced by a set of buttons with the following functionality:

| Functionality                             | Description                                                                                                                                                                                                                                                                   |
| ----------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ![](/attachments/245549330/245549352.png) | Displays the FusionReactor graph associated with this tracked value.                                                                                                                                                                                                          |
| ![](/attachments/245549330/245549358.png) | Sends this metric to **AWS CloudWatch Metrics**. Clicking the button opens a dialog to select CloudWatch Dimensions for the series (see AWS CloudWatch Metrics). The **Play** icon changes to a **Stop** icon to indicate active transfer. Clicking again stops the transfer. |
| ![](/attachments/245549330/245549369.png) | Removes this value from all FusionReactor tracking.                                                                                                                                                                                                                           |


### Metadata

Metadata for the selected MBean is displayed in a table. It includes information for:

* The **MBean** itself (**MBeanInfo**).
* Each attribute exposed by the MBean (**MBeanAttributeInfo**).



## JMX MBean Overview

The **MBean Tracking Overview** provides a list of all attributes
currently tracked by FusionReactor.

![](/attachments/245549391/245549397.png)


Attributes are listed according to their **owning bean**, represented by its position in the tree using **slash notation**.

The same operation button cluster from **[JMX MBean Tracking](#jmx-mbean-tracking)** is available here, with the addition of a **looking-glass icon**. Clicking this icon opens the **[JMX MBeans View](#jmx-mbeans-view)** page with the selected attribute already focused.


## JMX MBean Graphs

The **JMX MBean Graphs** page displays the tracked data for a single
MBean-tracked value.

![](/attachments/245549403/245549408.png)

The drop-down at the top can be used to select which attribute should be
displayed.

![](/attachments/245549403/245549414.png)


The **range selector** allows you to view data for **Live**, **Last Hour**, **Last Day**, or **Last Week**. The **zoom selector** lets you zoom into a specific portion of the graph within the selected range.

Using both selectors together enables you to see a **high-level overview** while also examining **fine-grained, detailed data** in the same graph.



___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.
