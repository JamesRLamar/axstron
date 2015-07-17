<cfif loginError NEQ 0>
	<cfoutput>
	<script>
	$(document).ready(function()
	{
		var #toScript(loginError, "loginError")#;
		$('##login-block').removeBlockMessages().blockMessage(loginError, {type: 'error'});
	});
	</script>
	</cfoutput>
</cfif>