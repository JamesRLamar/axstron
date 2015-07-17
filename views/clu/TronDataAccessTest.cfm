<article class="container12">
		<section>
			<div class="block-border">
				<div class="block-content">
					<cfscript>
					try {
					_Tron = new services._Tron();
					
					writeDump(SESSION);
					
					writeOutput("<h3>ROLE: " & GetuserRoles() & "</h3>");
										
					verified = false;
						
					_MethodArray = EntityLoad("_AccessMethod", {Component = "_Tron", MethodName =  "JsonRead"});
					
					writeOutput("number of methods: " & ArrayLen(_MethodArray));
					
					if ( _Tron.VerifyRemoteToken(SESSION.REMOTE_TOKEN) ) {
						
						writeOutput("<h3>token verified</h3>");
					
						for (i = 1; i LTE ArrayLen(_MethodArray); i++) { 
							
							_Method = _MethodArray[i];
							
							writeDump(_Method);
							
							if ( _Tron.GrantViewAccess(RoleName = "test", Section = "default", View = "default" ) ) {
								
								writeOutput("<h3>Access Granted</h3>");
								
								verified = true;
								break;
							}
							else {
								writeOutput("<h3>Access Denied</h3>");
							}
								
						}	
					}
					writeOutput("<h3>return: " & verified & "</h3>");
					}
					
					catch(Any e) {
						
						writeDump(e);
						
					}
					</cfscript>
				</div>
			</div>
		</section>
		<div class="clear">
	
	</article>
