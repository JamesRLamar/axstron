<div class="bs-docs-example">
	<cfif IsDefined("url.message")>
		<script>
			$( document ).ready(function() {
				$('#alert').hide().show('slow');
			});
		</script>
		<div class="alert alert-success" id="alert"><button type="button" class="close" data-dismiss="alert">&times;</button><cfoutput>#url.message#</cfoutput></div>
	</cfif>
	<form id="UserForm" action="<cfoutput>#APPLICATION.SES_URL#</cfoutput>/Default/_UserAccountUpdate" name="update" method="post" class="form-horizontal">
	<div class="control-group">
		<label for="UserName" class="control-label">User Name:</label>
		<div class="controls">
			<input type="text" name="UserName" id="UserName" value="<cfoutput>#Request._User.GetUserName()#</cfoutput>"/>
		</div>
	</div>
	<div class="control-group">
		<label for="Email" class="control-label">Email:</label>
		<div class="controls">
			<input type="text" name="Email" id="Email" value="<cfoutput>#Request._User.GetEmail()#</cfoutput>"/>
		</div>
	</div>
	<div class="control-group">
		<label for="Password" class="control-label">Password:</label>
		<div class="controls">
			<input type="password" name="Password" id="Password" value=""/>
		</div>
	</div>
	<div class="control-group">
		<label for="ConfirmPassword" class="control-label">Confirm Password:</label>
		<div class="controls">
			<input type="password" name="ConfirmPassword" id="ConfirmPassword" value=""/>
		</div>
	</div>
	<div class="control-group">
		<div class="controls">
			<input type="submit" name="submit" value="Submit Changes" class="btn btn-warning"/>	</div>
		</div>
	</form>
</div>
<script type="text/javascript">
$('#UserForm').submit(function() {
	var password = $('#Password').val();
	var confirmPassword = $('#ConfirmPassword').val();
	if(password != confirmPassword) {
		alert("Passwords must match.");
		$('#Password').val("");
		$('#ConfirmPassword').val("");
		return false;
	}
});
</script>
