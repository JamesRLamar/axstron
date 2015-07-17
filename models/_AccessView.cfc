<cfcomponent hint="I manage access to views" output="false" persistent="true" >

	<cfproperty name="AccessViewId" hint="UID" type="numeric" ormtype="int" length="11" fieldtype="id" generator="identity" required="true"/>
	<cfproperty name="Section" hint="Section Private Name" type="string" />
	<cfproperty name="View" hint="View Private Name" type="string" />
	<cfproperty name="RoleName" hint="Role Name" type="string" />

	<cfscript>
	public _AccessView function init(
		  string Section = ""
		, string View = ""
		, string RoleName = ""

	) output="false" {
		
		This.setSection(arguments.Section);
		This.setView(arguments.View);
		This.setRoleName(arguments.RoleName);
		
		return This;
	}
	</cfscript> 
 
</cfcomponent>
