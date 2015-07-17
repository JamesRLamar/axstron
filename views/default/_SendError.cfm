<cfquery name="qError">
SELECT * FROM _error
Where ERRORID = <cfqueryparam value="#form.ERRORID#" cfsqltype="cf_sql_integer">
</cfquery>

<cfmail 
	to="#APPLICATION.SUPPORT_EMAIL#"
	from="#APPLICATION.SUPPORT_EMAIL#"
	subject="Bug Report - ERROR: #form.ERRORID#" type="html">
	<cfoutput>
	<h1>NAME: #qError.ERRORNAME#</h1>
	<p><a href="#APPLICATION.SES_URL#/default/_errorreview?ERRORID=#form.ERRORID#" target="blank">View Report</a></p>
	</cfoutput>
</cfmail>

<div class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="ErrorModalLabel" aria-hidden="true" id="ErrorModal">
	<div class="modal-header">
		<h3 id="ErrorModalLabel">Thank you! A report was sent.</h3>
	</div>
	<div class="modal-body">
		<p><a href="<cfoutput>#APPLICATION.SES_URL#</cfoutput>">Go Home</a></p>
			<cfmail 
				to="#APPLICATION.SUPPORT_Email#"
				from="#APPLICATION.SUPPORT_Email#"
				subject="Bug Report - ERROR: #form.ERRORID# (USER)" type="html">
				<cfoutput>
					<h1>ERROR ##: #form.ERRORID#</h1>
					#form._error#</cfoutput>
			</cfmail>
	</div>
	<div class="modal-footer">
	</div>
</div>
<script type="text/javascript">
$(document).ready(function(){
	$('#ErrorModal').modal('show');
});
</script>