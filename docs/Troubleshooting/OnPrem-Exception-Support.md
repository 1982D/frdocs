
# Understanding exception tracking and addressing performance concerns

In order to capture telemetry on errors, FusionReactor tracks all exceptions running in the JVM by default. This allows us to generate Event Snapshots for errors and fire breakpoints in the Debugger when exceptions occurs.

In Adobe ColdFusion, this setting is disabled by default due to the ColdFusion engine's tendency to generate numerous exceptions in the background, making it unsafe to activate. However, in environments such as Lucee and Java, it is typically acceptable to enable this setting, as it allows for comprehensive tracking of exceptions, providing valuable insights for snapshots and breakpoints. This setting can aid in state control within application management, or it may be a design implementation that an individual has taken arbitrarily. 

In certain scenarios, such as when using specific frameworks, libraries, or code that generates frequent exceptions, caution is advised. This is because enabling this setting may lead to a performance impact, resulting in FusionReactor slowing down your application. To mitigate this issue, it is necessary to disable exception support using the following argument: 

`-Dfr.jvmti.enable.exceptions=false`


!!! info "Learn more"
    [Manual configuration examples](/Monitor-your-data/FR-Agent/Installation/Configuration-examples/)

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.



