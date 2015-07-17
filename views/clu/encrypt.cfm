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
					<h3>Decrypt Example</h3>
					
					<!--- Do the following if the form has been submitted. --->
					
					<cfif IsDefined("Form.myString")>
						<cfscript> 

							  /* GenerateSecretKey does not generate keys for the CFMXCOMPAT algorithm, 
						
							  so we use a key from the form. 
						
							  */ 
						
							  if (Form.myAlgorithm EQ "CFMXCOMPAT") 
						
								theKey=Form.MyKey; 
						
							  // For all other encryption techniques, generate a secret key. 
						
							  else 
						
								theKey=generateSecretKey(Form.myAlgorithm); 
						
							  //Encrypt the string. 
						
							  encrypted=encrypt(Form.myString, theKey, Form.myAlgorithm, 
						
								    Form.myEncoding); 
						
							  //Decrypt it. 
						
							  decrypted=decrypt(encrypted, theKey, Form.myAlgorithm, Form.myEncoding); 
						
						    </cfscript>
												
												<!--- Display the values used for encryption and decryption,  
						
								and the results. --->
												
						<cfoutput>
						<b>The algorithm:</b>
						#Form.myAlgorithm#<br>
						<b>The key:</B>
						#theKey#<br>
						<br>
						<b>The string:</b>
						#Form.myString#
						<br>
						<br>
						<b>Encrypted:</b>
						#encrypted#<br>
						<br>
						<b>SHA-1:</b>
						#Hash(encrypted, "SHA-1")#<br>
						<br>
						<b>Decrypted:</b>
						#decrypted#<br>
						</cfoutput>
					</cfif>
					
					<!--- The input form. --->
					
					<form action="#CGI.SCRIPTNAME#" method="post">
						<b>Select the encoding</b><br>
						<select size="1" name="myEncoding" >
							<option selected>UU</option>
							<option>Base64</option>
							<option>Hex</option>
						</select>
						<br>
						<br>
						<b>Select the algorithm</b><br>
						<select size="1" name="myAlgorithm" >
							<option selected>CFMXCOMPAT</option>
							<option>AES</option>
							<option>DES</option>
							<option>DESEDE</option>
						</select>
						<br>
						<br>
						<b>Input your key</b> (used for CFMXCOMPAT encryption only)<br>
						<input type = "Text" name = "myKey" value = "foobar">
						<br>
						<br>
						<b>Enter string to encrypt</b><br>
						<textArea name = "myString" cols = "40" rows = "5" WRAP = "VIRTUAL">This string will be encrypted (you can replace it with more typing). 

    </textArea>
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
