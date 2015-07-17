<div class="bs-docs-example">
<form action="<cfoutput>#APPLICATION.SES_URL#/#Request.Section#/</cfoutput>_UserUpdate" name="update" method="post" class="form-horizontal">
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
<input type="text" name="Password" id="Password" value="<cfoutput>#Request._User.GetPassword()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="RoleName" class="control-label">Role Name:</label>
	<div class="controls">
<input type="text" name="RoleName" id="RoleName" value="<cfoutput>#Request._User.GetRoleName()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="Status" class="control-label">Status:</label>
	<div class="controls">
<input type="text" name="Status" id="Status" value="<cfoutput>#Request._User.GetStatus()#</cfoutput>"/>
	</div>
</div>
<!--- <div class="control-group">
	<label for="LastLogin" class="control-label">Last Login:</label>
	<div class="controls">
<input type="text" name="LastLogin" id="LastLogin" value="<cfoutput>#Request._User.GetLastLogin()#</cfoutput>"/>
	</div>
</div> --->
<div class="control-group">
	<div class="controls">
	<a href="<cfoutput>#APPLICATION.SES_URL#/#Request.Section#/_UserReadForm?UserId=#Request._User.GetUserId()#</cfoutput>" class="btn btn-primary">Cancel</a>	<input type="submit" name="submit" value="Submit Changes" class="btn btn-warning"/>	</div>
</div>
<input type="hidden" name="UserId" value="<cfoutput>#Request._User.GetUserId()#</cfoutput>" />
</form>
<script>
$().ready(function() {
	$(".form-horizontal").validate();
});
</script>
</div>
