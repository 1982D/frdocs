# Overview


## Install the FusionReactor Agent

Installing the FusionReactor Agent is a straightforward process that ensures your applications are monitored effectively. For step-by-step guidance, refer to our comprehensive installation guides to ensure a seamless setup and take full advantage of FusionReactor's powerful monitoring capabilities.


[Automatic installation](/Monitor-your-data/FR-Agent/Installation/Automatic/){ .md-button .md-button--primary} 

[Manual installation](/Monitor-your-data/FR-Agent/Installation/Manual/){ .md-button .md-button--primary} 


## Choosing between Automated and Manual installation

FusionReactor can be installed in two ways:

1. [Automated](/Getting-started/install-fr/#automated-installation)  

2. [Manual](/Getting-started/install-fr/#manual-installation)  



### Automated installation

The **automated installation** deploys the FusionReactor Administration Manager, handling the setup process for you.

!!! tip 
    Recommended for environments with long-running physical or virtual machines that do not frequently change state.

#### **Benefits**

- Simplifies configuration-no need to modify files manually.
- Allows setting an instance password before running it.
- Provides access control over specific ports or IP addresses.

#### **Considerations**

- Requires installation on each server individually.
- Cannot be scripted for mass deployment.
- Requires appropriate permissions to modify the local file system.

### Manual Installation

The **manual installation** method involves configuring your application server and placing FusionReactor files in a specified directory.

!!! tip
    Best suited for dynamic environments using containers or lightweight VMs like Kubernetes, AWS, or Docker.

#### **Benefits**

- No additional services need to be installed.
- Does not require FusionReactor service access to modify the file system.
- Supports scripting for automated deployment.
- Makes updating FusionReactor simple and flexible.

#### **Considerations**

- Requires familiarity with server configuration.
- Ensuring accurate argument input to prevent misconfiguration.
- Checking permissions so the application server can read and write to the FusionReactor instance.

___

!!! question "Need more help?"
    Contact support via the chat bubble, and let us know how we can assist.

