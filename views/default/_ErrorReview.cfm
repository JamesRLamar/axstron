<cfquery name="qError">

SELECT * FROM _error

Where ERRORID = <cfqueryparam value="#url.ERRORID#" cfsqltype="cf_sql_integer">

</cfquery>
<div class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="ErrorModalLabel" aria-hidden="true" id="ErrorModal">
	<div class="modal-header">
		<h3 id="ErrorModalLabel">REVIEW ERROR</h3>
	</div>
	<div class="modal-body">
		<cfoutput>
			<p>#qError.ERRORNAME#</p>
									
			<p>#qError.STACKTRACE#</p>
		</cfoutput>
	</div>
	<div class="modal-footer">
	</div>
</div>
<script type="text/javascript">
$(document).ready(function(){
	$('#ErrorModal').modal('show');
});
</script>
