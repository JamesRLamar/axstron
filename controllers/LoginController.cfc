<cfcomponent extends="scaffold.Scaffold" name="LoginController">
	
	<cfscript>	
			
	_ViewSvc = New services._ViewService();
			
	_Tron = new services._Tron();

	public void function DefaultAction() {
		
		_ViewSvc.GetRequestedView( layout = "login" );
	}
	
	public void function LogoutAction() {
		
		_Tron.LogoutUser();
		
		location(APPLICATION.SES_URL, false);
	}
	</cfscript>

</cfcomponent>