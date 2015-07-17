<!---USER SECURITY AND AUTHENTICATION--->
	
<cfscript>
public any function AuthenticateUser(
	 string Password
	,string UserName = ""
	,string Email = ""
){
	var hashedPassword = HashPassword(arguments.Password);
	
	var _User = "";
	
	if( arguments.UserName IS NOT "" ){
		_User = EntityLoad("_User", {UserName = arguments.UserName, Password = hashedPassword, Status = "Active"}, true);
	}
	else if ( arguments.Email IS NOT "" ){
		_User = EntityLoad("_User", {Email = arguments.Email, Password = hashedPassword, Status = "Active"}, true);
	}

	if ( NOT IsNull(_User) ) 
		{ return _User; }
}

public string function HashPassword(
	string Password
){
	var hashedPassword = Hash(arguments.Password & APPLICATION.SALT, "SHA");
	return hashedPassword;
}

public string function SetTempPassword(
	string Email
){
	var tempPassword = GenerateRandomPassword();
	var _User = EntityLoad("_User", {Email = arguments.Email}, true);
	_User.SetPassword(tempPassword);
	return tempPassword;
}	
</cfscript>

<cffunction name="LoginUserById" returntype="void">
	<cfargument name="UserId" type="numeric"/>	
	<cfset _User = EntityLoadByPK("_User", arguments.UserId)>
	<cflogin>		
		<cfloginuser name="#_User.GetUserId()#" Password="#_User.GetPassword()#" roles="#_User.GetRoleName()#">
	</cflogin>
	<cfset SESSION.REMOTE_TOKEN = Hash( APPLICATION.SALT & arguments.UserId )>
	<cfset SESSION.USER.USERNAME = _User.GetUserName()>
	<cfset SESSION.USER.EMAIL = _User.GetEmail()>
	<cfset _User.setLastLogin(Now())>
</cffunction>

<cffunction name="LogoutUser" returntype="void">
	<cfset StructClear(SESSION)>
	<cfcookie name="#APPLICATION.COOKIE_NAME#" expires="now"/>
</cffunction>

<cffunction name="EmailTempPassword" returntype="void">
	<cfargument name="Email" type="string" required="yes">
	<cfargument name="Password" type="string" required="yes">
	<cfargument name="SendEmail" type="boolean" required="no" default="false">
	<cfset emailMessage = "<p>A password recovery has been initiated for your account.</p>
		<p>If you did not request this, please disregard this email.</p>
		<p>Please click <a href='" & APPLICATION.SES_URL & "/login'>here</a> and log in with your temporary password listed below.</p>
		<p>Your temporary password: " & Password & "</p>">
	<cfif SendEmail>
		<cfmail from="#APPLICATION.SUPPORT_Email#" to="#arguments.Email#" subject="Password Reset">
		#emailMessage#
		</cfmail>
	<cfelse>
		<cfset emailMessage = emailMessage & "<cfmail from='" & APPLICATION.SUPPORT_Email & "' to='" & arguments.Email & "' subject='" & APPLICATION.TITLE & "'>" & emailMessage & "</cfmail>">
		<cfquery>
			DROP TABLE IF EXISTS temp
		</cfquery>
		<cfquery>
			CREATE TABLE temp (
			  id int(11),
			  data longtext
			)
		</cfquery>
		<cfquery>
			INSERT INTO temp
			(id, data)
			VALUES
			(1, "#emailMessage#")
		</cfquery>
	</cfif>
</cffunction>	

<cffunction name="CreateCookie" returntype="void">
	<cfargument name="UserId" required="yes" type="numeric"/>
	<cfset cookieString = (
		CreateUUID() & ":" &
		arguments.UserId & ":" &
		CreateUUID() ) />

	<!--- ENCRYPT COOKIE --->

	<cfset cookieString = Encrypt(
		cookieString,
		APPLICATION.ENCRYPTION_KEY,
		"cfmx_compat",
		"hex"	) />

	<!--- STORE COOKIE --->

	<cfcookie name="#APPLICATION.COOKIE_NAME#"
		value="#cookieString#"
		expires="never"
		httponly="true" />
</cffunction>

<cffunction name="DecryptCookie" returntype="numeric">
	<cfset StoredUserId = Decrypt(
		COOKIE[APPLICATION.COOKIE_NAME],
		APPLICATION.ENCRYPTION_KEY,
		"cfmx_compat",
		"hex" ) />
	<cfset StoredUserId = ListGetAt(
		StoredUserId,
		2,
		":"	) />
	<cfreturn StoredUserId>
</cffunction>

<cffunction name="GenerateRandomPassword" access="private" returntype="string">
	
	<!--- --------------------------------------------------------------------------------------- ----
	
	Blog Entry:
	Generating Random Passwords In ColdFusion Based On Sets Of Valid Characters
	
	Author:
	Ben Nadel / Kinky Solutions
	
	Link:
	http://www.bennadel.com/index.cfm?event=blog.View&id=488
	
	Date Posted:
	Jan 24, 2007 at 3:25 PM
	
	---- --------------------------------------------------------------------------------------- --->
	
	<cfset strLowerCaseAlpha = "abcdefghijklmnopqrstuvwxyz" />

	<cfset strUpperCaseAlpha = UCase( strLowerCaseAlpha ) />
	 
	<cfset strNumbers = "0123456789" />
	 
	<cfset strOtherChars = "~!@##$%^&*" />
	 
	<cfset strAllValidChars = (
		strLowerCaseAlpha &
		strUpperCaseAlpha &
		strNumbers &
		strOtherChars
		) />

	<cfset arrPassword = ArrayNew( 1 ) />

	<cfset arrPassword[ 1 ] = Mid(	strNumbers,	RandRange( 1, Len( strNumbers ) ),	1	) />

	<cfset arrPassword[ 2 ] = Mid(	strLowerCaseAlpha,	RandRange( 1, Len( strLowerCaseAlpha ) ),	1	) />

	<cfset arrPassword[ 3 ] = Mid(	strUpperCaseAlpha,	RandRange( 1, Len( strUpperCaseAlpha ) ),	1	) />

	<cfloop	index="intChar"	from="#(ArrayLen( arrPassword ) + 1)#" to="8" step="1">
	 
		<cfset arrPassword[ intChar ] = Mid( strAllValidChars,	RandRange( 1, Len( strAllValidChars ) ), 1	) />
	 
	</cfloop>
	
	<cfset CreateObject( "java", "java.util.Collections" ).Shuffle(	arrPassword	) />
	
	<cfset strPassword = ArrayToList(arrPassword,"") />
	
	<cfreturn strPassword>

</cffunction>