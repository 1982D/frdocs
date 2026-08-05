# Span attributes
Attributes are information providing extra insight into the span.

!!! warning "Warning: Data Obfuscation"
    Span attributes are not obfuscated by default, network and database information could be present. Enable obfuscation for datapack and semantic attributes via [system properties](#properties-used-for-attributes) to ensure that no confidential data can be passed.

!!! info "Potential cause of missing attributes"
    An attribute might not have been set on the span if the attribute's value was null or empty.

!!! note "Potential cause of truncated attribute values"
    An attribute value ending in `...` indicates that it has been truncated to limit data size.

## OpsPilot UI attributes
These are attributes required for transaction rendering in FusionReactor's Cloud UI.

| Attribute Key/Name | Attribute Value |
| -- | -------- |
| flv | The span's transaction flavour. |
| sflv | The span's transaction sub-flavour. |
| description | The span's description. |
| app_name | Application name. |
| apps | Source of the application name. |
| tann | Transaction name. |
| tans | Source of the transaction name. |
| thread.id | Thread ID. |
| thread.name | Thread name. |
| txnId | Transaction ID. |
| dur | Duration. |
| direct_children.culled.count | How many of the transaction's children were not sampled/exported. Contained in one service. |
| total_children.culled.count | How many descendants of the master transaction were not sampled/exported. Contained in one service. |
| mstr | Master transaction ID |
| parentTxnId | Parent transaction ID |
| throwable | Throwable set on the transaction. |
| reason | A list of reasons why the transaction is considered an ITT. e.g. Slow/Error |
| tab | Thread memory allocated bytes. |
| ghs | Map of values describing the heap memory at the start of the transaction. |
| ghe | Map of values describing the heap memory at the end of the transaction. |
| rej | Whether the transaction was rejected or not. |
| sk | Whether the transaction was soft-killed or not. |
| stpd | Whether the transaction was stopped/killed or not. |
| cpx | Whether extended metrics were inhibited or not. |
| pid | Profile IDs. |
| event_snapshot_id | Event Snapshot ID. |
| cmp | Whether the request was compressed or not. |
| sec | Whether the request is secure or not. |
| ct | Request content type. |
| cp | Request context path. |
| prcl | Request protocol. |
| rsid | Requested session ID. | 
| bs |  Request buffer size. |
| ce | Request encoding. |
| cmmt | Whether the request was committed or not. |
| flv_stats | Transaction flavour stats. |
| properties | Transaction properties. |

#### WebRequest transaction properties
| Attribute key/name | Attribute value |
| -- | -------- |
| url | Request URL. |
| s | Request status. |
| cli | Client address. |
| m | Request method. |
| q | Request query string. |
| rs | Request status code. |
| cpu | Thread CPU time. |
| rcl | Request content length. |
| jqr | JDBC queries ran. |
| jtt | JDBC total time. |
| jte | JDBC total execution time. |
| jtr | JDBC total row count. |
| amf | AMF methods. |
| ua | Request user-agent. |
| strm | Stream data |

#### JDBC transaction properties
| Attribute key/name | Attribute value |
| -- | -------- |
| s | Statement. |
| exec/db | Execution elapsed time. |
| rc | Row count. |
| p | Prepared statement. |
| rl | Row limiter activated. |
| total | Duration |
| src | Source name. |
| expln | Explanation. |


## Miscellaneous attributes
Attributes which don't belong to a specific category.

| Attribute key/name | Attribute value |
| -- | -------- |
| status.code | The status of the span. 0=unset, 1=OK, 2=error |



## Resource/Process attributes
These are attributes which offer information about the instance/service.

| Attribute key/name | Attribute value |
| -- | -------- |
| fusionreactor.server.name | If obtainable by FusionReactor, the name of the server. e.g. Tomcat, ColdFusion, Jetty, etc. |
| fusionreactor.server.version | If obtainable by FusionReactor, the version of the server. |
| os.type | Name of the operating system. |
| os.description | Operating system version information. |
| process.executable.path | The full path to the process executable. |
| process.pid | Process identifier (PID). |
| process.runtime.version | The version of the runtime of this process. |
| process.runtime.description | An additional description about the runtime of the process, for example a specific vendor customization of the runtime environment. |
| process.runtime.name | The name of the runtime of this process. |
| service.name | Name of the service. Defined by -javaagent:{...}name={service.name}|
| job | As above. |
| instance | Name of the instance. Defined by email.hostname in reactor.conf |
| group | The value parsed from `-Dfr.cloud.group` |

## Properties used for attributes
Add to JVM arguments/options by prepending with `-D`.

| Property key | Default | Description |
| -- | -- | -------- |
| `fr.observability.trace.attributes.datapack.enabled` | `true` | If enabled, sets datapack (cloud UI) attributes on spans. WARNING: Transactions/spans will no longer be rendered in the OpsPilot UI. |
| `fr.observability.trace.attributes.datapack.obfuscation.enabled`  | `false`  | If enabled, attempts to obfuscate datapack span attributes. |
| `fr.observability.trace.attributes.semantics.enabled`             | `true`  | If enabled, sets semantic attributes on spans. |
| `fr.observability.trace.attributes.semantics.obfuscation.enabled` | `false` | If enabled, doesn't set or obfuscates `net.peer.port`, `net.peer.name`, `net.peer.ip`, `db.statement`, query string in `http.url` (for FusionRequest/WebRequests), `http.client_ip`, and `db.cassandra.coordinator.dc` semantic attributes. |
| `fr.observability.trace.attributes.request.headers` | `""` | Comma separated list of request header names to match and attach header to WebRequest, OkHttp and Httpclient span attributes. |
| `fr.observability.trace.attributes.response.headers` | `""` | Comma separated list of response header names to match and attach header to WebRequest, OkHttp and Httpclient span attributes. |
| `fr.observability.trace.attributes.resource.process_command_line` | `false` | If enabled, adds the process command line resource attribute on spans. |
| `fr.observability.trace.value.limit` | `1024` | Text limit for certain span string attributes. |
| `fr.observability.trace.labels` | `""` | A comma-separated key-value list of labels to add a maximum of 8 to traces, note that general observability labels specified by `fr.observability.labels` are applied first and contribute the limit. Format `labelKey1:labelValue1,labelKey2:labelValue2,...` |
| `fr.observability.trace.labels.separator.list` | `,` | Regex string to split/separate the `fr.observability.trace.labels` list. |
| `fr.observability.trace.labels.separator.keyvalue` | `:` | Regex string to split/separate the key-values in the `fr.observability.trace.labels` list. |
| `fr.observability.trace.sampling.ratio` | `0.05` | Decimal number representing the sampling ratio of spans with 0 being 0% and 1 being 100%. | 


---

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.