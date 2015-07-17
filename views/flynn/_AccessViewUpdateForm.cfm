<div class="bs-docs-example">
<form action="<cfoutput>#APPLICATION.SES_URL#/#Request.Section#/</cfoutput>_AccessViewUpdate" name="update" method="post" class="form-horizontal">
<div class="control-group">
	<label for="Section" class="control-label">Section:</label>
	<div class="controls">
<input type="text" name="Section" id="Section" value="<cfoutput>#Request._AccessView.GetSection()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="View" class="control-label">View:</label>
	<div class="controls">
<input type="text" name="View" id="View" value="<cfoutput>#Request._AccessView.GetView()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="RoleName" class="control-label">Role Name:</label>
	<div class="controls">
<input type="text" name="RoleName" id="RoleName" value="<cfoutput>#Request._AccessView.GetRoleName()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<div class="controls">
	<a href="<cfoutput>#APPLICATION.SES_URL#/#Request.Section#/_AccessViewReadForm?AccessViewId=#Request._AccessView.GetAccessViewId()#</cfoutput>" class="btn btn-primary">Cancel</a>	<input type="submit" name="submit" value="Submit Changes" class="btn btn-warning"/>	</div>
</div>
<input type="hidden" name="AccessViewId" value="<cfoutput>#Request._AccessView.GetAccessViewId()#</cfoutput>" />
</form>
<script>
$().ready(function() {
	$(".form-horizontal").validate();
});
</script>
</div>
