<cfinclude template="plugin/config.cfm" />
The plugin takes the following arguments:
<p>
DOMObject - required - The DOM object the content will be injected into<br />
queryString - A query string to be appended to the URL<br />
requestType - The type of request, POST/GET. Defaults to GET<br />
cached - Determines if the response will be cached. Default is false<br />
async - Determines if the request will be asynchronous. Default is true<br />
contentType - The content type of the request. Default is application/x-www-form-urlencoded<br />
requestTimeout - The request timeout in milliseconds. Default is one minute (60,000 ms)<br />
</p>
This example shows the proxy requesting content from a coldbox application, directly in a Mura template:<br />
getPlugin('ajaxContentProxy').getApplication().getValue('ajaxContentProxy').getAjaxContent('##header','cbEvent=UI.showTopNavigation','POST')<br />

