<article class="container12">
	<section class="grid12">
		<div class="block-border">
			<div class="block-content">
				<div class="h1">
					<cfoutput>
					#NavigationBlockHeading()#
					</cfoutput>
				</div>
				<div class="block-controls">
					<ul class="controls-tabs js-tabs same-height with-children-tip">
						<li>
							<a href="#tab-home" title="Home">
							<img src="<cfoutput>#APPLICATION.ASSET_PATH#</cfoutput>/images/icons/web-app/24/Bar-Chart.png" width="24" height="24">
							</a>
						</li>
					</ul>
				</div>
				<div id="tab-home" class="with-margin" style="height:auto;">
					<h3>Hash Example</h3>
					<cffunction name="requestKPSHash" access="public" returntype="String">
						<cfargument name="key" type="string" />
						<cfargument name="pin" type="string" />
						<cfargument name="salt" type="string" />
						<cfargument name="algorithm" type="string" required="false" default="SHA-1" />
						<cfscript>
						var hashed = '';
						hashed = hash( key & salt & pin, arguments.algorithm, 'UTF-8' );
						return hashed;
						</cfscript>
					</cffunction>
					<cfif IsDefined("Form.KEY")>
						<p>SALT:
							<cfoutput>#form.SALT#</cfoutput>
						</p>
						<p>PIN:
							<cfoutput>#form.PIN#</cfoutput>
						</p>
						<p>KEY:
							<cfoutput>#form.KEY#</cfoutput>
						</p>
						<p>HASHED TO DEATH:
							<cfoutput>#requestKPSHash(form.KEY, form.PIN, form.SALT, "SHA-1")#</cfoutput>
						</p>
					</cfif>
					
					<!--- Form for entering ID and password. --->
					<form action="#CGI.SCRIPTNAME#" method="post">
						<b>SALT: </b>
						<input type="text" name="SALT" >
						<br>
						<b>PIN: </b>
						<input type="text" name="PIN" >
						<br>
						<b>KEY: </b>
						<input type="text" name="KEY" >
						<br>
						<br>
						<input type="Submit" value="Hash it up!">
					</form>
				</div>
				<ul class="message no-margin">
					<li>
						This information is current as of
						<cfoutput>
						<b>#DateFormat(Now(), "Full")#</b>
						</cfoutput>
					</li>
				</ul>
			</div>
		</div>
	</section>
	<div class="clear">
	</div>
</article>
