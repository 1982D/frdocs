# How to get alerts for slow requests

## Getting Alerts for Slow Requests

!!! question
    Is there a way to correlate a specific request or endpoint to the CPU spike, so we can act quickly?

To correlate a specific request or endpoint to a CPU spike, you can use the **[CPU Sampler](https://docs.fusionreactor.io/Data-insights/Features/CPU-Sampler/CPU-Sampler/)** to track CPU usage by threads, identify CPU-heavy requests, and take actions like profiling or pausing threads. To access this, use the **on-premise tunnel** for the server in question, then navigate to **Profiler -> CPU Sampler**.


    

!!! question
    Can FusionReactor send an email or SMS alert when a specific request is causing a slowdown?

To set up alerts for slow requests, we recommend using the **On-premise view**, as the Cloud view aggregates metrics and cannot monitor individual requests. In the **On-prem** view:

1. Go to **Protection -> Settings**.
2. Select **WebRequest Runtime Protection**.
3. Specify a minimum request duration and choose an action (e.g., send an email).

If you want emails to be sent, configure email settings in the **FusionReactor dropdown** at the top left, then select **Settings**.
