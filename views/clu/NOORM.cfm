<cffunction name="ORMEntityLoad" access="public" returntype="any" output="false">
	<cfargument name="model" type="string" required="true">
	<cfargument name="datasource" type="string" required="false" default="#APPLICATION.DATASOURCE#">

	<cfquery name="ObjQuery" datasource="#arguments.datasource#">
		SELECT * FROM #arguments.model#
	</cfquery>

	<cfset ObjArray = ArrayNew(1)>
	<cfset index = 1>

	<cfloop query="ObjQuery">
		<cfset GetObject = structNew() />
		<cfset GetObject.component = "models." & arguments.model />
		<cfset GetObject.method = "GetEntity" />
		<cfset GetObject.returnVariable = "Object" />
		<cfinvoke attributecollection = "#GetObject#"> 
		    <cfinvokeargument name="ObjQuery" value="#ObjQuery#"> 
		</cfinvoke>
		<cfset ObjArray[index] = Object>
		<cfset index = index + 1>
	</cfloop>

	<cfreturn ObjArray>
	
</cffunction>


<cfscript>
	ObjArray = ORMEntityLoad("_User");
	for (i = 1; i LTE ArrayLen(ObjArray); i++) { 
		writeOutput("<p>" & ObjArray[i].GetUserName() & "</p>");
		writeDump(ObjArray[i]);
	}
</cfscript>


