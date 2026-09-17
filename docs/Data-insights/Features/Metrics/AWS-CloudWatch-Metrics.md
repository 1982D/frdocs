# AWS CloudWatch Metrics

[Amazon Web Services CloudWatch](https://aws.amazon.com/cloudwatch/) is a fully managed cloud service that **ingests, stores, visualizes, and monitors metrics**. It is part of the broader AWS ecosystem, a comprehensive suite of tightly integrated cloud services. CloudWatch integrates seamlessly with other AWS products, providing a robust framework for **metric collection, alerting, and notifications**.

FusionReactor can **periodically send any internally tracked metric** to AWS CloudWatch, enabling centralized monitoring of your application metrics alongside other AWS resources.

!!! warning
    **AWS CloudWatch is a paid service**.

!!! note
    Enabling CloudWatch integration in FusionReactor may incur charges from AWS. You are responsible for monitoring and managing these costs. Integral GmbH cannot be held liable for any AWS service charges.


!!! info "Learn more"
    [Pricing information for AWS CloudWatch](https://aws.amazon.com/cloudwatch/pricing/).



## Metrics Selection

The **Metrics > AWS CloudWatch Metrics** page allows you to:

* Select which metrics to send to AWS CloudWatch.
* View the status of currently selected metrics.

Before any data can be uploaded to AWS CloudWatch, **FusionReactor AWS CloudWatch Metrics** must be configured by clicking the **Configure** button.

Detailed instructions for configuration are available [here](#aws-cloudmetrics-setting).

![](/attachments/245549462/245549477.png)

### Metrics Selection Screen

The **Metrics Selection** screen is divided into a **selector area**, which includes:

* **Filter**  -  Narrow down the list of metrics.
* **Series Selector**  -  Choose the metric series you want to send.
* **Dimensions Selector**  -  Specify the dimensions for the selected series.
* **Add to CloudWatch** button  -  Send the selected series to AWS CloudWatch.

All series, including [JMX MBean](JMX-MBeans.md) series, are displayed in this screen. The displayed series can be further filtered to quickly locate and select the metrics you want to upload.


### Adding a Series

1. **Select the series**

    Click a series to select it. To select multiple series, hold down:

    * **Command** (Mac OS X)
    * **Control** (Linux & Windows)

2. **Enter dimensions**

     Specify any dimensions required for this series, then click **Add to CloudWatch** to start sending the metric to AWS.

**AWS CloudWatch Dimensions** allow you to differentiate the same metric coming from different servers.

!!! tip
    If you prefer **aggregated metrics**, either leave the **Dimensions** box empty or use the **same dimension** across your entire FusionReactor fleet.

!!! note
    Without specifying unique dimensions, you **will not be able to distinguish the source** of the metric in CloudWatch.




### Examples

!!! example "How to see the **Classes Loaded** metric for each instance on all servers separately"
     **Dimensions:** Use the default instancename and hostname dimensions.

!!! example "How to see the **Classes Loaded** metric per server, regardless of how many FR instances are on that server."
    **Dimensions:** Supply only the **hostname** dimension.

!!! example "How to see an aggregate of **Classes Loaded** over my whole fleet."
    **Dimensions**: Leave this blank. AWS CloudWatch will aggregate the metric as it is shipped by FusionReactor.



# Dimension Templates

FusionReactor allows several dimensions to be dynamically filled using **curly-brace templates**. Clicking the **Info** icon next to the Dimensions field displays the supported placeholders:

* **{hostname}**  -  The hostname of the machine.
* **{instancename}**  -  The name of the FusionReactor instance.



## Available and Stale Metrics

The lower half of the screen displays the current **Available** and **Stale** metrics.

![](/attachments/245549462/245549471.png)

The columns in this section include:

* **Name**  -  The name of the metric.
* **Description**  -  A brief description of the metric.
* **Dimensions**  -  The associated dimensions for this metric.
* **AWS Metric Name**  -  The corresponding metric name in AWS CloudWatch.
* **Full ID**  -  The full identifier of the metric.
* **Last Sampled Value**  -  The most recent recorded value.

The **Remove** button can be used to stop sending a metric to CloudWatch.

**Stale JMX Metrics** (metrics that have not published a new datapoint recently-usually because the JMX bean has stopped) are listed under the **Stale** tab.

To update the dimensions of a metric:

1. **Remove** the metric.
2. Add it again from the **Available Series** list with the new dimensions.



!!! info "Learn more"
    [AWS CloudWatch Metrics Configuration](/Data-insights/Features/Metrics/AWS-CloudMetrics-Configuration/)

___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.