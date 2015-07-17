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
					
					<!--- Do the following if the form is submitted. --->
					<cfif IsDefined("Form.UserID")>
						
						<!--- query the data base. --->
						<cfquery name = "CheckPerson" datasource = "cfdocexamples"> 
						Select PasswordHash 
						FROM SecureData 
						Where UserID = <cfqueryparam value = "#Form.userID#" cfsqltype = 'cf_sql_varchar'>  
						</cfquery>
						
						<!--- Compare query PasswordHash field and the hashed form password 
            and display the results. --->
						<cfoutput>
						<cfif Hash(Form.password, "SHA") is not checkperson.passwordHash>
							User ID #Form.userID# or password is not valid. Try again.
							<cfelse>
							Password is valid for User ID #Form.userID#.
							
						</cfif>
						</cfoutput>
					</cfif>
					
					<!--- Form for entering ID and password. --->
					<form action="#CGI.SCRIPTNAME#" method="post">
						<b>User ID: </b>
						<input type = "text" name="UserID" >
						<br>
						<b>Password: </b>
						<input type = "text" name="password" >
						<br>
						<br>
						<input type = "Submit" value = "Encrypt my String">
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
