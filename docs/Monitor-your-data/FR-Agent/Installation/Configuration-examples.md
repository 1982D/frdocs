# Manual configuration examples

Below are examples of configuring your Application Server/JVM arguments for the supported server types.

## Adobe ColdFusion server

!!! Warning
    ColdFusion 9, 10 and 11 on Windows interprets backslashes as a character escapement mechanism. Either use a double backslash or forward slash in your JVM config file.

??? info "View more"
    1. Navigate to the following directory:

        * ColdFusion9: ```{ColdFusion-Home}/runtime/bin```

        * ColdFusion 10/11/2016/2018: ```{ColdFusion-Home}/cfusion/bin```

    2. Locate and open the jvm.config file with a text editor of your preference.

    3. Add the FusionReactor Java agent and possibly the FusionReactor production debugger at the end of the line after "# Arguments to VM".

    4. Save the changes made.

    !!! tip
        Ensure all the Java arguments are on the same line.



    !!! example
        ```
        tab="jvm.config file"
        # Arguments to VMx
        java.args=-server -Xms256m -Xmx512m -XX:MaxPermSize=192m -Xbatch -Dcoldfusion.home={application.home} -Djava.awt.headless=true -Dcoldfusion.rootDir={application.home} -Djava.security.policy={application.home}/lib/coldfusion.policy -Djava.security.auth.policy={application.home}/lib/neo-jaas.policy -Dcoldfusion.classPath={application.home}/lib/updates,{application.home}/lib,{application.home}/lib/axis2,{application.home}/gateway/lib/,{application.home}/wwwroot/WEB-INF/cfform/jars,{application.home}/wwwroot/WEB-INF/flex/jars,{application.home}/lib/oosdk/lib,{application.home}/lib/oosdk/classes -Dcoldfusion.libPath={application.home}/lib -Dorg.apache.coyote.USE-CUSTOM-STATUS-MSG-IN-HEADER=true -javaagent:C:\FusionReactor\instance\cfusion.CF2018\fusionreactor.jar=name=cfusion.CF2018,address=8088 -agentpath:C:\FusionReactor\instance\cfusion.CF2018\frjvmti_x64.dll
        ```

## Adobe ColdFusion solr

### Windows

??? info "View more"

    1. Navigate to the following directory: {ColdFusion-Home}\solr\.

    2. Locate and open the solr.lax with a text editor of your preference.

    3. Add the FusionReactor Java agent and possibly the FusionReactor production debugger at the end of the line beginning with "lax.nl.java.option.additional=". 

    4. Save the changes made.

    !!! tip
        Ensure all the Java arguments are on the same line.

    

    !!! example
        ``` tab="Windows solr.lax file"
        ...
        lax.nl.java.option.additional=-server -Xmx256m -XX:+AggressiveOpts -XX:+ScavengeBeforeFullGC -XX:-UseParallelGC -DSTOP.PORT=8079 -DSTOP.KEY=cfstop -Dsolr.solr.home=multicore -javaagent:C:\FusionReactor\instance\cf9-solr\fusionreactor.jar=name=cf9-solr,address=8088 -agentpath:C:\FusionReactor\instance\cf9-solr\frjvmti_x64.dll
        ```
### Linux

??? info "View more"

    1. Navigate to the following directory: {ColdFusion-Home}/solr/.

    2. Locate and open the cfsolr file with a text editor of your preference.

    3. Add the FusionReactor Java agent and possibly the FusionReactor production debugger at the end of the line after **# JVM Args**. 
    
    4. Save the changes made.

    !!! tip
        Ensure all the Java arguments are on the same line.

    !!! example
        ``` 
        tab="Linux cfsolr file"
        # JVM Args
        JVMARGS="-XX:+AggressiveOpts -XX:+ScavengeBeforeFullGC -XX:-UseParallelGC -Xmx256m -Dsolr.solr.home=multicore -DSTOP.PORT=8079 -DSTOP.KEY=cfsolrstop -javaagent:/opt/fusionreactor/instance/cf9-solr/fusionreactor.jar=name=cf9-solr,address=8088 -agentpath:/opt/fusionreactor/instance/cf9-solr/libfrjvmti_x64.so"
        ```
## Adobe ColdFusion multi

??? info "View more"

    1. Navigate to the following directory: {ColdFusion-Multi-Home}/bin/.

    2. Locate and open the jvm.config file with a text editor of your preference.

    3. Add the  FusionReactor Java agent and possibly the FusionReactor production debugger at the end of the line after "# Arguments to VMx".

    4. Save the changes made.

    !!! tip
        Ensure all the Java arguments are on the same line.

    !!! example
        ```
        tab="Linux Jvm.config"
        # Arguments to VMx
        java.args=-server -Xms256m -Xmx512m -XX:MaxPermSize=192m -Xbatch -Dcoldfusion.home={application.home} -Djava.awt.headless=true -Dcoldfusion.rootDir={application.home} -Djava.security.policy={application.home}/lib/coldfusion.policy -Djava.security.auth.policy={application.home}/lib/neo-jaas.policy -Dcoldfusion.classPath={application.home}/lib/updates,{application.home}/lib,{application.home}/lib/axis2,{application.home}/gateway/lib/,{application.home}/wwwroot/WEB-INF/cfform/jars,{application.home}/wwwroot/WEB-INF/flex/jars,{application.home}/lib/oosdk/lib,{application.home}/lib/oosdk/classes -Dcoldfusion.libPath={application.home}/lib -Dorg.apache.coyote.USE-CUSTOM-STATUS-MSG-IN-HEADER=true -javaagent:/opt/fusionreactor/instance/coldfusion9-multi/fusionreactor.jar=address=8088 -agentpath:/opt/fusionreactor/instance/coldfusion9-multi/libfrjvmti_x64.so
        ```

## Lucee

### Windows

??? info "View more"

    1. Navigate to the following directory: {Lucee-Home}\tomcat\bin\.

    2. Locate and run the Luceew.exe program.

    3. Within the program, on the **Java** tab, add the FusionReactor Java agent and possibly the FusionReactor production Debugger for your server to the bottom of the list in the **Java Options** field.

    4. Select **Apply**.

    5. Select **OK**.

    !!! example
        ``` tab="Windows Java options"
        -Dcatalina.home=...
        -Dcatalina.base=...
        -Djava.endorsed.dirs=...
        -Djava.io.tmpdir=...
        -Djava.util.logging.manager=...
        -Djava.util.logging.config.file=...
        -javaagent:C:\FusionReactor\instance\lucee4\fusionreactor.jar=name=lucee4,address=8088
        -agentpath:C:\FusionReactor\instance\lucee4\frjvmti_x64.dll
        ```
### Linux

??? info "View more"

    1. Navigate to the following directory: {Lucee-Home}/bin/.

    2. Locate and open the setenv.sh file with a text editor of your preference.

    3. Add the FusionReactor Java agent and possibly the FusionReactor production debugger inside the setenv.sh file

    4. Save the changes made.

    !!! example
        ```
        tab="Linux setenv.sh"
        # FusionReactor JVM start options. Please do not edit these options.
        FR_OPTS="-javaagent:/opt/fusionreactor/instance/lucee4/fusionreactor.jar=name=lucee4,address=8088 -agentpath:/opt/fusionreactor/instance/lucee4/libfrjvmti_x64.so"
        export JAVA_OPTS="$JAVA_OPTS $FR_OPTS"
        # End of FusionReactor opts
        ```
        

## Tomcat

### Windows

??? info "View more"

    1. Navigate to the following directory: {Apache-Tomcat-Home}\bin\.

    2. Run the TomcatXw.exe program. (Where X is the version number of your tomcat installation).

    3. Access the Java tab and add the FusionReactor Java agent and possibly the FusionReactor production debugger for your server to the bottom of the list in the **Java options** field.

    4. Select **Apply**.

    5. Select **OK**.

    !!! example
        ```batch tab="Windows Java Options"
        -Dcatalina.home=...
        -Dcatalina.base=...
        -Djava.endorsed.dirs=...
        -Djava.io.tmpdir=...
        -Djava.util.logging.manager=...
        -Djava.util.logging.config.file=...
        -javaagent:C:\FusionReactor\instance\tomcat8\fusionreactor.jar=address=8088
        -agentpath:C:\FusionReactor\instance\tomcat8\frjvmti_x64.dll
        ```
### Linux

??? info "View more"

    1. Navigate to the following directory: {Apache-Tomcat-Home}/bin/.

    2. Locate the setenv.sh file OR if the file does not exist you can go ahead and create the file.

    3. Open the file with a text editor of you preference.
    4. Add the FusionReactor Java agent and possibly the FusionReactor production debugger values in the  setenv.sh file.
    5. Save the changes made.

    !!! example
        ```
        tab="Linux setenv.sh"
        ...
        # FusionReactor JVM start options. Please do not edit these options.
        FR_OPTS="-javaagent:/opt/fusionreactor/instance/tomcat8/fusionreactor.jar=address=8088 -agentpath:/opt/fusionreactor/instance/tomcat8/libfrjvmti_x64.so"
        export JAVA_OPTS="$JAVA_OPTS $FR_OPTS"
        # End of FusionReactor opts
        ```

## Standalone jar

??? info "View more"

    Add the FusionReactor JVM arguments to your run command for the jar.

    !!! example
        ```
        java -javaagent:/opt/fusionreactor/instance/myInstance/fusionreactor.jar=name=myInstance,address=8088 -agentpath:/opt/fusionreactor/instance/myInstance/libfrjvmti_x64.so -jar app.jar
        ```

## IDE

??? info "View more"

    1. Edit or create a run command for your application.

    2. In your run configuration, append the FusionReactor JVM arguments to your runtime / VM arguments



## Jboss / WildFly

??? info "View more"

    1. Navigate to the following directory: {JBoss/Wildfly-Home}/bin/.

    2. Locate and open the standalone.conf file with a text editor of your preference.

    3. Add the FusionReactor Java agent and possibly the FusionReactor production debugger in the standalone.conf file and preferably at the bottom.

    4. Save the changes made.
    !!! example
        ``` tab="Windows standalone.conf"
        ...
        JAVA_OPTS="$JAVA_OPTS -javaagent:C:\FusionReactor\instance\jboss7s\fusionreactor.jar=name=jboss7s,address=8088  -agentpath:C:\FusionReactor\instance\jboss7s\frjvmti_x64.dll"
        ```

## Jetty

??? info "View more"

    1. Navigate to the following directory: {Jetty-Home}/bin/.

    2. Locate and open the start.ini file with a text editor of your preference.

    3. Add the FusionReactor Java agent in the start.ini file at the bottom, preferably below the "--exec". In case the "--exec" is not in your start.ini file, add it to the bottom of the file and afterwards add the FusionReactor Java agent below it.

    4. Save the changes made.

    !!! example
        ``` tab="Linux start.ini"
        ...

        --exec
        -javaagent:/opt/fusionreactor/instance/jetty7/fusionreactor.jar=address=8088 -agentpath:/opt/fusionreactor/instance/jetty7/libfrjvmti_x64.so
        ```

## Glassfish / Payara

??? info "View more"

    1. Navigate to the following directory: {Glassfish-Home}\glassfish\domains\domain1\config\.

    2. Locate and open the domain.xml file with a text editor of your preference.

    3. Add the FusionReactor Java agent and possibly the FusionReactor production debugger inside the "<java-config>". 

        !!! tip
            Ensure all the Java arguments are on the same line.

    4. Save the changes made.
    !!! example
        ``` tab="domain.xml file"
        ...
        <java-config debug-options="-Xdebug -Xrunjdwp:transport=dt-socket,server=y,suspend=n,address=9009" system-classptah="" classpath-suffix="">
        ...
        <jvm-options>...</jvm-options>
        <jvm-options>...</jvm-options>
        <jvm-options>-javaagent:C:\FusionReactor\instance\domain1.GF4.1.1\fusionreactor.jar=name=domain1.GFf.1.1,address=8088</jvm-options>
        <jvm-options>-agentpath:C:\FusionReactor\instance\domain1.GF4.1.1\frjvmti_x64.dll</jvm-options>
        <jvm-options>...</jvm-options>
        <jvm-options>...</jvm-options>
        ...
        </java-config>
        ...
        ```
___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.


