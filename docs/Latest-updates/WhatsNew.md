# What's New in FusionReactor

## FusionReactor 2026.1.3 released

**Published: June 29, 2026**

- Exposes license and signal/data-export states in FRAPI via `getLicenseState()` and `getSignalState()` functions. See [FRAPI docs](../Data-insights/Extras/FRAPI.md) 
- Improves UI cloud tunnel connection stability.
- Fixes issues with instance name changes not being reflected in exported data (metrics etc.).
- Makes config corruption less likely.
- Persists log scraping offset, to config, less frequently. Use `-Dfr.observability.log.scrape.offsets.persist.rate=` to set the interval in milliseconds.

## FusionReactor 2026.1.2 released

**Published: May 26, 2026**

- Fixed issues with cfhttp tracking for Lucee 7
- Exposes more transaction info within FRAPI (see [FRAPI docs](../Data-insights/Extras/FRAPI.md#transaction-surrogate))
- Exports Linux meminfo as `fr.system.memory.` metrics (`-Dfr.observability.metric.linux.system.memory.enabled=false` to disable)

## FusionReactor 2026.1.1 released

**Published: May 6, 2026**

Reduces the cardinality of the request metrics added in 2026.1.0. Some users experienced a substantial metric usage increase due to certain metric labels, these have been removed by default while keeping the metrics.   

Removed labels:

- `http.route` for `http.server.request.duration` metrics
- `db.collection.name` and `db.namespace` for `db.client.operation.duration` metrics
- `messaging.consumer.group.name`, `messaging.destination.name`, and `messaging.destination.partition.id` for messaging request metrics

These labels can be re-enabled via the high_cardinality [properties](../Troubleshooting/Configuration/FusionReactor-System-Properties.md#observability-metrics). If metric usage is still an issue, you may wish to disable the metrics. 

## FusionReactor 2026.1.0 released

**Published: April 20, 2026**

- New and improved metrics
  - Additional request metrics (HTTP, database, and messaging)
  - Additional/improved JVM metrics
  - ColdFusion DB Pools stats are now exported
  - Option to switch metric names and recording to other formats (FR/OTel/Prometheus)
    - `-Dfr.observability.metric.names=` with `fr`, `otel` or `all` (both) as options
    - `-Dfr.observability.metric.prometheus.jvm.enabled=true` to enable Prometheus-like JVM metrics
- New ability to send emails without requiring an SMTP server     
- Debugger improvements and fixes:     
  - Fixed issues with listing variables when using Java 21+
  - Added support for enabling/disabling breakpoints per location
    - Be careful, this isn't persisted across restarts. An enabled breakpoint will trigger on all locations when the agent is restarted.
  - Lucee specific fixes for showing correct source files on triggered breakpoints
    - Lucee users, who don't use the debugger, may wish to disable this functionality to prevent unnecessary class processing `-Dfr.lucee.debugger.fullfilename.enabled=false`
- Improved error capture for Lucee requests
  - `-Dfr.lucee.exception.request.enabled=false` to disable if error capture is too sensitive in your case.
- Improvements made to increase the reliability of the UI tunnel connection.
- [Various bug fixes and improvements](./release-notes.md)

## FusionReactor Cloud is now OpsPilot

**Published: March 9, 2026**

FusionReactor Cloud is officially becoming **OpsPilot**.

Your account, pricing, integrations, and support team remain exactly as they were. What's changing is the identity of the platform - and for good reason.

OpsPilot has been the AI engine at the heart of the product for the past three years. As the platform grew to proactively guide teams, score stack health, investigate incidents, and deliver prioritised recommendations, it became clear that OpsPilot wasn't just a feature. It was the product. The rename reflects that reality.

### What's new in this release

Alongside the rebrand, this is the biggest UI update in FusionReactor's history:

- **Fully refreshed interface** - Modern, unified, and designed for clarity
- **Side navigation** - Faster and more intuitive product navigation
- **Full mobile and tablet support** - The navigation is now fully responsive
- **Multi-tenancy built in** - Seamless switching between multiple organisations
- **New homepage** - Clear summaries, current statuses, and onboarding guidance
- **Alerting engine front and centre** - Easier to configure, monitor, and act on alerts
- **Improved Servers view** - Now the default view, with real-time and historic data side by side and built-in crash protection analysis
- **OpsPilot AI throughout the product** - AI-powered chat and analysis accessible from anywhere in the product

!!! note
    To get the most out of these new features, we recommend upgrading to the **FusionReactor Agent 2025.2** release.

### What comes next

The roadmap for 2026 is anchored around AI and OpenTelemetry - deeper AI-powered investigation and root cause analysis, broader OpenTelemetry support across languages and frameworks, and more intelligence built into every layer of the product.

### FusionReactor 2025.2.1 released

- Added support for Jersey classes that use Jakarta  (e.g. ColdFusion REST) while also prevent errors.
- Fixed bug found when JDBC PreparedStatements have an odd number of quote characters (`'`) in comments
- Fixed potential XSS exploit in UI.
- Added HTTPS support, in the on-prem UI, for later versions of Java.
- Prevents out-of-date metric labels.

### FusionReactor 2025.2.0 released 

- Support for OTLP data format allowing the export of FusionReactor data to any OTLP data ingest (Metrics, Logs, and Traces).
- Crash Protection alerts in cloud adding improved clarity and analysis.
- Added OpsPilot integration within the on-prem UI tunnel in cloud for AI analysis.
- New colour themes for FusionReactor's on-prem UI.
- Support for Lucee 7 installation via FRAM.
- Updated version of the JRE bundled with FRAM (8u472) and other security updates within FusionReactor.



!!! Warning
    If you are upgrading to **FusionReactor 2025.2** and are already using **OTel**, FusionReactor will now automatically use any existing configured endpoints. To ensure you continue receiving data in **FusionReactor Cloud** while using an OTel Collector, you must update your `collector.yaml` configuration file. Please refer to the [documentation linked here](https://docs.fusionreactor.io/Monitor-your-data/FR-Agent/Configuration/OTel-shipping-config/) for the required changes.



<div style="padding:56.25% 0 0 0;position:relative;"><iframe src="https://player.vimeo.com/video/1140102032?badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479" frameborder="0" allow="autoplay; fullscreen; picture-in-picture; clipboard-write; encrypted-media; web-share" referrerpolicy="strict-origin-when-cross-origin" style="position:absolute;top:0;left:0;width:100%;height:100%;" title="FusionReactor 25.2 Release"></iframe></div><script src="https://player.vimeo.com/api/player.js"></script>

!!! info "Learn more"
    [Release notes](https://docs.fusionreactor.io/Latest-updates/release-notes/)

## Trace-powered investigations in OpsPilot

OpsPilot can now query and analyze distributed traces, giving it the ability to investigate individual transactions in real time. This powerful new capability allows OpsPilot to:

- Search for slow or failing requests using TraceQL.

- View complete execution paths across microservices.

- Identify performance bottlenecks and errors at the span level.

- Correlate metrics with traces to show not just *what* is happening, but *why*.

This feature transforms OpsPilot from a monitoring assistant into a true root cause analysis engine, helping you move from detection to diagnosis in seconds.

<iframe src="https://player.vimeo.com/video/1130895710?badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479" width="600" height="400" frameborder="0" allow="autoplay; fullscreen; picture-in-picture; clipboard-write; encrypted-media; web-share" referrerpolicy="strict-origin-when-cross-origin" title="Why is checkout latency high?"></iframe>

## Model Context Protocol (MCP) Support in FusionReactor

FusionReactor now supports the Model Context Protocol (MCP) - a vendor-neutral standard that allows AI tools to securely connect with external systems in real time. MCP enables AI models to access up-to-date information and even interact with supported tools.

### FR Cloud MCP

<div style="display: flex; gap: 20px;">
  <div style="flex: 1;">
    Connect AI assistants like Claude Desktop directly to your FusionReactor Cloud data using MCP. Gain real-time insights, run queries, and integrate FR Cloud with your AI workflows - powered by the open-source Grafana MCP project.
  </div>
  
  <div style="flex: 1;">
    <div style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; max-width: 100%;">
      <iframe 
        style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;" 
        src="https://player.vimeo.com/video/1109031163?title=0&amp;byline=0&amp;portrait=0&amp;badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479" 
        title="MCP Integration" 
        frameborder="0" 
        allow="autoplay; fullscreen; picture-in-picture; clipboard-write; encrypted-media; web-share" 
        referrerpolicy="strict-origin-when-cross-origin" 
        allowfullscreen>
      </iframe>
    </div>
  </div>
</div>
    
!!! info "Learn more"
    [FR Cloud MCP](/Monitor-your-data/MCP/mcp-overview/)

### Katie 

We're excited to introduce Katie and Katie MCP, two new tools designed to help you integrate and manage your Kubernetes clusters with AI.

With an easy-to-install agent and MCP tooling, you can bring real-time data from your Kubernetes clusters into your AI's decision-making process. The Katie agent can be installed in two modes:

- **Read-write mode**: This allows AI to not only receive live data but also to make changes to your cluster.

- **Read-only mode**: This provides up-to-the-second data to AI language models without allowing them to make any modifications.


!!! info "Learn more"
    [Katie](/Monitor-your-data/Katie/overview/)

## Explore: Logs Now Available

We’ve added a new way to investigate issues by exploring logs directly inside FusionReactor. FusionReactor’s Logs Drilldown makes log exploration effortless with an intuitive, query-free interface. Your log data is instantly transformed into interactive visualizations, allowing engineers of any skill level to investigate issues and uncover insights - no LogQL needed.

![!Screenshot](../../Latest-updates/images/logs.png)

**Highlights:**

* Instantly see log volume and sample log lines when opening Explore Logs - no more blank screen.
* Browse labels and detected fields with volume and distribution insights; refine results without writing LogQL.
* Spot common patterns to filter noise or focus on anomalies.

!!! info 
    [Explore Logs](/Data-insights/Features/explore-logs/)

## Explore: Traces Now Available

We’re excited to announce the availability  of Traces Drilldown in Explore, delivering a simplified, query-free way to analyze distributed traces. This release offers a refined, fully integrated deep-dive tracing solution.

![!Screenshot](../../Latest-updates/images/traces.png)

**Highlights:**

- **No queries needed**  -  Jump straight from dashboards to detailed trace insights, connecting RED (Rate, Errors, Duration) metrics with exact trace data.

- **Seamless navigation**  -  Move smoothly from high-level overviews to detailed span views while keeping context, making root cause analysis faster.

- **Built-in tools**  -  Use integrated filtering, highlighting, comparisons, and correlation to quickly spot anomalies without leaving the interface.

- **Rich trace visualization**  -  Inspect spans with metadata, duration, and status to pinpoint bottlenecks and errors.

- **Unified workflow**  -  Link traces with logs, metrics, and profiles for a complete observability view, enabling rapid investigation from any signal.

!!! info 
    [Explore Traces](/Data-insights/Features/explore-traces/)

## New in OpsPilot: Web Search Toggle

You now have more control over your queries in OpsPilot with the new **Web Search Toggle**!

Easily **enable or disable web search** depending on your needs - perfect for switching between private/internal topics and general web lookups.

**Where to find it:**
Look for the **globe icon** next to the mic in the chat bar.

* **<span style="color:blue">Blue</span> icon = ON** (uses live web search)
* **<span style="color:gray">Gray</span> icon = OFF** (uses only internal knowledge)


!!! info "Learn more"
    [Web Search Toggle](/Data-insights/Features/OpsPilot/OpsPilot-user-guide/#web-search-toggle)






## New Authentication System Now Live

We’ve launched a major upgrade to FusionReactor’s authentication system to enhance security, usability, and flexibility across the board.

**Here’s what’s new:**

* **🔑 Passwordless Logins with Passkeys**  -  A faster, phishing-resistant way to log in using device-based authentication.
* **🛡️ Built-in Multi-Factor Authentication (MFA)**  -  Add an extra layer of protection with TOTP or biometric verification.
* **🔁 Seamless Multi-Account Switching**  -  Easily move between accounts and organizations without logging out.


These changes help secure your FusionReactor access while reducing friction in your daily workflow.



## What's new in FusionReactor 2025.1.0

FusionReactor 2025.1.0 introduces several new features, improvements, and bug fixes to enhance performance, observability, and ease of use. This release includes support for Adobe ColdFusion 2025, ensuring seamless monitoring for the latest ColdFusion applications. Bug fixes include resolving an issue where certain transactions were not displaying correctly in Lucee, ensuring service names are correctly set in Deep Integration, and moving a cloud connection from port 2804 to port 443 for easier setup. Observability enhancements include metadata descriptions for metrics in the cloud (which can be disabled using `-Dfr.observability.metric.prometheus.remotewrite.metadata.enabled=false`), expanded FRAPI capabilities for creating web request transactions and setting transaction properties, and the ability to view transaction profiles in Pyroscope and Tempo traces. Additional fixes and enhancements are also included in this update. 

!!! info "Learn more"
    [Full release notes](/Latest-updates/release-notes/#202510-3rd-march-2025)

### Pyroscope continuous profiling

Pyroscope is a multi-tenant, continuous profiling aggregation system designed to seamlessly integrate with existing observability tools. By correlating profiling data with metrics, logs, and traces, Pyroscope provides deeper insights into application performance. With structured querying and analysis of production data, you can efficiently identify bottlenecks and optimize resource usage. 

![!Screenshot](/Data-insights/Features/Pyroscope/trace.png)





## OpsPilot updates

We're excited to announce two major updates to OpsPilot! First, our new agentic system for querying metrics data enhances your experience with dynamic, relevant insights, more frequent and accurate graphs, and quicker response times. Second, we've introduced the ability to scrape websites and ingest their content directly into your knowledge base, expanding the ways you can gather and utilize information. These updates empower you to gain deeper insights and build a more comprehensive knowledge repository effortlessly.



## Jira integration
OpsPilot now integrates directly with Jira Cloud and Data Center, enabling you to:

- Create and track issues directly through OpsPilot.
- Search and comment on existing tickets.
- Manage tickets across your selected projects.

![!Screenshot](../../Latest-updates/images/Jira1.png)

!!! info "Learn more"
    [Jira integration](/Data-insights/Features/OpsPilot/OpsPilot-Hub/Knowledge/)

## Explore: Servers 
The new Servers tab in Explore provides enhanced server monitoring capabilities:

- Real-time metric tiles with traffic light status indicators.
- Key performance metrics including CPU, memory, and throughput.
- Detailed performance graphs for trend analysis.
- Advanced filtering by client ID and server groups.
- Customizable time ranges for precise monitoring.


## Explore: Metrics
A powerful new addition to the Explore suite that will revolutionize how you visualize and analyze your Prometheus-compatible metrics:

- Browse metrics without writing complex queries.
- Interactive metric previews with real-time graphs.
- Advanced filtering and labeling capabilities.
- Customizable time ranges and view options.
- Unified search across all metric names.


## OpsPilot 1.3.0

Introducing OpsPilot Hub: Your centralized knowledge repository for enhanced operational efficiency available in the OpsPilot 1.3.0 release. This new feature serves as the backbone for the OpsPilot AI Assistant, allowing you to store and manage critical operational information. With OpsPilot Hub, you can document your services, add custom metadata, and upload various types of knowledge through snippets and files. The intuitive interface includes progress tracking for service documentation, tagging for easy organization, and powerful filtering options. By centralizing your organization's information, OpsPilot Hub empowers the AI Assistant to provide more accurate, context-aware solutions to your team's operational challenges.


!!! info "Learn more"
    [OpsPilot Hub](/Data-insights/Features/OpsPilot/OpsPilot-Hub/Knowledge/)

## FusionReactor 12.1

### Java 21 Support

FusionReactor 12.1 introduces comprehensive support for applications running on Java 21, the latest long-term support release of the Java platform. This update ensures full compatibility and optimal performance monitoring for Java 21 environments. Users can now track transactions and requests on Java 21 with the same depth and accuracy as previous Java versions. The seamless performance monitoring extends to all applications that have been upgraded to Java 21, allowing development teams to confidently adopt the latest Java features while maintaining robust application insights.

### Cloud UI WebSocket Tunnel
A groundbreaking feature in this release is the Cloud UI WebSocket Tunnel, which enables users to browse on-premises agent's UI directly through the FusionReactor Cloud website. This innovation facilitates seamless navigation between cloud and on-premises resources, providing a unified experience for managing distributed environments. The WebSocket Tunnel significantly reduces the need for complex port connections or intricate networking setups, simplifying the overall management process for DevOps teams. This feature is particularly beneficial for organizations with strict firewall policies or those managing applications across various network environments.

<div style="padding:56.25% 0 0 0;position:relative;"><iframe src="https://player.vimeo.com/video/992148025?title=0&amp;byline=0&amp;portrait=0&amp;badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479" frameborder="0" allow="autoplay; fullscreen; picture-in-picture; clipboard-write" style="position:absolute;top:0;left:0;width:100%;height:100%;" title="On-Prem UI Tunnel"></iframe></div><script src="https://player.vimeo.com/api/player.js"></script>

### Cloud Credentials for Agent Login
FusionReactor 12.1 enhances user authentication by allowing login to on-premise FusionReactor agents using FR Cloud credentials. This integration enables centralized user management through the FR Cloud platform, streamlining access control across multiple environments. The cloud-based authentication mechanism provides enhanced security, leveraging robust cloud security protocols to protect sensitive monitoring data. Teams managing multiple agents across different locations will find the login process significantly simplified, reducing the overhead of credential management and improving overall operational efficiency. This feature is especially valuable for large enterprises with distributed teams and complex application architectures.


<div style="padding:56.25% 0 0 0;position:relative;"><iframe src="https://player.vimeo.com/video/1008366105?title=0&amp;byline=0&amp;portrait=0&amp;badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479" frameborder="0" allow="autoplay; fullscreen; picture-in-picture; clipboard-write" style="position:absolute;top:0;left:0;width:100%;height:100%;" title="English-FR 121 Cloud Login.mp4"></iframe></div><script src="https://player.vimeo.com/api/player.js"></script>


These new features in FusionReactor 12.1 provide:

- Support for the latest Java developments

- Improved integration between cloud and on-premises environments

- Streamlined monitoring workflows



## Custom Detectors

FusionReactor Cloud has been upgraded with new Custom Detectors, enhancing its anomaly detection capabilities. This feature allows for more precise monitoring and diagnostics of your application's performance. While setting up Custom Detectors requires manual input and some knowledge of PromQL, they offer exceptional customization, letting you set specific conditions or thresholds that match your application's particular requirements. 

To help you begin, FusionReactor Cloud provides three pre-configured custom detectors specifically designed for Java and ColdFusion users. It's important to note that if you're not using Java or ColdFusion, these default detectors may not be directly applicable to your environment. However, regardless of your technology stack, you have the freedom to create your own custom detectors for monitoring CPU, memory, or any other crucial resources relevant to your specific application. This flexibility enables accurate identification of performance bottlenecks and potential issues across various technologies, helping maintain your application's efficiency and reliability.

<div style="padding:56.25% 0 0 0;position:relative;"><iframe src="https://player.vimeo.com/video/992149064?badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479" frameborder="0" allow="autoplay; fullscreen; picture-in-picture; clipboard-write" style="position:absolute;top:0;left:0;width:100%;height:100%;" title="Custom Detectors"></iframe></div><script src="https://player.vimeo.com/api/player.js"></script>

!!! info "Learn more" 
    [Custom Detectors](/Data-insights/Features/Anomaly-Detection/ADuserguide/#custom-detectors)


## Enhanced On-Prem billing experience

We’ve listened to your feedback and are excited to announce that we’ve upgraded to a new billing platform powered by Stripe, designed with your convenience in mind. Enjoy a smoother, more flexible billing experience, addressing challenges with updating credit card details and adjusting product quantities. Managing subscriptions is now really easy in the new billing system, as you can add or remove seats directly within the product without needing to call sales or support.

## Deep 

FusionReactor's new Deep integration provides AI powered root cause analysis to help solve issues quickly and instantly debug in production with no restart or redeploy required. With Deep, your team are able to concentrate on delivering innovative features rather than spending valuable time debugging.

![!Screenshot](../../Latest-updates/images/Deep.png)

## OpsPilot 1.2.0

With version 1.2.0, OpsPilot introduces exciting new features and improvements to enhance user experience, streamline workflows, and deliver even more powerful monitoring and management capabilities.



### New feature 

* **OpsPilot Vision**: OpsPilot introduces OpsPilot Vision, a groundbreaking feature that enriches its capabilities by allowing users to upload images for added context to their inquiries. With OpsPilot Vision, users can now provide supplementary visual information alongside their questions, enabling OpsPilot to deliver more comprehensive and tailored responses. This integration enhances the overall user experience, fostering greater clarity and effectiveness in communication. 

![!Screenshot](../../Latest-updates/images/OPimage.png)


![!Screenshot](../../Latest-updates/images/OPvision.png)

!!! info "Learn more"
    [OpsPilot Vision](/Data-insights/Features/OpsPilot/OpsPilot-user-guide/#opspilot-vision)
    
* **Updated FR knowledge base**: OpsPilot has undergone a significant upgrade in its FusionReactor knowledge base, resulting in enhanced proficiency in understanding and addressing issues. With this improvement, OpsPilot can now provide more informed and effective responses when dealing with FusionReactor-related tasks. This advancement promises smoother operations and quicker resolutions, ultimately optimizing system performance and minimizing downtime.

![!Screenshot](../../Latest-updates/images/FRknow.png)

* **Continue On Error**: In the event that OpsPilot encounters an issue while responding, users now have the option to choose between retrying the operation or continuing the conversation seamlessly without interruption.


### Improvements

* **Alarm refinement** - In response to user feedback, OpsPilot has undergone optimization to refine its alarm notification system.  With this update, when OpsPilot notifies users of detected alarms during its task list processing, it will no longer repeat identical alarm notifications. This refinement ensures a more focused and efficient user experience by eliminating redundancy and providing clear, actionable notifications when necessary.


* **Time ranges** - OpsPilot now features automatic time range determination, simplifying the process of querying data within FusionReactor Cloud. OpsPilot will intelligently analyze the data and automatically determine the most relevant time range to address user queries. This enhancement saves time, eliminates guesswork, and ensures that users receive actionable insights based on the most pertinent data available.

* **Graph resolutions**: OpsPilot has enhanced the resolution of graphs displayed within the platform, ensuring clearer and more detailed visual representations of data

## FusionReactor 12

We're excited to announce several enhancements in the latest release of FusionReactor 12. First off, we've seamlessly integrated the [Observability Agent](/Monitor-your-data/Observability-agent/overview/) within FRAM, offering enhanced monitoring capabilities for better insights into your applications. Additionally, our system now automatically detects supported application servers within FRAM, streamlining setup and management processes. We've also invested in improving support for Lucee 6 and Tomcat 10 within FRAM, ensuring smoother experiences for users of these technologies. These updates reflect our commitment to empowering developers with robust tools and features to optimize their workflows.

![!Screenshot](../../Latest-updates/images/FR12.png)


!!! info "Learn more"
    [Release notes](/Latest-updates/release-notes/)

## Anomaly Detection (Beta)

For users familiar with FusionReactor Cloud (FR Cloud), the latest exciting update is the introduction of the Anomaly Detection component. This new feature enhances FR Cloud by enabling users to track the **probability of anomalies** in critical service metrics, known as RED (Request, Errors and Duration rates). It not only allows for closer monitoring of these key metrics but also provides notifications when they exceed set thresholds, offering a more proactive approach to service management.

!!! info "Learn more"
    [Anomaly Detection user guide](/Data-insights/Features/Anomaly-Detection/ADoverview/)



![!Screenshot](../../Latest-updates/images/WhatsNewAD.png)

## OpsPilot version 1.1.1 

**New features**

* Theme overhaul: OpsPilot now boasts a fresh, modern theme, providing an enhanced visual experience. The revamped theme contributes to a more cohesive and aesthetically pleasing monitoring interface.

![!Screenshot](../../Latest-updates/images/WNOP1.png)


* Alert integration: OpsPilot takes a significant step forward in its capabilities by now providing direct access to alerts firing within FusionReactor. This integration enables users to swiftly investigate and respond to alerts, streamlining the troubleshooting process for enhanced system reliability.

![!Screenshot](../../Latest-updates/images/WNOP2.png)

**Improvements**

* Graph enhancements: Enjoy a more flexible graphing experience with the ability to add or remove graph series from display using a simple ctrl+click command. This improvement gives users greater control over the visualization of their data, contributing to a more tailored and insightful monitoring experience.

* Graph accuracy: OpsPilot's graphs have undergone refinements to ensure a more accurate reflection of the data received. Users can now rely on the enhanced precision of graphs, facilitating a clearer understanding of the system's response as portrayed by OpsPilot.

**Bug fixes**

* Custom commands (HF): Resolving a bug that previously hindered the creation of custom commands, this update ensures a smoother experience for users looking to customize and optimize their monitoring workflows. With this bug fix, OpsPilot maintains its commitment to providing a robust and reliable monitoring solution.



Stay tuned for more updates and enhancements as OpsPilot continues to evolve, delivering an even more intuitive and powerful monitoring experience.

## FusionReactor 11

FusionReactor, the renowned application performance monitoring (APM) tool, has reached version 11.0.0. This release provides a significant improvement in security updates, reflecting the company's commitment to keeping your applications safe and secure. However, one notable change in this release is the discontinuation of Java 7 support, a decision made to address critical CVEs (Common Vulnerabilities and Exposures). We're also happy to announce integration with the upcoming Deep release as well as support for WebRequest tracking within servers using Jakarta servlet, which includes later versions of Tomcat and Wildfly amongst others.  

!!! info "Learn more"
    [Release notes](/Latest-updates/release-notes/)
    
## OpsPilot Assistant

At FusionReactor, we're no stranger to the demands of on-call responsibilities because we've encountered those high-pressure situations ourselves. We're also passionate about discovering innovative solutions that enhance an engineer's daily routine, particularly in the realm of incident response management. That's why we're thrilled to unveil OpsPilot, an industry-first, fully launched, and production-ready assistant that serves as the cornerstone of FR Cloud. 

Our trusted assistant is the equivalent to having a team of experts on-call, 24/7. With OpsPilot Assistant the opportunities are endless. Conduct a series of automated system evaluations, promptly bringing potential issues in your entire environment to the surface.  Or simply pose a question, then let OpsPilot delve into the depths of your system, bringing forth insights that are not just data-driven but context-aware.  Armed with the vision provided by OpsPilot, you can swiftly pinpoint the core of any problem and streamline your resolution process for greater efficiency. OpsPilot transforms complex application landscapes into understandable conversations, empowering you with real-time insights at the speed of thought. 


## Enhanced dashboard navigation

We're thrilled to introduce some exciting enhancements to our dashboards providing you with even more powerful data insights! In our latest update,we've improved the user experience by allowing variables and time picker settings to seamlessly pass between dashboards. Our update allows you to move easily between dashboards ensuring you never lose context while exploring your data as all filters and time values are retained as you switch dashboards. To make navigation a breeze, we've improved the search facilities allowing you to effortlessly locate any dashboard you require. The newly incorporated  dropdown dashboard links make it easier than ever to access the information you need. These updates are designed to streamline your dashboard experience and empower you to make data-driven decisions effortlessly.

![!Screenshot](../../Latest-updates/images/newdash.png)

## Servers update

We're excited to unveil the latest enhancements to FusionReactor's servers view, designed with On-Prem parity to elevate your monitoring and troubleshooting experience. Our team has diligently worked to make the servers view clearer and more accessible than ever before. With a refreshed interface, intuitive navigation, and streamlined information presentation, gaining insights into your server's performance has never been easier. Whether you're a seasoned developer or just starting your journey, you'll appreciate the enhanced visibility into key metrics, real-time updates, and advanced analytics, all thoughtfully organized for effortless comprehension.

![!Screenshot](../../Latest-updates/images/wnservers.png)


## Coming soon...

The next FusionReactor Agent release is scheduled for late October to early November. Here's what's included:

### Light & Dark Theme (On-Premises UI)
Choose between light and dark themes in the FusionReactor on-premises interface. Your theme preference will persist across sessions for a consistent visual experience.

### OpenTelemetry (OTEL) Shipping Integration
Native OTEL shipping support enables you to send telemetry data directly to OpenTelemetry-compatible platforms, providing seamless integration with your existing observability stack.

### Crash Protection Logs in Cloud
Crash Protection logs will automatically ship to FusionReactor Cloud, providing centralized visibility across all your servers. A new dedicated crash analysis page will be available in the Cloud UI.

#### OpsPilot Analysis for Crash Protection
Access intelligent crash analysis directly from the Cloud interface. The new **Analyse with OpsPilot** button provides AI-powered insights and recommendations for Crash Protection events, helping you diagnose and resolve issues faster. 


### OpenTelemetry Standard Agent
Send your FusionReactor data to popular APM tools like Grafana and Datadog. Our OpenTelemetry-compliant agent gives you the flexibility to work with the platforms you already use.

### Unified Billing Model
A simplified billing approach that supports on-premises, cloud, and hybrid deployments. Switch between environments without billing complexity  -  pay only for what you need.

### Server View
A centralized dashboard for monitoring all your servers in one place. Get high-level visibility into server health, performance metrics, and alerts, with the ability to drill down into individual server details and analyze historical trends.

### Application View
Monitor all your applications from a single dashboard. View key performance metrics at a glance, including transaction throughput, error counts, and response times, with detailed drill-down capabilities for deeper analysis.

### Enhanced Alerting System
Set alerts across any data source with support for additional notification channels. Your existing alerts will migrate automatically, and silencers return to give you full control over notifications.

---

Stay tuned for updates as these features roll out!





