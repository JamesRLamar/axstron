<cfcomponent name="_Flynn" output="false" extends="_Tron">
<cfscript>
	public void function BuildCRUD( 
		 required string model
		,required string section 
		,boolean protect = true
		,boolean makeview = false 
		) {
	
		qModel = DbInfo( table = arguments.model, type = "columns");
		qModel.sort(qModel.findColumn("ORDINAL_POSITION"),TRUE);

		primaryKey = GetPrimaryKey(qModel);
		
		//INIT CONTROLLER BUILD
		var controllerFileName = arguments.model & ".cfm";
		var controllerFilePath = APPLICATION.BASE_PATH & "\controllers\scaffold\";
		var controllerFullPath = controllerFilePath & controllerFileName;
		fileContent = '<cfscript>' & chr(10) & chr(10)
			& arguments.model & 'Svc = New services.' & arguments.model & 'Service();' & chr(10);
		FileWrite("memory", "#fileContent#");
		var fileInMemory = FileRead("memory");

		/* writeOutput(controllerFilePath & " = controllerFilePath<br><br>");
		writeOutput(controllerFileName & " = controllerFileName<br><br>");
		writeOutput(fileInMemory & " = fileInMemory<br><br>");
		writeOutput(arguments.protect & " = protect<br><br>"); */

		var controllerFullPath = CreateFile( filePath = controllerFilePath,	fileName = controllerFileName, fileContent = fileInMemory,protect = arguments.protect );
		
		//APPEND READ FUNCTION
		/* var fileContent = BuildReadFunctions( model = arguments.model);
		controllerFile = FileOpen(controllerFullPath, "append"); 
		FileWriteLine(controllerFile, fileContent); 
		FileClose(controllerFile); */
		
		//APPEND CREATE ACTION
		var fileContent = BuildCreateAction( model = arguments.model);
		controllerFile = FileOpen(controllerFullPath, "append"); 
		FileWriteLine(controllerFile, fileContent); 
		FileClose(controllerFile);
		
		//APPEND READ ACTION
		var fileContent = BuildReadAction( model = arguments.model);
		controllerFile = FileOpen(controllerFullPath, "append"); 
		FileWriteLine(controllerFile, fileContent); 
		FileClose(controllerFile);
		
		//APPEND UPDATE ACTION
		var fileContent = BuildUpdateAction( model = arguments.model);
		controllerFile = FileOpen(controllerFullPath, "append"); 
		FileWriteLine(controllerFile, fileContent); 
		FileClose(controllerFile);
		
		//APPEND DELETE ACTION
		var fileContent = BuildDeleteAction( model = arguments.model);
		controllerFile = FileOpen(controllerFullPath, "append"); 
		FileWriteLine(controllerFile, fileContent); 
		FileClose(controllerFile);
		
		//FINISH CONTROLLER BUILD
		var fileContent = chr(10) & '</cfscript>' ;
		controllerFile = FileOpen(controllerFullPath, "append"); 
		FileWriteLine(controllerFile, fileContent); 
		FileClose(controllerFile);
	
		
		//INIT FORM BUILDS
		var formFilePath = APPLICATION.BASE_PATH & "\views\" & arguments.section & '\includes';
		preViewWrapping = "";
		postViewWrapping = "";
		
		if (arguments.makeview) {
			formFilePath = APPLICATION.BASE_PATH & "\views\" & arguments.section;
			preViewWrapping = '<div class="bs-docs-example">' & chr(10);
			postViewWrapping = '</div>';
		}
		
		//BUILD CREATE FORM
		var fileContent = BuildCreateForm( model = arguments.model);
		FileWrite("memory", "#fileContent#"); 
		var fileInMemory = FileRead("memory");
		var formFileName = arguments.model & "CreateForm.cfm";
		var formFullPath = formFilePath & '\' & formFileName;
		
		CreateFile( filePath = formFilePath,
							fileName = formFileName,
								fileContent = fileInMemory, 
									protect = arguments.protect );
		
		//BUILD READ FORM
		var fileContent = BuildReadForm( model = arguments.model);
		FileWrite("memory", "#fileContent#"); 
		var fileInMemory = FileRead("memory");
		var formFileName = arguments.model & "ReadForm.cfm";
		var formFullPath = formFilePath & '\' & formFileName;
		
		CreateFile( filePath = formFilePath,
							fileName = formFileName,
								fileContent = fileInMemory, 
									protect = arguments.protect );
		
		//BUILD UPDATE FORM
		var fileContent = BuildUpdateForm( model = arguments.model );
		FileWrite("memory", "#fileContent#"); 
		var fileInMemory = FileRead("memory");
		var formFileName = arguments.model & "UpdateForm.cfm";
		var formFullPath = formFilePath & '\' & formFileName;
		CreateFile( filePath = formFilePath,
							fileName = formFileName,
								fileContent = fileInMemory, 
									protect = arguments.protect );
		
		//BUILD DELETE FORM
		/* var fileContent = BuildDeleteForm( model = arguments.model);
		FileWrite("memory", "#fileContent#"); 
		var fileInMemory = FileRead("memory");
		var formFileName = arguments.model & "DeleteForm.cfm";
		var formFullPath = formFilePath & '\' & formFileName; */
		
		/* CreateFile( filePath = formFilePath,
							fileName = formFileName,		
								fileContent = #fileInMemory#, 
									protect = #arguments.protect# ); */

		//BUILD GRID
		var fileContent = BuildGrid( model = arguments.model );
		FileWrite("memory", "#fileContent#"); 
		var fileInMemory = FileRead("memory");
		var formFileName = arguments.model & "Grid.cfm";
		var formFullPath = formFilePath & '\' & formFileName;
		CreateFile( filePath = formFilePath,
							fileName = formFileName,
								fileContent = fileInMemory, 
									protect = arguments.protect );

		//REGISTER REMOTE GRID FUNCTIONS
		var axsMethod = "JsonCreate" & arguments.model;
		var axsView = arguments.model & "Grid";
		var _AccessMethodTest = EntityLoad("_AccessMethod", { Component = arguments.model, MethodName = axsMethod, Section = arguments.section, View = axsView});
		if ( ArrayLen(_AccessMethodTest) == 0 ) {
			var _AccessMethod = New models._AccessMethod();
			_AccessMethod.SetComponent(arguments.model);
			_AccessMethod.SetMethodName(axsMethod);
			_AccessMethod.SetSection(arguments.section);
			_AccessMethod.SetView(axsView);
			EntitySave(_AccessMethod);
		}

		var axsMethod = "JsonRead" & arguments.model;
		var axsView = arguments.model & "Grid";
		var _AccessMethodTest = EntityLoad("_AccessMethod", { Component = arguments.model, MethodName = axsMethod, Section = arguments.section, View = axsView});
		if ( ArrayLen(_AccessMethodTest) == 0 ) {
			var _AccessMethod = New models._AccessMethod();
			_AccessMethod.SetComponent(arguments.model);
			_AccessMethod.SetMethodName(axsMethod);
			_AccessMethod.SetSection(arguments.section);
			_AccessMethod.SetView(axsView);
			EntitySave(_AccessMethod);
		}

		var axsMethod = "JsonUpdate" & arguments.model;
		var axsView = arguments.model & "Grid";
		var _AccessMethodTest = EntityLoad("_AccessMethod", { Component = arguments.model, MethodName = axsMethod, Section = arguments.section, View = axsView});
		if ( ArrayLen(_AccessMethodTest) == 0 ) {
			var _AccessMethod = New models._AccessMethod();
			_AccessMethod.SetComponent(arguments.model);
			_AccessMethod.SetMethodName(axsMethod);
			_AccessMethod.SetSection(arguments.section);
			_AccessMethod.SetView(axsView);
			EntitySave(_AccessMethod);
		}

		var axsMethod = "JsonDelete" & arguments.model;
		var axsView = arguments.model & "Grid";
		var _AccessMethodTest = EntityLoad("_AccessMethod", { Component = arguments.model, MethodName = axsMethod, Section = arguments.section, View = axsView});
		if ( ArrayLen(_AccessMethodTest) == 0 ) {
			var _AccessMethod = New models._AccessMethod();
			_AccessMethod.SetComponent(arguments.model);
			_AccessMethod.SetMethodName(axsMethod);
			_AccessMethod.SetSection(arguments.section);
			_AccessMethod.SetView(axsView);
			EntitySave(_AccessMethod);
		}

		//INIT SERVICE BUILD
		var serviceFileName = arguments.model & ".cfm";
		var serviceFilePath = APPLICATION.BASE_PATH & "\services\scaffold\";
		//serviceFullPath = serviceFilePath & serviceFileName;
		var fileContent = '<cfscript>' & chr(10);
		FileWrite("memory", "#fileContent#");
		var fileInMemory = FileRead("memory");

		/* writeOutput("<h1>serviceFullPath</h1>");
		writeDump(serviceFullPath);
		writeOutput("<h1>fileContent</h1>");
		writeDump(fileContent); */

		var serviceFullPath = CreateFile( filePath = serviceFilePath, fileName = serviceFileName, fileContent = fileInMemory, protect =  arguments.protect);
		
		//APPEND JSON CREATE FUNCTION
		fileContent = BuildJsonCreateFunction( model = arguments.model);
		serviceFile = FileOpen(serviceFullPath, "append"); 
		FileWriteLine(serviceFile, fileContent); 
		FileClose(serviceFile);

		//APPEND JSON READ FUNCTION
		fileContent = BuildJsonReadFunction( model = arguments.model);
		serviceFile = FileOpen(serviceFullPath, "append"); 
		FileWriteLine(serviceFile, fileContent); 
		FileClose(serviceFile);

		//APPEND JSON UPDATE FUNCTION
		fileContent = BuildJsonUpdateFunction( model = arguments.model);
		serviceFile = FileOpen(serviceFullPath, "append"); 
		FileWriteLine(serviceFile, fileContent); 
		FileClose(serviceFile);

		//APPEND JSON DELETE FUNCTION
		fileContent = BuildJsonDeleteFunction( model = arguments.model);
		serviceFile = FileOpen(serviceFullPath, "append"); 
		FileWriteLine(serviceFile, fileContent); 
		FileClose(serviceFile);

		//APPEND FORM CREATE FUNCTION
		fileContent = BuildFormCreateFunction( model = arguments.model);
		serviceFile = FileOpen(serviceFullPath, "append"); 
		FileWriteLine(serviceFile, fileContent); 
		FileClose(serviceFile);

		//APPEND FORM UPDATE FUNCTION
		fileContent = BuildFormUpdateFunction( model = arguments.model);
		serviceFile = FileOpen(serviceFullPath, "append"); 
		FileWriteLine(serviceFile, fileContent); 
		FileClose(serviceFile);

		//APPEND FORM DELETE FUNCTION
		fileContent = BuildFormDeleteFunction( model = arguments.model);
		serviceFile = FileOpen(serviceFullPath, "append"); 
		FileWriteLine(serviceFile, fileContent); 
		FileClose(serviceFile);

		//FINISH SERVICE BUILD
		fileContent = '</cfscript>' ;
		serviceFile = FileOpen(serviceFullPath, "append"); 
		FileWriteLine(serviceFile, fileContent); 
		FileClose(serviceFile);
	}
	
	private string function BuildCreateAction( 
		 required string model
		){
			
		var fileContent = 
		
			'public void function ' & arguments.model & 'CreateAction() {' & chr(10) & chr(10)
		
			& '	try {' & chr(10)

			& '		'& arguments.model & ' = ' & arguments.model & 'Svc.FormCreate' & arguments.model & '( form = form );' & chr(10)	& chr(10)	
					
			& '		location(APPLICATION.SES_URL & "/" & Request.Section & "/' & arguments.model & 'ReadForm?' 
			
			& primaryKey & '=" & ' & arguments.model & '.Get' & primaryKey & '(), false);' & chr(10)
			
			& '	}' & chr(10)

			& '	catch(Any e) {' & chr(10)
			
			& '		location(APPLICATION.SES_URL & "/" & Request.Section & "?Message=An error occurred while trying to create record.", false);' & chr(10)
			
			& '	}' & chr(10)

			& '}' & chr(10);
		
		return fileContent;
	}
	
	private string function BuildCreateForm( 
		 required string model
		){
		
		var fileContent = preViewWrapping & '<form action="<cfoutput>##APPLICATION.SES_URL##/##Request.Section##/</cfoutput>' & arguments.model & 'Create" name="create" method="post" class="form-horizontal">' & chr(10);
		
		for (col = 1; col LTE qModel.RecordCount; col++) {

			if ( NOT qModel["IS_PRIMARYKEY"][col] ) {

				fileContent = fileContent 
						
						& '<div class="control-group">' & chr(10)
						
						& '	<label for="' & qModel["COLUMN_NAME"][col] & '" class="control-label">'
						
						& camelToSpace(qModel["COLUMN_NAME"][col], true)
						
						& ':</label>' & chr(10) 

						& '	<div class="controls">' & chr(10);
				
				if ( qModel["TYPE_NAME"][col] EQ "DATETIME" OR qModel["TYPE_NAME"][col] EQ "DATE" ) {
					
					fileContent = fileContent 
											
						& '		<input class="datepicker" type="text" name="' & qModel["COLUMN_NAME"][col]
						
						& '" id="' & qModel["COLUMN_NAME"][col]
						
						& '" value="<cfoutput>##DateFormat(Now(), ' & '"' & 'yyyy-mm-dd' & '"' & ')##</cfoutput>" class="icon-calendar"/>' & chr(10); 
				}
				
				else if ( NOT qModel["TYPE_NAME"][col] EQ "LONGTEXT") {
					
					fileContent = fileContent 
						
						& '		<input type="text" name="' & qModel["COLUMN_NAME"][col]
						
						& '" id="' & qModel["COLUMN_NAME"][col] & '"/>' & chr(10);
				}

				else if ( qModel["TYPE_NAME"][col] EQ "LONGTEXT" ) {
					
					fileContent = fileContent 

						& '<label for="' & qModel["COLUMN_NAME"][col] & '">'
					
						& camelToSpace(qModel["COLUMN_NAME"][col], true)
					
						& ':</label>' & chr(10)
					
						& '<textarea name="' & qModel["COLUMN_NAME"][col]
					
						& '" id="' & qModel["COLUMN_NAME"][col] & '"></textarea>' & chr(10);
					
						//& DefaultCKEDITOR( fieldName = #qModel["COLUMN_NAME"][col]# )
				}

				fileContent = fileContent & '	</div>' & chr(10) & '</div>' & chr(10); 
			}
		}

		fileContent = fileContent 
						
			& '<div class="control-group">' & chr(10)

			& '	<div class="controls">' & chr(10)

			& '	<input type="submit" name="submit" value="Submit" class="btn btn-primary" />' & chr(10)

			& '	</div>' & chr(10) & '</div>' & chr(10)

			& '</form>' & chr(10) 

			& '<script>' & chr(10) 

			& '$().ready(function() {' & chr(10) 

			& '	$(".form-horizontal").validate();' & chr(10) 

			& '});' & chr(10) 

			& '</script>' & chr(10) 

			& postViewWrapping;
		
		return fileContent;
	}
	
	private string function BuildReadAction( 
		 required string model
		){
			
		var fileContent = 
		
		'public void function ' & arguments.model & 'ReadFormAction() {' & chr(10) & chr(10)
		
		& '	param name="url.' & primaryKey & '" default="0" type="numeric";' & chr(10) & chr(10)
		
		& '	Request.' & arguments.model & ' = EntityLoadByPK( "' & arguments.model & '", url.' & primaryKey & ');' & chr(10) & chr(10)	
	
		& '	_ViewSvc.GetRequestedView();' & chr(10)
	
		& '}' & chr(10) & chr(10);
			
		return fileContent;
	}
	
	private string function BuildReadForm( 
	 	 required string model
		){
	
		var fileContent = preViewWrapping & '<form action="" name="read" method="" class="form-horizontal">' & chr(10);
		
		for (col = 1; col LTE qModel.RecordCount; col++) {

			if ( NOT qModel["IS_PRIMARYKEY"][col] ) {

				fileContent = fileContent 
						
						& '<div class="control-group">' & chr(10)
						
						& '	<label for="' & qModel["COLUMN_NAME"][col] & '" class="control-label">'
						
						& camelToSpace(qModel["COLUMN_NAME"][col], true)
						
						& ':</label>' & chr(10) 

						& '	<div class="controls">' & chr(10);
				
				if ( qModel["TYPE_NAME"][col] EQ "DATETIME" OR qModel["TYPE_NAME"][col] EQ "DATE" ) {
					
					fileContent = fileContent 
											
						& '		<input disabled class="datepicker" type="text" name="' & qModel["COLUMN_NAME"][col]
						
						& '" id="' & qModel["COLUMN_NAME"][col]
						
						& '" value="<cfoutput>##DateFormat(Request.' & arguments.model & '.Get' & qModel["COLUMN_NAME"][col] & '(), "yyyy-mm-dd")##</cfoutput>" class="icon-calendar"/>' & chr(10); 
				}
				
				else if ( NOT qModel["TYPE_NAME"][col] EQ "LONGTEXT") {
					
					fileContent = fileContent 
						
					& '<input disabled type="text" name="' & qModel["COLUMN_NAME"][col] & '" '
						
					& 'id="' & qModel["COLUMN_NAME"][col] & '" '
						
					& 'value="<cfoutput>##Request.' & arguments.model & '.Get' & qModel["COLUMN_NAME"][col] & '()##</cfoutput>"/>' & chr(10);
				}

				else if ( qModel["TYPE_NAME"][col] EQ "LONGTEXT" ) {
					
					fileContent = fileContent 

						& '<label for="' & qModel["COLUMN_NAME"][col] & '">'
					
						& camelToSpace(qModel["COLUMN_NAME"][col], true)
					
						& ':</label>' & chr(10)
					
						& '<textarea disabled name="' & qModel["COLUMN_NAME"][col]
					
						& '" id="' & qModel["COLUMN_NAME"][col] & '"><cfoutput>##Request.' & arguments.model & '.Get' & qModel["COLUMN_NAME"][col] & '()##</cfoutput></textarea>' & chr(10);
					
						//& DefaultCKEDITOR( fieldName = #qModel["COLUMN_NAME"][col]# )
				}

				fileContent = fileContent & '	</div>' & chr(10) & '</div>' & chr(10); 
			}
		}

		fileContent = fileContent 
						
			& '<div class="control-group">' & chr(10)

			& '	<div class="controls">' & chr(10)

			& '	<a href="<cfoutput>##APPLICATION.SES_URL##/##Request.Section##/' & arguments.model 
	
			& 'UpdateForm?' & primaryKey & '=##Request.' & arguments.model 
	
			& '.Get' & primaryKey & '()##</cfoutput>" class="btn btn-primary">Update</a>'
	
			& '	<a href="##Delete" role="button" class="btn btn-warning" data-toggle="modal">Delete</a>'

			& '	</div>' & chr(10) & '</div>' & chr(10)

			& '</form>' & chr(10);
		 
		fileContent = fileContent 
			& '<div id="Delete" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">' & chr(10)
			
			& '  <div class="modal-header">' & chr(10)
			
			& '    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>' & chr(10)
			
			& '    <h3 id="myModalLabel">Delete Record</h3>' & chr(10)
			
			& '  </div>' & chr(10)
			
			& '  <div class="modal-body">' & chr(10)
			
			& '    <p>Are you sure you want to delete this record?</p>' & chr(10)
			
			& '  </div>' & chr(10)
			
			& '  <div class="modal-footer">' & chr(10)
			
			& '    <button class="btn btn-primary" data-dismiss="modal" aria-hidden="true">Cancel</button>' & chr(10)
			
			& '    <a href="<cfoutput>##APPLICATION.SES_URL##/##Request.Section##/' & arguments.model & 'Delete?' & primaryKey & '=##Request.' & arguments.model & '.Get' & primaryKey & '()##</cfoutput>" class="btn btn-warning">Confirm Delete</a>' & chr(10)
			
			& '  </div>' & chr(10)
			
			& '</div>' & chr(10)
			
			& postViewWrapping;
		
		return fileContent;
	}
	
	private string function BuildUpdateAction( 
		 required string model
		){
		
		var fileContent = 
		
		'public void function ' & arguments.model & 'UpdateFormAction() {' & chr(10) & chr(10)
		
		& '	param name="url.' & primaryKey & '" default="0" type="numeric";' & chr(10) & chr(10)
		
		& '	Request.' & arguments.model & ' = EntityLoadByPK( "' & arguments.model & '", url.' & primaryKey & ');' & chr(10) & chr(10)	
	
		& '	_ViewSvc.GetRequestedView();' & chr(10)
	
		& '}' & chr(10) & chr(10);
				
		
		fileContent = fileContent & 'public void function ' & arguments.model & 'UpdateAction() {' & chr(10) & chr(10)
				
	    & '	try {' & chr(10)

	    & '		' & arguments.model & 'Svc.FormUpdate' & arguments.model & '( form = form );' & chr(10) & chr(10)
		
		& '		location(APPLICATION.SES_URL & "/" & Request.Section & "/' & arguments.model & 'ReadForm?' & primaryKey & '=" & form.' & primaryKey & ', false);' & chr(10)

		& '	}' & chr(10)

		& '	catch(Any e) {' & chr(10)
		
		& '		location(APPLICATION.SES_URL & "/" & Request.Section & "?Message=An error occurred while trying to update record.", false);' & chr(10)
		
		& '	}' & chr(10)

		& '}' & chr(10);
		
		return fileContent;
	}
	
	private string function BuildUpdateForm( 
		 required string model
		){
				
		var fileContent = preViewWrapping &  '<form action="<cfoutput>##APPLICATION.SES_URL##/##Request.Section##/</cfoutput>' & arguments.model & 'Update" name="update" method="post" class="form-horizontal">' & chr(10);
						
		for (col = 1; col LTE qModel.RecordCount; col++) {

			if ( NOT qModel["IS_PRIMARYKEY"][col] ) {

				fileContent = fileContent 
						
						& '<div class="control-group">' & chr(10)
						
						& '	<label for="' & qModel["COLUMN_NAME"][col] & '" class="control-label">'
						
						& camelToSpace(qModel["COLUMN_NAME"][col], true)
						
						& ':</label>' & chr(10) 

						& '	<div class="controls">' & chr(10);
				
				if ( qModel["TYPE_NAME"][col] EQ "DATETIME" OR qModel["TYPE_NAME"][col] EQ "DATE" ) {
					
					fileContent = fileContent 
											
						& '		<input class="datepicker" type="text" name="' & qModel["COLUMN_NAME"][col]
						
						& '" id="' & qModel["COLUMN_NAME"][col]
						
						& '" value="<cfoutput>##DateFormat(Request.' & arguments.model & '.Get' & qModel["COLUMN_NAME"][col] & '(), "yyyy-mm-dd")##</cfoutput>" class="icon-calendar"/>' & chr(10); 
				}
				
				else if ( NOT qModel["TYPE_NAME"][col] EQ "LONGTEXT") {
					
					fileContent = fileContent 
						
					& '<input type="text" name="' & qModel["COLUMN_NAME"][col] & '" '
						
					& 'id="' & qModel["COLUMN_NAME"][col] & '" '
						
					& 'value="<cfoutput>##Request.' & arguments.model & '.Get' & qModel["COLUMN_NAME"][col] & '()##</cfoutput>"/>' & chr(10);
				}

				else if ( qModel["TYPE_NAME"][col] EQ "LONGTEXT" ) {
					
					fileContent = fileContent 

						& '<label for="' & qModel["COLUMN_NAME"][col] & '">'
					
						& camelToSpace(qModel["COLUMN_NAME"][col], true)
						//& Replace(qModel["COLUMN_NAME"][col], "_", " ", "All")
					
						& ':</label>' & chr(10)
					
						& '<textarea name="' & qModel["COLUMN_NAME"][col]
					
						& '" id="' & qModel["COLUMN_NAME"][col] & '"><cfoutput>##Request.' & arguments.model & '.Get' & qModel["COLUMN_NAME"][col] & '()##</cfoutput></textarea>' & chr(10);
					
						//& DefaultCKEDITOR( fieldName = #qModel["COLUMN_NAME"][col]# )
				}

				fileContent = fileContent & '	</div>' & chr(10) & '</div>' & chr(10); 
			}
		}

		fileContent = fileContent 
						
			& '<div class="control-group">' & chr(10)

			& '	<div class="controls">' & chr(10)

			& '	<a href="<cfoutput>##APPLICATION.SES_URL##/##Request.Section##/' & arguments.model 
	
			& 'ReadForm?' & primaryKey & '=##Request.' & arguments.model 
	
			& '.Get' & primaryKey & '()##</cfoutput>" class="btn btn-primary">Cancel</a>'
	
			& '	<input type="submit" name="submit" value="Submit Changes" class="btn btn-warning"/>'

			& '	</div>' & chr(10) & '</div>' & chr(10)

			& '<input type="hidden" name="' & primaryKey 

			& '" value="<cfoutput>##Request.' & arguments.model & '.Get' & primaryKey & '()##</cfoutput>" />' & chr(10)

			& '</form>' & chr(10) 

			& '<script>' & chr(10) 

			& '$().ready(function() {' & chr(10) 

			& '	$(".form-horizontal").validate();' & chr(10) 

			& '});' & chr(10) 

			& '</script>' & chr(10) 

			& postViewWrapping;
		
		return fileContent;
	}
	
	private string function BuildDeleteAction( 
		 required string model
		){
		
		var fileContent = 
		
		'public void function ' & arguments.model & 'DeleteFormAction() {' & chr(10) & chr(10)
		
		& '	param name="url.' & primaryKey & '" default="0" type="numeric";' & chr(10) & chr(10)
		
		& '	Request.' & arguments.model & ' = EntityLoadByPK( "' & arguments.model & '", url.' & primaryKey & ');' & chr(10) & chr(10)	
	
		& '	_ViewSvc.GetRequestedView();' & chr(10)
	
		& '}' & chr(10) & chr(10);
		
		fileContent = fileContent 

		& 'public void function ' & arguments.model & 'DeleteAction() {' & chr(10) & chr(10)
		
		& '	param name="url.' & primaryKey & '" default="0" type="numeric";' & chr(10) & chr(10)

		& '	try {' & chr(10)
				
	    & '		' & arguments.model & 'Svc.FormDelete' & arguments.model & '( url.' & primaryKey & ' );' & chr(10) & chr(10)
		
		& '		location(APPLICATION.SES_URL & "/" & Request.Section, false);' & chr(10)

		& '	}' & chr(10)

		& '	catch(Any e) {' & chr(10)
		
		& '		location(APPLICATION.SES_URL & "/" & Request.Section & "?Message=An error occurred while trying to delete record.", false);' & chr(10)
		
		& '	}' & chr(10)

		& '}' & chr(10);
		
		return fileContent;
	}
	
	private string function BuildDeleteForm( 
		 required string model
		){
		
		var fileContent = preViewWrapping 
						
			& '<div class="control-group warning">' & chr(10)

			& '	<div class="controls">' & chr(10)

			& '	<p class="control-label">Are you sure you want to delete this record?</p>'
	
			& '	<a href="<cfoutput>##APPLICATION.SES_URL##/##Request.Section##/' 
					
			& arguments.model & 'ReadForm?' & primaryKey & '=##Request.' & arguments.model & '.Get' & primaryKey & '()##</cfoutput>" class="btn btn-primary">Cancel</a>'
			
			& '	<a href="<cfoutput>##APPLICATION.SES_URL##/##Request.Section##/' 
			
			& arguments.model & 'Delete?' & primaryKey & '=##Request.' & arguments.model & '.Get' & primaryKey & '()##</cfoutput>" class="btn btn-warning">Confirm Delete</a>'

			& '	</div>' & chr(10) & '</div>' & chr(10)

			& postViewWrapping;
		
		return fileContent;
	}

	private string function BuildJsonCreateFunction( 
		 required string model
		){
		var fileContent = 
			'remote void function JsonCreate' & arguments.model & '('& chr(10)
			& '		 string RemoteToken'& chr(10)
			& '		,string models'& chr(10)
			& '	) output="false" {' & chr(10) & chr(10)

			& '	if( GrantMethodAccess(arguments.RemoteToken, "' & arguments.model & '", "JsonCreate' & arguments.model & '") ) {' & chr(10)
			
			& '		JsonCreateByObject(models = arguments.models, model = "' & arguments.model & '");' & chr(10)
			
			& '	}' & chr(10)

			& '}' & chr(10);
		
		return fileContent;
	}

	private string function BuildJsonReadFunction( 
		 required string model
		){
		var fileContent = 
			'remote string function JsonRead' & arguments.model & '('& chr(10)
			
			& '		 string RemoteToken'& chr(10)
			
			& '		,string model'& chr(10)

			& '	) returnFormat="plain" output="false" {' & chr(10) & chr(10)

			& '	if( GrantMethodAccess(arguments.RemoteToken, "' & arguments.model & '", "JsonRead' & arguments.model & '") ) {' & chr(10)
			
			& '		return JsonReadByObject(model = "' & arguments.model & '");' & chr(10)
			
			& '	}' & chr(10)

			& '}' & chr(10);
		
		return fileContent;
	}

	private string function BuildJsonUpdateFunction( 
		 required string model
		){
		var fileContent = 
			'remote void function JsonUpdate' & arguments.model & '('& chr(10)
			& '		 string RemoteToken'& chr(10)
			& '		,string models'& chr(10)
			& '	) output="false" {' & chr(10) & chr(10)

			& '	if( GrantMethodAccess(arguments.RemoteToken, "' & arguments.model & '", "JsonUpdate' & arguments.model & '") ) {' & chr(10)
			
			& '		JsonUpdateByObject(models = arguments.models, model = "' & arguments.model & '");' & chr(10)
			
			& '	}' & chr(10)

			& '}' & chr(10);
		
		return fileContent;
	}

	private string function BuildJsonDeleteFunction( 
		 required string model
		){
		var fileContent = 
			'remote void function JsonDelete' & arguments.model & '('& chr(10)
			& '		 string RemoteToken'& chr(10)
			& '		,string models'& chr(10)
			& '	) output="false" {' & chr(10) & chr(10)

			& '	if( GrantMethodAccess(arguments.RemoteToken, "' & arguments.model & '", "JsonDelete' & arguments.model & '") ) {' & chr(10)
			
			& '		JsonDeleteByObject(models = arguments.models, model = "' & arguments.model & '");' & chr(10)
			
			& '	}' & chr(10)

			& '}' & chr(10);
		
		return fileContent;
	}

	private string function BuildFormCreateFunction( 
		 required string model
		){
		var fileContent = 
			'public any function FormCreate' & arguments.model & '('& chr(10)

			& '		 struct form' & chr(10)

			& '	) output="false" {' & chr(10) & chr(10)

			& '	return FormCreateByObject(arguments.form, "' & arguments.model & '");' & chr(10)

			& '}' & chr(10);
		
		return fileContent;
	}

	private string function BuildFormUpdateFunction( 
		 required string model
		){
		var fileContent = 
			'public void function FormUpdate' & arguments.model & '('& chr(10)

			& '		 struct form' & chr(10)

			& '	) output="false" {' & chr(10) & chr(10)

			& '	FormUpdateByObject(arguments.form, "' & arguments.model & '");' & chr(10)

			& '}' & chr(10);
		
		return fileContent;
	}

	private string function BuildFormDeleteFunction( 
		 required string model
		){
		var fileContent = 
			'public void function FormDelete' & arguments.model & '('& chr(10)

			& '		 numeric PID' & chr(10)

			& '	) output="false" {' & chr(10) & chr(10)

			& '	FormDeleteByObject(arguments.PID, "' & arguments.model & '");' & chr(10)

			& '}' & chr(10);
		
		return fileContent;
	}

	private string function BuildGrid( 
		 required string model
		){
		
		var fileContent = preViewWrapping 
				
			& '<cfinclude template="../../helpers/KendoHelper.cfm">' & chr(10)

			& '<a href="<cfoutput>##APPLICATION.BASE_URL##/index.cfm/default/' & arguments.model & 'CreateForm</cfoutput>" class="btn"> Add New ' & arguments.model & ' </a>
				<br><br>' & chr(10)

			& '<cfoutput> ##GetGrid( model="' & arguments.model & '", component = "services/' & arguments.model & 'Service.cfc", overwrite = false, include=true )## </cfoutput>' & chr(10)
			
			& '<script id="' & arguments.model & 'Template" type="text/x-kendo-tmpl">' & chr(10)
			
			& '<cfoutput><a href="##APPLICATION.BASE_URL##/index.cfm/##Request.Section##/' & arguments.model & 'ReadForm?' & primaryKey & '=${ ' & primaryKey & ' }" class="btn">View ' & arguments.model & '</a></cfoutput>' & chr(10)
			
			& '</script>' & chr(10)

			& postViewWrapping;
		
		return fileContent;
	}
</cfscript>
</cfcomponent>