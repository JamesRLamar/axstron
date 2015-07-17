<cfcomponent hint="I am an Error Log" output="false" persistent="true" >
	
	<cfproperty name="ErrorId" hint="Error Id" type="numeric" ormtype="int" length="11" fieldtype="id" generator="identity" required="true"/>
	<cfproperty name="ErrorName" hint="Error Name" type="string" ormtype="text" />
	<cfproperty name="StackTrace" hint="Full Error Description" type="string" ormtype="text" />
	<cfproperty name="ErrorDate" hint="Error Date" type="string" />
	
	<cffunction name="init" hint="constructor" access="public" returntype="_Error" output="false">
		<cfargument name="ErrorName" type="any" required="true">
		<cfargument name="StackTrace" type="any" required="true">
		<cfscript>
			This.setErrorName(arguments.ErrorName);
			This.setStackTrace(arguments.StackTrace);
			This.setErrorDate(Now());
			return(This);
		</cfscript>
	</cffunction>
</cfcomponent>
