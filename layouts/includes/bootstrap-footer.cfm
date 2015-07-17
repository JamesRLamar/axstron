<cfoutput>
	<footer>
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="navbar">
					<div class="navbar-inner">
						<cfoutput><a class="brand" href="#APPLICATION.SES_URL#">#APPLICATION.TITLE#</a></cfoutput>
						<ul class="nav">
							<li><a href="mailto:#APPLICATION.SUPPORT_EMAIL#">Support</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</footer>
</cfoutput>