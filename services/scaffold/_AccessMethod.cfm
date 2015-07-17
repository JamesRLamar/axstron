<cfscript>

remote void function JsonCreate_AccessMethod(
		 string RemoteToken
		,string models
	) output="false" {

	if( GrantMethodAccess(arguments.RemoteToken, "_AccessMethod", "JsonCreate_AccessMethod") ) {
		JsonCreateByObject(models = arguments.models, model = "_AccessMethod");
	}
}

remote string function JsonRead_AccessMethod(
		 string RemoteToken
		,string model
	) returnFormat="plain" output="false" {

	if( GrantMethodAccess(arguments.RemoteToken, "_AccessMethod", "JsonRead_AccessMethod") ) {
		return JsonReadByObject(model = "_AccessMethod");
	}
}

remote void function JsonUpdate_AccessMethod(
		 string RemoteToken
		,string models
	) output="false" {

	if( GrantMethodAccess(arguments.RemoteToken, "_AccessMethod", "JsonUpdate_AccessMethod") ) {
		JsonUpdateByObject(models = arguments.models, model = "_AccessMethod");
	}
}

remote void function JsonDelete_AccessMethod(
		 string RemoteToken
		,string models
	) output="false" {

	if( GrantMethodAccess(arguments.RemoteToken, "_AccessMethod", "JsonDelete_AccessMethod") ) {
		JsonDeleteByObject(models = arguments.models, model = "_AccessMethod");
	}
}

public any function FormCreate_AccessMethod(
		 struct form
	) output="false" {

	return FormCreateByObject(arguments.form, "_AccessMethod");
}

public void function FormUpdate_AccessMethod(
		 struct form
	) output="false" {

	FormUpdateByObject(arguments.form, "_AccessMethod");
}

public void function FormDelete_AccessMethod(
		 numeric PID
	) output="false" {

	FormDeleteByObject(arguments.PID, "_AccessMethod");
}

</cfscript>
