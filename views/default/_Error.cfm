<div class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="ErrorModalLabel" aria-hidden="true" id="ErrorModal">
	<div class="modal-header">
		<h3 id="ErrorModalLabel">Sorry, an error has occured.</h3>
	</div>
	<div class="modal-body">
		<cfoutput>
			<form class="form" id="error-recovery" method="post" action="#APPLICATION.SES_URL#/default/_SendError">
				<fieldset class="grey-bg no-margin">
					<p>
						<label for="recoveryerror">Please enter a short description of the problem.</label>
						<textarea name="_error" id="_error" class="full-width"></textarea>
					</p>
				</fieldset>
				<input type="submit" name="submit" value="Send" class="btn">
				<input type="hidden" name="ERRORID" value="#url.errorid#">
			</form>
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