# Importing and Graphing Data in Excel

Most FusionReactor Log files can be easily imported into Excel (and
other tools that can import delimited files) in order to analyze them or
create graphs.

There are several log files that you can be useful import and analyze:

-   [request.log](Files/Request-Log.md)
-   [resource.log](Files/Resource-Log.md)
-   [jdbc.log](Files/JDBC-Log.md)
-   [crashprotection.log](Files/Crash-Protection-Log.md)
-   [memory\[\*\].log](Memory-Logs.md)
-   [gc\[\*\].log](Files/Garbage-Collection-Logs.md)

If you are using the [FusionReactor ColdFusion Plugin](/Data-insights/Extras/Plugins/FusionReactor-ColdFusion-Plugin/)
plugin then you will also have access to the following additional log files:

-   [dbpoolstats.log](/Data-insights/Extras/Plugins/FusionReactor-ColdFusion-Plugin/#cf-stats)
-   [hitcountstats.log](/Data-insights/Extras/Plugins/FusionReactor-ColdFusion-Plugin/#cf-hit-count)
-   [realtimestats.log](/Data-insights/Extras/Plugins/FusionReactor-ColdFusion-Plugin/#cf-realtime)




## How to Import a FusionReactor Log File into Excel

1. **Make a copy** of the log file you want to import. Working on a copy prevents interrupting live log writing.
2. Open Excel, go to the **File** menu, select **Open…**, and navigate to your log file. You may need to choose **All Files (.)** in the file type dropdown.
3. The **Text Import Wizard** dialog will appear.
4. Select **Delimited** as the original data type, then click **Next >**.
5. Choose **Space** as the delimiter, then click **Finish**.
6. The spreadsheet will now display the log data in separate columns.
7. Highlight the column(s) you want to graph, then click the **Chart Wizard** icon in the toolbar, or go to **Insert → Chart**. Use the column letters to match the log field descriptions above.
8. Select the desired chart type (e.g., line, scatter, or bar) and click **Finish**.


