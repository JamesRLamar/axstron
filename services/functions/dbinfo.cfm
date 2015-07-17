<!---DATABASE INTROSPECTION--->

<cffunction name="DbInfo" access="public" returntype="query" output="false">
	<cfargument name="datasource" type="string" required="false" default="#APPLICATION.DATASOURCE#">
	<cfargument name="type" type="string" required="false" default="tables">
	<cfargument name="dbname" type="string" required="false">
	<cfargument name="password" type="string" required="false">
	<cfargument name="username" type="string" required="false">
	<cfargument name="pattern" type="string" required="false">
	<cfargument name="table" type="string" required="false">
	<cfscript>
	//TODO: MAKE THIS A PRIVATE FUNCTION TO AVOID SECURITY RISK
	var args = structNew();
	args.type = arguments.type;
	args.datasource = arguments.datasource;
	args.name = "dbInfo";
	
	if ( IsDefined("arguments.password") ) {
		
		args.password = arguments.password;
	}
	
	else if (IsDefined("arguments.username") ) {
		
		args.username = arguments.username;
	}
	
	else if ( IsDefined("arguments.pattern") ) {
	 
		args.pattern = arguments.pattern;
	}
	
	else if ( IsDefined("arguments.table") ) {
	
		args.table = arguments.table;
	}
	</cfscript>
	<cfdbinfo attributecollection = "#args#">
	<cfreturn dbInfo>
</cffunction>

<cffunction name="GetPrimaryKey" access="public" returntype="string" output="false">
	<cfargument name="model" type="query" required="true">
	<cfscript>
	var qModel = arguments.model;
	
	//ADD SORT BY IS_PRIMARYKEY AND LOOP WILL NO LONGER BE NECESSARY
	
	for (col = 1; col LTE qModel.RecordCount; col++) {
		
		if (qModel["IS_PRIMARYKEY"][col]) {
			
			primaryKey = qModel["COLUMN_NAME"][col];
			break;
		}
	}
	
	return primaryKey;
	</cfscript>
</cffunction>

<cffunction name="DbInfoValidateNumericColumn" access="public" returntype="boolean" output="false">
	<cfargument name="model" type="query" required="true">
	<cfargument name="column" type="string" required="true">
	<cfscript>
	var qModel = arguments.model;
	
	var numericCol = false;
	
	for (col = 1; col LTE qModel.RecordCount; col++) {
		
		if (qModel["COLUMN_NAME"][col] EQ arguments.column) {
		
			if (qModel["TYPE_NAME"][col] IS "INT" OR qModel["TYPE_NAME"][col] IS "NUMERIC" OR qModel["TYPE_NAME"][col] IS "DOUBLE") {
				
				numericCol = true;
				
				break;
			}
			break;
		}
	}
	
	return numericCol;
	</cfscript>
</cffunction>

<cffunction name="PropertyArrayFromStruct" access="public" returntype="array" output="false">
	<cfargument name="struct" type="struct" required="true">
	<cfscript>
	var array = StructKeyArray(arguments.struct);
	ArraySort(array, "textnocase", "ASC");
	
	return array;
	</cfscript>
</cffunction>

<cffunction name="PropertiesArray" access="public" returntype="any" output="false">
	<cfargument name="dbInfo" type="query" required="true">
	<cfargument name="upperCase" type="boolean" default="false">
	<cfscript>
	var array = ArrayNew(1);
	var propertyName = "";
					
	for (row = 1; row LTE dbInfo.RecordCount; row++) {

		if (arguments.upperCase) {
			propertName = UCase(dbInfo["COLUMN_NAME"][row]);
		}
		else {
			propertName = dbInfo["COLUMN_NAME"][row];	
		}
		
		ArrayAppend(array, propertName);
	}
	
	ArraySort(array, "textnocase", "ASC");
	
	return array;
	</cfscript>
</cffunction>

<cffunction name="PropertyList" access="public" returntype="string" output="false">
	<cfargument name="modelInfo" type="query" required="true">
	<cfscript>
	array = PropertiesArray( arguments.modelInfo );
	list = ArrayToList(array);
	
	return list;
	</cfscript>
</cffunction>

<cffunction name="CreateFile" access="public" returntype="string" output="false">
	<cfargument name="filePath" type="string" default="#APPLICATION.BASE_PATH#\content\temp">
	<cfargument name="fileName" type="string" default="#APPLICATION.BASE_PATH#\content\temp\#DateFormat(Now(), 'yyyy-mm-dd')#-#TimeFormat(Now(),'hh-mm-ss')#.txt">
	<cfargument name="fileContent" type="any" default="test">
	<cfargument name="protect" type="boolean" default="true">
	<cfset fullPath = arguments.filePath & "\" & arguments.fileName>
	<cfif arguments.protect>
		<cfif FileExists(fullPath)>
			<cffile action="write" file="#arguments.filePath#\#DateFormat(Now(), 'yyyy-mm-dd')#-#TimeFormat(Now(),'hh-mm-ss')#-#arguments.fileName#" output="#ToString(arguments.fileContent)#">
			<cfset fullPath = arguments.filePath & "\" & DateFormat(Now(), 'yyyy-mm-dd') & "-" & TimeFormat(Now(),'hh-mm-ss') & "-" & arguments.fileName>
			<cfelse>
			<cffile action="write" file="#fullPath#" output="#ToString(arguments.fileContent)#">
		</cfif>
		<cfelse>
		<cffile action="write" file="#fullPath#" output="#ToString(arguments.fileContent)#">
	</cfif>
	<cfreturn fullPath>
</cffunction>

