<cfscript>

_AccessMethodSvc = New services._AccessMethodService();

public void function _AccessMethodCreateAction() {

	try {
		_AccessMethod = _AccessMethodSvc.FormCreate_AccessMethod( form = form );

		location(APPLICATION.SES_URL & "/" & Request.Section & "/_AccessMethodReadForm?AccessMethodId=" & _AccessMethod.GetAccessMethodId(), false);
	}
	catch(Any e) {
		location(APPLICATION.SES_URL & "/" & Request.Section & "?Message=An error occurred while trying to create record.", false);
	}
}

public void function _AccessMethodReadFormAction() {

	param name="url.AccessMethodId" default="0" type="numeric";

	Request._AccessMethod = EntityLoadByPK( "_AccessMethod", url.AccessMethodId);

	_ViewSvc.GetRequestedView();
}


public void function _AccessMethodUpdateFormAction() {

	param name="url.AccessMethodId" default="0" type="numeric";

	Request._AccessMethod = EntityLoadByPK( "_AccessMethod", url.AccessMethodId);

	_ViewSvc.GetRequestedView();
}

public void function _AccessMethodUpdateAction() {

	try {
		_AccessMethodSvc.FormUpdate_AccessMethod( form = form );

		location(APPLICATION.SES_URL & "/" & Request.Section & "/_AccessMethodReadForm?AccessMethodId=" & form.AccessMethodId, false);
	}
	catch(Any e) {
		location(APPLICATION.SES_URL & "/" & Request.Section & "?Message=An error occurred while trying to update record.", false);
	}
}

public void function _AccessMethodDeleteFormAction() {

	param name="url.AccessMethodId" default="0" type="numeric";

	Request._AccessMethod = EntityLoadByPK( "_AccessMethod", url.AccessMethodId);

	_ViewSvc.GetRequestedView();
}

public void function _AccessMethodDeleteAction() {

	param name="url.AccessMethodId" default="0" type="numeric";

	try {
		_AccessMethodSvc.FormDelete_AccessMethod( url.AccessMethodId );

		location(APPLICATION.SES_URL & "/" & Request.Section, false);
	}
	catch(Any e) {
		location(APPLICATION.SES_URL & "/" & Request.Section & "?Message=An error occurred while trying to delete record.", false);
	}
}


</cfscript>
