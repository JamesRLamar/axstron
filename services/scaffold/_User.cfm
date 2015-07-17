<cfscript>

remote void function JsonCreate_User(
		 string RemoteToken
		,string models
	) output="false" {

	if( GrantMethodAccess(arguments.RemoteToken, "_User", "JsonCreate_User") ) {
		JsonCreateByObject(models = arguments.models, model = "_User");
	}
}

remote string function JsonRead_User(
		 string RemoteToken
		,string model
	) returnFormat="plain" output="false" {

	if( GrantMethodAccess(arguments.RemoteToken, "_User", "JsonRead_User") ) {
		return JsonReadByObject(model = "_User");
	}
}

remote void function JsonUpdate_User(
		 string RemoteToken
		,string models
	) output="false" {

	if( GrantMethodAccess(arguments.RemoteToken, "_User", "JsonUpdate_User") ) {
		JsonUpdateByObject(models = arguments.models, model = "_User");
	}
}

remote void function JsonDelete_User(
		 string RemoteToken
		,string models
	) output="false" {

	if( GrantMethodAccess(arguments.RemoteToken, "_User", "JsonDelete_User") ) {
		JsonDeleteByObject(models = arguments.models, model = "_User");
	}
}

public any function FormCreate_User(
		 struct form
	) output="false" {

	return FormCreateByObject(arguments.form, "_User");
}

public void function FormUpdate_User(
		 struct form
	) output="false" {

	FormUpdateByObject(arguments.form, "_User");
}

public void function FormDelete_User(
		 numeric PID
	) output="false" {

	FormDeleteByObject(arguments.PID, "_User");
}

</cfscript>
