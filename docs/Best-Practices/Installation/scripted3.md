![!Screenshot](/Best-Practices/Installation/Images/Script3.png)

## Step 1: Install the Observability Agent

The Observability Agent provides you with the necessary tools and insights to effectively monitor, manage, and optimize your applications, leading to improved reliability, performance, and user experience.

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
    
## Step 2: Instrument OpenTelemetry

Instrument your code to support OpenTelemetry on your application (Node.js, Python, Go etc).

!!! info "Learn more"
    [OpenTelemetry](https://opentelemetry.io/docs/what-is-opentelemetry/)

Configure the endpoint of the OTel application to the Observability Agent at either http://localhost:4317 or http://localhost:4318 of your machine (depending on whether you're using gRPC or HTTP). This ships telemetry data to the Observability Agent, which does the cloud shipping for you.


!!! note
    It is possible to use a dedicated OTel collector or alternative if required, but the Observability Agent is the simplest method for shipping telemetry data.