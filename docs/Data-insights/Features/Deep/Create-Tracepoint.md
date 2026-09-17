

## List Tracepoints


To view a list of configured tracepoints, open **Explore**, select the **Deep** data source, and navigate to **Tracepoints → List Tracepoints**.  

![!Screenshot](/Monitor-your-data/Deep/images/list.png)

You can adjust the **Limit** field to control the number of results displayed (default: 20). The results will show all currently configured tracepoints.  

!!! tip 
    Using the run query button will list the available tracepoints.


## Create Tracepoint

To create a tracepoint, open **Explore**, select the **Deep** data source, and navigate to **Tracepoints → Create Tracepoint**.

![!Screenshot](/Monitor-your-data/Deep/images/create.png)

You now need to configure the tracepoint to trigger as required. To do this, you **must** set the file path and line number- all other settings are optional.

![!Screenshot](/Monitor-your-data/Deep/images/tracepoint-details.png)


| Item Name     | Default | Example                         | Description |
|--------------|---------|--------------------------------|-------------|
| **File Path**  | -       | `simple_test.py`              | This is the file path to the **source** file in which the trigger is to be installed. This can be a full path or just the file name, depending on the agent being used. |
| **Line number** | -       | 42                          | This is the line number in the **source** file where the trigger is to be installed. |
| **Fire Count**  | 1     | 10                          | This is the number of times the trigger should fire before it is disabled. This count is per client, not a global value. Setting this to **Forever** will trigger the tracepoint every time (rate limiting still applies) until removed. |
| **Targeting**   | -       | `service.name=myapp`          | A query used to target triggers to specific clients based on the client resource. Using `service.name=myapp` will ensure only clients defining `service.name` as `myapp` receive this trigger. |
| **Log Message** | -       | `user id = {user.id}`         | Allows dynamic log messages to be injected into the target application. These log messages can be consumed by log platforms such as Loki. Expressions within `{}` will be evaluated at the trigger location to extract local variables. |
| **Trace**       | None | Line                       | Allows dynamic spans to be injected. Selecting **Line**  creates a span at the targeted line. Selecting **Method/Function** creates a span around the enclosing method/function. |
| **Metrics**     | -       | `basket_size len(basket.items)` | Allows dynamic metrics to be created using local variables. [Read more below.](/Data-insights/Features/Deep/Create-Tracepoint/#metrics) |
| **Watches**     | -       | `user.id`                     | Allows selection of specific variables when using snapshots. To learn more about watches, view the docs for [the client](https://intergral.github.io/deep/#client) being used. |

### Metrics
 

When creating metrics, you can specify both the metric **name** and **value**.  

- The **name** must be lowercase and use underscores (`_`) for compatibility. It will be automatically prefixed with `deep_` to avoid conflicts with existing metrics. 

!!! example
    If you specify `basket_size`, the generated metric will be `deep_basket_size`.  

- The **value** can be:  
  - **A fixed numeric value**  
  - **An expression** that uses local variables to extract a numeric value  

When defining metrics, ensure the expression is valid and results in a numeric value. Invalid expressions will prevent metrics from being generated, and no data will appear in the metric endpoint. Errors can be found in the client logs if logging is enabled.



## Delete Tracepoint


To delete a tracepoint using **Explore**, select the **Deep** data source and navigate to **Tracepoints → Delete Tracepoint**.  

![!Screenshot](/Monitor-your-data/Deep/images/delete.png)

- Enter the **ID** of the tracepoint you want to delete.  
- The tracepoint ID can be found in the table view of the **List Tracepoints** response, which also provides a delete link.  
- If using the **integral-deeptracepoint-panel** plugin, a delete button is available for easy removal.