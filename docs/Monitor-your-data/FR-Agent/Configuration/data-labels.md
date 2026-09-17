# Custom data labels

The FusionReactor agent allows custom labelling of exported data. Up to 8 labels are allowed for logs, metrics and traces each.

## General Custom labels
These labels are applied to all observability data. They are applied before the specific labels and contribute the label amount limit of each.

Labels are separated according to the specific data type's specified delimiters. By default, this is `,` for separating the list of key-value pairs and `:` for separating keys and values. E.g. `-Dfr.observability.labels=key1:value1,key2:value2,key3:value3,key4:value4` 

Add to JVM arguments/options by prepending with `-D`.

| Property Key | Default | Description |
| -- | -- | -------- |
| `fr.observability.labels` | `""` | A comma-separated key-value list of labels to add to all observability types. Format follows the formatting of the observability type. |


## Logs Custom Labelling
These labels will be applied to the logs only. Specifying different separators will affect how general labels are separated too.

| Property Key | Default | Description |
| -- | -- | -------- |
| `fr.observability.log.labels` | `""` | A comma-separated key-value list of labels to add a maximum of 8 (by default) to logs, note that general observability labels specified by `fr.observability.labels` are applied first and contribute the limit. Format `labelKey1:labelValue1,labelKey2:labelValue2,...` |
| `fr.observability.log.labels.separator.list` | `,` | Regex string to split/separate the `fr.observability.log.labels` list. |
| `fr.observability.log.labels.separator.keyvalue` | `:` | Regex string to split/separate the key-values in the `fr.observability.log.labels` list. |

## Metrics Custom Labelling
These labels will be applied to the metrics only. Specifying different separators will affect how general labels are separated too.

| Property Key | Default | Description |
| -- | -- | -------- |
| `fr.observability.metrics.labels` | `""` | A comma-separated key-value list of labels to add a maximum of 8 (by default) to logs, note that general observability labels specified by `fr.observability.labels` are applied first and contribute the limit. Format `labelKey1:labelValue1,labelKey2:labelValue2,...` |
| `fr.observability.metrics.labels.separator.list` | `,` | Regex string to split/separate the `fr.observability.metrics.labels` list. |
| `fr.observability.metrics.labels.separator.keyvalue` | `:` | Regex string to split/separate the key-values in the `fr.observability.metrics.labels` list. |

## Traces Custom Labelling
These labels will be applied to the traces only. Specifying different separators will affect how general labels are separated too.

| Property Key | Default | Description |
| -- | -- | -------- |
| `fr.observability.trace.labels` | `""` | A comma-separated key-value list of labels to add a maximum of 8 to traces, note that general observability labels specified by `fr.observability.labels` are applied first and contribute the limit. Format `labelKey1:labelValue1,labelKey2:labelValue2,...` |
| `fr.observability.trace.labels.separator.list` | `,` | Regex string to split/separate the `fr.observability.trace.labels` list. |
| `fr.observability.trace.labels.separator.keyvalue` | `:` | Regex string to split/separate the key-values in the `fr.observability.trace.labels` list. |
