# Visualizing your logs

OpenTelemetry logs integrate logging information into your observability stack, enriching it with additional telemetry data and linking it to related traces. Log entries can accommodate both unstructured text and structured information, making them flexible for various logging needs.

To visualize your logs, simply navigate to OpsPilot in a browser and access the **Log Browser** dashboard, which provides comprehensive logging features without requiring additional configuration. Alternatively, you can view your logs in **Explore** by selecting **Logs** from the datasource dropdown, or via the **Logging** tab.

## Python example

!!! info
    The following example relies on a user having first [instrumented a Python application](/Monitor-your-data/OpenTelemetry/Instrumentation/Python/) to ship data to OpsPilot. 


In the OpsPilot **Logging** window, open the **Job** dropdown and select `fib_by_iteration`. All the log messages emitted by the Python code will appear.


![!Screenshot](/Monitor-your-data/OpenTelemetry/images/pythonlogs1.png)*Logs supplied by Python*