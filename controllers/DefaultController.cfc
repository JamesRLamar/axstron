<cfcomponent extends="scaffold.Scaffold" name="DefaultController">
	<cfscript>
		_Tron = New services._Tron();
		_ViewSvc = New services._ViewService();

		if (APPLICATION.IS_PROTECTED) {
			if ( _Tron.GrantViewAccess(Section = Request.Section, View = Request.View) == "false" ) {
				location( APPLICATION.SES_URL & "?message=AUTHORIZATION REJECTED" ,false );
			}
		}

		public void function DefaultAction() {

			_ViewSvc.GetRequestedView( layout = "bootstrap");
		}
	
		public void function _ErrorAction() {
			
			_ViewSvc.GetRequestedView( layout = "error");
		}

		public void function _SendErrorAction() {
			
			_ViewSvc.GetRequestedView( layout = "error");
		}
	
		public void function _ErrorDevAction() {
			
			_ViewSvc.GetRequestedView( layout = "error");
		}
		
		public void function _ErrorReviewAction() {
			
			if ( isUserLoggedIn() ) {
		
				if ( NOT _Tron.GrantViewAccess() ) {
					
					location( APPLICATION.SES_URL 
						
						& "?message=AUTHORIZATION REJECTED" ,false );
				}	
			}
			
			else {
				
				location( APPLICATION.SES_URL 
						& "/login" ,false );
			}
			
			_ViewSvc.GetRequestedView( layout = "bootstrap");
		}

		public void function _UserAccountFormAction() {

			Request._User = EntityLoadByPK( "_User", getAuthUser());

			_ViewSvc.GetRequestedView();
		}

		public void function _UserAccountUpdateAction() {

			_UserSvc = New services._UserService()._UserAccountUpdate( form = form );

			location(APPLICATION.SES_URL & "/Default/_UserAccountForm?Message=Update successful!", false);
		}
	</cfscript>

</cfcomponent>