# Cloud Log Multiline Blocks

FusionReactor logs may sometimes contain exceptions.

In most cases, these exceptions are formatted as a single multiline block. However, some servers do not provide the necessary formatting, which can result in a stack trace being split across multiple log entries.

To address this, FusionReactor gives you the flexibility to define custom rules that roll up multiple related log lines into a single message before they are passed along the observability chain. These rules can be applied to both FusionReactor and scraped logs, and you can configure multiple rules for different filesets.

Rule priority is determined by order: rules higher in the table take precedence (e.g., Rule 1 supersedes Rule 2).

When defining a rule, you can specify:

- Which logs should be inspected

- How to detect the start of a new log event

- Whether to include subsequent logs that match the same pattern, or to also capture logs that don’t match but belong to the same block

Consider the following log lines:
````
Customer 1 order_no 529348, order_line 2384, item 2452 
Customer 2 order_no 324525, order_line 2345, item 4523
order_no 324525, order 2345, item 4524
order_no 324525, order 2345, item 4525
````
You can specify the following rule so customer 2 order would be rolled up into a single line:

| Logs Filepaths       | Regex Pattern        | Positive Lookahead |
|----------------------|----------------------|--------------------|
| ```/path/to/*.log``` | ```Customer \d .*``` | ```false```        |
Alternatively if you switch the positive lookahead to `true` Customer 1 and 2 will be rolled up into a single message.

For hints on specifying logfile patterns see [Logging Regex Pattern Hints](/Troubleshooting/logging-regex-pattern-hints/)
