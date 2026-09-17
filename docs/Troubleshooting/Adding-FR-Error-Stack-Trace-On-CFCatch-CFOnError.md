# Adding FR error context to handle errors in CF

Within ColdFusion, you have multiple ways to [handle errors as they occur in ColdFusion](https://helpx.adobe.com/coldfusion/developing-applications/developing-cfml-applications/handling-errors/about-error-handling-in-coldfusion.html).

The most common two being to utilize ```CFTRY / CFCATCH``` or use the ```onError``` function within your ```Application.cfc``` file.

When you do this, the Exception will be caught and not rethrown within the Java engine. This will prevent FusionReactor from being able to track the error.

!!! tip
    Use [FRAPI](/Data-insights/Extras/FRAPI/) to set the error stack trace on your FusionReactor request without throwing the actual error.

## FRAPI code example


Below is an example of how to safely initialize and use FRAPI to set the trapped throwable object.

!!! example 
    ```
    # CF TAG EXAMPLE
    <cftry>

        <cfset frapiClass = createObject("java", "com.intergral.fusionreactor.api.FRAPI")>
        <cfset frapi = frapiClass.getInstance()>
        <cfset frtxn = frapi.getActiveMasterTransaction()>
        <cfset frexception = frtxn.setTrappedThrowable({throwable})>
        
        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
        </cfcatch>
        
    </cftry>

    # CF SCRIPT EXAMPLE
    <cfscript>
      try {
      frapiClass = createObject("java", "com.intergral.fusionreactor.api.FRAPI")
      frapi = frapiClass.getInstance()
      frtxn = frapi.getActiveMasterTransaction()
      frtxn.setTrappedThrowable({throwable})
      }
      catch (any e) {
        writeOutput("Error: " & e.message);
      }
    </cfscript>
    ```

## CFTRY / CFCATCH example in Lucee

!!! example
    ```
    <cfscript>
      try {
        x=1/0;
      }
      catch (e) {
        throwableException = createObject( "java", "java.lang.Throwable" ).init( e.StackTrace );

        try {
          frapiClass = createObject("java", "com.intergral.fusionreactor.api.FRAPI")
          frapi = frapiClass.getInstance()
          frtxn = frapi.getActiveMasterTransaction()
          frtxn.setTrappedThrowable(throwableException)
        }

        catch (any e2) {
          writeOutput("Error: " & e2.message);
        }

        Dump(e);
      }
    </cfscript>
    ```

## CF onError example in Lucee

!!! example
    ```
    public void function onError(required any error) {
      var throwableException = createObject( "java", "java.lang.Throwable" ).init( error.StackTrace );

      try {
        frapiClass = createObject("java", "com.intergral.fusionreactor.api.FRAPI")
        frapi = frapiClass.getInstance()
        frtxn = frapi.getActiveMasterTransaction()
        frtxn.setTrappedThrowable(throwableException)
      }
      
      catch (any e2) {
        writeOutput("Error: " & e2.message);
      }
      
      Dump(error);
    }
    ```
## CFTRY / CFCATCH example in ColdFusion

!!! example
    ```
    <cfscript>
      try {
        x=1/0;
      }
      catch(any e) {
        throwableException = createObject( "java", "java.lang.Throwable" ).init( e );

        try {
          frapiClass = createObject("java", "com.intergral.fusionreactor.api.FRAPI")
          frapi = frapiClass.getInstance()
          frtxn = frapi.getActiveMasterTransaction()
          frtxn.setTrappedThrowable(throwableException)
        }

        catch (any e2) {
          writeOutput("Error: " & e2.message);
        }

        writeDump(var = e, label = "e");
      }
    </cfscript>
    ```

## CF onError example in ColdFusion

!!! example
    ```
    public void function onError(
      required any error,
      required any eventName
      )
      {
      var throwableException = createObject( "java", "java.lang.Throwable" ).init( error );

      try {
        frapiClass = createObject("java", "com.intergral.fusionreactor.api.FRAPI")
        frapi = frapiClass.getInstance()
        frtxn = frapi.getActiveMasterTransaction()
        frtxn.setTrappedThrowable(throwableException)
      }
      catch (any e2) {
        writeOutput("Error: " & e2.message);

      }
      writeDump(var = error, label = "error");

    }
    ```

___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist. 