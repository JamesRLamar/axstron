<cfscript>
pathInfo = reReplaceNoCase(trim(cgi.path_info), '.+\.cfm/? *', '');

requestList = ListtoArray(pathInfo, "/");

Request.section = "default";

Request.view = "default";

if ( ArrayLen(requestList) == 2 ) {
	
	Request.section = requestList[1];
	
	Request.view = requestList[2];
}

else if ( ArrayLen(requestList) == 1 ) {
	
	Request.section = requestList[1];
}

</cfscript>

<cfset getAction = structNew() />

<cfif APPLICATION.IS_PROTECTED AND NOT IsUserLoggedIn()>

	<cfset getAction.component = "controllers.LoginController" />
	
	<cfset getAction.method = "DefaultAction" />

<cfelse>
	
	<cfset getAction.component = "controllers." & Request.section & "Controller" />

	<cfset getAction.method = Request.view & "Action" />

</cfif>

<cftry>

	<cfinvoke attributecollection = "#getAction#" />
	
	<cfcatch type="Application">
	
		<cfset getDefaultAction.component = "controllers." & Request.section & "Controller" />
		
		<cfset getDefaultAction.method = "defaultAction" />
		
		<cfinvoke attributecollection = "#getDefaultAction#" />
		
	</cfcatch>
	
</cftry>