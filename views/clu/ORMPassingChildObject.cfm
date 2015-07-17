<article class="container12">
		<section>
			<div class="block-border">
				<div class="block-content">
					<cfscript>
					
					import models.*;

					ORMReload();

					User = EntityLoad("_user", 116, true);

					//writeDump( User );
					
					//Person = New models.person();
//					
//					Person.SetUser(User);
//					
//					Person.SetFirstName("James");
//					
//					Person.SetLastName("Lamar");
//
//					EntitySave( Person );
//
//					writeDump( Person );
					
					newPerson = new person(User);
					
					writeDump(newPerson);
					
					//newPerson.setUser(User);
					
					newPerson = EntityLoad("person", { User = User }, true);
					
					writeDump(newPerson);
					
								
					</cfscript>
				</div>
			</div>
		</section>
		<div class="clear">
		</div>
	</article>
