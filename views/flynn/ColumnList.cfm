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
					<cfform name="List" action="#CGI.SCRIPTNAME#/superadmin/columnList" method="get">
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
						<cfset modelInfo = DbInfo( type = "columns", table = url.model)>
						<cfset modelColList = ArrayToList(PropertiesArray(modelInfo))>
						<p>
							<cfoutput>#modelColList#</cfoutput>
						</p>
						<cfset columnArray = PropertiesArray(modelInfo)>
						<cfloop from="1" to="#ArrayLen(columnArray)#" index="i">
							<cfoutput>#columnArray[i]#</cfoutput>,<br>
						</cfloop>
						<cfscript>
						qModel = DbInfo( type = "columns", table = url.model);
						
						qModel.sort(qModel.findColumn("ORDINAL_POSITION"),TRUE);
						
						numericDataTypes = "INT,TINYINT,DOUBLE,INTEGER";

						stringDataTypes = "VARCHAR";
						
						textDataTypes = "LONGTEXT,TEXT";
					
						booleanDataTypes = "BIT,SMALLINT";
						
						for (col = 1; col LTE qModel.RecordCount; col++) {
							
							isRequired = "true";
							
							if ( qModel["IS_NULLABLE"][col] ) {
								
								isRequired = "false";
							}
			
							if (qModel["IS_PRIMARYKEY"][col]) {
								
								writeOutput( XMLFormat('<cfproperty name="' & Ucase(qModel["COLUMN_NAME"][col]) & '" hint="' & Ucase(qModel["COLUMN_NAME"][col]) & '" type="numeric" ormtype="int" length="11" fieldtype="id" generator="identity" required="true"/>'));
							}
							
							else {
								
								if ( Find( qModel["TYPE_NAME"][col], numericDataTypes ) ) {
													
									writeOutput( XMLFormat('<cfproperty name="' & Ucase(qModel["COLUMN_NAME"][col]) & '" hint="' & Ucase(qModel["COLUMN_NAME"][col]) & '" type="numeric" ormtype="int" required="' & isRequired & '"/>')); 
								}
								
								else if ( Find( qModel["TYPE_NAME"][col], stringDataTypes ) ) {
													
									writeOutput( XMLFormat('<cfproperty name="' & Ucase(qModel["COLUMN_NAME"][col]) & '" hint="' & Ucase(qModel["COLUMN_NAME"][col]) & '" type="string" ormtype="string" required="' & isRequired & '"/>')); 
								}
								
								else if ( Find( qModel["TYPE_NAME"][col], textDataTypes ) ) {
													
									writeOutput( XMLFormat('<cfproperty name="' & Ucase(qModel["COLUMN_NAME"][col]) & '" hint="' & Ucase(qModel["COLUMN_NAME"][col]) & '" type="string" ormtype="text" required="' & isRequired & '"/>')); 
								}
								
								else if ( Find( qModel["TYPE_NAME"][col], booleanDataTypes ) ) {
													
									writeOutput( XMLFormat('<cfproperty name="' & Ucase(qModel["COLUMN_NAME"][col]) & '" hint="' & Ucase(qModel["COLUMN_NAME"][col]) & '" type="boolean" ormtype="boolean" required="' & isRequired & '"/>')); 
								}
							}
							writeOutput('<br>');
						} 
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
