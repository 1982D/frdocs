# Java/Lucee/CFML & databases 

![!Screenshot](/Best-Practices/Installation/Images/Script1.png)

Manually installing FusionReactor requires you to directly place the FusionReactor installation files and configure the JVM arguments on your application servers.

## Step 1: Add FusionReactor to your image

### a) Make the FusionReactor instance directory


!!! note 
    Ensure that you always use the latest version of FusionReactor.

#### Windows

??? info "View more"

    ```
    mkdir -p C:\\FusionReactor\instance\{name}
    curl -o C:\\FusionReactor\instance\{name}\fusionreactor.jar https://download.fusionreactor.io/FR/Latest/fusionreactor.jar
    curl -o C:\\FusionReactor\instance\{name}\frjvmti_x64.dll https://download.fusionreactor.io/FR/Latest/frjvmti_x64.dll

    ```
#### Linux

??? info "View more"

    ```
    mkdir -p /opt/fusionreactor/instance/{name}
    curl -o /opt/fusionreactor/instance/{name}/fusionreactor.jar https://download.fusionreactor.io/FR/Latest/fusionreactor.jar
    curl -o /opt/fusionreactor/instance/{name}/frjvmti_x64.dll https://download.fusionreactor.io/FR/Latest/frjvmti_x64.dll

    ```
#### MacOS

??? info "View more"

    ```
    mkdir -p /Applications/fusionreactor/instance/{name}
    curl -o /Applications/fusionreactor/instance/{name}/fusionreactor.jar https://download.fusionreactor.io/FR/Latest/fusionreactor.jar
    curl -o /Applications/fusionreactor/instance/{name}/frjvmti_x64.dll https://download.fusionreactor.io/FR/Latest/frjvmti_x64.dll
    ```

### b)  Stop your application server
JVM arguments for your application server are only read when the server/JRE (Java Runtime Environment) is started. We recommend stopping your application server before adding or modifying any of your JVM arguments

### c) Add FusionReactor to the JVM arguments 

!!! info 
    App servers use different methods to do this and we advise reading the [Manual configuration examples](/Monitor-your-data/FR-Agent/Installation/Configuration-examples/)

```
ENV JAVA_OPTS="-javaagent:/opt/fusionreactor/instance/{name}/fusionreactor.jar=name=tomcat,address=8088 -agentpath:/opt/fusionreactor/instance/{name}/libfrjvmti_x64.so"
```


### d) Start your application server
With your JVM arguments now modified, FusionReactor should start within the Java process.

<iframe src="https://player.vimeo.com/video/600155904?h=9f7dada6ed" width="640" height="360" frameborder="0" allow="autoplay; fullscreen; picture-in-picture" allowfullscreen></iframe>
<p><a href="https://vimeo.com/600155904">Install FusionReactor on Java</a> from <a href="https://vimeo.com/user109619720">FusionReactor APM</a> on <a href="https://vimeo.com">Vimeo</a>.</p>

## Step 2: Install the Observability Agent

The Observability Agent provides you with the necessary tools and insights to effectively monitor, manage, and optimize your applications, leading to improved reliability, performance, and user experience. During the install you'll be prompted to configure databases and frameworks you wish to monitor.



!!! info
    [Latest release](https://github.com/intergral/observability-agent/releases)

<iframe src="https://player.vimeo.com/video/946516448?h=2875944fd9" width="640" height="360" frameborder="0" allow="autoplay; fullscreen; picture-in-picture" allowfullscreen></iframe>
<p><a href="https://vimeo.com/946516448">How to install the observability Agent locally</a> from <a href="https://vimeo.com/user109619720">FusionReactor APM</a> on <a href="https://vimeo.com">Vimeo</a>.</p>

### Windows

??? info "View more" 
   
    To download and run the installer, open powershell admin terminal, navigate to your desired download folder and run: 

    ````
    Invoke-WebRequest -Uri "https://github.com/intergral/observability-agent/releases/latest/download/observability-agent-autoconf.ps1" -OutFile "observability-agent-autoconf.ps1"
    .\observability-agent-autoconf.ps1
    ````

    !!! info
        The installer for Windows assumes you are installing Grafana Alloy in the default location on the C drive. This is required for the config file to be placed in the correct location for Grafana Alloy to read it.

### Linux
??? info "View more" 

    To download and run the installer, in a terminal, run:


    ````
    curl -O -L "https://github.com/intergral/observability-agent/releases/latest/download/observability-agent-autoconf.sh"
    chmod a+x "observability-agent-autoconf.sh"
    sudo /bin/bash observability-agent-autoconf.sh
    ````
### Further options

!!! info "Learn more"
    Further [options](/Monitor-your-data/Observability-agent/Installation/Snippets/#options) are available when installing the Observability Agent.
