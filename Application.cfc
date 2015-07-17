<cfcomponent
	name="Application"
	output="false"
	hint="I define the application and root-level event handlers.">
	
<cfinclude template="ThisSettings.cfm">

<cffunction
	name="OnApplicationStart"
	access="public"
	returntype="boolean"
	output="false"
	hint="I run when the application boots up. If I return false, the application initialization will hault.">
		
	<cfinclude template="ApplicationSettings.cfm">
	
	<cfreturn true />

</cffunction>

<cffunction
	name="OnSessionStart"
	access="public"
	returntype="void"
	output="false"
	hint="I run when a session boots up.">

	
	<cfset _Tron = new services._Tron()>
	
	<!---CHECK FOR REMEMBER ME COOKIE--->
	
	<cftry>

		<!--- DECRYPT COOKIE --->
		
		<cfset StoredUserId = _Tron.DecryptCookie()>
	
		<cfif IsNumeric( StoredUserId )>
	
			<cfset _Tron.LoginUserById(StoredUserId)>
				
		</cfif>
		
		<cfcatch type="any">
		
		<!---THERE ISN'T A VALID COOKIE--->
				
		</cfcatch>
	
	</cftry>
		
	<cfreturn />

</cffunction>

<cffunction
	name="OnRequestStart"
	access="public"
	returntype="boolean"
	output="false"
	hint="I request authentication and process the view. If I return false, I hault the rest of the view from processing.">

	<cfargument name="request" required="true"/>
	
	<cfset _Tron = New services._Tron()>

	<cfif StructKeyExists( URL, "reinit" )>
		<cfset _Tron.LogoutUser()>
		
		<cfset THIS.OnApplicationStart() />
	
		<cfset THIS.OnSessionStart() />

		<cfset _Tron.InitApplication()>

		<cflocation url="#APPLICATION.SES_URL#" addtoken="no">
	</cfif>

	<cfif StructKeyExists( URL, "reset" )>
			
		<cfset _Tron.LogoutUser()>
		
		<cfset THIS.OnApplicationStart() />
	
		<cfset THIS.OnSessionStart() />

		<cfif THIS.ORMENABLED>
			<cfset ORMReload()/>
		</cfif>
		

		<cflocation url="#APPLICATION.SES_URL#" addtoken="no">

	</cfif>
	
	<!---RECOVERY Password SUBMISSION--->
	
	<cfif IsDefined("form.recovery_email")>
				
		<cfset _User = EntityLoad("_User", {Email = form.recovery_email}, true)>
		
		<cfif NOT IsNull(_User)>
			
			<cfset tempPassword = _Tron.SetTempPassword(_User.GetEmail())>
						
			<cfif APPLICATION.DEVELOPMENT>
			
				<cfset _Tron.EmailTempPassword(_User.GetEmail(), tempPassword, false)>
			
			<cfelse>
			
				<cfset _Tron.EmailTempPassword(_User.GetEmail(), tempPassword, true)>
	
			</cfif>	
		
		</cfif>
	
	<!---LOGIN FORM SUBMISSION--->
	
	<cfelseif IsDefined("form.jusername")>
		
			<cfif form.jusername IS "" OR form.jpassword IS "">
	
				<!---LOGIN DATA IS EMPTY--->
	
				<!---THIS ENFORCES A Password--->
	
				<cfset SESSION.Login_Message = "You must enter an Email and Password.">
	
				<cfset GetLoginForm()>
	
			<cfelse>
	
				<cfset _User = _Tron.AuthenticateUser(Password = form.jpassword, Email = form.jusername)>
	
				<cfif NOT IsNull(_User) AND IsObject(_User)>
					
					<cfset _Tron.LoginUserById(_User.GetUserId())>
					
					<cfif IsDefined("form.rememberUser")>
	
						<cfset _Tron.CreateCookie(_User.GetUserId())>
						
					</cfif>
					
					<cflocation addtoken="no" url="#APPLICATION.SES_URL#/default">
					
				<cfelse>
	
					<!---LOGIN DATA IS NOT VALID--->
	
					<cfset SESSION.Login_Message = "Your login failed. Please try again.">
	
					<cfset GetLoginForm()>
					
				</cfif>
				
			</cfif>

		<cfelse>
	
			<!---NO LOGIN FORM HAS BEEN SUBMITTED YET--->
				
			<cfset GetLoginForm()>
	
		</cfif>

	<cfreturn true />

</cffunction>

<cffunction name="GetLoginForm" returntype="void">

	<cfargument name="reset" required="no" default="false"/>

	<cfinclude template="layouts/includes/bootstrap-head.cfm">

	<body>

	<cfinclude template="layouts/includes/login-header.cfm">
	
	<cfinclude template="views/login/default.cfm">

	<cfinclude template="layouts/includes/login-footer.cfm">

	</body>

	</html>

</cffunction>

<cffunction name="onError">

	<!--- THE ONERROR METHOD GETS TWO arguments: 

            AN EXCEPTION STRUCTURE, WHICH IS IDENTICAL TO A CFCATCH VARIABLE. 

            THE NAME OF THE APPLICATION.CFC METHOD, IF ANY, IN WHICH THE ERROR 

            HAPPENED. --->

	<cfargument name="Exception" required="true"/>

	<cfargument type="String" name="EventName" required="true"/>

	<!--- LOG ALL ERRORS IN AN APPLICATION-SPECIFIC LOG FILE. --->

	<cflog file="#THIS.NAME#" type="error" text="Event Name: #EventName#" >

	<cflog file="#THIS.NAME#" type="error" text="Message: #Exception.message#">

	<!--- SOME EXCEPTIONS, INCLUDING SERVER-SIDE VALIDATION ERRORS, DO NOT 

             GENERATE A ROOTCAUSE STRUCTURE. --->

	<cfif isdefined("Exception.rootcause")>
	
		<cflog file="#This.Name#" type="error" text="Root Cause Message: #Exception.rootcause.message#">
		
	</cfif>
	
	<!--- DISPLAY AN ERROR MESSAGE IF THERE IS A View CONTEXT. --->
	
	<cfsavecontent variable="errorDump">
	
	<cfdump var="#Exception#">
	
	</cfsavecontent>
	
	 <!---<cfset _Error = New models._Error( ErrorName = Exception.message , StackTrace = errorDump )>
	
	<cfset EntitySave(_Error)> --->

	<cfquery result="AddError">
		INSERT INTO _Error
		(ErrorName, StackTrace)
		VALUES
		(<cfqueryparam value="#Exception.message#" cfsqltype="cf_sql_varchar">,
			<cfqueryparam value="#errorDump#" cfsqltype="cf_sql_varchar">)
	</cfquery>
	
	<!---DISPLAY ERROR INFORMATION--->
	<cfif APPLICATION.DEVELOPMENT>
		<cfdump var="#Exception#">
	<cfelse>
		<cflocation addtoken="false" url="#APPLICATION.SES_URL#/default/_error?errorid=#AddError.GENERATED_KEY#">
	</cfif>

</cffunction>
</cfcomponent>
