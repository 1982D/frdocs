# Best ways to monitor and troubleshoot issues


!!! question
    What are the best dashboards or views in FusionReactor to quickly find performance issues?

There are various views to explore, but we specifically recommend:

- **Server's Metrics tab** - Allows selection of multiple graphs for a comprehensive view.
- **Enterprise Dashboard** - Provides an overview of memory, CPU, DB load, and average request time across all your instances in a single window.

!!! question
    Can we track patterns over time to see if the same request or function keeps causing slowdowns?

Currently, this must be done manually using the monitoring steps outlined above. However, new features in development should improve this process in the future. In the meantime, you can use:

- **[Crash Protection](/Data-insights/Features/Crash-protection/Crash-Protection/)** to monitor and react to repeated slowdowns.

!!! tip "Want automated anomaly detection?"
    **OpsPilot** provides anomaly detection and alerting for unusual patterns across your services.
    [Start a free trial](https://app.opspilot.com)
