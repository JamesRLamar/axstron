<article class="container12">
		<section>
			<div class="block-border">
				<div class="block-content">
					<cfscript>

					ORMReload();

					email = "test@email.com";

					password = 01234;

					first = "first";

					last = "last";

					User = New models._user(

							Email = email,
					
							Password = password,
							
							RoleName = "parent",
							
							Status = "Active",
							
							UserName = "#first# #last#"

						);

					EntitySave( User );

					writeDump( User );
								
					</cfscript>
				</div>
			</div>
		</section>
		<div class="clear">
		</div>
	</article>
