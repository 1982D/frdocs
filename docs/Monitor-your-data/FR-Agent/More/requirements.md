## System Requirements

### Operating Systems

FusionReactor is a Java agent (jar file) which contains most of the functionality
and a native debugger library which provides the **Event Snapshot**, **Debugger**, and **Heap Analysis** features.

The Java agent will work on virtually any Java version on any operating system but some features may not be
available; **System Monitor** and **System CPU** may be missing depending on the operating system's CPU.

!!! warning "Installer supports 64 bit operating systems"
    The traditional installer only support 64 bit operating systems.

!!! warning "Native debugger only supports amd64 and aarch64"
    The native debugger library only supports 64 bit operating systems on Windows and Mac OS
    and is only provided for aarch64 and amd64 processors on Linux operating systems.

#### ![](/Monitor-your-data/FR-Agent/More/requirements/ms.gif) Windows

  * Microsoft Windows Server 2022
  * Microsoft Windows Server 2019
  * Microsoft Windows Server 2016
  * Microsoft Windows Server 2012 R2
  * Microsoft Windows Server 2012
  * Microsoft Windows Server 2008 R2
  * Microsoft Windows Server 2008
  * Microsoft Windows 10
  * Microsoft Windows 8
  * Microsoft Windows 7

#### ![](/Monitor-your-data/FR-Agent/More/requirements/tux.gif) Linux

  * Red Hat Enterprise Linux 5 + Above
  * openSuse Linux 10.2  -  12.2
  * SuSE Linux Enterprise Server 8 + Above
  * Debian Linux 3 + Above
  * Oracle Linux 6 + Above
  * CentOS 6 + Above
  * Ubuntu 11 + Above
  * Kubuntu 9 + Above
  * Fedora 15 + Above

#### ![](/Monitor-your-data/FR-Agent/More/requirements/apple.gif) macOS

  * Apple macOS 13: "Ventura"
  * Apple macOS 12: "Monterey"
  * Apple macOS 11: "Big Sur"


### Java

* Oracle Java 8  -  21
* Open JDK 8  -  21
* Liberica JDK 8, 11, 16
* Amazon Corretto 8, 11, 17
* Azul Zulu 11, 17

!!! warning "Java 7 support removed"
    Java 7 support was discontinued with FusionReactor 11.0.0.  If you need to use Java 7 we recommend you stay with version [10.0.2](https://intergral-download.s3.eu-west-1.amazonaws.com/FR/FusionReactor-10.0.2/fusionreactor.jar) or [10.0.1](https://intergral-download.s3.eu-west-1.amazonaws.com/FR/FusionReactor-10.0.1/fusionreactor.jar) of you wish to use the cloud.

!!! warning "Java 6 support removed"
    Java 6 support was discontinued with FusionReactor 8.3.0.  If you need to use Java 6 we recommend you stay with version [8.2.3](https://intergral-download.s3.eu-west-1.amazonaws.com/FR/FusionReactor-8.2.3/fusionreactor.jar).

### Servers

#### ![](/Monitor-your-data/FR-Agent/More/requirements/j2eee.gif) J2EE / Other Servers

  * Apache Tomcat 7  -  10
  * JBoss AS 6 / 7
  * WildFly 8  -  29
  * Jetty 7  -  11
  * GlassFish 4 / 5
  * Payara 5

#### ![](/Monitor-your-data/FR-Agent/More/requirements/cf1.gif)  ColdFusion Servers

  * Adobe ColdFusion 2025
  * Adobe ColdFusion 2023
  * Adobe ColdFusion 2021
  * Adobe ColdFusion 2018
  * Adobe ColdFusion 2016
  * Adobe ColdFusion 11
  * Adobe ColdFusion 10
  * Lucee 4.5.x
  * Lucee 5.x

!!! note "Manual install only for WebSphere & WebLogic"
    WebSphere and WebLogic servers work in most configurations but are not supported by Installer / FRAM.   Users must follow
    the manual installation steps.

### Browsers

| | | | |
| - | - | - | - |
| ![](/Monitor-your-data/FR-Agent/More/requirements/chrome.png) <br>Chrome 21+ | ![](/Monitor-your-data/FR-Agent/More/requirements/firefox.png) <br>Firefox 20+ | ![](/Monitor-your-data/FR-Agent/More/requirements/safari.png) <br>Safari<br><br>Windows: Safari 5.1.7+<br>Mac OSX: Safari 5.1.9+ | ![](/Monitor-your-data/FR-Agent/More/requirements/edge.png) <br>Microsoft Edge |

!!!warning "Internet Explorer support removed"
    Due to security concerns Internet Explorer support was removed in FusionReactor 8.5.0 and above.
    You will now see a blank page when attempting to load the FusionReactor UI.

___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.
