<cfcomponent hint="I register remote methods and manage access to those methods" output="false" persistent="true">

	<cfproperty name="AccessMethodId" hint="UID" type="numeric" ormtype="int" length="11" fieldtype="id" generator="identity" required="true"/>
	<cfproperty name="Component" hint="Component Name" type="string" />
	<cfproperty name="MethodName" hint="Method Name" type="string" />
	<cfproperty name="Section" hint="Section" type="string" />
	<cfproperty name="View" hint="View" type="string" />
		
	<cfscript>
	public _AccessMethod function init(
		  string Component = ""
		, string MethodName = ""
		, string Section = ""
		, string View = ""
	) {
		
		This.SetComponent(arguments.Component);
		This.SetMethodName(arguments.MethodName);
		This.SetSection(arguments.Section);
		This.SetView(arguments.View);
		
		return This;
	}
	</cfscript> 
</cfcomponent>
