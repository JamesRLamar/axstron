<div class="bs-docs-example">
<form action="" name="read" method="" class="form-horizontal">
<div class="control-group">
	<label for="UserName" class="control-label">User Name:</label>
	<div class="controls">
<input disabled type="text" name="UserName" id="UserName" value="<cfoutput>#Request._User.GetUserName()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="Email" class="control-label">Email:</label>
	<div class="controls">
<input disabled type="text" name="Email" id="Email" value="<cfoutput>#Request._User.GetEmail()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="Password" class="control-label">Password:</label>
	<div class="controls">
<input disabled type="text" name="Password" id="Password" value="<cfoutput>#Request._User.GetPassword()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="RoleName" class="control-label">Role Name:</label>
	<div class="controls">
<input disabled type="text" name="RoleName" id="RoleName" value="<cfoutput>#Request._User.GetRoleName()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="Status" class="control-label">Status:</label>
	<div class="controls">
<input disabled type="text" name="Status" id="Status" value="<cfoutput>#Request._User.GetStatus()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="LastLogin" class="control-label">Last Login:</label>
	<div class="controls">
<input disabled type="text" name="LastLogin" id="LastLogin" value="<cfoutput>#Request._User.GetLastLogin()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<div class="controls">
	<a href="<cfoutput>#APPLICATION.SES_URL#/#Request.Section#/_UserUpdateForm?UserId=#Request._User.GetUserId()#</cfoutput>" class="btn btn-primary">Update</a>	<a href="#Delete" role="button" class="btn btn-warning" data-toggle="modal">Delete</a>	</div>
</div>
</form>
<div id="Delete" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
    <h3 id="myModalLabel">Delete Record</h3>
  </div>
  <div class="modal-body">
    <p>Are you sure you want to delete this record?</p>
  </div>
  <div class="modal-footer">
    <button class="btn btn-primary" data-dismiss="modal" aria-hidden="true">Cancel</button>
    <a href="<cfoutput>#APPLICATION.SES_URL#/#Request.Section#/_UserDelete?UserId=#Request._User.GetUserId()#</cfoutput>" class="btn btn-warning">Confirm Delete</a>
  </div>
</div>
</div>
