<cffunction name="ORMEntityLoad" access="public" returntype="any" output="false">
	<cfargument name="datasource" type="string" required="false" default="#APPLICATION.DATASOURCE#">
	<cfargument name="model" type="string" required="true">

	<cfquery name="ObjQuery" datasource="#arguments.datasource#">
		SELECT * FROM #arguments.object#
	</cfquery>

	<cfset ObjArray = ArrayNew(1)>
	<cfset index = 1>

	<cfloop query="#ObjQuery#">
		<cfset GetObject = structNew() />
		<cfset GetObject.component = "models." & arguments.model />
		<cfset GetObject.method = "init" />
		<cfset GetObject.name = "Object" />
		<cfinvoke attributecollection = "#GetObject#" />
		<cfset ObjArray[index] = Object>
		<cfset index = index + 1>
	</cfloop>

	<cfreturn ObjArray>
	
</cffunction>