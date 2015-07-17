<article class="container12">
		<section>
			<div class="block-border">
				<div class="block-content">
					<cfset _Error = New models._error( ERRORNAME = "test" , STACKTRACE = "test" )>
					
					<cfset EntitySave(_Error)>
					
					<cfdump var="#_Error#">
					
					<h3><cfoutput>#_Error.GetErrorId()#</cfoutput></h3>
				</div>
			</div>
		</section>
		<div class="clear">
		</div>
	</article>
