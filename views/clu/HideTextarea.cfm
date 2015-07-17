<div class="bs-docs-example">
<form action="<cfoutput>#APPLICATION.SES_URL#/clu/HideTextarea</cfoutput>" name="create" method="post" class="form-horizontal">
<div class="control-group">
	<label for="Confession" class="control-label">Type away:</label>
	<div class="controls" style="height:150px;">
		<textarea name="Confession" id="Confession" style="height:150px;" class="text-error"></textarea>
	</div>
</div>
<div class="control-group">
	<div class="controls">
	<span id="wipe" class="btn btn-info">Wipe Away...</span>
	</div>
</div>
</form>
<script>

$("#wipe").click( function(){
	$('#Confession').removeClass("text-error").addClass("muted");
	$('#Confession').fadeOut(3000, function() {
		$(this).val("");
	}).fadeIn('slow', function() {
		alert("No records have been kept. Your sins are forgotten. Go and sin no more.");
		$('#Confession').removeClass("muted").addClass("text-error");
	});
});

</script>
</div>
