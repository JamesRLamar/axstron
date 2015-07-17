<article class="container12">
	<section>
		<div class="block-border">
			<div class="block-content">
			
				<cfquery name="qUser">
				select * from _user where userid = 116
				</cfquery>
				<cfdump var="#qUser.ColumnList#">
				<cfdump var="#qUser#">
				<cfscript>
		
				_User = EntityLoadByPK("_User", 116);
								
				writeDump(_User);
				
				data = serializeJSON(_User, true);
				
				writeDump(data);
				
				data = DeserializeJSON(data, true);
				
				writeDump(data);
				
				</cfscript>
			</div>
		</div>
	</section>
	<div class="clear"></div>
</article>
