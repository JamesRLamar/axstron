<article class="container12">
		<section>
			<div class="block-border">
				<div class="block-content">
					<cfscript>
					_Tron = New services._Tron();
					
					data = "<h3>null</h3>";
	
					if ( _Tron.GrantViewAccess("Flynn") ) {
					
					data = "<h3>access granted</h3>";
					
					}	
					
					if ( ISUSERLOGGEDIN() ) {
					
					data = "<h3>logged in</h3>";
					
					}
					
					data = _Tron.SelectWhere( model = "_User", name = "UserId", value = "116");
		data = _Tron.QueryToStruct( data );	
					
					writeDump(data);
					</cfscript>
				</div>
			</div>
		</section>
		<div class="clear">
		</div>
	</article>
