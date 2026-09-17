
# Increasing SQL query character limit 

<div style="padding:56.25% 0 0 0;position:relative;"><iframe src="https://player.vimeo.com/video/1080792100?badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479" frameborder="0" allow="autoplay; fullscreen; picture-in-picture; clipboard-write; encrypted-media" style="position:absolute;top:0;left:0;width:100%;height:100%;" title="Increasing SQL query character limit (On-prem &amp; Cloud)"></iframe></div><script src="https://player.vimeo.com/api/player.js"></script>

This page explains how to adjust the displayed character limit for SQL queries tracked by FusionReactor's JDBC monitoring. Increasing or disabling this limit allows you to view complete long SQL queries for better debugging and analysis.

## Understanding the issue

FusionReactor's JDBC tracking provides insights into SQL queries executed within your transactions. However, by default, the displayed text of long SQL queries may be truncated in the interface. This limitation can hinder your ability to fully understand and debug complex database interactions.

## Solution: Adjusting the SQL text limit

FusionReactor offers settings to increase the default character limit for displayed SQL queries or disable it entirely.


1.  **Navigate to JDBC Settings:**
    In the FusionReactor on-premise UI, locate and click on the **JDBC** section in the left-hand navigation menu.
2.  **Access Logging / Metrics Settings:**
    Within the JDBC section, click on the **Settings** tab. Under this tab, find the **Logging / Metrics** subsection.
3.  **Modify SQL Text Limiting:**
    Locate the setting labeled **SQL Text Limiting (Log and Display)**.
4.  **Adjust the Character Limit:**
    * **Increase the Limit:** Change the numerical value from the default of `1000` to a higher number that accommodates your typical long queries.
    * **Disable the Limit:** Set the value to `0` to disable the character limit entirely.



## Important considerations

* **Memory usage:** Increasing or disabling the SQL text limit can potentially increase FusionReactor's memory usage, as it will need to store and display larger query strings.
* **Monitoring for impact:** After adjusting the settings, monitor your FusionReactor instance for any unexpected performance or memory impact. If you observe any issues, you can revert the settings to their previous values once you have completed your troubleshooting.

By following these steps, you can customize the SQL query display limit in FusionReactor, enabling you to gain a comprehensive view of your database interactions.
