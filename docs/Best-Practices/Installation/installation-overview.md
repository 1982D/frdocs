Welcome to the installation best practice section of FusionReactor's documentation, where we provide comprehensive guidance tailored to your specific environment. With individual diagrams illustrating installation options for different setups, this section aims to enable you to maximize the performance and reliability of your FusionReactor-monitored applications.

## Setups

### Local server

Whether you're running a ColdFusion setup or a more complex Lucee/Java environment with additional instrumentation like OTel, we've got you covered. Beginning with downloading the FRAM installer and utilizing the auto discovery tool to install FusionReactor onto each ColdFusion, Java or Lucee instance, with data automatically sent to the cloud. Additionally, the guide details the installation of the Observability Agent via FRAM, emphasizing the necessity of enabling the OpenTelemetry collector if it is required. 

!!! info
    FRAM is better for very small environments that use physical servers, anything beyond, for example, 10 we would recommend a  docker/manual FusionReactor install because then the process can be scripted.	

#### Use cases

1. I run a simple Coldfusion setup and I also want to monitor a database(s). 
<br> (See Fig 1 below)
2. I migrated to Lucee and/or Java and I also want to monitor a database(s). 
<br> (See Fig 2 below)
3. I monitor CF, other languages and I also want to monitor a database(s).
<br> (See Fig 3 below)


![!Screenshot](/Best-Practices/Installation/Images/Local-server.png)


!!! info "Learn more" 
    [ColdFusion guide](/Best-Practices/Installation/CF-guide/) | [Java/Lucee guide](/Best-Practices/Installation/Lucee-Java-guide/) | [Java/Lucee + OTel guide](/Best-Practices/Installation/Java-Lucee-OTel/)<br>

### Scripted 

Installing FusionReactor manually entails placing the FusionReactor installation files directly onto your application servers and configuring the JVM arguments accordingly Additionally, the guide highlights the importance of enabling the OpenTelemetry collector when installing the Observability Agent. Users can monitor their environment effectively by configuring the endpoint of the OTel application to the Observability Agent, allowing seamless telemetry data transmission to the cloud.

!!! info
    If you have more than 10 servers we recommend a manual install of FusionReactor.

#### Use cases

1. I run Lucee and/or Java and I also want to monitor a database(s). 
<br> (See Fig 1 below)
2. I run Lucee and/or Java and I want to monitor a database(s) and other languages.
<br> (See Fig 2 below)
3. I monitor a non Java/CFML language(s) and I want to monitor a database(s). 
<br> (See Fig 3 below)


![!Screenshot](/Best-Practices/Installation/Images/Scripted.png)


!!! info "Learn more" 
    [FR Agent + Observability Agent guide](/Best-Practices/Installation/scripted1/) | [FR Agent + Observability Agent + OTel guide](/Best-Practices/Installation/scripted2/) | [Observability Agent + OTel guide](/Best-Practices/Installation/scripted3/)



### Docker

The Docker install guides provide clear instructions for effortlessly adding FusionReactor and the Observability Agent into your Docker environment. Starting by manually installing the FusionReactor Agent onto your Docker image. Additionally, the guide highlights the importance of enabling the OpenTelemetry collector when installing the Observability Agent. Users are empowered to monitor their Docker environment effectively by configuring the endpoint of the OTel application to the Observability Agent, allowing seamless telemetry data transmission to the cloud.

!!! info 
    If your environment utilises Docker, the manual installation process is the best practice to install and maintain FusionReactor.


#### Use cases

1. I run Lucee and/or Java in Docker containers and I also want to monitor a database(s). 
<br> (See Fig 1 below)
2. I run Lucee and/or Java in Docker containers and I want to monitor other langauges and a database(s). 
<br> (See Fig 2 below)
3. I monitor a non Java/CFML language(s) in Docker and I want to monitor a database(s). 
<br> (See Fig 3 below)


![!Screenshot](/Best-Practices/Installation/Images/Docker.png)



!!! info "Learn more" 
    [FR Agent + Observability Agent guide](/Best-Practices/Installation/FR-ObsAgent/) | [FR Agent + Observability Agent + OTel guide](/Best-Practices/Installation/FR-ObsAgent-OTel/) | [Observability Agent + OTel guide](/Best-Practices/Installation/ObsAgent-OTel/)









## Supported languages

OpenTelemetry code instrumentation is supported for many popular programming languages including .Net, PHP, C++, Go, Python, Java, Javascript, Ruby, Rust, Erlang and Swift.

!!! info "Learn more"
    [Status and releases](https://opentelemetry.io/docs/languages/)

## Supported databases & frameworks

![!Screenshot](/Best-Practices/Installation/Images/supported.png)








