<fieldset class="grey-bg no-margin">

<cfquery name="qError">

SELECT * FROM _error

Where ERRORID = <cfqueryparam value="#url.errorid#" cfsqltype="cf_sql_integer">

</cfquery>

<cfoutput>

<p><label for="recoveryerror">#qError.ERRORNAME#</label></p>
						
<p>Message:<br>#qError.STACKTRACE#</p>

</cfoutput>

</fieldset>