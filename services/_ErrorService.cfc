<cfcomponent hint="I am an Error" output="false">
	
	<cfscript>
	public void function GetErrorMessage( required error, string errorName = "" ) {
	
		writeOutput( "<h3>ERROR LOADING <b>" & arguments.errorName & "</b></h3>" );
		
		writeOutput( "Type: " & arguments.error.type & "<br/>" );
		
		writeOutput( "Message: " & arguments.error.message & "<br/>" );
		
		writeOutput( "Detail: " & arguments.error.detail & "<br/>" );
		
		writeOutput( "ExtendedInfo: " & arguments.error.ExtendedInfo & "<br/>" );
		
		writedump( arguments.error );
	}	
	</cfscript>
</cfcomponent>
