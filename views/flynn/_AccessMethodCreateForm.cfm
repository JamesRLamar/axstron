<div class="bs-docs-example">
<form action="<cfoutput>#APPLICATION.SES_URL#/#Request.Section#/</cfoutput>_AccessMethodCreate" name="create" method="post" class="form-horizontal">
<div class="control-group">
	<label for="Component" class="control-label">Component:</label>
	<div class="controls">
		<input type="text" name="Component" id="Component"/>
	</div>
</div>
<div class="control-group">
	<label for="MethodName" class="control-label">Method Name:</label>
	<div class="controls">
		<input type="text" name="MethodName" id="MethodName"/>
	</div>
</div>
<div class="control-group">
	<label for="Section" class="control-label">Section:</label>
	<div class="controls">
		<input type="text" name="Section" id="Section"/>
	</div>
</div>
<div class="control-group">
	<label for="View" class="control-label">View:</label>
	<div class="controls">
		<input type="text" name="View" id="View"/>
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
