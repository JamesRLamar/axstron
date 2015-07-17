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
					<h3>Column List</h3>
					<cfform name="List" action="<cfoutput>#CGI.SCRIPTNAME#</cfoutput>" method="get">
					<fieldset class="grey-bg">
						<div>
							Model:
							<input type="text" name="model">
							<br>
							<input type="submit" name="submit" value="submit">
						</div>
					</fieldset>
					</cfform>
					<cfif IsDefined("url.model")>
						
						<cfscript>
						qModel = DbInfo( type = "columns", table = url.model);
						
						qModel.sort(qModel.findColumn("ORDINAL_POSITION"),TRUE);
						
						writeDump( qModel);
						
						com = "models." & url.model;
						
						obj = CreateObject( com );
						
						writeDump( obj);
						</cfscript>
					</cfif>
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
