<cfscript>

remote void function JsonCreate_AccessView(
		 string RemoteToken
		,string models
	) output="false" {

	if( GrantMethodAccess(arguments.RemoteToken, "_AccessView", "JsonCreate_AccessView") ) {
		JsonCreateByObject(models = arguments.models, model = "_AccessView");
	}
}

remote string function JsonRead_AccessView(
		 string RemoteToken
		,string model
	) returnFormat="plain" output="false" {

	if( GrantMethodAccess(arguments.RemoteToken, "_AccessView", "JsonRead_AccessView") ) {
		return JsonReadByObject(model = "_AccessView");
	}
}

remote void function JsonUpdate_AccessView(
		 string RemoteToken
		,string models
	) output="false" {

	if( GrantMethodAccess(arguments.RemoteToken, "_AccessView", "JsonUpdate_AccessView") ) {
		JsonUpdateByObject(models = arguments.models, model = "_AccessView");
	}
}

remote void function JsonDelete_AccessView(
		 string RemoteToken
		,string models
	) output="false" {

	if( GrantMethodAccess(arguments.RemoteToken, "_AccessView", "JsonDelete_AccessView") ) {
		JsonDeleteByObject(models = arguments.models, model = "_AccessView");
	}
}

public any function FormCreate_AccessView(
		 struct form
	) output="false" {

	return FormCreateByObject(arguments.form, "_AccessView");
}

public void function FormUpdate_AccessView(
		 struct form
	) output="false" {

	FormUpdateByObject(arguments.form, "_AccessView");
}

public void function FormDelete_AccessView(
		 numeric PID
	) output="false" {

	FormDeleteByObject(arguments.PID, "_AccessView");
}

</cfscript>
