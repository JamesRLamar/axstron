<article class="container12">
	<section>
		<div class="block-border">
			<div class="block-content">
				<cfset _TS = new services._Tron()>
				<cfset arguments.model = "_User">
				<cfset data = '[{"ListAgentId":"test","RoleName":"none","UserName":"Mr.Test","Email":"test","Status":"Inactive","Password":" "}]'>
				<cftry>
					<cfset data = deserializeJSON(data, false)>
					
					<!---CREATE ARRAY FROM DATA--->
					
					<cfset dataProperties = _TS.PropertyArrayFromStruct(data[1])>
					<Cfdump var="#dataProperties#" label="dataProperties">
					
					<!---GET NAME OF PKEY--->
					
					<cfset modelInfo = _TS.DbInfo( type = "columns", table = arguments.model)>
					<cfset primaryKey = UCase(_TS.GetPrimaryKey( modelInfo ))>
					<h3>
						<cfoutput>#primaryKey#</cfoutput>
					</h3>
					
					<!---GET LIST OF PROPERTY NAMES FROM RELEVANT MODEL--->
					
					<cfset modelProperties = ArrayToList(_TS.PropertiesArray(modelInfo, true))>
					<cfdump var="#modelProperties#">
					
					<!---LOOP THROUGH DATA ARRAY--->
					
					<cfloop from="1" to="#ArrayLen(data)#" index="d">
						
						<!---LOOP THROUGH EACH ROW OF DATA--->
						
						<cfset dataRow = data[d]>
						<cfdump var="#dataRow#">
						
						<!---CREATE UPDATE STATEMENT FOR QUERY--->
						
						<cfset SQL = "INSERT INTO " & arguments.model & " ( ">
						<cfset queryService = new query()>
						
						<!---GET PROPERTY NAME AND PROPERTY VALUE--->
						
						<cfloop from="1" to="#ArrayLen(dataProperties)#" index="c">
							<cfset dataProperty = dataProperties[c]>
							<h3>
								<cfoutput>#dataProperty#</cfoutput>
							</h3>
							
							<!---GET PROPERTIES LIST--->
							
							<cfif Find(dataProperty, modelProperties)>
								found! 
								
								<cfset SQL = SQL 
									& dataProperty & ','>
								
							</cfif>
						</cfloop>
						
						<cfset statementLen = Len(SQL) - 1>
						
						<cfset SQL = Left(SQL, statementLen)>
						
						<cfset SQL = SQL & 	") VALUES ( ">
											
						<cfloop from="1" to="#ArrayLen(dataProperties)#" index="c">
							<cfset dataProperty = dataProperties[c]>
							
							<cfif Find(dataProperty, modelProperties)>
								
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
					<cfoutput>#SQL#</cfoutput>
					<br />
					<br />
					<br />
					<br />
					<cfquery name="qUser">
					select * from _users
					</cfquery>
					<cfdump var="#qUser#">
					<cfcatch type="any">
						<cfdump var="#cfcatch#">
					</cfcatch>
				</cftry>
			</div>
		</div>
	</section>
	<div class="clear"></div>
</article>
