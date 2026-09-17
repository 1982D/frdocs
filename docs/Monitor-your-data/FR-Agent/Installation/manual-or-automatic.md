# Automated vs Manual installation

FusionReactor can be installed into your application server in two ways:

1. Automated  

2. Manual  

## Automated installation
The **Automated** option installs the FusionReactor Administration Manager to your server allowing us to install FusionReactor for you.

!!! tip 
    This is often better in an environment with long running physical or virtual machines that do not change state often.

### Benefits

The automated installer is often the easiest way to get started with FusionReactor as it provides a simple way of configuring your instances.

It allows a user to:

* Avoid the need to manually modify configuration files.
* Set the instance password before running the instance.
* Restrict access to FusionReactor over specific ports or IP addresses.

### Considerations

While the automated installer is simple, there are a few things to consider before choosing this option:

* It's not possible to install instances on remote machines, each server must have its own copy of the automated installer.
* It's not possible to script installing instances of FusionReactor on an application server, access to the instance via a browser is required.
* Permissions must be checked to ensure the installer can modify the local file system.

## Manual installation
Manual installation requires you to configure your application server and place the FusionReactor installation files into a directory of your choosing.


!!! tip
    This approach is recommended if you have a dynamic environment with containers or lightweight VMs such as Kubernetes, AWS or Docker.

### Benefits

For developers with previous experience configuring their application server, manual installation is usually a quick process.

* No need for an additional service to be installed on the server.
* No need to grant a FusionReactor service access to modify the local file system.
* It's possible to script the install process of FusionReactor.
* It's simple to update FusionReactor.


### Considerations

When installing FusionReactor manually, ensure that:

* The user has an understanding of the application server and its configuration.
* Arguments are not mistyped in the server configuration.
* Permissions are checked so the application server can read and write to the FusionReactor instance.

___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.