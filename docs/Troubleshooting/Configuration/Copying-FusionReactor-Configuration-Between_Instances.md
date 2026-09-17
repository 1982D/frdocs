# How to copy FusionReactor configuration between instances

The configuration of FusionReactor is per instance, meaning if you have five instances of FusionReactor on a server they must all be configured separately.

 The configuration is all stored in a single file named reactor.conf, this file can be located at {FusionReactor Directory}/instance/{Instance Name}/conf/reactor.conf.

!!! tip
    It is safe to copy this file between instances, making it possible to configure one instance as desired, then copy this configuration to other instances of FusionReactor.

!!! note
    Stop the application server before changing the configuration, otherwise there is a chance the old
    configuration will stomp over any changes.

 To take a configuration from one instance and place it in another, follow the steps below:

 **Step 1:** Navigate to the conf directory of the preconfigured instance by going to {FusionReactor Directory}/instance/{Instance Name}/conf.

**Step 2:** Take a copy of the reactor.conf file.

**Step 3:** Navigate to the conf directory of the instance to configure by going to {FusionReactor Directory}/instance/{Instance Name}/conf.

 **Step 4:** Stop the application server on the server to configure.

**Step 5:** Make a backup copy of the current reactor.conf file.

**Step 6:** Place a copy of the preconfigured reactor.conf file in the conf directory.

**Step 7:** Start the application server on the server to configure.

 When the application server and FusionReactor start, the configuration of FusionReactor should reflect the settings of the preconfigured server.

!!! warning
    Ensure that the read/write permissions of the reactor.conf file are correct, otherwise it may not be possible for the user running the application server to read or write to the configuration file on startup.


