<cfscript>

_ViewSvc = New services._ViewService();

public void function _ViewCreateAction() {

	try {
		_View = _ViewSvc.FormCreate_View( form = form );

		location(APPLICATION.SES_URL & "/" & Request.Section & "/_ViewReadForm?ViewId=" & _View.GetViewId(), false);
	}
	catch(Any e) {
		location(APPLICATION.SES_URL & "/" & Request.Section & "?Message=An error occurred while trying to create record.", false);
	}
}

public void function _ViewReadFormAction() {

	param name="url.ViewId" default="0" type="numeric";

	Request._View = EntityLoadByPK( "_View", url.ViewId);

	_ViewSvc.GetRequestedView();
}


public void function _ViewUpdateFormAction() {

	param name="url.ViewId" default="0" type="numeric";

	Request._View = EntityLoadByPK( "_View", url.ViewId);

	_ViewSvc.GetRequestedView();
}

public void function _ViewUpdateAction() {

	try {
		_ViewSvc.FormUpdate_View( form = form );

		location(APPLICATION.SES_URL & "/" & Request.Section & "/_ViewReadForm?ViewId=" & form.ViewId, false);
	}
	catch(Any e) {
		location(APPLICATION.SES_URL & "/" & Request.Section & "?Message=An error occurred while trying to update record.", false);
	}
}

public void function _ViewDeleteFormAction() {

	param name="url.ViewId" default="0" type="numeric";

	Request._View = EntityLoadByPK( "_View", url.ViewId);

	_ViewSvc.GetRequestedView();
}

public void function _ViewDeleteAction() {

	param name="url.ViewId" default="0" type="numeric";

	try {
		_ViewSvc.FormDelete_View( url.ViewId );

		location(APPLICATION.SES_URL & "/" & Request.Section, false);
	}
	catch(Any e) {
		location(APPLICATION.SES_URL & "/" & Request.Section & "?Message=An error occurred while trying to delete record.", false);
	}
}


</cfscript>
