<cfcomponent hint="User Service - I help protect and persist _User" name="_UserService" output="false" extends="_Tron">
<cfscript>
    variables.RegisteredName = "_UserService";

	public any function FormCreate_User(
			 struct form
		) output="false" {
		var _User = EntityLoad("_User", {Email = form.Email});

		if(ArrayLen(_User)) {
			throw;
		}
		else {
			return FormCreateByObject(arguments.form, "_User");
		}
	}

	public any function QueryUserById(
		numeric PID
		) output="false" {
		var qResults = EntityLoadByPk("_User", arguments.PID);
		if ( NOT IsNull(qResults) ) {
			return EntityToQuery(qResults);
		}
	}

	public query function QueryAllUsers() output="false" {

		var qResults = EntityLoad("_User");

		return EntityToQuery(qResults);
	}

	public query function QueryAllUsersSafe() output="false" {
		var qry = new query();
		result = qry.execute(sql="Select UserId, UserName, RoleName, Email, Status, LastLogin FROM _user WHERE RoleName <> 'Flynn'");
		return result.getResult();
	}

	remote string function JsonRead_User(
			string RemoteToken
		) returnFormat="plain" output="false" {
		
		if ( GrantMethodAccess(arguments.RemoteToken, variables.RegisteredName, "JsonRead_User") ) {
			return serializeJSON(QueryToStruct(QueryAllUsersSafe()));
		}
	}

	public void function _UserAccountUpdate(
			 struct form
		) output="false" {
		
		_User = EntityLoadByPK("_User", getAuthUser());
		_User.SetUserName(form.UserName);
		_User.SetEmail(form.Email);
		if(form.Password != "" && form.Password == form.ConfirmPassword) {
			_User.SetPassword(form.Password);
		}
	}
</cfscript>
</cfcomponent>