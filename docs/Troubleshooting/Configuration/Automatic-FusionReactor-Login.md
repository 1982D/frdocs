
# How to automatically login to FusionReactor

FusionReactor provides several user roles, each allowing a different set of actions.

The available users are:

 - Administrator
 - Manager
 - Observer

You can use a cookie to configure a webpage that will automatically login to FusionReactor as an **Observer**, however the process is the same for an **Administrator** or **Manager**.

## Retrieve the cookie information

To view the cookie for FusionReactor, use the console of your browser.

!!! note
	You must be logged into the instance for the cookie to exist.

**Step 1:** Navigate to the **Application** tab and view the cookie for FusionReactor.


![Screenshot](/Troubleshooting/images/FR_login_cookie.png)


**Step 2:** Create a blank html page.

**Step 3:** Insert the code below in the page:

```html
<html>
	<head>
		<title>FusionReactor Auto-Login</title>
	</head>
	<body>
		<script type="text/javascript">
			document.cookie =
				'FusionReactorAuthorization.testtc7' +
				'=' +
				'Observer:FE0FF6B85C7164B1DA6FCECFF06E5611';
			window.location =
				'http://localhost:8098/fusionreactor/';
		</script>
	</body>
</html>
```

!!! tip
	In the example above, the cookie name and value have been copied from my instance testTC7 into the document.cookie. My server is located on port 8098 so I have specified this as the window location.

**Step 4:** Edit these values (see Tip) to match your servers configuration. Once complete, your automatic login script should direct you straight into your FusionReactor instance.



