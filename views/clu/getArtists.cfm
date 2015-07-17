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
				<div id="tab-home" class="with-margin" style="height:1000px;">
					<h3>Get CFARTGALLERY</h3>
					<cfset service = new services._Tron()>
					<cfset db = service.DbInfo(datasource = "cfartgallery", type = "columns", table = "artists")>
					<cfdump var="#db#">
					
					<cfset artists = service.SelectJSONP("test","artists","cfartgallery")>
					<cfdump var="#artists#">
					<!---<div id="myGrid"></div>
					<script>
					$(document).ready(function () {
					
						var serviceURL = "http://webbware/services/_Tron.cfc?method=",
					
						dataSource = new kendo.data.DataSource({
					
							transport: {
					
								read:  {
					
									url: serviceURL + "SelectJSONP&model=artists&datasource=cfartgallery",
					
									dataType: "JSONP"
								}
							}
						} );
					
						var grid = $("#myGrid").kendoGrid({
					
							dataSource: dataSource,
					
							scrollable: false,
					
							sortable: true,
					
							pageable: true
						} );
					} );
				
					</script>--->
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
