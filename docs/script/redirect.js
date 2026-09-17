function calculate_redirect(url) {
    // Handle FR Version Space and redirect to /fr/ base
    // http://docs.intergral.com/fr/8.4.0/help/Using+a+License+provided+by+a+System+Property

    var re = new RegExp(/(\d+)?\.(\d+)?\.(\d+).*/);
    if (url.startsWith("/fr/")) {
        url = url.substring(4);
        var slash = url.indexOf('/');
        if (slash != -1) {
            var version = url.substring(0, slash);
            var found = re.test(version);
            if (found) {
                url = url.substring(slash+1);
                return "/fr/" + url;
            }
        }
    }

    // Handle space specific page links (mostly from the website)
    // http://docs.intergral.com/display/FR60/Settings
    if (url.startsWith("/display/")) {
        url = url.substring(9);
        var slash = url.indexOf('/');
        if (slash != -1) {
            url = url.substring(slash+1);
            return "/space/" + url;
        }
    }
}

const url = window.location.pathname;
var redirect = calculate_redirect(url);
if (redirect) {
    window.location.replace(redirect);
} else {
    var div = document.getElementById("404");
    if (div) {
        div.innerHTML = "<h1>404</h1><p>Page not found : <br>" + window.location + "</p>";

        Bugsnag.notify( new Error('404 ' + window.location), function (event) {
          event.request.referer = document.referrer;
        });
    }
}
