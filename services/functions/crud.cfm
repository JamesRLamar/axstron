<!---JSON CRUD OPERATIONS--->
<cffunction name="JsonCreateByQuery" hint="I dynamically build and param INSERT queries from dbinfo and JSON" access="public" output="false">
	<cfargument name="models" type="string" required="true">	
	<cfargument name="model" type="string" required="true">
	<cfset data = urldecode(arguments.models)>
	<cfset data = deserializeJSON(data, false)>
	
	<!---CREATE ARRAY FROM DATA--->
	<cfset dataProperties = PropertyArrayFromStruct(data[1])>
	
	<!---GET NAME OF PKEY--->
	<cfset modelInfo = DbInfo( type = "columns", table = arguments.model)>
	<cfset primaryKey = UCase(GetPrimaryKey( modelInfo ))>
	
	<!---GET LIST OF PROPERTY NAMES FROM RELEVANT MODEL--->	
	<cfset modelProperties = ArrayToList(PropertiesArray(modelInfo, true))>
	
	<!---LOOP THROUGH DATA ARRAY--->
	<cfloop from="1" to="#ArrayLen(data)#" index="d">
		
		<!---LOOP THROUGH EACH ROW OF DATA--->		
		<cfset dataRow = data[d]>
		
		<!---CREATE UPDATE STATEMENT FOR QUERY--->		
		<cfset SQL = "INSERT INTO " & arguments.model & " ( ">		
		<cfset queryService = new query()>
		
		<!---GET PROPERTY NAME AND PROPERTY VALUE--->		
		<cfloop from="1" to="#ArrayLen(dataProperties)#" index="c">
			<cfset dataProperty = dataProperties[c]>
			
			<!---GET PROPERTIES LIST--->			
			<cfif dataProperty NEQ primaryKey && Find(dataProperty, modelProperties)>				
				<cfset SQL = SQL 
					& dataProperty & ','>				
			</cfif>
		</cfloop>

		<cfset statementLen = Len(SQL) - 1>		
		<cfset SQL = Left(SQL, statementLen)>		
		<cfset SQL = SQL & 	") VALUES ( ">
							
		<cfloop from="1" to="#ArrayLen(dataProperties)#" index="c">
			<cfset dataProperty = dataProperties[c]>			
			<cfif dataProperty NEQ primaryKey &&  Find(dataProperty, modelProperties)>
				
				<!---EVALUATE IF THE DATA ARRAY IS PASSING BOOLEAN VALUES AND IF SO CHANGE TO 0 OR 1--->
				<cfif StructFind(dataRow, dataProperty) EQ "NO">
					<cfset tempValue = 0>
					<cfelseif StructFind(dataRow, dataProperty) EQ "YES">
					<cfset tempValue = 1>
					<cfelse>
					<cfset tempValue = StructFind(dataRow, dataProperty)>
				</cfif>
				
				<!---
				EVALUATE IF THERE IS A DEFAULT NUMERIC VALUE
				AND THE CURRENT DATA ARRAY IS PASSING A BLANK VALUE, 
				SET TO DEFAULT VALUE FROM TABLE
				--->
				<cfset SQL = SQL & ":" & dataProperty & ','>
					
				<cfif DbInfoValidateNumericColumn(modelInfo, dataProperty) AND StructFind(dataRow, dataProperty) EQ "">
					<cfset queryService.addParam(
						name=dataProperty,
						value=0,
						cfsqltype="cf_sql_numeric"
					)>
				<cfelseif DbInfoValidateNumericColumn(modelInfo, dataProperty) AND StructFind(dataRow, dataProperty) NEQ "">
					<cfset queryService.addParam(
						name=dataProperty,
						value=tempValue,
						cfsqltype="cf_sql_numeric"
					)>
				<cfelse>
					<cfset queryService.addParam(
						name=dataProperty,
						value=tempValue,
						cfsqltype="cf_sql_varchar"
					)>
				</cfif>
				<cfdump var="#tempValue#" label="tempValue">
			</cfif>
		</cfloop>
		
		<!---REMOVE LAST "," from SQL--->
		<cfset statementLen = Len(SQL) - 1>
		<cfset SQL = Left(SQL, statementLen)>
		<cfset SQL = SQL & " )">
		<cfset queryService.setSQL(SQL)>
		<cfset result = queryService.execute()>		
	</cfloop>
</cffunction>

<cffunction name="JsonReadByQuery" access="public" returntype="any" returnformat="JSON" output="false">
	<cfargument name="model" type="string" required="yes">
	<cfargument name="datasource" type="string" required="false" default="#APPLICATION.DATASOURCE#">
	<cfquery name="qResults" datasource="#arguments.datasource#">
		SELECT * FROM #arguments.model#
	</cfquery>
	<cfreturn QueryToStruct( qResults )>
</cffunction>

<cffunction name="JsonUpdateByQuery" hint="I dynamically build and param UPDATE queries from dbinfo and JSON" access="public" output="false">
	<cfargument name="models" type="string" required="true">
	<cfargument name="model" type="string" required="true">
	<cfset data = urldecode(arguments.models)>
	<cfset data = deserializeJSON(data, false)>
				
	<!---CREATE ARRAY FROM DATA--->
	<cfset dataProperties = PropertyArrayFromStruct(data[1])>
	
	<!---GET NAME OF PKEY--->
	<cfset modelInfo = DbInfo( type = "columns", table = arguments.model)>
	<cfset primaryKey = UCase(GetPrimaryKey( modelInfo ))>
		
	<!---GET LIST OF PROPERTY NAMES FROM RELEVANT MODEL--->
	<cfset modelProperties = ArrayToList(PropertiesArray(modelInfo, true))>
		
	<!---LOOP THROUGH DATA ARRAY--->
	<cfloop from="1" to="#ArrayLen(data)#" index="d">
	 
		<!---LOOP THROUGH EACH ROW OF DATA--->
		<cfset dataRow = data[d]>
				
		<!---CREATE UPDATE STATEMENT FOR QUERY--->
		<cfset SQL = "UPDATE " & arguments.model & " SET ">
		<cfset queryService = new query()>
		
		<!---GET PROPERTY NAME AND PROPERTY VALUE--->
		<cfloop from="1" to="#ArrayLen(dataProperties)#" index="c">
		
			<cfset dataProperty = dataProperties[c]>
					
			<!---
				IF PROPERTY IS NOT THE PRIMARY KEY 
				AND THE PROPERTY IN THE dataRow IS A PROPERTY OF THE ACTUAL MODEL
			---> 
			<!---	
				IF PROPERTY NAMES IN dataRow DO NOT MATCH 
				PROPERTY NAMES IN MODEL EXACTLY (CASE INCLUDED) THIS CONDITION WILL RENDER FALSE
			--->
			<cfif dataProperty NEQ primaryKey AND Find(dataProperty, modelProperties)>
						
				<!---EVALUATE IF THE DATA ARRAY IS PASSING BOOLEAN VALUES AND IF SO CHANGE TO 0 OR 1--->
				<cfif StructFind(dataRow, dataProperty) EQ "NO">
			
					<cfset tempValue = 0>

				<cfelseif StructFind(dataRow, dataProperty) EQ "YES">
			
					<cfset tempValue = 1>
			
				<cfelse>
			
					<cfset tempValue = StructFind(dataRow, dataProperty)>
			
				</cfif>
				
				<!---
					EVALUATE IF THERE IS A DEFAULT NUMERIC VALUE
					AND THE CURRENT DATA ARRAY IS PASSING A BLANK VALUE, 
					SET TO DEFAULT VALUE FROM TABLE
				--->
				<cfset SQL = SQL 
						& dataProperty & ' = :' & dataProperty	& ','>
						
				<cfif DbInfoValidateNumericColumn(modelInfo, dataProperty) AND StructFind(dataRow, dataProperty) EQ "">
					<cfset queryService.addParam(
							name=dataProperty,
							value=0,
							cfsqltype="cf_sql_numeric"
						)>
				<cfelseif DbInfoValidateNumericColumn(modelInfo, dataProperty) AND StructFind(dataRow, dataProperty) NEQ "">
					<cfset queryService.addParam(
							name=dataProperty,
							value=tempValue,
							cfsqltype="cf_sql_numeric"
						)>
				<cfelse>
					<cfset queryService.addParam(
							name=dataProperty,
							value=tempValue,
							cfsqltype="cf_sql_varchar"
						)>
				</cfif>
				
			<cfelseif dataProperty EQ primaryKey>
				<cfset primaryKeyValue = StructFind(dataRow, dataProperty)>
			</cfif>
		</cfloop>
		
		<!---REMOVE LAST "," from SQL--->
		<cfset statementLen = Len(SQL) - 1>
		<cfset SQL = Left(SQL, statementLen)>
		
		<!---Where PRIMARYKEY = PASSEDUID--->
		<cfset queryService.addParam(
				name=primaryKey,
				value=primaryKeyValue,
				cfsqltype="cf_sql_numeric"
			)>			
		<cfset SQL = SQL & " WHERE " & primaryKey & ' = :' & primaryKey>
		<cfset queryService.setSQL(SQL)>
		<cfset result = queryService.execute()>
	</cfloop>
</cffunction>

<cffunction name="JsonDeleteByQuery" access="public" output="false">
	<cfargument name="models" type="string" required="true">
	<cfargument name="model" type="string" required="true">
	<cfset data = urldecode(arguments.models)>
	<cfset data = deserializeJSON(data, false)>
				
	<!---CREATE ARRAY FROM DATA--->
	<cfset dataProperties = PropertyArrayFromStruct(data[1])>
	
	<!---GET NAME OF PKEY--->
	<cfset modelInfo = DbInfo( type = "columns", table = arguments.model)>
	<cfset primaryKey = UCase(GetPrimaryKey( modelInfo ))>
		
	<!---LOOP THROUGH DATA ARRAY--->
	<cfloop from="1" to="#ArrayLen(data)#" index="d">
	 	
	 	<!---CREATE DELETE STATEMENT FOR QUERY--->
		<cfset SQL = "DELETE FROM " & arguments.model>
		<cfset queryService = new query()>

		<!---LOOP THROUGH EACH ROW OF DATA--->
		<cfset dataRow = data[d]>
		
		<!---GET PROPERTY NAME AND PROPERTY VALUE--->
		<cfloop from="1" to="#ArrayLen(dataProperties)#" index="c">
			<cfset dataProperty = dataProperties[c]>				
			<cfif dataProperty EQ primaryKey>
				<cfset primaryKeyValue = StructFind(dataRow, dataProperty)>
				<cfbreak>
			</cfif>
		</cfloop>
				
		<!---Where PRIMARYKEY = PASSEDUID--->
		<cfset queryService.addParam(
				name=primaryKey,
				value=primaryKeyValue,
				cfsqltype="cf_sql_numeric"
			)>			
		<cfset SQL = SQL & " WHERE " & primaryKey & ' = :' & primaryKey>
		<cfset queryService.setSQL(SQL)>
		<cfset result = queryService.execute()>
	</cfloop>
</cffunction>

<cffunction name="JsonCreateByObject" hint="I dynamically create objects" access="public" output="false">
	<cfargument name="models" type="string" required="true">
	<cfargument name="model" type="string" required="true">
	<cfset data = urldecode(arguments.models)>
	<cfset data = deserializeJSON(data, false)>
	
	<!---GET NAME OF PKEY--->
	<cfset modelInfo = DbInfo( type = "columns", table = arguments.model)>
	<cfset primaryKey = UCase(GetPrimaryKey( modelInfo ))>
		
	<!---LOOP THROUGH DATA ARRAY--->
	<cfloop from="1" to="#ArrayLen(data)#" index="d">
	 
		<cfset dataRow = data[d]>
		<cfset Object = EntityNew(arguments.model)>
		<cfset properties = ORMGetSessionFactory().getAllClassMetadata()[ ListLast( GetMetaData( Object ).fullname, "." ) ].getPropertyNames()>

		<cfloop array="#properties#" index="item">
			<cfif UCase(item) NEQ primaryKey>
				<cftry>
					<cfinvoke component="#Object#" method="Set#item#" returnvariable="result">
						<cfinvokeargument name="#item#" value="#StructFind(dataRow, item)#"/>
					</cfinvoke>
					<cfcatch type="any">
						Do nothing because the column may not exist the data set being sent
					</cfcatch>
				</cftry>
			</cfif>
		</cfloop>

		<cfset EntitySave(Object)>
		
	</cfloop>
</cffunction>

<cffunction name="JsonReadByObject" access="public" returntype="string" returnformat="plain" output="false">
	<cfargument name="model" type="string" required="yes">
	<cfset ObjectArray = EntityLoad(arguments.model)>
	<!--- <cfset json = "[">
	<cfset objIndex = 0>
	<cfloop array="#ObjectArray#" index="object">
		<cfset objIndex++>
		<cfset properties = ORMGetSessionFactory().getAllClassMetadata()[ ListLast( GetMetaData( object ).fullname, "." ) ].getPropertyNames()>
		<cfset data = {}>
		<cfset result = "">
		<cfset propIndex = 0>
		<cfset json = json & "{">
		
		<cfloop array="#properties#" index="item">
			<cfset propIndex++>
			<cfinvoke component="#object#" method="get#item#" returnvariable="result">
			<cfif IsNull(result)>
				<cfset data[item] = "">
			<cfelse>
				<cfset data[item] = result>
			</cfif>
			<cfset json = json & '"' & item & '":"' & data[item] & '"'>
			<cfif ArrayLen(properties) NEQ propIndex>
				<cfset json = json & ",">
			<cfelse>
				<cfset json = json & "}">
			</cfif>
		</cfloop>
		<cfif ArrayLen(ObjectArray) NEQ objIndex>
			<cfset json = json & ",">
		</cfif>
	</cfloop>
	<cfset json = json & "]"> --->
	<cfreturn serializeJson(ObjectArray)>
</cffunction>

<cffunction name="JsonUpdateByObject" hint="I dynamically update objects" access="public" output="false">
	<cfargument name="models" type="string" required="true">
	<cfargument name="model" type="string" required="true">
	<cfset data = urldecode(arguments.models)>
	<cfset data = deserializeJSON(data, false)>
	
	<!---GET NAME OF PKEY--->
	<cfset modelInfo = DbInfo( type = "columns", table = arguments.model)>
	<cfset primaryKey = UCase(GetPrimaryKey( modelInfo ))>
		
	<!---LOOP THROUGH DATA ARRAY--->
	<cfloop from="1" to="#ArrayLen(data)#" index="d">
	 
		<cfset dataRow = data[d]>
		<cfset PKValue = StructFind(dataRow, primaryKey)>
		<cfset Object = EntityLoadByPK(arguments.model, PKValue)>
		<cfset properties = ORMGetSessionFactory().getAllClassMetadata()[ ListLast( GetMetaData( Object ).fullname, "." ) ].getPropertyNames()>

		<cfloop array="#properties#" index="item">
			<cfif UCase(item) NEQ primaryKey>
				<cftry>
					<cfinvoke component="#Object#" method="Set#item#" returnvariable="result">
						<cfinvokeargument name="#item#" value="#StructFind(dataRow, item)#"/>
					</cfinvoke>
					<cfcatch type="any">
						Do nothing because the column may not exist the data set being sent
					</cfcatch>
				</cftry>
			</cfif>
		</cfloop>

		<cfset EntitySave(Object)>
		
	</cfloop>
</cffunction>

<cffunction name="JsonDeleteByObject" hint="I dynamically update objects" access="public" output="false">
	<cfargument name="models" type="string" required="true">
	<cfargument name="model" type="string" required="true">
	<cfset data = urldecode(arguments.models)>
	<cfset data = deserializeJSON(data, false)>
	
	<!---GET NAME OF PKEY--->
	<cfset modelInfo = DbInfo( type = "columns", table = arguments.model)>
	<cfset primaryKey = UCase(GetPrimaryKey( modelInfo ))>
		
	<!---LOOP THROUGH DATA ARRAY--->
	<cfloop from="1" to="#ArrayLen(data)#" index="d">
	 
		<cfset dataRow = data[d]>
		<cfset PKValue = StructFind(dataRow, primaryKey)>
		<cfset Object = EntityLoadByPK(arguments.model, PKValue)>
		<cfset EntityDelete(Object)>
		
	</cfloop>
</cffunction>

<cffunction name="JsonFromQuery" access="public" returntype="string" returnformat="plain" output="false">
	<cfargument name="query" type="query" required="true">
	<cfset json = QueryToStruct( arguments.query )>
	<cfset json = serializeJSON( json )>
	<cfreturn json>
</cffunction>

<cffunction name="JsonPFromQuery" access="public" returntype="string" returnformat="plain" output="false">
	<cfargument name="callback" type="string" required="false">
	<cfargument name="query" type="string" required="yes">
	<cfscript>
	var jsonp = QueryToStruct( arguments.query );
	jsonp = serializeJSON(jsonp, false);
	
	if (structKeyExists(arguments, "callback")) {
		jsonp = arguments.callback & "(" & jsonp & ")";
	}
	
	return jsonp;
	</cfscript>
</cffunction>

<cffunction name="QueryToStruct" access="public" returntype="any" output="false"
hint="Converts an entire query or the given record to a struct. This might return a structure (single record) or an array of structures.">
	
	<!--- Define arguments. --->
	<cfargument name="Query" type="query" required="true" />
	<cfargument name="Row" type="numeric" required="false" default="0" />
	<cfscript>
	// Define the local scope.
	var LOCAL = {};
	
	// Determine the indexes that we will need to loop over.
	// To do so, check to see if we are working with a given row,
	// or the whole record set.
	if (arguments.Row){
	// We are only looping over one row.
	LOCAL["FromIndex"] = arguments.Row;
	LOCAL["ToIndex"] = arguments.Row;
	} else {
	// We are looping over the entire query.
	LOCAL["FromIndex"] = 1;
	LOCAL["ToIndex"] = arguments.Query.RecordCount;
	}
	
	// Get the list of columns as an array and the column count.
	//LOCAL["Columns"] = ListToArray( arguments.Query.ColumnList );
	//CHANGED TO MAINTAIN PROPER CASE OF PROPERTIES FROM QUERY RESULT
	LOCAL["Columns"] = arguments.Query.getMetaData().getColumnLabels();
	LOCAL["ColumnCount"] = ArrayLen( LOCAL["Columns"] );
	
	// Create an array to keep all the objects.
	LOCAL["DataArray"] = ArrayNew( 1 );
	
	// Loop over the rows to create a structure for each row.
	for (LOCAL["RowIndex"] = LOCAL["FromIndex"] ; LOCAL["RowIndex"] LTE LOCAL["ToIndex"] ; LOCAL["RowIndex"] = (LOCAL["RowIndex"] + 1))
	{
		// Create a new structure for this row.
		ArrayAppend( LOCAL["DataArray"], {} );
		
		// Get the index of the current data array object.
		LOCAL["DataArrayIndex"] = ArrayLen( LOCAL["DataArray"] );
		
		// Loop over the columns to set the structure values.
		for (LOCAL["ColumnIndex"] = 1 ; LOCAL["ColumnIndex"] LTE LOCAL["ColumnCount"] ; LOCAL["ColumnIndex"] = (LOCAL["ColumnIndex"] + 1))
		{
			// Get the column value.
			LOCAL["Column_Name"] = LOCAL["Columns"][ LOCAL["ColumnIndex"] ];
			// Set column value into the structure.
			LOCAL["DataArray"][ LOCAL["DataArrayIndex"] ][ LOCAL["Column_Name"] ] = arguments.Query[ LOCAL["Column_Name"] ][ LOCAL["RowIndex"] ];
		}
	}
	// At this point, we have an array of structure objects that
	// represent the rows in the query over the indexes that we
	// wanted to convert. If we did not want to convert a specific
	// record, return the array. If we wanted to convert a single
	// row, then return the just that STRUCTURE, not the array.
	if (arguments.Row) {
		// Return the first array item.
		return( LOCAL["DataArray"][ 1 ] );
	} 
	else {
		// Return the entire array.
		return( LOCAL["DataArray"] );
	}
	</cfscript>
</cffunction>

<!--- FORM CRUD OPERATIONS --->

<cffunction name="FormCreateByQuery" access="public" returntype="numeric">
	<cfargument name="form" type="struct" required="yes">
	<cfargument name="model" type="string" required="yes">
	<cfargument name="datasource" type="string" required="false" default="#APPLICATION.DATASOURCE#">
	<cfset MyFieldArray = ArrayNew(1)>
	<!---LOOP THROUGH SUBMITTED FORM FIELDS--->
	<cfloop collection= "#arguments.form#" item="theField" >
		<!---FILTER FIELDS THAT ARE NOT IN TABLE OR ARE NOT SIMPLE--->
		<cfif theField IS NOT "fieldNames" AND theField IS NOT "Submit">
			<!---SET FORM FIELDS AND THEIR VALUES TO AN ARRAY, VALUES ARRAY IS FOR DEVELOPMENT ONLY--->
			<cfset ArrayAppend(MyFieldArray, theField)>
			<cfoutput> #theField# = #form[theField]# </br> </cfoutput>
		</cfif>
	</cfloop>
	<!---SET FORM FIELD ARRAY TO A LIST FOR CFInsert--->
	<cfset Fields = ArraytoList(MyFieldArray, ",")>
	<!---Get DbInfo--->
	<cfset qModel = DbInfo( type = "columns", table = arguments.model)>
	<!---Get Primary Key--->
	<cfset primaryKey = GetPrimaryKey( qModel )>
	<cftransaction>
		<cfinsert datasource="#APPLICATION.DATASOURCE#" tablename="#arguments.model#" formfields="#Fields#">
			<cfquery name="qResult">
			Select #primaryKey#
			FROM #arguments.model#
			ORDER BY #primaryKey# DESC
			LIMIT 1;
		</cfquery>
	</cftransaction>
	<cfreturn qResult[primaryKey][1]>
</cffunction>

<cffunction name="FormUpdateByQuery" access="public" returntype="void">
	<cfargument name="form" type="struct" required="yes">
	<cfargument name="model" type="string" required="yes">
	<cfargument name="excluded" type="string" required="false" default="">
	<cfargument name="datasource" type="string" required="false" default="#APPLICATION.DATASOURCE#">
	<cfset MyFieldArray = ArrayNew(1)>
	<!---LOOP THROUGH SUBMITTED FORM FIELDS--->
	<cfloop collection= "#arguments.form#" item="theField" >
		<!---FILTER FIELDS THAT ARE NOT IN TABLE OR ARE NOT SIMPLE--->
		<cfif theField IS NOT "fieldNames" AND theField IS NOT "Submit" AND NOT Find(theField, arguments.excluded)>
			
			<!---SET FORM FIELDS AND THEIR VALUES TO AN ARRAY, VALUES ARRAY IS FOR DEVELOPMENT ONLY--->
			<cfset ArrayAppend(MyFieldArray, theField)>
			<cfoutput> #theField# = #form[theField]# </br> </cfoutput>
		</cfif>
	</cfloop>
	<!---SET FORM FIELD ARRAY TO A LIST FOR CFInsert--->
	<cfset Fields = ArraytoList(MyFieldArray, ",")>
	<cfupdate datasource="#arguments.datasource#" tablename="#arguments.model#" formfields="#Fields#">
</cffunction>

<cffunction name="FormDeleteByQuery" access="public" returntype="void">
	<cfargument name="model" type="string" required="yes">
	<cfargument name="keyValue" type="numeric" required="yes">
	<!---Get DbInfo--->
	<cfset qModel = DbInfo( type = "columns", table = arguments.model)>
	<!---Get Primary Key--->
	<cfset primaryKey = GetPrimaryKey( qModel )>
	<cfquery name="queryResult">
      Delete FROM #arguments.model#
	Where #primaryKey# = <cfqueryparam value="#arguments.keyValue#" cfsqltype="cf_sql_integer">
      </cfquery>
</cffunction>

<cffunction name="FormCreateByObject" hint="I dynamically create objects" access="public" output="true" returntype="Any">
	<cfargument name="form" type="struct" required="yes">
	<cfargument name="model" type="string" required="true">
	<cfset MyFieldArray = ArrayNew(1)>
	<!---LOOP THROUGH SUBMITTED FORM FIELDS--->
	<cfloop collection= "#arguments.form#" item="theField" >
		<!---FILTER FIELDS THAT ARE NOT IN TABLE OR ARE NOT SIMPLE--->
		<cfif theField IS NOT "fieldNames" AND theField IS NOT "Submit">
			<!---SET FORM FIELDS AND THEIR VALUES TO AN ARRAY, VALUES ARRAY IS FOR DEVELOPMENT ONLY--->
			<cfset ArrayAppend(MyFieldArray, theField)>
		</cfif>
	</cfloop>
	<!---SET FORM FIELD ARRAY TO A LIST FOR CFInsert--->
	<cfset formFields = ArraytoList(MyFieldArray, ",")>
	
	<!---GET NAME OF PKEY--->
	<cfset modelInfo = DbInfo( type = "columns", table = arguments.model)>
	<cfset primaryKey = UCase(GetPrimaryKey( modelInfo ))>

	<cfset Object = EntityNew(arguments.model)>
	<cfset EntitySave(Object)>
	<cfdump var="#Object#">
	<cfset properties = ORMGetSessionFactory().getAllClassMetadata()[ ListLast( GetMetaData( Object ).fullname, "." ) ].getPropertyNames()>

	<cfloop array="#properties#" index="item">
		<cfif UCase(item) NEQ primaryKey AND Find(UCase(item), formFields)>
			<cftry>
				<cfinvoke component="#Object#" method="Set#item#" returnvariable="result">
					<cfinvokeargument name="#item#" value="#form[item]#"/>
				</cfinvoke>
				<cfcatch type="numeric">
					<cfinvoke component="#Object#" method="Set#item#" returnvariable="result">
						<cfinvokeargument name="#item#" value="0"/>
					</cfinvoke>
				</cfcatch>
				<cfcatch type="any">
					<cfinvoke component="#Object#" method="Set#item#" returnvariable="result">
						<cfinvokeargument name="#item#" value="0"/>
					</cfinvoke>
				</cfcatch>
			</cftry>
		</cfif>
	</cfloop>

	<cfset EntitySave(Object)>
		
	<cfreturn Object>
</cffunction>

<cffunction name="FormUpdateByObject" hint="I dynamically create objects" access="public" output="false" returntype="Any">
	<cfargument name="form" type="struct" required="yes">
	<cfargument name="model" type="string" required="true">
	<cfset MyFieldArray = ArrayNew(1)>
	<!---LOOP THROUGH SUBMITTED FORM FIELDS--->
	<cfloop collection= "#arguments.form#" item="theField" >
		<!---FILTER FIELDS THAT ARE NOT IN TABLE OR ARE NOT SIMPLE--->
		<cfif theField IS NOT "fieldNames" AND theField IS NOT "Submit">
			<!---SET FORM FIELDS AND THEIR VALUES TO AN ARRAY, VALUES ARRAY IS FOR DEVELOPMENT ONLY--->
			<cfset ArrayAppend(MyFieldArray, theField)>
		</cfif>
	</cfloop>
	<!---SET FORM FIELD ARRAY TO A LIST FOR CFInsert--->
	<cfset formFields = ArraytoList(MyFieldArray, ",")>
	
	<!---GET NAME OF PKEY--->
	<cfset modelInfo = DbInfo( type = "columns", table = arguments.model)>
	<cfset primaryKey = UCase(GetPrimaryKey( modelInfo ))>
	<cfset PKValue = form[primaryKey]>

	<cfset Object = EntityLoadByPK(arguments.model, PKValue)>
	<cfset properties = ORMGetSessionFactory().getAllClassMetadata()[ ListLast( GetMetaData( Object ).fullname, "." ) ].getPropertyNames()>

	<cfloop array="#properties#" index="item">
		<cfif UCase(item) NEQ primaryKey AND Find(UCase(item), formFields)>
			<cfinvoke component="#Object#" method="Set#item#" returnvariable="result">
				<cfinvokeargument name="#item#" value="#form[item]#"/>
			</cfinvoke>
		</cfif>
	</cfloop>

	<cfset EntitySave(Object)>
		
	<cfreturn Object>
</cffunction>

<cffunction name="FormDeleteByObject" hint="I dynamically create objects" access="public" output="false" returntype="void">
	<cfargument name="PID" type="numeric" required="yes">
	<cfargument name="model" type="string" required="true">
	<cfset Object = EntityLoadByPK(arguments.model, arguments.PID)>
	<cfset EntityDelete(Object)>
</cffunction>

<cfscript>
/**
 * Breaks a camelCased string into separate words
 * 8-mar-2010 added option to capitalize parsed words Brian Meloche brianmeloche@gmail.com
 * 
 * @param str      String to use (Required)
 * @param capitalize      Boolean to return capitalized words (Optional)
 * @return Returns a string 
 * @author Richard (brianmeloche@gmail.comacdhirr@trilobiet.nl) 
 * @version 0, March 8, 2010 
 */
function camelToSpace(str) {
    /* var rtnStr=lcase(reReplace(arguments.str,"([A-Z])([a-z])","&nbsp;\1\2","ALL"));
    if (arrayLen(arguments) GT 1 AND arguments[2] EQ true) {
        rtnStr=reReplace(arguments.str,"([a-z])([A-Z])","\1&nbsp;\2","ALL");
        rtnStr=uCase(left(rtnStr,1)) & right(rtnStr,len(rtnStr)-1);
    }
	return trim(rtnStr);
 */
 	var retString = Replace(arguments.str, "_", " ", "All");
	return trim(rereplace(rereplace(retString,"(^[a-z])","\u\1"),"([A-Z])"," \1","all"));
}
</cfscript>