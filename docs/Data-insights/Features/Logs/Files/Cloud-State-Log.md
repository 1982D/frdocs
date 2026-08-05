# Cloud State Log

**Available exclusively with OpsPilot licenses.**

This log records changes in the state of the **Control Channel**, the cloud connection channel. For a detailed overview of the channel’s status, see the [Cloud Status page](/Monitor-your-data/FR-Agent/Agent/Cloud-Status).


|Field Name|Column|Description|
|--- |--- |--- |
|Date (Formatted)|1|The date of this state change.|
|Time (Formatted)|2|The time of this state change.|
|Date/Time (ms)|3|The millisecond instant of this state change.|
|Version|4|Version number of this log entry.|
|Server Startup Time (ms)|5|Startup time of FusionReactor server in milliseconds (ms) since epoch.|
|Channel|6|The name of the channel registering a state change: CC|
|Entry Type|7|F (first) or C continuation entry.|
|Previous State|8|The old state, one of NASCENT (starting up), FAILED or OK.|
|New State|9|The new state.|
|License Key|10|The license installed in this instance.|
|Message|11|A string indicating more information about the state change.|
|Exception (JSON)|12|A JSON-encoded list of exception stack frames, if an exception was associated with this state change.|
