# How to identify the real cause of slow requests

!!! question
    We often see slow requests, but they may just be symptoms. How can we identify the real cause (e.g., CPU-heavy process, database issue)?

## 1. Analyze transactions for slow sub-transactions

- Go to **Web Requests** and select **History** or **Slow Transactions** from the dropdown.
- Optionally set a minimum request duration using the right-hand filter.
- Select a slow request and navigate to **Tracing > Transaction Hierarchy**.
- This highlights the slowest path through the transaction, helping to pinpoint where time was lost.

## 2. Examine the Detailed Trace

- From the same Tracing screen, click the button on the far right to open the **Detailed Trace**.
- This shows all spans involved in the transaction, including any external calls.
- Use this to identify exactly where delays occurred.

## 3. Review server-level metrics

- Open the **Metrics** tab in FusionReactor to review CPU, memory, and request throughput at the time of the slowdown.
- Check the **Enterprise Dashboard** for a multi-instance overview and to spot resource saturation across servers.

!!! info "Learn more"
    [Crash Protection](/Data-insights/Features/Crash-protection/Crash-Protection/) can be configured to alert you when requests exceed defined thresholds.
