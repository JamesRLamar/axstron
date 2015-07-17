<cfscript>

_UserSvc = New services._UserService();

public void function _UserCreateAction() {

	try {
		_User = _UserSvc.FormCreate_User( form = form );

		location(APPLICATION.SES_URL & "/" & Request.Section & "/_UserReadForm?UserId=" & _User.GetUserId(), false);
	}
	catch(Any e) {
		location(APPLICATION.SES_URL & "/" & Request.Section & "?Message=An error occurred while trying to create record.", false);
	}
}

public void function _UserReadFormAction() {

	param name="url.UserId" default="0" type="numeric";

	Request._User = EntityLoadByPK( "_User", url.UserId);

	_ViewSvc.GetRequestedView();
}


public void function _UserUpdateFormAction() {

	param name="url.UserId" default="0" type="numeric";

	Request._User = EntityLoadByPK( "_User", url.UserId);

	_ViewSvc.GetRequestedView();
}

public void function _UserUpdateAction() {

	try {
		_UserSvc.FormUpdate_User( form = form );

		location(APPLICATION.SES_URL & "/" & Request.Section & "/_UserReadForm?UserId=" & form.UserId, false);
	}
	catch(Any e) {
		location(APPLICATION.SES_URL & "/" & Request.Section & "?Message=An error occurred while trying to update record.", false);
	}
}

public void function _UserDeleteFormAction() {

	param name="url.UserId" default="0" type="numeric";

	Request._User = EntityLoadByPK( "_User", url.UserId);

	_ViewSvc.GetRequestedView();
}

public void function _UserDeleteAction() {

	param name="url.UserId" default="0" type="numeric";

	try {
		_UserSvc.FormDelete_User( url.UserId );

		location(APPLICATION.SES_URL & "/" & Request.Section, false);
	}
	catch(Any e) {
		location(APPLICATION.SES_URL & "/" & Request.Section & "?Message=An error occurred while trying to delete record.", false);
	}
}


</cfscript>
