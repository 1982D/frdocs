#  Databases & other languages

![!Screenshot](/Best-Practices/Installation/Images/Docker3.png)

## Step 1: Run the Observability Agent

The Observability Agent provides you with the necessary tools and insights to effectively monitor, manage, and optimize your applications, leading to improved reliability, performance, and user experience.

### Run via Docker

Run the following command, replacing **YOUR_API_KEY** with your actual [API key](/Monitor-your-data/Log-monitoring/log-shipper/#generating-api-keys) and adjusting the environment variables as needed: 

```
docker run --env otel_collection=true --env api_key=YOUR_API_KEY --env ENV_VARIABLE=VALUE --env  mysql_connection_string=root:my-secret-pw@(mysql:3306)/ intergral/observability-agent:latest
```



!!! info
    Docker automatically pulls the latest version of the Observability Agent image from the [Dockerhub](https://hub.docker.com/r/intergral/observability-agent) repository.


<iframe src="https://player.vimeo.com/video/827268952?h=0f2c0e8fad" width="640" height="360" frameborder="0" allow="autoplay; fullscreen; picture-in-picture" allowfullscreen></iframe>
<p><a href="https://vimeo.com/827268952">FusionReactor Observability agent Docker installation</a> from <a href="https://vimeo.com/user109619720">FusionReactor APM</a> on <a href="https://vimeo.com">Vimeo</a>.</p>




!!! info "Learn more"
    [Log collection and other databases](/Monitor-your-data/Observability-agent/Configuration/) can be enabled by setting the appropriate environment variables.




### Run via Docker Compose
      
```
version: "3.2"


services:


  #database
  mysql:
    image: mysql:latest
    ports:
      - "3306:3306"
    environment:
      - MYSQL_ROOT_PASSWORD=my-secret-pw
  
  #agent
  agent:
    image: intergral/observability-agent:latest
    environment:
      - api_key=1234567890
      - otel_collection=true
      - mysql_connection_string=root:my-secret-pw@(mysql:3306)/
    ports:
      - 12345:12345
```

!!! info "Learn more"
    [Log collection and other databases](/Monitor-your-data/Observability-agent/Configuration/) can be enabled by setting the appropriate environment variables.

## Step 2: Instrument OpenTelemetry

Instrument your code to support OpenTelemetry on your application (Node.js, Python, Go etc).

!!! info "Learn more"
    [OpenTelemetry](https://opentelemetry.io/docs/what-is-opentelemetry/)

Configure the endpoint of the OTel application to the Observability Agent at "otel-collector:4317" or "otel-collector:4318" of your machine (depending on whether you're using gRPC or HTTP)s. This ships telemetry data to the Observability Agent, which does the cloud shipping for you.


!!! note
    It is possible to use a dedicated OTel collector or alternative if required, but the Observability Agent is the simplest method for shipping telemetry data.

___
    
!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.