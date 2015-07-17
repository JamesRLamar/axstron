<div class="bs-docs-example">
<form action="<cfoutput>#APPLICATION.SES_URL#/#Request.Section#/</cfoutput>_ViewCreate" name="create" method="post" class="form-horizontal">
<div class="control-group">
	<label for="SectionFolderName" class="control-label">Section Folder Name:</label>
	<div class="controls">
		<input type="text" name="SectionFolderName" id="SectionFolderName"/>
	</div>
</div>
<div class="control-group">
	<label for="DisplayName" class="control-label">Display Name:</label>
	<div class="controls">
		<input type="text" name="DisplayName" id="DisplayName"/>
	</div>
</div>
<div class="control-group">
	<label for="FileName" class="control-label">File Name:</label>
	<div class="controls">
		<input type="text" name="FileName" id="FileName"/>
	</div>
</div>
<div class="control-group">
	<label for="ViewOrder" class="control-label">View Order:</label>
	<div class="controls">
		<input type="text" name="ViewOrder" id="ViewOrder"/>
	</div>
</div>
<div class="control-group">
	<label for="IsPublished" class="control-label">Is Published:</label>
	<div class="controls">
		<input type="text" name="IsPublished" id="IsPublished"/>
	</div>
</div>
<div class="control-group">
	<label for="IsSection" class="control-label">Is Section:</label>
	<div class="controls">
		<input type="text" name="IsSection" id="IsSection"/>
	</div>
</div>
<div class="control-group">
	<label for="Icon" class="control-label">Icon:</label>
	<div class="controls">
		<input type="text" name="Icon" id="Icon"/>
	</div>
</div>
<div class="control-group">
	<label for="Content" class="control-label">Content:</label>
	<div class="controls">
<label for="Content">Content:</label>
<textarea name="Content" id="Content"></textarea>
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
