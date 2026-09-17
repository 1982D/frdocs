

# Post-crash troubleshooting with FusionReactor On-Premise

## Overview

This guide shows how to use **FusionReactor On-Premise** to investigate and prevent application server crashes. You’ll walk through a real-world crash scenario using tools like the **Archive Viewer**, **Crash Protection**, and **JDBC Logs**, and learn how to identify root causes and put safeguards in place.

---

## Video

<div style="padding:56.25% 0 0 0;position:relative;"><iframe src="https://player.vimeo.com/video/1097774282?badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479" frameborder="0" allow="autoplay; fullscreen; picture-in-picture; clipboard-write; encrypted-media; web-share" style="position:absolute;top:0;left:0;width:100%;height:100%;" title="Diagnosing Server Crashes with FusionReactor On-Premise"></iframe></div><script src="https://player.vimeo.com/api/player.js"></script>



---

## Key features for crash investigation

| Feature              | Description                                                       |
| -------------------- | ----------------------------------------------------------------- |
| **Archive Viewer**   | View historical metrics, requests, and logs from before the crash |
| **Crash Protection** | Automatically detect and respond to problematic requests          |
| **Request Log**      | Analyze completed requests by duration, memory, or resource usage |
| **JDBC Logging**     | Capture and trace SQL statements for database-level visibility    |

---

## Example crash scenario

A server crash occurs unexpectedly during peak usage. Your objective is to:

1. Use **FusionReactor On-Premise** to diagnose what happened.
2. Correlate system metrics with application activity.
3. Prevent future downtime by configuring alerts and protective actions.

---

## Step 1: Investigate the crash with Archive Viewer

1. Open **FusionReactor On-Premise** and launch the **Archive Viewer**.
2. Scroll back to the crash timeframe using log rotation timestamps.

![!Screenshot](../../Getting-started/Tutorials/archive.png)

### What to look for

* In the video example, memory usage spiked at **11:49** and remained high.
* The server crashed 14 minutes later - be sure to check the logs following the default hourly rotation.
* By jumping back to the time of the spike, open the **Request Log** to examine what was happening.

### Identify the trigger

* Sort the Request Log by **execution time**.
* In the video example a `Store Cache` request appears right as memory maxes out.
* Other requests begin to **slow down** or **queue**, indicating resource contention.

!!! info "Learn more"
    [Archive Metrics](/Data-insights/Features/Metrics/Archive-Metrics/)

---

## Step 2: Validate with logs

* Open Server Logs for the relevant window.
* Look for entries like:

  * `java.lang.OutOfMemoryError`
  * Stack traces or fatal exceptions
* In the video scenario, an **Out of Memory error** is logged just before the crash, confirming the suspected cause.

![!Screenshot](../../Getting-started/Tutorials/log1.png)

---

## Step 3: Prevent recurrence with Crash Protection

### Overview

**Crash Protection** helps you detect and manage problem requests before they crash the server.

![!Screenshot](../../Getting-started/Tutorials/crash-p.png)

### How to enable:

1. Open the **Crash Protection** section in the On-Premise dashboard.
2. Configure **email settings** to receive alerts.
3. Define thresholds for:

     * Long-running or high-frequency requests
     * High CPU or memory usage

4. Choose a response:

     * **Queue** or **abort** requests
     * Apply rules to specific endpoints

!!! tip
    You can ignore known long-running requests to minimize false positives.

### Sample alert

Here’s an example of the email notification sent when Crash Protection is triggered, including the endpoint, threshold breached, and recommended action.

![!Screenshot](../../Getting-started/Tutorials/protection.png)

!!! info "Learn more"
    [Crash Protection](/Data-insights/Features/Crash-protection/Crash-Protection/)

---

## Optional: Enable JDBC Logging

If your crash may be database-related or you want SQL traceability:

1. Go to **JDBC → Settings** in the on-prem UI.
2. Set **JDBC Logging** to **Enabled**.

### What it provides:

* Logs every SQL statement executed by the application
* Includes **stack traces** for traceability
* Appears within the **Archive Viewer** for historical analysis
* Logging levels and retention can be customized

---

## Outcome

By using FusionReactor On-Premise, you can:

* Rewind system state leading up to a crash.
* Link metrics, logs, and requests to pinpoint the root cause.
* Set up proactive rules with **Crash Protection**.
* Monitor database behavior with **JDBC Logging**.

---





