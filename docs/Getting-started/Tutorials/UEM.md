# User experience monitoring & improvement

<div style="padding:56.25% 0 0 0;position:relative;"><iframe src="https://player.vimeo.com/video/1075712846?badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479" frameborder="0" allow="autoplay; fullscreen; picture-in-picture; clipboard-write; encrypted-media" style="position:absolute;top:0;left:0;width:100%;height:100%;" title="User Experience Monitoring &amp; Optimization with FusionReactor"></iframe></div><script src="https://player.vimeo.com/api/player.js"></script>

**Problem:** Slow application response times are negatively impacting user experience and satisfaction.

**Solution using FusionReactor:**

1. **Install & set up User Experience Monitoring (UEM):**
    - UEM uses JavaScript embedded in your webpages to track user experience end-to-end.
    - Follow the setup instructions [here](/Data-insights/Features/UEM/User-Experience-Monitoring/#script-examples) to add the snippet to the pages you want to monitor.

2. **Monitor end-to-end transaction times:**
    - Access the **User Experience graph** in FusionReactor to visualize tracked experiences.
    - Observe load times from the user's browser through to your ColdFusion application.
    - Analyze latency across all components: backend services, database queries, and external API calls.
    - Identify slow endpoints and recurring performance trends.

3. **Implement performance improvements:**
    - Based on identified bottlenecks:
        - Refactor inefficient ColdFusion code.
        - Tune slow SQL queries - see [Resolve slow queries](/Getting-started/Tutorials/resolve-slow-queries/).
        - Reduce external service call latency.
        - Optimize data sent to the browser.

4. **Validate and monitor:**
    - Re-test affected transactions using UEM and compare metrics before and after changes.
    - Confirm response times have improved.
    - Configure **[Crash Protection](/Data-insights/Features/Crash-protection/Crash-Protection/)** alerts to notify you of slow response times or recurring issues.

!!! info "Learn more"
    [User Experience Monitoring](/Data-insights/Features/UEM/User-Experience-Monitoring/)
