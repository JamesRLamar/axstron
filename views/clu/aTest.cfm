<cfscript>
	//ListingSvc = New services.ListingService();
	//data = GetMetaData(ListingSvc);
	//writeDump(data);

	serviceDir = DirectoryList( getDirectoryFromPath(ExpandPath("services\")), false, "query");

	for (service = 1; service LTE serviceDir.RecordCount; service++) {

		serviceName = serviceDir["name"][service];
		
		if (serviceName NEQ "functions" AND serviceName NEQ "scaffold") {

			writeOutput("<h1>" & ServiceName & "</h1>");
			serviceNameLen = Len(serviceName) - 4;
			serviceName =  "services." & Left(serviceName, serviceNameLen);		

			tempObj = createObject("component", serviceName);

			data = GetMetaData(tempObj);
			//writeDump(data);

			try {

				for ( i = 1; i <= ArrayLen(data.Functions); i++ ) {
					myFunc = data.Functions[i];
					
					if ( myFunc.Access == "Remote") {
						//writeDump(myFunc.Name);
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
								Section = "Default",
								View = "Default");
							EntitySave(regMethod);
							writeDump(regMethod);
						}
						//writeDump(qResults.GetResult());
					}
				}
			}

			catch(Any e) {
				writeOutput("<p>there may not have been valid functions</p>");
			}
		}		
	}
</cfscript>