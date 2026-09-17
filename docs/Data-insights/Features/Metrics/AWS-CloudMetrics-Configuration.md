## AWS CloudMetrics setting

Before using the FusionReactor AWS CloudWatch Metrics system, some configuration is required.

To configure: 

1. Navigate to Metrics > AWS CloudWatch Metrics.

2. Click the Configure button at the top of the page.


| **Name**                  | **Description / Value**                                                                                                        |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| **AWS Access Key**        | The AWS Access Key of a user or IAM identity under which metrics will be pushed to CloudWatch.                                 |
| **AWS Secret Key**        | The Secret Key corresponding to the Access Key above.                                                                          |
| **AWS Region**            | The AWS region where CloudWatch metrics will be sent.                                                                          |
| **AWS Namespace**         | The CloudWatch namespace under which metrics will be organized. See note below for guidance.                                   |
| **AWS Dimensions**        | The default set of AWS dimensions that will be applied to metrics in the CloudMetrics page.                                    |
| **Send Stale Data**       | Determines whether stale datapoints (JMX metrics that haven’t updated in the last minute) are sent using their previous value. |
| **AWS CloudWatch Active** | Master switch to enable or disable the metrics shipping system entirely.                                                       |




## Troubleshooting

If you encounter issues with AWS CloudMetrics, follow these steps:

1. **Verify Configuration:**

    * Ensure the configuration form is filled out correctly.
    * Remove any trailing spaces from fields, as these can cause errors.

2. **Check AWS Permissions:**

    * The user, IAM identity, or role associated with the AWS Access Key must have permission to write CloudWatch metrics.
    * Ensure the necessary AWS permission is granted:

```JSON
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "Stmt1493894646000",
                "Effect": "Allow",
                "Action": [
                    "cloudwatch:PutMetricData"
                ],
                "Resource": [
                    "*"
                ]
            }
        ]
    }
```

!!! info "Learn more"
    For further information go to log file `plugin-fusionreactor-cloudwatch-plugin-0.log`.


___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.