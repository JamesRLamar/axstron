<div class="bs-docs-example">
<form action="" name="read" method="" class="form-horizontal">
<div class="control-group">
	<label for="Section" class="control-label">Section:</label>
	<div class="controls">
<input disabled type="text" name="Section" id="Section" value="<cfoutput>#Request._AccessView.GetSection()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="View" class="control-label">View:</label>
	<div class="controls">
<input disabled type="text" name="View" id="View" value="<cfoutput>#Request._AccessView.GetView()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="RoleName" class="control-label">Role Name:</label>
	<div class="controls">
<input disabled type="text" name="RoleName" id="RoleName" value="<cfoutput>#Request._AccessView.GetRoleName()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<div class="controls">
	<a href="<cfoutput>#APPLICATION.SES_URL#/#Request.Section#/_AccessViewUpdateForm?AccessViewId=#Request._AccessView.GetAccessViewId()#</cfoutput>" class="btn btn-primary">Update</a>	<a href="#Delete" role="button" class="btn btn-warning" data-toggle="modal">Delete</a>	</div>
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
    <a href="<cfoutput>#APPLICATION.SES_URL#/#Request.Section#/_AccessViewDelete?AccessViewId=#Request._AccessView.GetAccessViewId()#</cfoutput>" class="btn btn-warning">Confirm Delete</a>
  </div>
</div>
</div>
