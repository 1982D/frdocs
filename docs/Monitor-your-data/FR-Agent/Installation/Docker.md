
# Install FusionReactor in Docker

In the [fusionreactor-docker](https://github.com/intergral/fusionreactor-docker) GitHub repository we have example Dockerfiles for:

* [ColdFusion](https://github.com/intergral/fusionreactor-docker/tree/master/coldfusion)
* [CommandBox](https://github.com/intergral/fusionreactor-docker/tree/master/commandbox)
* [Lucee](https://github.com/intergral/fusionreactor-docker/tree/master/lucee)
* [Tomcat](https://github.com/intergral/fusionreactor-docker/tree/master/tomcat)
* [Jetty](https://github.com/intergral/fusionreactor-docker/tree/master/jetty)
* [Enterprise Dashboard](https://github.com/intergral/fusionreactor-docker/tree/master/ephemeral)

!!! tip
    Take these resources to use as examples for your own Dockerfiles.

## Installation example

For example, consider the Dockerfile for Tomcat:

```dockerfile
FROM tomcat

ADD myApp.war /usr/local/tomcat/webapps
```

You now add in FusionReactor by writing the following lines:

```dockerfile
FROM tomcat

ADD myApp.war /usr/local/tomcat/webapps

#Creates a FusionReactor Directory
RUN mkdir -p /opt/fusionreactor/instance/tomcat

#Adds the fusionreactor.jar file to the instance directory
ADD https://download.fusionreactor.io/FR/Latest/fusionreactor.jar /opt/fusionreactor/instance/tomcat

#Adds the debug library file to the instance directory
ADD https://download.fusionreactor.io/FR/Latest/libfrjvmti_x64.so /opt/fusionreactor/instance/tomcat

#Adds FusionReactor to the JVM arguments
ENV JAVA_OPTS="-javaagent:/opt/fusionreactor/instance/tomcat/fusionreactor.jar=name=tomcat,address=8088 -agentpath:/opt/fusionreactor/instance/tomcat/libfrjvmti_x64.so"
```

## Adding a configuration file to Docker
The configuration of FusionReactor is stored in the reactor.conf file of your FusionReactor instance.

You can take an existing reactor.conf file from an instance of FusionReactor that has already been configured and place this in your Dockerfile.
You can find the configuration of FusionReactor from another instance at {FusionReactor Directory}/instance/{Instance Name}/conf/reactor.conf. See Copying FusionReactor configuration to new instances.

The following 2 lines are all that would be required to pass in a configuration file:

```dockerfile
RUN mkdir -p /opt/fusionreactor/instance/{Instance Name}/conf
ADD reactor.conf 
RUN mkdir -p /opt/fusionreactor/instance/{Instance Name}/conf
```

## System properties to add to a container
FusionReactor has System properties to configure the instance password, license key, Enterprise Dashboard and OpsPilot. These arguments can be found in [FusionReactor System Properties](../Configuration/FusionReactor-System-Properties.md).

## Persisting log files using Docker volumes
To persist the FusionReactor logs outside of the container, you can use a Docker volume so that logs are stored on the host machine. For example:

```bash
docker run -v /opt/docker/share/fusionreactor/{instance name}/log:/opt/fusionreactor/instance/{instance name}/log -v /opt/docker/share/fusionreactor/{instance name}/archive:/opt/fusionreactor/instance/{instance name}/archive ...
```

### Docker compose

````yaml
volumes:
  - /opt/docker/share/fusionreactor/{instance name}/log:/opt/fusionreactor/instance/{instane name}/log
  - /opt/docker/share/fusionreactor/{instance name}/archive:/opt/fusionreactor/instance/{instance name}/archive
````

## Videos
### Java Docker

<div style="padding:56.25% 0 0 0;position:relative;"><iframe src="https://player.vimeo.com/video/1140795074?badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479" frameborder="0" allow="autoplay; fullscreen; picture-in-picture; clipboard-write; encrypted-media; web-share" referrerpolicy="strict-origin-when-cross-origin" style="position:absolute;top:0;left:0;width:100%;height:100%;" title="Installing FusionReactor in Docker - Java example"></iframe></div><script src="https://player.vimeo.com/api/player.js"></script>

### ColdFusion Docker

<div style="padding:56.25% 0 0 0;position:relative;"><iframe src="https://player.vimeo.com/video/1140776728?badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479" frameborder="0" allow="autoplay; fullscreen; picture-in-picture; clipboard-write; encrypted-media; web-share" referrerpolicy="strict-origin-when-cross-origin" style="position:absolute;top:0;left:0;width:100%;height:100%;" title="Installing FusionReactor in Docker - ColdFusion example"></iframe></div><script src="https://player.vimeo.com/api/player.js"></script>

### Configuring Docker

<iframe width="560" height="315" src="https://www.youtube.com/embed/zuk2b_yphj0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.