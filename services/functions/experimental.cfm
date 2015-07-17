<!---UNDER DEVELOPMENT--->
<cffunction name="XSSProtect" access="private" returntype="string" output="false">
	<cfargument name="inputString" type="string" required="yes">
	<cfscript>
	//CREDIT TO SCOTT BENNETT FOR THE FOLLOWING CODE
	//http://www.coldfusionguy.com/ColdFusion/blog/index.cfm/2008/5/23/Do-I-Suck-Because-I-Dont-Use-Frameworks
	cleanText = replace(urldecode(inputString), "<iframe", "INVALIDTAG", "ALL");
	cleanText = replace(cleanText, "<", "", "ALL");
	cleanText = replace(cleanText, ">", "", "ALL");
	//cleanText = replace(cleanText, "'", "", "ALL");
	//cleanText = replace(cleanText, "(", "", "ALL");
	//cleanText = replace(cleanText, ")", "", "ALL");
	return cleanText;
	</cfscript>
</cffunction>

<cffunction name="InsertImageForm" access="public" returntype="any">
	<cfargument name="form" required="yes">
	<cfargument name="model" type="string" required="no">
	<cfargument name="path" type="string" required="no" default="content\images">
	<cfargument name="excluded" type="string" required="no" default="">
	<cfargument name="filefield" type="string" required="no" default="upload">
	<cfargument name="imagefield" type="string" required="no" default="image">
	<cfargument name="nameconflict" type="string" required="no" default="makeunique">
	<cffile action="upload" filefield="#arguments.filefield#" destination="#APPLICATION.BASE_PATH#\#arguments.path#"  nameconflict="#arguments.nameconflict#">
	<cfif IsDefined("arguments.model")>
		<cfset MyFieldArray = ArrayNew(1)>
		<!---LOOP THROUGH SUBMITTED FORM FIELDS--->
		
		<cfloop collection= "#arguments.form#" item="theField" >
			<!---FILTER FIELDS THAT ARE NOT IN TABLE OR ARE NOT SIMPLE--->
			<cfif theField IS NOT "fieldNames" AND theField IS NOT "Submit" AND NOT Find(theField, arguments.excluded) AND theField NEQ arguments.filefield>
				<!---SET FORM FIELDS AND THEIR VALUES TO AN ARRAY, VALUES ARRAY IS FOR DEVELOPMENT ONLY--->
				<cfset ArrayAppend(MyFieldArray, theField)>
			</cfif>
		</cfloop>
		<!---SET FORM FIELD ARRAY TO A LIST FOR CFInsert--->
		<cfset Fields = ArraytoList(MyFieldArray, ",")>
		<cftry>
			<!---Get DbInfo--->
			<cfset qModel = DbInfo( type = "columns", table = arguments.model)>
			<!---Get Primary Key--->
			<cfset primaryKey = GetPrimaryKey( qModel )>
			<cftransaction>
			<cfinsert datasource="#APPLICATION.DATASOURCE#" tablename="#arguments.model#" formfields="#Fields#">
			<cfquery name="PKEY">
			Select #primaryKey#
			FROM #arguments.model#
			ORDER BY #primaryKey# DESC
			LIMIT 1;
			</cfquery>
			<cfset qModel = QueryToStruct(PKEY)>
			<cfquery>
			Update #arguments.model#
			SET #arguments.imagefield# = "#serverFileName#.#serverFileExt#"
			Where #primaryKey# = #qModel[1][primaryKey]#
			</cfquery>
			</cftransaction>
			<cfcatch type="any">
				<cfset returnMessage = cfcatch.detail & " | " & cfcatch.message & " | " & cfcatch.type >
				<cfoutput>#returnMessage#</cfoutput>
			</cfcatch>
		</cftry>
		<cfreturn PKEY>
		<cfelse>
		<cfreturn serverFileName>
	</cfif>
</cffunction>

<cffunction name="UpdateImageForm" access="public" returntype="any">
	<cfargument name="form" required="yes">
	<cfargument name="model" type="string" required="no">
	<cfargument name="keyValue" type="numeric" required="yes">
	<cfargument name="path" type="string" required="no" default="content\images">
	<cfargument name="excluded" type="string" required="no" default="">
	<cfargument name="filefield" type="string" required="no" default="upload">
	<cfargument name="imagefield" type="string" required="no" default="image">
	<cfargument name="nameconflict" type="string" required="no" default="makeunique">
	<cffile action="upload" filefield="#arguments.filefield#" destination="#APPLICATION.BASE_PATH#\#arguments.path#"  nameconflict="#arguments.nameconflict#">
	<cfif IsDefined("arguments.model")>
		<cfset MyFieldArray = ArrayNew(1)>
		<!---LOOP THROUGH SUBMITTED FORM FIELDS--->
		<h1>
			<cfoutput>#arguments.excluded#</cfoutput>
		</h1>
		<cfloop collection= "#arguments.form#" item="theField" >
			<!---FILTER FIELDS THAT ARE NOT IN TABLE OR ARE NOT SIMPLE--->
			<cfif theField NEQ "fieldNames" AND theField NEQ "Submit" AND NOT Find(theField, arguments.excluded) AND theField NEQ arguments.filefield>
				<!---SET FORM FIELDS AND THEIR VALUES TO AN ARRAY, VALUES ARRAY IS FOR DEVELOPMENT ONLY--->
				<cfset ArrayAppend(MyFieldArray, theField)>
				<h1>
					<cfoutput>#theField# = #form[theField]#</cfoutput>
				</h1>
			</cfif>
		</cfloop>
		<!---SET FORM FIELD ARRAY TO A LIST FOR CFInsert--->
		<cfset Fields = ArraytoList(MyFieldArray, ",")>
		<cftry>
			<!---Get DbInfo--->
			<cfset qModel = DbInfo( type = "columns", table = arguments.model)>
			<!---Get Primary Key--->
			<cfset primaryKey = GetPrimaryKey( qModel )>
			<cftransaction>
			<cfupdate datasource="#APPLICATION.DATASOURCE#" tablename="#arguments.model#" formfields="#Fields#">
			<cfquery>
			Update #arguments.model#
			SET #arguments.imagefield# = "#serverFileName#.#serverFileExt#"
			Where #primaryKey# = #arguments.keyValue#
			</cfquery>
			</cftransaction>
			<cfcatch type="any">
				<cfset returnMessage = cfcatch.detail & " | " & cfcatch.message & " | " & cfcatch.type >
				<cfoutput>#returnMessage#</cfoutput>
			</cfcatch>
		</cftry>
		<cfelse>
		<cfreturn serverFileName>
	</cfif>
</cffunction>
<cffunction name="InvokeEPAY" access="public" returntype="any">
	<cfargument name="method" required="yes" type="string" default="">
	<cfargument name="argCollection" required="yes" type="struct">
	<cfinvoke 
	method="#arguments.method#" 
	returnvariable="EPAYReturn" 
	webservice="#EPAY.WSDL#"
	argumentCollection="#argCollection#"/>
	<cfreturn EPAYReturn>
</cffunction>

<cffunction name="SelectJSONObject" access="remote" returntype="any" returnformat="JSON" output="false">
	<cfargument name="callback" type="string" required="false">
	<cfargument name="model" type="string" required="false">
	<cfset Obj = EntityLoad(arguments.model)>
	<cfset q = EntityToQuery(Obj)>
	<cfset var data = q>
	<cfset data = QueryToStruct( data )>
	<cfset data = serializeJSON(data)>
	<cfreturn data>
</cffunction>

<cffunction name="CSVFromQuery" access="public" returntype="string" output="false" hint="I take a query and convert it to a comma separated value string.">
	<cfargument 
		name="Query" 
		type="query" 
		required="true" 
		hint="I am the query being converted to CSV." />
	<cfargument
		name="Fields"
		type="string"
		required="true"
		hint="I am the list of query fields to be used when creating the CSV value."/>
	<cfargument
		name="CreateHeaderRow"
		type="boolean"
		required="false"
		default="true"
		hint="I flag whether or not to create a row of header values."/>
	<cfargument name="Delimiter"
		type="string"
		required="false"
		default=","
		hint="I am the field delimiter in the CSV value."	/>
	<cfargument name="fileName" type="string" required="false" default="" hint="I make a file from the result"/>
	
	<!--- Define the local scope. --->
	<CFSET var LOCAL = {} />
	
	<!---
First, we want to set up a column index so that we can
iterate over the column names faster than if we used a
standard list loop on the passed-in list.
--->
	<cfset LOCAL.COLUMN_NAMES = {} />
	
	<!---
Loop over column names and index them numerically. We
are going to be treating this struct almost as if it
were an array. The reason we are doing this is that
look-up times on a table are a bit faster than look
up times on an array (or so I have been told).
--->
	<cfloop
		index="LOCAL.COLUMN_NAME"
		list="#arguments.Fields#"
		delimiters=",">
		
		<!--- Store the current column name. --->
		<cfset LOCAL.COLUMN_NAMES[ StructCount( LOCAL.COLUMN_NAMES ) + 1 ] = Trim( LOCAL.COLUMN_NAME ) />
	</cfloop>
	
	<!--- Store the column count. --->
	<cfset LOCAL.ColumnCount = StructCount( LOCAL.COLUMN_NAMES ) />
	
	<!---
Now that we have our index in place, let's create
a string buffer to help us build the CSV value more
effiently.
--->
	<cfset LOCAL.Buffer = CreateObject( "java", "java.lang.StringBuffer" ).Init() />
	
	<!--- Create a short hand for the new line characters. --->
	<cfset LOCAL.NewLine = (Chr( 13 ) & Chr( 10 )) />
	
	<!--- Check to see if we need to add a header row. --->
	<cfif arguments.CreateHeaderRow>
		
		<!--- Loop over the column names. --->
		<cfloop
			index="LOCAL.ColumnIndex"
			from="1"
			to="#LOCAL.ColumnCount#"
			step="1">
			
			<!--- Append the field name. --->
			<cfset LOCAL.Buffer.Append(
				JavaCast(
				"string",
				"""#LOCAL.COLUMN_NAMES[ LOCAL.ColumnIndex ]#"""
				)
				) />
			
			<!---
Check to see which delimiter we need to add:
field or line.
--->
			<cfif (LOCAL.ColumnIndex LT LOCAL.ColumnCount)>
				
				<!--- Field delimiter. --->
				<cfset LOCAL.Buffer.Append(
					JavaCast( "string", arguments.Delimiter )
					) />
				<cfelse>
				
				<!--- Line delimiter. --->
				<cfset LOCAL.Buffer.Append(
					JavaCast( "string", LOCAL.NewLine )
					) />
			</cfif>
		</cfloop>
	</cfif>
	
	<!---
	Now that we have dealt with any header value, let's
	convert the query body to CSV. When doing this, we are
	going to qualify each field value. This is done be
	default since it will be much faster than actually
	checking to see if a field needs to be qualified.
	---> 
	
	<!--- Loop over the query. --->
	<cfloop query="arguments.Query">
		
		<!--- Loop over the columns. --->
		<cfloop
			index="LOCAL.ColumnIndex"
			from="1"
			to="#LOCAL.ColumnCount#"
			step="1">
			
			<!--- Append the field value. --->
			<cfset LOCAL.Buffer.Append(
				JavaCast(
				"string",
				"""#arguments.Query[ LOCAL.COLUMN_NAMES[ LOCAL.ColumnIndex ] ][ arguments.Query.CurrentRow ]#"""
				)
				) />
			
			<!---
			Check to see which delimiter we need to add:
			field or line.
			--->
			<cfif (LOCAL.ColumnIndex LT LOCAL.ColumnCount)>
				
				<!--- Field delimiter. --->
				<cfset LOCAL.Buffer.Append(
					JavaCast( "string", arguments.Delimiter )
					) />
				<cfelse>
				
				<!--- Line delimiter. --->
				<cfset LOCAL.Buffer.Append(
					JavaCast( "string", LOCAL.NewLine )
					) />
			</cfif>
		</cfloop>
	</cfloop>
	<cfif arguments.fileName NEQ "">
		<cffile action="write" file="#arguments.fileName#" output="#LOCAL.Buffer.ToString()#">
	</cfif>
	
	<!--- Return the CSV value. --->
	<cfreturn LOCAL.Buffer.ToString() />
</cffunction>

<cffunction name="Invoke" access="public" returntype="any">
	<cfargument name="component" required="no" type="string" default="">
	<cfargument name="method" required="no" type="string" default="">
	<cfargument name="webservice" required="no" type="string" default="">
	<cfargument name="attributecollection" required="no" type="struct">
	<cfargument name="argCollection" required="no" type="struct">
	<cfscript>
	var glue = structNew();
	glue.returnvariable = "glueResults";
	glue.method = arguments.method;
	
	if ( arguments.webservice NEQ "") {
	
		glue.webservice = arguments.webservice;
	}
	
	else {
		
		glue.component = arguments.component;
	}
	
	if ( IsDefined("arguments.argCollection") ) {
	
		glue.argumentCollection = arguments.argCollection;
	}
	</cfscript>
	<cfinvoke attributecollection = "#glue#" />
	<cfreturn glueResults>
</cffunction>
<!---<cffunction name="GetJQMFORMHTML" access="remote" returntype="string" returnformat="plain" output="false">
	<cfargument name="viewRequest" type="string" required="no">
	<cfscript>
	includePath = "../views/phonegap/" & arguments.viewRequest & ".cfm";
	savecontent variable="readFile" {
		
		include includePath; 
	};
	return readFile;
	</cfscript>
</cffunction>
---> 