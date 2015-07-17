<cfscript>

_AccessViewSvc = New services._AccessViewService();

public void function _AccessViewCreateAction() {

	try {
		_AccessView = _AccessViewSvc.FormCreate_AccessView( form = form );

		location(APPLICATION.SES_URL & "/" & Request.Section & "/_AccessViewReadForm?AccessViewId=" & _AccessView.GetAccessViewId(), false);
	}
	catch(Any e) {
		location(APPLICATION.SES_URL & "/" & Request.Section & "?Message=An error occurred while trying to create record.", false);
	}
}

public void function _AccessViewReadFormAction() {

	param name="url.AccessViewId" default="0" type="numeric";

	Request._AccessView = EntityLoadByPK( "_AccessView", url.AccessViewId);

	_ViewSvc.GetRequestedView();
}


public void function _AccessViewUpdateFormAction() {

	param name="url.AccessViewId" default="0" type="numeric";

	Request._AccessView = EntityLoadByPK( "_AccessView", url.AccessViewId);

	_ViewSvc.GetRequestedView();
}

public void function _AccessViewUpdateAction() {

	try {
		_AccessViewSvc.FormUpdate_AccessView( form = form );

		location(APPLICATION.SES_URL & "/" & Request.Section & "/_AccessViewReadForm?AccessViewId=" & form.AccessViewId, false);
	}
	catch(Any e) {
		location(APPLICATION.SES_URL & "/" & Request.Section & "?Message=An error occurred while trying to update record.", false);
	}
}

public void function _AccessViewDeleteFormAction() {

	param name="url.AccessViewId" default="0" type="numeric";

	Request._AccessView = EntityLoadByPK( "_AccessView", url.AccessViewId);

	_ViewSvc.GetRequestedView();
}

public void function _AccessViewDeleteAction() {

	param name="url.AccessViewId" default="0" type="numeric";

	try {
		_AccessViewSvc.FormDelete_AccessView( url.AccessViewId );

		location(APPLICATION.SES_URL & "/" & Request.Section, false);
	}
	catch(Any e) {
		location(APPLICATION.SES_URL & "/" & Request.Section & "?Message=An error occurred while trying to delete record.", false);
	}
}


</cfscript>
