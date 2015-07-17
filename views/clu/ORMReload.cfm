<article class="container12">
	<section>
		<div class="block-border">
		<div class="block-content">
			<cfscript>

			methods = EntityLoad("_user");
			
			/* method = new models._Method("_Tron", "JsonRead", "ALL", "ALL");
			
			EntitySave(method); */
			
			writeDump(methods);
			
			/* writeOutput(ArrayLen(methods)); */

			ObjArray=  arrayNew(1);

			obj = New models._User(UserId=1, UserName="test");

			ObjArray[1] = obj;

			writeDump(ObjArray);
			
			</cfscript>
		</div>
	</section>
	<div class="clear"></div>
</article>
