# Resolve slow queries

<div style="padding:56.25% 0 0 0;position:relative;"><iframe src="https://player.vimeo.com/video/1070253171?title=0&amp;byline=0&amp;portrait=0&amp;badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479" frameborder="0" allow="autoplay; fullscreen; picture-in-picture; clipboard-write; encrypted-media" style="position:absolute;top:0;left:0;width:100%;height:100%;" title="Troubleshooting Slow SQL Queries with FusionReactor"></iframe></div><script src="https://player.vimeo.com/api/player.js"></script>

**Problem:** Your application is running slowly, and you suspect slow SQL queries are the cause.

**Solution using FusionReactor:**

1. **Identify the bottleneck:**
    - Open FusionReactor.
    - Navigate to **JDBC History**.
    - Sort by the **Duration** column (descending) to see the longest running queries first.

2. **Drill down into a slow transaction:**
    - Click on a transaction that took longer than expected.
    - Go to the **JDBC** tab within the transaction details.
    - Review the specific SQL query and the time taken for each part of the execution.

3. **Analyze the SQL query:**
    - Look for common issues such as:
        - **Missing indexes** on columns used in `WHERE` clauses or `JOIN` conditions.
        - **Inefficient JOINs** that require excessive processing.
        - **Leading wildcards** (e.g., `LIKE '%value'`) that prevent index usage.
        - **Selecting unnecessary columns** (`SELECT *`).

4. **Implement optimizations:**
    - **Add indexes** to frequently queried columns.
    - **Rewrite queries** to be more specific - avoid `SELECT *`.
    - **Optimize JOINs** by using appropriate join types and indexed columns.
    - **Restructure tables** if the schema itself is causing performance issues.

5. **Verify improvements:**
    - Re-run the query and check **JDBC History** again.
    - Compare duration before and after your changes.
    - Monitor overall application performance to confirm the fix.

6. **Set up proactive monitoring:**
    - Configure **[Crash Protection](/Data-insights/Features/Crash-protection/Crash-Protection/)** alerts to notify you when SQL queries exceed defined thresholds.

---

## Best practices for SQL performance

- Index frequently queried columns.
- Avoid leading wildcards in `LIKE` clauses.
- Use appropriate join types with indexed columns.
- Only select the columns you need.
- Regularly review query performance in JDBC History.
