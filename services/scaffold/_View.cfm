<cfscript>

remote void function JsonCreate_View(
		 string RemoteToken
		,string models
	) output="false" {

	if( GrantMethodAccess(arguments.RemoteToken, "_View", "JsonCreate_View") ) {
		JsonCreateByObject(models = arguments.models, model = "_View");
	}
}

remote string function JsonRead_View(
		 string RemoteToken
		,string model
	) returnFormat="plain" output="false" {

	if( GrantMethodAccess(arguments.RemoteToken, "_View", "JsonRead_View") ) {
		return JsonReadByObject(model = "_View");
	}
}

remote void function JsonUpdate_View(
		 string RemoteToken
		,string models
	) output="false" {

	if( GrantMethodAccess(arguments.RemoteToken, "_View", "JsonUpdate_View") ) {
		JsonUpdateByObject(models = arguments.models, model = "_View");
	}
}

remote void function JsonDelete_View(
		 string RemoteToken
		,string models
	) output="false" {

	if( GrantMethodAccess(arguments.RemoteToken, "_View", "JsonDelete_View") ) {
		JsonDeleteByObject(models = arguments.models, model = "_View");
	}
}

public any function FormCreate_View(
		 struct form
	) output="false" {

	return FormCreateByObject(arguments.form, "_View");
}

public void function FormUpdate_View(
		 struct form
	) output="false" {

	FormUpdateByObject(arguments.form, "_View");
}

public void function FormDelete_View(
		 numeric PID
	) output="false" {

	FormDeleteByObject(arguments.PID, "_View");
}

</cfscript>
