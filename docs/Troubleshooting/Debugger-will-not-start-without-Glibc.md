The FusionReactor **Debugger** uses a native library to provide some of its features. The debugger native library requires GLIBC_2.14 to function.

Centos 6.x, Red Hat Enterprise Linux and other Linux systems don’t provide this version. 

!!! example "Example error messages"
    ````
    $ sudo bin/catalina.sh run
    Using CATALINA_BASE:   /opt/apache-tomcat-8.0.3
    Using CATALINA_HOME:   /opt/apache-tomcat-8.0.3
    Using CATALINA_TMPDIR: /opt/apache-tomcat-8.0.3/temp
    Using JRE_HOME:        /usr
    Using CLASSPATH:       /opt/apache-tomcat-8.0.3/bin/bootstrap.jar:/opt/apache-tomcat-8.0.3/bin/tomcat-juli.jar
    Error occurred during initialization of VM
    Could not find agent library /opt/fusionreactor/instance/tomcat8/libfrjvmti_x64.so in absolute path, with
    error: /lib64/libc.so.6: version `GLIBC_2.14' not found (required by /opt/fusionreactor/instance/tomcat8/libfrjvmti_x64.so)
    ````

On CF servers this error information is redirected to /dev/null so its never seen but you could be hitting this error.

!!! tip 
    To check the version of glibc on a linux system you can run one of the following:
    ````
    # red hat / centos
    rpm -q glibc

    # debian / ubuntu
    dpkg -l libc6

    # via ldd
    ldd --version
    ````

## Workaround

To work around we have build a libc.so6 version 2.14.1 for uses on Centos (64 bit only) which must be explicitly loaded via the LD_PRELOAD variable

!!! example


    In Tomcat you would set the following lines in the ‘setenv.sh’
    ````
    export FR_OPTS="-javaagent:/opt/fusionreactor/instance/tomcat8/fusionreactor.jar=name=tomcat8,address=127.0.0.1:8088 -agentpath:/opt/fusionreactor/instance/tomcat8/libfrjvmti_x64.so"
    export JAVA_OPTS="$JAVA_OPTS $FR_OPTS"

    export LD_PRELOAD=/opt/fusionreactor/instance/tomcat8/libc.so.6
    ````

!!! info
    [Download libc.so.6](/downloads/libc.so.6.bz2)

___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist. 
