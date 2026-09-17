## Memory Settings

### Heap Histogram

The **Heap Histogram settings** control both the live view and snapshot behavior, including filtering, UI limits, and disk usage.

* The **live view** can be configured with filtering and timeout settings.
* **Snapshots** can be configured with limits to prevent excessive disk usage.

| Configuration              | Description                                                                                                                                                                                                                            | Default           |
| -------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------- |
| **Remove Old Snapshots**   | When enabled, old snapshots are automatically deleted once the maximum snapshot limit is reached. If no maximum is set, nothing is deleted.                                                                                            | Don’t Remove      |
| **Maximum Snapshots**      | Defines the maximum number of snapshot files allowed in a single heap directory. If unset, the directory can store unlimited snapshots.                                                                                                | *None*            |
| **UI Row Limit**           | Sets the maximum number of rows displayed in the heap view. Very high values may slow down or crash older browsers.                                                                                                                    | 250               |
| **Snapshot Directory**     | Directory where heap snapshots are stored. Changing this location does not affect the old directory, which will still exist with its snapshots. New snapshots will be stored in the new directory.                                     | `<instance>/heap` |
| **Exclude Packages**       | A comma - or newline-separated list of packages to exclude from memory snapshots. <br>Example: <br>`java.lang` <br>`java.util`                                                                                                          | `com.intergral`   |
| **Heap Histogram Timeout** | The maximum time (in milliseconds) the heap histogram scanner runs. This applies only to the native API call (not the UI or browser). Leave empty for no limit-but note this can cause long page generation times on very large heaps. | 1000              |




### Garbage Collection Roots

The **Garbage Collection Roots settings** control how the GC Roots pages behave when accessed from **Memory → Heap View**.

| Configuration               | Description                                                                                                                                                                                                                                           | Default |
| --------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- |
| **GC Roots Timeout**        | The maximum time (in milliseconds) the GC Roots scanner will run. This only applies to the native API call (not FusionReactor’s UI or browser). Leave empty for unlimited duration, but note that large heaps may take a long time to process.        | 1000    |
| **GC Roots Max Tree Depth** | The maximum tree depth shown in the GC Roots UI. This limits both the UI rendering and the data model size to prevent browser overload on large heaps. Leave empty for unlimited depth, but this can significantly slow down loading for large heaps. | 10      |


