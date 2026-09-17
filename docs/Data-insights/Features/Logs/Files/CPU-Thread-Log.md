

# CPU Thread Log

To enable CPU Thread Logs (`cputhread.log`), activate the option on the [Resource Settings](../../Resources/Settings.md) page.

This log provides detailed information about threads running on the server's CPU. Each entry occupies a single line and includes multiple useful data points.

The table below explains each element in the log. Elements are separated by a whitespace character.


| Field Name                     | Number | Description                                                                                |
| ------------------------------ | ------ | ------------------------------------------------------------------------------------------ |
| Date (Formatted)               | 1      | The date when this resource probe was triggered.                                           |
| Time (Formatted)               | 2      | The time when this resource probe was triggered.                                           |
| Date/Time (ms)                 | 3      | The timestamp in milliseconds when this resource probe was triggered.                      |
| Version                        | 4      | Version number of this log entry.                                                          |
| Server Startup Time (ms)       | 5      | FusionReactor server startup time in milliseconds since epoch.                             |
| Thread Name                    | 6      | Name of the thread.                                                                        |
| Thread ID                      | 7      | ID of the thread.                                                                          |
| CPU Time (nanoseconds)         | 8      | Total CPU time the thread has been running while alive.                                    |
| User Time (nanoseconds)        | 9      | Total time the thread has executed in user mode.                                           |
| CPU Time Delta (nanoseconds)   | 10     | Difference between the current and previous CPU Time entries in the log.                   |
| User Time Delta (nanoseconds)  | 11     | Difference between the current and previous User Time entries in the log.                  |
| Thread Blocked Count           | 12     | Number of times the thread has entered the blocked state.                                  |
| Thread Blocked Time (ms)       | 13     | Total time the thread has spent in the blocked state.                                      |
| Thread Blocked Delta           | 14     | Difference in blocked count between the current thread and the previous log entry.         |
| Thread Blocked Time Delta (ms) | 15     | Difference in blocked time between the current thread and the previous log entry.          |
| Lock Name                      | 16     | Monitor lock associated with the thread.                                                   |
| Lock Owner ID                  | 17     | ID of the thread holding the monitor lock.                                                 |
| Lock Owner Name                | 18     | Name of the thread holding the monitor lock.                                               |
| Waited Count                   | 19     | Number of times the thread has entered the waiting state.                                  |
| Waited Time (ms)               | 20     | Total time the thread has spent waiting.                                                   |
| Waited Count Delta             | 21     | Difference in waited count between the current thread and the previous log entry.          |
| Waited Time Delta (ms)         | 22     | Difference in waited time between the current thread and the previous log entry.           |
| Thread State                   | 23     | Current state of the thread (new, runnable, blocked, waiting, timed\_waiting, terminated). |
| Sample Period                  | 24     | Time difference between this and the previous resource probe.                              |




