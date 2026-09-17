
# Stdout.log and Stderr.log

FusionReactor automatically captures and redirects Java application output streams to dedicated log files, providing centralized logging for standard output and error messages. This feature enables comprehensive monitoring of application console output without requiring code modifications.

## How It Works

When FusionReactor initializes, it intercepts all messages sent through Java's standard output streams:

- **System.out** messages are redirected to `stdout.log`
- **System.err** messages are redirected to `stderr.log`

This interception occurs at the JVM level, ensuring that all Java-based print statements, stack traces, and console output are captured regardless of the application framework or logging configuration.

## Limitations

**Native Library Output**: Messages written directly by native libraries (C/C++ components, JNI calls) bypass Java's standard streams and will not be captured in these log files. Only output that flows through `System.out` and `System.err` is intercepted.

## Startup Behavior

During FusionReactor's initialization phase, the logging behavior operates with specific constraints:

- **Buffer Limit**: Up to 500 lines are buffered for each stream (stdout and stderr) while FusionReactor is starting
- **Storage Location**: Buffered messages are written to the FusionReactor log directory once initialization completes
- **Full Activation**: After FusionReactor fully loads, all subsequent `System.out` and `System.err` operations are immediately written to their respective log files

## Configuration

The stdout and stderr logging feature can be controlled through the **[Log Settings](../Settings.md)** page, where administrators can:

- Enable or disable stream capture
- Configure log file rotation policies
- Set retention periods for captured output

This centralized approach to console output management simplifies troubleshooting and provides a complete audit trail of application console activity.
