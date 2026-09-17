# Content filters

## Search and Replace

**Search and Replace** allows you to make temporary changes to
your pages without having to modify source code. Fix broken links,
spelling mistakes or html problems. **Search and Replace** filters enable
you to change the content sent to the web browser by replacing or
removing text on the fly. The **Search and Replace** page has two main
areas: At the top of the page there is a form for you to enter new
filters and below this is a list of all existing filters for this
feature.

### New Search and Replace Filter

To enter a **Search and Replace** filter you will need to fill the following
fields:

|Configuration|Description|
|--- |--- |
|**Find**|Firstly, select if you want to search for an **Exact String**, or if you want to use **Regular Expressions** to search for a pattern. Once you have selected the search type, enter the search string in the text field provided.|
|**Replace Text**|This field contains the text you want to replace your search string with. If you just want to search for a string and remove it from your page then simply leave this field blank.|
|**Replace**|This option lets you decide if you want to replace all instances of your search string (All), or just the first one found on the page (First).|

!!! info "Learn more"
    [Examples of regular expressions](https://docs.oracle.com/javase/1.5.0/docs/api/java/util/regex/Pattern.html) 

### Managing Existing Search and Replace Filters

Below the **Add New Search and Replace Filter** displays a list of
all existing filters. Each filter has two icons next to it:

|Button|Description|
|--- |--- |
| ![](/attachments/245550192/245550203.png) |Clicking this button changes the **Ass Filter** form above into the **Edit Filter** form, which is filled out with the details of the selected filter. Change any of the information and save it using **Save Filter** on the right.|
| ![](/attachments/245550192/245550198.png) |Click this button to delete a **Search and Replace Filter** from the list. FusionReactor will no longer use it to filter responses.|

## Content Filter Restrictions

**Content Filter Restrictions** are designed to let you specify which pages
to run through the content filter system, or alternatively, which
pages you do **NOT** wish to be filtered (leaving all remaining pages to run
through content filtering.) To select which mode the Restrictions page
works in, change the Restrictions option on the [Content Filter settings](#filter-settings) page. 

The **Content Filter Restrictions** page has two main areas: 

* [New Content Filter Restriction](/Data-insights/Features/Requests/Content-Filters/#new-content-filter-restriction)

* [Managing Content Filter Restrictions](/Data-insights/Features/Requests/Content-Filters/#managing-content-filter-restrictions)

!!! info
    At the top of the page there is a form to enter new restrictions and below this is a list of all existing restrictions for this feature.


### New Content Filter Restriction

To enter a restriction, complete the following fields:

|Configuration|Description|
|--- |--- |
|**Match Strategy**|This defines how FusionReactor will interpret the expression specified in the request field. FusionReactor can either interpret it as an **Exact Match** or a **Regular Expression**.|
|**Request**|This field defines the expression used to perform the restrictions. This must follow the pattern defined by the Match Strategy.<br>Examples of request expressions used with the different match strategies:<br><br>**Exact Match**<br>By default the request will be an exact match and should look something like "/batchStats.cfm" or "/batch/dailyStats.cfm" (beginning with a '/' and without parameters.) . The text you input here will depend on the options you choose for the Hostname and Parameters fields.<br>**Regular Expressions**<br>A good use of Regular Expressions here would be to restrict everything within a given folder. The text you input here will depend on the options you choose for the Hostname and Parameters fields.|
|Hostname|By default, FusionReactor ignores the hostname and simply matches based on the web path of a given request, but you can also opt to include it. If you enable Hostname checking then the request field should also include a hostname and look something like "productionMachine/batchStats.cfm". You should NOT include HTTP or HTTPS at the start of this string.|
|Parameters|By default, FusionReactor ignores any parameters passed to a page, however, as with the Hostname, you can also opt to include them in your restriction. With parameter checking enabled, the request field should include the necessary parameters. For example "/batchStats.cfm?period=YEAR". Once again, Regular Expressions can be useful here when specifying multiple possible parameter values, or even specifying parameters where the order isn't fixed.|

!!! info
    Once you submit the form the page is refreshed and your new restriction is listed in the table at the bottom of the page.

### Managing Content Filter Restrictions

Below the **Add Restriction** form you will see a list of all existing
restrictions. Each restriction has two icons next to it:

|Button|Description|
|--- |--- |
| ![](/attachments/245550228/245550260.png) |Clicking this icon changes the **New Filter** form above into the **Edit Filter** form, which will be filled out with the details of the selected filter. You can change any of the information which is listed above (New Content Filter Restrictions), and save it using the **Save Restriction** button on the right.|
| ![](/attachments/245550228/245550245.png) |Clicking this icon will prompt you if you are sure you want to delete this restriction. Select **OK** to remove the restriction from the **Existing Restrictions** list and the page will be refreshed.|

## Filter Settings

The **Content Filter Settings** page lets you turn on or off the **Search and
Replace** feature as well as letting you define how the Filter Restrictions behave.

### Content Filters

|Configuration|Description|Default|
|--- |--- |--- |
|**Search and Replace**|When this option is Enabled, FusionReactor will run responses through the Search and Replace feature unless otherwise instructed by the Filter Restrictions.|Disabled|


### Content Filter Restrictions

|Configuration|Description|Default|
|--- |--- |--- |
|**Filter Restrictions**|This value defines how **Filter Restrictions** behave.<br><br>**Filter requests that match the rules**<br>By default, no requests will be run through the Search and Replace filters. If a request matches one of the rules defined on the Filter Restrictions page then it will be filtered.<br>**Ignore requests that match the rules**<br>By default, all requests will be run through the Search and Replace filters. If a request matches one of the rules defined on the **Filter Restrictions page** then it will not be filtered.|Ignore requests that match the rules|


___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.