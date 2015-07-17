<cfcomponent hint="_AccessMethod Service" name="_AccessMethodService" output="false" extends="_Tron">
	<cfscript>
	variables.RegisteredName = "_AccessMethodService";

	remote string function JsonRead_AccessMethod(
			 string RemoteToken
			,string model
		) returnFormat="plain" output="false" {

		if( GrantMethodAccess(arguments.RemoteToken, "_AccessMethod", "JsonRead_AccessMethod") ) {
			var ObjectArray = ORMExecuteQuery("FROM _AccessMethod ORDER BY AccessMethodId DESC");
			return serializeJson(ObjectArray);
		}
	}

	public void function RegisterRemoteMethods() output="true" {

		serviceDir = DirectoryList( getDirectoryFromPath(ExpandPath("services\")), false, "query");

		for (service = 1; service LTE serviceDir.RecordCount; service++) {

			serviceName = serviceDir["name"][service];
			
			if (serviceName NEQ "functions" AND serviceName NEQ "scaffold") {

				writeOutput("<h1>" & ServiceName & "</h1>");
				serviceNameLen = Len(serviceName) - 4;
				serviceName =  "services." & Left(serviceName, serviceNameLen);	
				tempObj = createObject("component", serviceName);
				data = GetMetaData(tempObj);

				try {

					for ( i = 1; i <= ArrayLen(data.Functions); i++ ) {
						myFunc = data.Functions[i];
						
						if ( myFunc.Access == "Remote") {

							comNameLen = Len(data.FullName) - 9;
							comName =  Right(data.FullName, comNameLen);
							queryService = new query();
							queryService.AddParam(name = "component", value = comName, cfsqltype="cf_sql_varchar");
							queryService.AddParam(name = "method", value = myFunc.Name, cfsqltype="cf_sql_varchar");
							queryService.SetSQL('SELECT * FROM _accessmethod WHERE Component = :component AND MethodName = :method');
							qResults = queryService.Execute();
							qResults = qResults.GetResult();
							if( qResults.RecordCount == 0 ) {
								regMethod = New models._AccessMethod(
									Component = comName, 
									MethodName = myFunc.Name,
									Section = "Flynn",
									View = "");
								EntitySave(regMethod);
								writeDump(regMethod);
							}
						}
					}
				}

				catch(Any e) {
					writeOutput("<p>there may not have been valid functions</p>");
				}
			}		
		}
	}
	</cfscript>
</cfcomponent>