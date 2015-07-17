<div class="bs-docs-example">
<form action="<cfoutput>#APPLICATION.SES_URL#/#Request.Section#/</cfoutput>_AccessMethodUpdate" name="update" method="post" class="form-horizontal">
<div class="control-group">
	<label for="Component" class="control-label">Component:</label>
	<div class="controls">
<input type="text" name="Component" id="Component" value="<cfoutput>#Request._AccessMethod.GetComponent()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="MethodName" class="control-label">Method Name:</label>
	<div class="controls">
<input type="text" name="MethodName" id="MethodName" value="<cfoutput>#Request._AccessMethod.GetMethodName()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="Section" class="control-label">Section:</label>
	<div class="controls">
<input type="text" name="Section" id="Section" value="<cfoutput>#Request._AccessMethod.GetSection()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="View" class="control-label">View:</label>
	<div class="controls">
<input type="text" name="View" id="View" value="<cfoutput>#Request._AccessMethod.GetView()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<div class="controls">
	<a href="<cfoutput>#APPLICATION.SES_URL#/#Request.Section#/_AccessMethodReadForm?AccessMethodId=#Request._AccessMethod.GetAccessMethodId()#</cfoutput>" class="btn btn-primary">Cancel</a>	<input type="submit" name="submit" value="Submit Changes" class="btn btn-warning"/>	</div>
</div>
<input type="hidden" name="AccessMethodId" value="<cfoutput>#Request._AccessMethod.GetAccessMethodId()#</cfoutput>" />
</form>
<script>
$().ready(function() {
	$(".form-horizontal").validate();
});
</script>
</div>
