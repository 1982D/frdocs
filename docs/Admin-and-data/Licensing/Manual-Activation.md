# Manual activation

To manually activate FusionReactor, you need internet access to enter an activation code into a browser. This generates an activation key to activate your FusionReactor instance.


This process should only be used when activating FusionReactor through other methods is not possible. Whenever possible, consider using the [troubleshooting steps for licensing connection issues](/Admin-and-data/Licensing/Troubleshooting/) as a workaround.

!!! note
    Manual activation must be done for each instance individually; a single activation key cannot be used for multiple instances.

## Video tutorial

<iframe width="560" height="315" src="https://www.youtube.com/embed/5EHY8TEa8g8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## How to manually activate

If you apply a license on the FusionReactor **About** page and the instance cannot connect to the licensing server, you will be redirected to the manual activation page.

 ![Manual Activation code](../../Licensing/Manual-Activation-Code.jpg)

On the activation page, you'll find instructions for manual activation, an activation code, and a field to enter the activation key.

To manually activate:

1. Go to the [Manual Activation Page](https://portal.fusion-reactor.com/manual) on a machine with an internet connection.

2. Copy the activation code from FusionReactor into the manual activation page.

    ![Manual Activation Input](../../Licensing/Manual-Activation-Input.jpg)

    !!! note
        You may be required to save the activation code to disk and transfer it to a new machine via usb, ftp or other methods.

1. Click submit.

    This will either display the reason FusionReactor could not be activated:
    ![Manual Activation Error](../../Licensing/Manual-Activation-Error.jpg)

     Or provide an activation key:

     ![Manual Activation Success](../../Licensing/Manual-Activation-Success.jpg)

1. Copy the output of the manual activation into the activation key input field of FusionReactor.

    ![Manual-Activation-Key](../../Licensing/Manual-Activation-Key.jpg)

1. Click Activate.

    You'll be redirected to the **About** page in FusionReactor, and should now be able to use it.


## Caveats to manual activation

Due to the nature of manual activation, FusionReactor is unable to periodically check the validity of the installed license, as it prevents the software from contacting the licensing server.  

As a result, there are certain limitations to manual activation that you should be aware of:

- **Upgrades**: When upgrading FusionReactor to a new major or minor version (e.g., from 8.3 to 8.4 or 8.3 to 9.0), you must manually activate FusionReactor again.
- **Subscription Renewals**: With a subscription license, you'll need to repeat the activation process each time your license renews, as the expiry date cannot be updated automatically.

!!! warning  
    Purchasing a monthly subscription is not recommended when manual activation is required.  