<article class="container12">
		<section>
			<div class="block-border">
				<div class="block-content">
					<cfscript>
					
					_Users = EntityLoad("_User");
					
					if( NOT IsNull(_Users) ) {
					
						writeOutput("<h3>Number of objects returned " & ArrayLen(_Users) & "</h3>");
						
						
						for (i = 1; i LTE ArrayLen(_Users); i++) { 
							
							_User = _Users[i];
						
							RoleName = _User.GetRoleName();
						
							writeOutput( '<h3>_User["RoleName"][i]: ' & RoleName & '</h3>');							
						}
					
					}
					
					</cfscript>
				</div>
			</div>
		</section>
		<div class="clear">
		</div>
	</article>
