<div class="bs-docs-example">
<form action="<cfoutput>#APPLICATION.SES_URL#/#Request.Section#/</cfoutput>_ViewUpdate" name="update" method="post" class="form-horizontal">
<div class="control-group">
	<label for="SectionFolderName" class="control-label">Section Folder Name:</label>
	<div class="controls">
<input type="text" name="SectionFolderName" id="SectionFolderName" value="<cfoutput>#Request._View.GetSectionFolderName()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="DisplayName" class="control-label">Display Name:</label>
	<div class="controls">
<input type="text" name="DisplayName" id="DisplayName" value="<cfoutput>#Request._View.GetDisplayName()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="FileName" class="control-label">File Name:</label>
	<div class="controls">
<input type="text" name="FileName" id="FileName" value="<cfoutput>#Request._View.GetFileName()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="ViewOrder" class="control-label">View Order:</label>
	<div class="controls">
<input type="text" name="ViewOrder" id="ViewOrder" value="<cfoutput>#Request._View.GetViewOrder()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="IsPublished" class="control-label">Is Published:</label>
	<div class="controls">
<input type="text" name="IsPublished" id="IsPublished" value="<cfoutput>#Request._View.GetIsPublished()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="IsSection" class="control-label">Is Section:</label>
	<div class="controls">
<input type="text" name="IsSection" id="IsSection" value="<cfoutput>#Request._View.GetIsSection()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="Icon" class="control-label">Icon:</label>
	<div class="controls">
<input type="text" name="Icon" id="Icon" value="<cfoutput>#Request._View.GetIcon()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="Content" class="control-label">Content:</label>
	<div class="controls">
<label for="Content">Content:</label>
<textarea name="Content" id="Content"><cfoutput>#Request._View.GetContent()#</cfoutput></textarea>
	</div>
</div>
<div class="control-group">
	<div class="controls">
	<a href="<cfoutput>#APPLICATION.SES_URL#/#Request.Section#/_ViewReadForm?ViewId=#Request._View.GetViewId()#</cfoutput>" class="btn btn-primary">Cancel</a>	<input type="submit" name="submit" value="Submit Changes" class="btn btn-warning"/>	</div>
</div>
<input type="hidden" name="ViewId" value="<cfoutput>#Request._View.GetViewId()#</cfoutput>" />
</form>
<script>
$().ready(function() {
	$(".form-horizontal").validate();
});
</script>
</div>
