<div class="bs-docs-example">
<form action="<cfoutput>#APPLICATION.SES_URL#/#Request.Section#/</cfoutput>_UserCreate" name="create" method="post" class="form-horizontal">
<div class="control-group">
	<label for="UserName" class="control-label">User Name:</label>
	<div class="controls">
		<input type="text" name="UserName" id="UserName"/>
	</div>
</div>
<div class="control-group">
	<label for="Email" class="control-label">Email:</label>
	<div class="controls">
		<input type="text" name="Email" id="Email"/>
	</div>
</div>
<div class="control-group">
	<label for="Password" class="control-label">Password:</label>
	<div class="controls">
		<input type="text" name="Password" id="Password"/>
	</div>
</div>
<div class="control-group">
	<label for="RoleName" class="control-label">Role Name:</label>
	<div class="controls">
		<input type="text" name="RoleName" id="RoleName"/>
	</div>
</div>
<div class="control-group">
	<label for="Status" class="control-label">Status:</label>
	<div class="controls">
		<input type="text" name="Status" id="Status"/>
	</div>
</div>
<div class="control-group">
	<label for="LastLogin" class="control-label">Last Login:</label>
	<div class="controls">
		<input type="text" name="LastLogin" id="LastLogin"/>
	</div>
</div>
<div class="control-group">
	<div class="controls">
	<input type="submit" name="submit" value="Submit" class="btn btn-primary" />
	</div>
</div>
</form>
<script>
$().ready(function() {
	$(".form-horizontal").validate();
});
</script>
</div>
