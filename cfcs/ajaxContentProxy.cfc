<cfcomponent extends="mura.plugin.pluginGenericEventHandler">

<cffunction name="onRenderStart" output="false" returntype="any">
	<cfargument name="event">
</cffunction>

<cffunction name="onApplicationLoad" output="false" returntype="any">
	<cfargument name="event">
	
	<cfset pluginConfig.getApplication().setValue('ajaxContentProxy',this)>

</cffunction>

<cffunction name="getAJAXContent" output="true" returntype="void" access="public">
	<cfargument name="DOMObject" required="true" hint="the DOM object the content will be injected into"/>
	<cfargument name="queryString" required="false" hint="A query string"/>
	<cfargument name="requestType" required="false" default="GET" hint="The type of request, POST/GET"/>
	<cfargument name="cached" required="false" default="false" hint="determines if the response will be cached"/>
	<cfargument name="async" required="false" default="true" hint="determines if the request will be asynchronous"/>
	<cfargument name="contentType" required="false" hint="The content type of the request"/>
	<cfargument name="requestTimeout" required="false" hint="The request timeout"/>
	<cfargument name="event"/>
	
	<cfset var ajaxProxy = ""/>
	<cfset var timeout = pluginConfig.getSetting('DefaultTimeout') />
	
	<cfif structKeyExists(arguments, 'requestTimeout')>
		<cfset timeout = arguments.requestTimeout />
	</cfif>
	
	<!--- create our ajax proxy script --->
	<cfsavecontent variable="ajaxProxy">
	<cfoutput>
	<script>
		$.ajax(
		{
	  			url: '#pluginConfig.getSetting('RemoteURL')#'
				<cfif structKeyExists(arguments, 'queryString')>
				,data: '#queryString#'
				</cfif>
	  			,cache: #cached#
				,async: #async#
				,timeout: #timeout#
				,type: '#requestType#'
				<cfif structKeyExists(arguments, 'contentType')>
				,contentType: '#contentType#'
				</cfif>
  				,success: function(html)
				{
    				$("#arguments.DOMObject#").append(html);
  				}
		});
	</script>
	</cfoutput>
	</cfsavecontent>
	<!--- add the ajax proxy script to the head of the html document --->
	<cfhtmlhead text="#ajaxProxy#" />

</cffunction>
<!---
<cffunction name="onError" output="true" returntype="any">
<cfargument name="event">
<cfset var str="">
<cfthrow detail="test" message="this is a test">
<cfoutput>
An error has occured.
</cfoutput>
</cffunction>
--->

</cfcomponent>