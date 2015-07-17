<cfcomponent hint="I am a User (Protected by Tron)" output="false" persistent="true" >

	<cfproperty name="UserId" hint="User ID" type="numeric" ormtype="int" length="11" fieldtype="id" generator="identity" required="true"/>
	<cfproperty name="UserName" hint="UserName" type="string" length="255"/>
	<cfproperty name="Email" hint="Email" type="string" length="255"/>
	<cfproperty name="Password" hint="Password" type="string" length="255"/>
	<cfproperty name="RoleName" hint="RoleName" type="string"/>
	<cfproperty name="Status" hint="Status" type="string"/>
	<cfproperty name="LastLogin" hint="LastLogin" type="string" />
	
	<cfset _Tron = New services._Tron()>
	
	<cffunction name="init" hint="constructor" access="public" returntype="_User" output="false">
		<cfargument name="UserName" type="string" default="">
		<cfargument name="Email" type="string" default="">
		<cfargument name="Password" type="string" default="">
		<cfargument name="RoleName" type="string" default="">
		<cfargument name="Status" type="string" default="">
		<cfargument name="LastLogin" type="string" default="">
		
		<cfscript>
			This.SetUserName(arguments.UserName);
			This.SetEmail(arguments.Email);
			This.SetPassword(arguments.Password);
			This.SetRoleName(arguments.RoleName);
			This.SetStatus(arguments.Status);
			This.SetLastLogin(arguments.LastLogin);
			return This;
		</cfscript>
	</cffunction>

	<cffunction name="GetEntity" access="public" returntype="_User" output="false">
		<cfargument name="ObjQuery" type="query">
		
		<cfscript>
			This.SetUserId(ObjQuery.UserId);
			This.SetUserName(ObjQuery.UserName);
			This.SetEmail(ObjQuery.Email);
			//This.SetPassword(ObjQuery.Password);
			This.SetRoleName(ObjQuery.RoleName);
			This.SetStatus(ObjQuery.Status);
			This.SetLastLogin(ObjQuery.LastLogin);
			return This;
		</cfscript>
	</cffunction>
	
	<cffunction name="SetPassword" returntype="void">
		<cfargument name="Password" type="string" required="yes">
		<cfset variables.Password = _Tron.HashPassword(arguments.Password)>
	</cffunction>

</cfcomponent>