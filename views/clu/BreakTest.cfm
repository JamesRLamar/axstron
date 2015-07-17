<article class="container12">
		<section>
			<div class="block-border">
				<div class="block-content">
					<cfscript>					
					public string function test(firstVar = 1, secondVar = 1 , thirdVar = 1) {
						
						var retVal = "<h3>false</h3>";
						
						var retTrue = false;
						
						if ( 1 == firstVar ) {	
							
							retVal = "<h3>firstVar: " & firstVar & "</h3>";
							
							writeOutput(retVal);
							
							retTrue = true;
							
							//return retTrue;
							
							break;
							
						}
						
						else {
										
							for (i = 1; i LTE secondVar; i++) { 
															
								if(retTrue) {
								
									break;	
								}
								
								if ( i == 5 ) {
									
									retVal = "<h3>secondVar: " & i & "</h3>";
									
									writeOutput(retVal);
									
									retTrue = true;
							
									//return retTrue;
									
									break;
									
								}
								
								else {
									
									for (n = 1; n LTE thirdVar; n++) { 
															
										
										
										if ( n == 5 ) {
											
											retVal = "<h3>thirdVar: " & n & "</h3>";
											
											writeOutput(retVal);
											
											retTrue = true;
									
											//return retTrue;
											
											break;
											
										}
										
										else {
											
											retVal = "<h3>thirdVar: false</h3>";
											
											writeOutput(retVal);	
										}										
									}	
								}
								
							}
							
						}
												
						return retTrue;
						
					}
					if( test(2, 4, 5) ) {
						writeOutput("<h3>true</h3>");
					}
					else {
						writeOutput("<h3>false</h3>");	
					}
					</cfscript>
				</div>
			</div>
		</section>
		<div class="clear">
	/div>
	</article>
