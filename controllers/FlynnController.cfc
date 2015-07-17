<cfcomponent extends="scaffold.Scaffold" name="FlynnController">
<cfscript>
	_ViewSvc = New services._ViewService();
	_Tron = New services._Tron();
	
	if ( isUserLoggedIn() ) {
		if ( _Tron.GrantViewAccess() IS "false" ) {
			location( APPLICATION.SES_URL & "?message=AUTHORIZATION REJECTED" ,false );
		}	
	}
	
	else {
		location( APPLICATION.SES_URL & "/login" ,false );
	}
					
	public void function DefaultAction() {
		_ViewSvc.GetRequestedView( layout = "bootstrap");
	}

	public void function BuildCRUDAction() {
		
		_ViewSvc.GetRequestedView( layout = "bootstrap");
	}
</cfscript>
</cfcomponent>