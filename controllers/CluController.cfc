<cfcomponent extends="scaffold.Scaffold" name="CluController">
	
	<cfscript>	
			
		_ViewSvc = New services._ViewService();
				
		param name="url.ErrorId" default="0";

		public void function _UserReadFormAction() {

			param name="url.UserId" default="116" type="numeric";

			Request._User = EntityLoadByPK( "_User", url.UserId);

			_ViewSvc.GetRequestedView();
		}
							
		public void function DefaultAction() {

			/* var ViewStruct = {};

			ViewStruct[1]["Section"] = "clu";
			ViewStruct[1]["View"] = "default";

			if ( Request.View != "default"
			){
				ViewStruct[2]["Section"] = Request.Section;
				ViewStruct[2]["View"] = Request.View;
			}
			
			_ViewSvc.GetRequestedView( Layout = "bootstrap", ViewStruct = ViewStruct); */

			_ViewSvc.GetRequestedView( Layout = "bootstrap");
			
		}

		public void function TestAction() {

			_ViewSvc.GetRequestedView( Layout = "bootstrap");
		}
	
	</cfscript>

</cfcomponent>