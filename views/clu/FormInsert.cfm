<cfset _Tron = New services._Tron()>

<cfif IsDefined("form.submit")>
	
	<cfdump var="#form#" label="form">

	<cfset MyFieldArray = ArrayNew(1)>

	<!---LOOP THROUGH SUBMITTED FORM FIELDS--->
	<cfloop collection= "#form#" item="theField" >
		<!---FILTER FIELDS THAT ARE NOT IN TABLE OR ARE NOT SIMPLE--->
		<cfif theField IS NOT "fieldNames" AND theField IS NOT "Submit">

			<!---SET FORM FIELDS AND THEIR VALUES TO AN ARRAY, VALUES ARRAY IS FOR DEVELOPMENT ONLY--->
			<cfset ArrayAppend(MyFieldArray, theField)>
			<!--- <p><cfoutput> #theField# = #form[theField]#</cfoutput></p> --->
		</cfif>
	</cfloop>
	<!---SET FORM FIELD ARRAY TO A LIST FOR CFInsert--->
	<cfset Fields = ArraytoList(MyFieldArray, ",")>
	<!--- <cfdump var="#Fields#" label="Fields"> --->

	<!---Get DbInfo--->
	<cfset qModel = _Tron.DbInfo( type = "columns", table = "temp")>
	<!---Get Primary Key--->
	<cfset primaryKey = _Tron.GetPrimaryKey( qModel )>
	<cftransaction>
		<cfinsert datasource="#APPLICATION.DATASOURCE#" tablename="temp" formfields="#Fields#">
			<cfquery name="qResult">
			Select #primaryKey#
			FROM temp
			ORDER BY #primaryKey# DESC
			LIMIT 1;
		</cfquery>
	</cftransaction>
	
	<cfdump var="#qResult#" label="qResult">
	<h4><cfoutput>DATA returned: #form.data#</cfoutput></h4>
	<h4><cfoutput>PID returned: #qResult[primaryKey][1]#</cfoutput></h4>
	
</cfif>
<br><br>
<div class="bs-docs-example">
	<form action="<cfoutput>#APPLICATION.SES_URL#</cfoutput>/clu/FormInsert" name="create" method="post" class="form">
	<fieldset>
		<div>
			<label for="data">Enter Data Here:</label>
			<input type="text" name="data" id="data"/>
		</div>
	</fieldset>
	<input type="submit" name="submit" value="Submit" class="btn" />
</form>
</div>
