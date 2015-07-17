<cfset _Tron = New services._Tron()>
<!--- THIS FILE IS MEANT TO BE INLCUDED AND CALLED AS A UDF --->
<cfoutput>
<link href="#APPLICATION.ASSET_PATH#/kendoui/styles/kendo.common.min.css" rel="stylesheet" type="text/css" />
<link href="#APPLICATION.ASSET_PATH#/kendoui/styles/kendo.bootstrap.min.css" rel="stylesheet" type="text/css" />
<script src="#APPLICATION.ASSET_PATH#/kendoui/js/kendo.web.min.js" type="text/javascript"></script>
<script>
$(document).ready(function() { 
	#toScript( APPLICATION.BASE_URL , "kendoURL")# // Example: "http://localhost:8500/kendohelper";
	#toScript( SESSION.REMOTE_TOKEN , "RemoteToken")# // Optional, but allows you to compare a hashed login token to the current session token for secuity purposes
});
</script>
</cfoutput>
<cfscript>
/**
*
* @author  James R Lamar - Nautilus Technology Solutions Inc. - gonautilus.com
* @description This software is issued wihtout warranty under GPL v3 and is meant to be used with the open source version of Kendo UI Web widgets
*
*/

public string function GetGrid( 

	required string model
	,string method = "Default"
	,string directory = Request.Section
	,boolean overwrite = false
	,boolean include = false
	,boolean CRUD = true
	,string dataType = "JSON"
	,numeric pageSize = 10
	//,numeric height = 400
	,string pKey = ""
	,string component = ""
	
	) {
			
	IncludePath = "../views/" & arguments.directory & "/includes/";

	URL = APPLICATION.BASE_URL;

	Datasource = APPLICATION.DATASOURCE;

	CreateMethod = "JsonCreate" & arguments.model;

	ReadMethod = "JsonRead" & arguments.model;

	UpdateMethod = "JsonUpdate" & arguments.model;

	DeleteMethod = "JsonDelete" & arguments.model;

	var uniqueName = "kendo" & arguments.model & "" & arguments.method;
	
	var generatedFileName = uniqueName & ".js";

	IncludePath = IncludePath & generatedFileName;

	var absPath = APPLICATION.BASE_PATH & "\views\" & arguments.directory & "\includes\" & generatedFileName;	

	var primaryKey = arguments.pKey;
	
	try {
		
		//OVERWRITE

		if ( arguments.overwrite ) {
		
			writeOutput('<div id="' & uniqueName & '"></div>');

			//GetURL();

			throw("overwrite", "Any");	
		}

		//GET EXISTING
		
		else if ( FileExists(absPath) ) {
			
			writeOutput('<div id="' & uniqueName & '"></div>') ;

			//GetURL();
			
			if (arguments.include) {
				
				writeOutput('<script>' & chr(10) );

				include IncludePath;

				writeOutput('</script>');	
			}
		}

		//FILE DOES NOT EXIST
		
		else {
			
			writeOutput('<div id="' & uniqueName & '"></div>') ;

			//GetURL();

			throw("nonexistance", "Any");
		}
		
	}
	
	catch(Any e) {
		
		var generatedOutput = '// JavaScript Document' & chr(10) ;
		
		var qModel = GetDbInfo( type = "columns", table = arguments.model );

		if ( primaryKey == "" ) {

			primaryKey = GetKey( qModel );
		}
				
		generatedOutput = generatedOutput &  '$(document).ready(function () {' & chr(10) & chr(10);

		if (arguments.component != "" ) {
			generatedOutput = generatedOutput &  '	var serviceURL = kendoURL + "/' & arguments.component & '?RemoteToken=" + RemoteToken + "&method=",' & chr(10) & chr(10) ;
		}
		else {
			generatedOutput = generatedOutput &  '	var serviceURL = kendoURL + "/services/' & arguments.model & 'Service.cfc?RemoteToken=" + RemoteToken + "&method=",' & chr(10) & chr(10) ;
		}

		
	
		generatedOutput = generatedOutput &  '	dataSource = new kendo.data.DataSource({' & chr(10) & chr(10);

		generatedOutput = generatedOutput &  '		transport: {' & chr(10) & chr(10);

		generatedOutput = generatedOutput &  '			read:  {' & chr(10) & chr(10);

		generatedOutput = generatedOutput &  '				url: serviceURL + "' &  ReadMethod &  '",' &  chr(10) & chr(10);
			
		if (arguments.CRUD) {
		
			generatedOutput = generatedOutput &  '				dataType: "' & arguments.dataType & '"' & chr(10) ;

			generatedOutput = generatedOutput &  '			},' & chr(10) & chr(10) ;

			generatedOutput = generatedOutput &  '			update: {' & chr(10) ;

			generatedOutput = generatedOutput &  '				url: serviceURL + "' & UpdateMethod & '",' & chr(10) & chr(10);

			generatedOutput = generatedOutput &  '				dataType: "' & arguments.dataType & '"' & chr(10) ;

			generatedOutput = generatedOutput &  '			},' & chr(10)  & chr(10);

			generatedOutput = generatedOutput &  '			destroy: {' & chr(10) & chr(10);

			generatedOutput = generatedOutput &  '				url: serviceURL + "' & DeleteMethod & '",' & chr(10) & chr(10);

			generatedOutput = generatedOutput &  '				dataType: "' & arguments.dataType & '"' & chr(10) ;

			generatedOutput = generatedOutput &  '			},' & chr(10) & chr(10);

			generatedOutput = generatedOutput &  '			create: {' & chr(10) & chr(10);

			generatedOutput = generatedOutput &  '				url: serviceURL + "' & CreateMethod & '",' & chr(10) & chr(10);
		}
		
		generatedOutput = generatedOutput &  '				dataType: "' & arguments.dataType & '"' & chr(10) ;

		generatedOutput = generatedOutput &  '			},' & chr(10) & chr(10);

		generatedOutput = generatedOutput &  '			parameterMap: function(options, operation) {' & chr(10)  & chr(10);

		generatedOutput = generatedOutput &  '				if (operation !== "read" && options.models) {' & chr(10)  & chr(10);

		generatedOutput = generatedOutput &  '					return {models: kendo.stringify(options.models)};' & chr(10) ;

		generatedOutput = generatedOutput &  '				}' & chr(10) ;

		generatedOutput = generatedOutput &  '			}' & chr(10) ;

		generatedOutput = generatedOutput &  '		},' & chr(10)  & chr(10);

		generatedOutput = generatedOutput &  '		batch: true,' & chr(10)  & chr(10);
		
		if (arguments.pageSize) {
			
			generatedOutput = generatedOutput &  '		pageSize: ' & arguments.pageSize & ',' & chr(10)  & chr(10);	
		}
		
		generatedOutput = generatedOutput &  '		schema: {' & chr(10)  & chr(10);

		generatedOutput = generatedOutput &  '			model: {' & chr(10)  & chr(10);

		generatedOutput = generatedOutput &  '				id: "' & primaryKey & '",' & chr(10)  & chr(10);

		generatedOutput = generatedOutput &  '				fields: {' & chr(10)  & chr(10);
		
		for (col = 1; col LTE qModel.RecordCount; col++) {
			
			if (qModel["IS_PRIMARYKEY"][col]) {
				
				generatedOutput = generatedOutput & '					' & qModel["COLUMN_NAME"][col] & ': { editable: false, nullable: true }'  ;
				
				if (col NEQ qModel.RecordCount) {
					
					generatedOutput = generatedOutput &  ',' & chr(10);
				}
			}
			
			else {
			
				generatedOutput = generatedOutput & '					' & qModel["COLUMN_NAME"][col]

					& ': { ' 

					& GetColumnInfo(

						qModel["TYPE_NAME"][col],

						qModel["REMARKS"][col],

						qModel["ORDINAL_POSITION"][col],

						qModel["IS_NULLABLE"][col],

						qModel["COLUMN_DEFAULT_VALUE"][col]) 

					& ' }' ;
				
				if (col NEQ qModel.RecordCount) {
					
					generatedOutput = generatedOutput &  ',' & chr(10) & chr(10);
				}
			}
		}
		
		generatedOutput = generatedOutput & chr(10) & '					}' & chr(10);

		generatedOutput = generatedOutput &  '				}' & chr(10) ;

		generatedOutput = generatedOutput &  '			}' & chr(10) ;

		generatedOutput = generatedOutput &  '		} );' & chr(10) & chr(10);
			
		generatedOutput = generatedOutput &  '	var grid = $("##' & uniqueName & '").kendoGrid({' & chr(10)  & chr(10);

		generatedOutput = generatedOutput &  '		dataSource: dataSource,' & chr(10)  & chr(10);

		generatedOutput = generatedOutput &  '		navigatable: true,' & chr(10)  & chr(10);
		
		if (arguments.pageSize NEQ 0) {
			
			generatedOutput = generatedOutput &  '		pageable: true,' & chr(10)  & chr(10);
			generatedOutput = generatedOutput &  '		scrollable: false,' & chr(10)  & chr(10);
		}
		
		generatedOutput = generatedOutput &  '		sortable: true,' & chr(10)  & chr(10);

		generatedOutput = generatedOutput &  '		filterable: false,' & chr(10)  & chr(10);
		
		if (arguments.CRUD) {
			
			generatedOutput = generatedOutput &  '		editable: "inline",' & chr(10)  & chr(10);

			//generatedOutput = generatedOutput &  '		toolbar: ["create", "save", "cancel"],' & chr(10) & chr(10) ;
		}
		
		//generatedOutput = generatedOutput &  '		height: ' & arguments.height & ',' & chr(10) & chr(10);

		generatedOutput = generatedOutput &  '		columns: [' & chr(10) & chr(10);

		generatedOutput = generatedOutput & '			{ filterable: false, sortable: false, template: kendo.template($("##' & arguments.model & 'Template").html()), width: "125px" },' & chr(10) & chr(10);
		
		for (col = 1; col LTE qModel.RecordCount; col++) {
			
			if (NOT qModel["IS_PRIMARYKEY"][col]) {
				
				generatedOutput = generatedOutput &  '			{ field: "' & qModel["COLUMN_NAME"][col] & '", title: "' & _Tron.CamelToSpace(qModel["COLUMN_NAME"][col]) & '"}' ;
					
					if (arguments.CRUD) {
					
						generatedOutput = generatedOutput & ',' & chr(10) & chr(10);
					}
					
					else if ( col NEQ qModel.RecordCount ) {
						
						generatedOutput = generatedOutput & ',' & chr(10) & chr(10);
					}
			}
		}
		
		if (arguments.CRUD) {
			
			generatedOutput = generatedOutput &  '			{ command: ["edit", "destroy"], title: "&nbsp;", width: "200px" }]' & chr(10) ;
		}
		
		else {
			
			generatedOutput = generatedOutput &  '		]' & chr(10);
		}
		
		generatedOutput = generatedOutput &  '	} );' & chr(10);

		generatedOutput = generatedOutput &  '} );' & chr(10);
				
		FileWrite("memory", "#generatedOutput#"); 

		var fileOutput = FileRead("memory");

		FileWrite(absPath, "#fileOutput#");
		
		if (arguments.include) {
				
			writeOutput('<script>' & chr(10) );

			include IncludePath;

			writeOutput('</script>');	
		}
	}
}

private string function GetURL() {
	
	writeOutput( chr(10) & '<script>' & chr(10) );

	writeOutput( 
		
		'$(document).ready(function() { ' & chr(10)
			& '#toScript( kendoURL , "kendoURL")#' & chr(10)
			& '#toScript( SESSION.REMOTE_TOKEN , "RemoteToken")#' & chr(10)
		& '});' & chr(10)
	);

	writeOutput('</script>');
}

private query function GetDbInfo(
	
 	string type = "tables",
 	string dbname,
 	string password,
 	string username,
 	string pattern,
 	string table
 ) {
	
 	//if ( APPLICATION.RAILO ) {
//
// 		//Railo Version
// 		dbinfo
// 			datasource = Datasource
// 			name = "d"
// 			table = arguments.table
// 			type = arguments.type;
// 	}
//
// 	else {

 		//Adobe ColdFusion Version
 		d = new dbinfo( datasource = #Datasource#, table = #arguments.table#, type = #arguments.type# ).columns();
 	//}
	
 	return d;
 }

private string function GetKey(
	
	required query model
) {
	
	//model argument must come from GetDbInfo

	var qModel = arguments.model;
	
	//ADD SORT BY IS_PRIMARYKEY AND LOOP WILL NO LONGER BE NECESSARY
	
	for (col = 1; col LTE qModel.RecordCount; col++) {
		
		if (qModel["IS_PRIMARYKEY"][col]) {
			
			primaryKey = qModel["COLUMN_NAME"][col];
			break;
		}
	}
	
	return primaryKey;
}

private string function GetColumnInfo(

	required string colType = "", 
	string remarks = "", 
	string position = "", 
	string IS_NULLABLE = false,
	string defaultValue = "" 
	
	) {
	
	var colInfo = "";

	var numericDataTypes = "INT,TINYINT,DOUBLE,INTEGER";

	var stringDataTypes = "VARCHAR,LONGTEXT,TEXT";

	var booleanDataTypes = "BIT,SMALLINT";
	
	if ( arguments.IS_NULLABLE EQ "NO" ) {
		
		arguments.IS_NULLABLE = "false";
	}
	
	else {
	
		arguments.IS_NULLABLE = "true";	
	}
	
	if ( Find(arguments.colType, numericDataTypes) ) {
		
		colInfo = 'type: "number"';
		
		if ( arguments.IS_NULLABLE EQ "false" ) {
		
			colInfo = colInfo & ', validation: { required: true, nullable: ' & arguments.IS_NULLABLE & ' }';
			
			if ( arguments.defaultValue NEQ "" ) {
		
				colInfo = colInfo & ', defaultValue: "' & arguments.defaultValue & '"';
			}
		}
		
		else {
		
			colInfo = colInfo & ', validation: { required: false, nullable: ' & arguments.IS_NULLABLE & ' }';
			
			if ( arguments.defaultValue NEQ "" ) {
		
				colInfo = colInfo & ', defaultValue: "' & arguments.defaultValue & '"';
			}
		}
	}
	
	else if ( Find(arguments.colType, booleanDataTypes) ) {
					
		colInfo = 'type: "boolean"';
		
		if ( arguments.IS_NULLABLE EQ "false" ) {
		
			colInfo = colInfo & ', validation: { required: true, nullable: ' & arguments.IS_NULLABLE & ' }';
			
			if ( arguments.defaultValue NEQ "" ) {
		
				colInfo = colInfo & ', defaultValue: "' & arguments.defaultValue & '"';
			}
		}
		
		else {
		
			colInfo = colInfo & ', validation: { required: false, nullable: ' & arguments.IS_NULLABLE & ' }';
			
			if ( arguments.defaultValue NEQ "" ) {
		
				colInfo = colInfo & ', defaultValue: "' & arguments.defaultValue & '"';
			}

			else {

				colInfo = colInfo & ', defaultValue: "b' & "'" & "0'" & '"'; 
			}
		}
	}
	
	else if ( Find(arguments.colType, stringDataTypes) ) {
		
		if ( arguments.position EQ "2" ) {
		
			colInfo = 'type: "string"';
		
			if ( arguments.IS_NULLABLE EQ "false" ) {
			
				colInfo = colInfo & ', validation: { required: true, nullable: ' & arguments.IS_NULLABLE & ' }';
				
				if ( arguments.defaultValue NEQ "" ) {
			
					colInfo = colInfo & ', defaultValue: "' & arguments.defaultValue & '"';
				}
			}
			
			else {
			
				colInfo = colInfo & ', validation: { required: false, nullable: ' & arguments.IS_NULLABLE & ' }';
				
				if ( arguments.defaultValue NEQ "" ) {
			
					colInfo = colInfo & ', defaultValue: "' & arguments.defaultValue & '"';
				}
			}
		}
		
		else {
			
			colInfo = 'type: "string"';
		
			if ( arguments.IS_NULLABLE EQ "false" ) {
			
				colInfo = colInfo & ', validation: { required: true, nullable: ' & arguments.IS_NULLABLE & ' }';
				
				if ( arguments.defaultValue NEQ "" ) {
			
					colInfo = colInfo & ', defaultValue: "' & arguments.defaultValue & '"';
				}
			}
			
			else {
			
				colInfo = colInfo & ', validation: { required: false, nullable: ' & arguments.IS_NULLABLE & ' }';
				
				if ( arguments.defaultValue NEQ "" ) {
			
					colInfo = colInfo & ', defaultValue: "' & arguments.defaultValue & '"';
				}
			}
		}
	}
	
	else {
		
		colInfo = 'type: "' & arguments.colType & '"';
				
		if ( arguments.IS_NULLABLE EQ "false" ) {
		
			colInfo = colInfo & ', validation: { required: true, nullable: ' & arguments.IS_NULLABLE & ' }';
			
			if ( arguments.defaultValue NEQ "" ) {
		
				colInfo = colInfo & ', defaultValue: "' & arguments.defaultValue & '"';
			}
		}
		
		else {
		
			colInfo = colInfo & ', validation: { required: false, nullable: ' & arguments.IS_NULLABLE & ' }';
			
			if ( arguments.defaultValue NEQ "" ) {
		
				colInfo = colInfo & ', defaultValue: "' & arguments.defaultValue & '"';
			}
		}
	}

	return colInfo;
}
</cfscript>
