<div class="bs-docs-example">
<form action="" name="read" method="" class="form-horizontal">
<div class="control-group">
	<label for="SectionFolderName" class="control-label">Section Folder Name:</label>
	<div class="controls">
<input disabled type="text" name="SectionFolderName" id="SectionFolderName" value="<cfoutput>#Request._View.GetSectionFolderName()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="DisplayName" class="control-label">Display Name:</label>
	<div class="controls">
<input disabled type="text" name="DisplayName" id="DisplayName" value="<cfoutput>#Request._View.GetDisplayName()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="FileName" class="control-label">File Name:</label>
	<div class="controls">
<input disabled type="text" name="FileName" id="FileName" value="<cfoutput>#Request._View.GetFileName()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="ViewOrder" class="control-label">View Order:</label>
	<div class="controls">
<input disabled type="text" name="ViewOrder" id="ViewOrder" value="<cfoutput>#Request._View.GetViewOrder()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="IsPublished" class="control-label">Is Published:</label>
	<div class="controls">
<input disabled type="text" name="IsPublished" id="IsPublished" value="<cfoutput>#Request._View.GetIsPublished()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="IsSection" class="control-label">Is Section:</label>
	<div class="controls">
<input disabled type="text" name="IsSection" id="IsSection" value="<cfoutput>#Request._View.GetIsSection()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="Icon" class="control-label">Icon:</label>
	<div class="controls">
<input disabled type="text" name="Icon" id="Icon" value="<cfoutput>#Request._View.GetIcon()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="Content" class="control-label">Content:</label>
	<div class="controls">
<label for="Content">Content:</label>
<textarea disabled name="Content" id="Content"><cfoutput>#Request._View.GetContent()#</cfoutput></textarea>
	</div>
</div>
<div class="control-group">
	<div class="controls">
	<a href="<cfoutput>#APPLICATION.SES_URL#/#Request.Section#/_ViewUpdateForm?ViewId=#Request._View.GetViewId()#</cfoutput>" class="btn btn-primary">Update</a>	<a href="#Delete" role="button" class="btn btn-warning" data-toggle="modal">Delete</a>	</div>
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
    <a href="<cfoutput>#APPLICATION.SES_URL#/#Request.Section#/_ViewDelete?ViewId=#Request._View.GetViewId()#</cfoutput>" class="btn btn-warning">Confirm Delete</a>
  </div>
</div>
</div>
