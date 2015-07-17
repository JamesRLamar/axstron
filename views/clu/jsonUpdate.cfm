<article class="container12">
	<section>
		<div class="block-border">
			<div class="block-content">
				<cfset _TS = new services._Tron()>
				
				<cfset excluded = "">
				
				<cfset data = '[{"ListAgentId":"test 2","RoleName":"tron","UserName":"James Lamar","Email":"jlamar777@gmail.com","Status":"Active","Password":"4191DA1860762F2AEAD58F812A18150D9202C968","LastLogin":"{ts ''2013-04-26 11:24:45''}","USERID":116}]'>
					
				<cfset data = deserializeJSON(data, false)>
				
				<!---CREATE ARRAY FROM DATA--->
				
				<cfset dataProperties = _TS.PropertyArrayFromStruct(data[1])>
				
				<Cfdump var="#dataProperties#" label="dataProperties">
				
				<!---GET NAME OF PKEY--->
				
				<cfset modelInfo = _TS.DbInfo( type = "columns", table = "_User")>
				
				<cfset primaryKey = UCase(_TS.GetPrimaryKey( modelInfo ))>
				
				<h3><cfoutput>#primaryKey#</cfoutput></h3>
				
				<!---GET LIST OF PROPERTY NAMES FROM RELEVANT MODEL--->
				
				<cfset modelProperties = ArrayToList(_TS.PropertiesArray(modelInfo, true))>
				
				<cfdump var="#modelProperties#">
				
				<!---LOOP THROUGH DATA ARRAY--->
				
				<cfloop from="1" to="#ArrayLen(data)#" index="d">
				 
					<!---LOOP THROUGH EACH ROW OF DATA--->
					
					<cfset dataRow = data[d]>
					
					<cfdump var="#dataRow#">
					
					<!---CREATE UPDATE STATEMENT FOR QUERY--->
					
					<cfset SQL = "UPDATE " & "_User" & " SET ">
					
					<cfset queryService = new query()>
					
					<!---GET PROPERTY NAME AND PROPERTY VALUE--->
					
					<cfloop from="1" to="#ArrayLen(dataProperties)#" index="c">
					
						<cfset dataProperty = dataProperties[c]>
						
						<h3><cfoutput>#dataProperty#</cfoutput></h3>
					
						<!---
							IF PROPERTY IS NOT THE PRIMARY KEY 
							AND THE PROPERTY IN THE dataRow IS A PROPERTY OF THE ACTUAL MODEL
						---> 
						<!---	
							IF PROPERTY NAMES IN dataRow DO NOT MATCH 
							PROPERTY NAMES IN MODEL EXACTLY (CASE INCLUDED) THIS CONDITION WILL RENDER FALSE
						--->
						<cfif dataProperty NEQ primaryKey AND Find(dataProperty, modelProperties)>
						
							found!
						
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
									
							<cfif _TS.DbInfoValidateNumericColumn(modelInfo, dataProperty) AND StructFind(dataRow, dataProperty) EQ "">
							
								<cfset queryService.addParam(
										name=dataProperty,
										value=0,
										cfsqltype="cf_sql_numeric"
									)>
								
							<cfelseif _TS.DbInfoValidateNumericColumn(modelInfo, dataProperty) AND StructFind(dataRow, dataProperty) NEQ "">
							
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
				</cfloop><br />
				<cfoutput>#SQL#</cfoutput><br /><br /><br /><br />
				<cfquery name="qUser">
				select * from _user where userid = 116
				</cfquery>
				<cfdump var="#qUser#">

			</div>
		</div>
	</section>
	<div class="clear"></div>
</article>
