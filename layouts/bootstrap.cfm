<cfinclude template="../helpers/BootstrapThemeHelper.cfm">
<cfinclude template="includes/bootstrap-head.cfm">
<body>
<div id="pagetop" style="padding:5px;"></div>
<cfinclude template="includes/bootstrap-header.cfm">
<div class="container-fluid">
	<div class="row-fluid">
		<div class="span12">
			<cfloop from="1" to="#StructCount(Request.ViewPath)#" index="v">
				<article>
					<cfinclude template="#Request.ViewPath[v]["path"]#">
				</article>
			</cfloop>
		</div>
	</div>
</div>
<cfif IsDefined("URL.message")>
	<div class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="messageModalLabel" aria-hidden="true" id="messageModal">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
			<h3 id="messageModalLabel">Message</h3>
		</div>
		<div class="modal-body">
			<p><cfoutput>#URL.message#</cfoutput></p>
		</div>
		<div class="modal-footer">
			<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
		</div>
	</div>
	<script type="text/javascript">
	$(document).ready(function(){
		$('#messageModal').modal('show');
	});
	</script>
</cfif>
<cfinclude template="includes/bootstrap-footer.cfm">
</body>
</html>