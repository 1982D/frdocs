# Instance Manager Log

The **Instance Manager Log** provides detailed information about the operations it performs. This includes server scanning, installations, configuration of existing servers, upgrades, and other Instance Manager functions such as starting or stopping servers.

### Status Log (`instance-manager.log`)

The **Instance Manager Log** entries follow the format below:

| Field Name | Number | Description                                                                                                                                                                                     |
| ---------- | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Date       | 1      | The date when this log entry was recorded.                                                                                                                                                      |
| Time       | 2      | The time when this log entry was recorded.                                                                                                                                                      |
| Log Level  | 3      | Indicates the nature of the log entry. For example: **INFO** for general information, **ERROR** for an error, and **SEVERE** for critical issues, usually accompanied by a generated exception. |
| Operation  | 4      | Describes events or actions performed by the Instance Manager, such as starting procedures (install, scan, etc.), and provides specific details useful for debugging if an operation fails.     |

### Additional information


If you encounter issues with Instance Manager and its logs do not provide enough detail, it can be helpful to check the logs of your application server. In some cases, the application server may be malfunctioning or improperly configured, which can cause Instance Manager operations to fail and limit the information available in its logs.
