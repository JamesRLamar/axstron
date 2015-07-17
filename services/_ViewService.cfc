<cfcomponent hint="I am a View Service" output="false" extends="_Tron">
	
	<cfscript>
		public void function GetRequestedView( layout = "bootstrap", any ViewStruct = "" ) {
								
			try 
			{
				if (NOT IsStruct(ViewStruct)
				){
					ViewStruct = {};
					ViewStruct[1]["Section"] = Request.Section;
					ViewStruct[1]["View"] = Request.View;
				}

				Request.ViewPath = {};

				//writeDump(var = ViewStruct, label="ViewStruct");

				for (view in ViewStruct) {

					Request.ViewPath[view]["path"] = "../views/" & ViewStruct[view]["Section"] & "/" & ViewStruct[view]["View"] & ".cfm";
					//writeDump(var = Request.ViewPath, label = "Request.ViewPath");
				}
								
				var LayoutPath = "../layouts/" & arguments.Layout & ".cfm";
				
				include LayoutPath;
			}
			catch(Any e) {writeDump(e);}
		}

		public boolean function GetMobileBrowser() {
			
			var isMobile = false;
			
			if  (reFindNoCase("(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino",CGI.HTTP_USER_AGENT) GT 0 OR reFindNoCase("1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-",Left(CGI.HTTP_USER_AGENT,4)) GT 0) {
				
				isMobile = true;
			}
			
			return isMobile;
		}
		
		public string function SetViewNameFormat( required string beforeString ) {
		
			return uCase(left(arguments.beforeString,1)) & right(arguments.beforeString,len(arguments.beforeString)-1);
		}
			
		public void function RebuildViewLinks(
			purge = false
			) {
			
			//GET DIRECTORY OF SECTIONS FROM FILESYSTEM
			
			var sectionDir = DirectoryList( getDirectoryFromPath(ExpandPath("views\")), false, "query");
		
			var sectionArray = ArrayNew(1);
		
			var viewArray = ArrayNew(1);
			
			//LOOP THROUGH SECTIONS DIRECTORY
			
			for (section = 1; section LTE sectionDir.RecordCount; section++) {
				
				//SET Section NAME EQUAL TO Section FOLDER NAME
			
				var sectionName = sectionDir["name"][section];
				
				//CREATE APPENDED LIST OF SECTIONS
				
				//WILL BE USED FOR DELETING MISSING SECTIONS FROM THE DIRECTORY
				
				var sectionArray[section] = sectionName;
				
				var newSection = 0;
				
				
				//EXCLUDE ALL SVN AND NOTES DIRECTORIES
				
				if ( Find(".svn", sectionName) 
				
					//OR Find("prop-base", sectionName) 
				
					//OR Find("props", sectionName) 
				
					//OR Find("text-base", sectionName) 
				
					//OR Find("tmp", sectionName)

					OR Find(".git", sectionName)
				
					//OR Find("notes", sectionName) 
					) {
						
					//DO NOTHING
				}
					
				else {
					
					writeOutput( "<h2>Section: " & sectionName & "</h2>" );
					
					var qSection = QuerySection(sectionName);
					
					if ( IsNull(qSection) ) {
						
						//INSERT NEW Section
					
						var CreateSection = CreateSection(sectionName, sectionName);
					
						var newSection = 1;
					
						writeOutput( "<h3>Inserted: " & sectionName & "</h3>" );
					}
					
					//SET PATH WITHIN CURRENT Section
					
					var sectionPath = "views\" & sectionName & "\";
					
					
					//GET DIRECTORY OF ViewS IN CURRENT Section
					
					var viewDir = DirectoryList( getDirectoryFromPath(ExpandPath(sectionPath)), false, "query");
					
					var viewList = "";
							
					//LOOP THROUGH ViewS OF CURRENT Section
					
					for (view = 1; view LTE viewDir.RecordCount; view++) {
				
						var viewName = viewDir["name"][view];
						
						//EXCLUDE ALL SVN AND NOTES DIRECTORIES
					
						if ( Find("svn", viewName)
					
							//OR Find("prop-base", viewName) 
					
							//OR Find("props", viewName) 
					
							//OR Find("text-base", viewName) 
					
							//OR Find("tmp", viewName)
					
							//OR Find("notes", viewName)
					
							OR Find("includes", viewName) 
							
							OR Find(".git", viewName) 
					
							OR Len(viewName) IS 0) {
								
							//DO NOTHING
						}
		
						else {
							
							//REMOVE FILE EXTENSION FROM VIEW NAME
					
							var count = Len(viewName) - 4;
					
							var viewName = Left(viewName,count);
					
							
							//CREATE APPENDED LIST OF VIEWS
					
							//WILL BE USED FOR DELETING MISSING ViewS FROM THE DIRECTORY
					
							viewList = viewList & "," & viewName;
					
							var viewArray[section] = viewList;
							
							writeOutput( "<li>view: " & viewName  & "</li>");
							
							//Section IS NEW SO VIEW MUST BE NEW
					
							if ( newSection ) {
								
								var currentViewID = CreateView(viewName, viewName, sectionName);
					
								writeOutput( "<p>Inserted View: " & viewName & "</p>" );
	
							}
							
							//Section EXISTS SO CHECK TO SEE IF VIEW EXISTS
					
							else {
							
								var qView = SelectWhereViewAndSection(viewName, sectionName);
								
								//VIEW EXISTS
					
								if ( qView.RecordCount ) {
									
									//SET CURRENT VIEW ID
					
									var currentViewID = qView.ViewId;	
								}
								
								//VIEW IS NEW
					
								else {
									
									var currentViewID = CreateView(viewName, viewName, sectionName);
					
									writeOutput( "<p>Inserted View: " & viewName & "</p>" );
								}
							}
							
						}
					} //END OF LOOP THROUGH VIEWS OF CURRENT Section
				}
			}// END OF LOOP THROUGH SECTIONS DIRECTORY
			
			if ( arguments.purge ) {
			
				writeOutput( "<h2>Sections to Delete:</h2>" );
				
				//QUERY ALL SECTIONS
				
				var ExistingSectionArray = EntityLoad("_View", { IsSection = 1 } );
				
				//LOOP THROUGH Section QUERY AND Section ARRAY AND REMOVE MISSING SECTIONS AND THEIR CHILDREN FROM THE DATABASE
				
				for (existingSection = 1; existingSection LTE ArrayLen(ExistingSectionArray); existingSection++) {
					
					var sectionMatch = false;
					
					var existingSectionID = ExistingSectionArray[existingSection].GetViewId();
					
					var existingSectionName = ExistingSectionArray[existingSection].GetFileName();
					
					for (s = 1; s LTE ArrayLen(sectionArray); s++) {
						
						if ( existingSectionName IS sectionArray[s] ) {
							
							var sectionMatch = true;
				
							break;
						}
					}
					
					if ( sectionMatch IS false ) {
						
						writeOutput( "<li>Delete Section: " & existingSectionName & "</li>" );
						
						//DELETE Section
				
						var DeleteSection = DeleteView(existingSectionID);
						
						//DELTE ALL ViewS UNDER Section
				
						var DeleteViews = DeleteViewsBYSection(existingSectionName);
					}
				}
			}
			
			if ( arguments.purge ) {
			
				//LOOP THROUGH Section ARRAY 
				
				//LOOP THROUGH View ARRAY AND REMOVE MISSING ViewS
				
				for (section = 1; section LTE ArrayLen(sectionArray); section++) {
					
					var ExistingViewArray = EntityLoad("_View", { SectionFolderName = sectionArray[section] } );
				
					for (existingView = 1; existingView LTE ArrayLen(ExistingViewArray); existingView++) {
						
						var existingViewid = ExistingViewArray[existingView].GetViewId();
				
						var existingViewname = ExistingViewArray[existingView].GetFileName();
			
						if (  NOT viewArray[section] CONTAINS existingViewname ) {
							
							writeOutput( "<li>Delete View: " & existingViewname & "</li>" );
				
							var DeleteView = DeleteView(existingViewid);
						}
					}
				}
			}
		}

		public any function QueryAllPublishedSections() {

			var qResults = EntityLoad("_View", {IsPublished = 1, IsSection = 1}, "ViewOrder ASC");

			if ( NOT IsNull(qResults) ) {
				return EntityToQuery(qResults);
			}
		}

		public any function QueryPublishedViewsBySection(string SectionFolderName) {

			var qResults = ORMExecuteQuery("from _View where IsPublished = 1 AND SectionFolderName=:SectionFolderName ORDER BY ViewOrder ASC, DisplayName ASC", {SectionFolderName = arguments.SectionFolderName});

			if ( NOT IsNull(qResults) ) {
				return EntityToQuery(qResults);
			}
		}

		public any function QueryPublishedSection(string FileName) {

			var qResults = EntityLoad("_View", {IsPublished = 1, IsSection = 1, FileName = arguments.FileName}, true);
			
			if ( NOT IsNull(qResults) ) {
				return EntityToQuery(qResults);
			}
			
		}

		public any function QuerySection(string FileName) {

			var qResults = EntityLoad("_View", { IsSection = 1, FileName = arguments.FileName}, true);
			
			if ( NOT IsNull(qResults) ) {
				return EntityToQuery(qResults);
			}
			
		}

		public any function QueryPublishedView(string FileName, string SectionFolderName) {

			var qResults = EntityLoad("_View", {IsPublished = 1, FileName = arguments.FileName, SectionFolderName = arguments.SectionFolderName}, true);

			if ( NOT IsNull(qResults) ) {
				return EntityToQuery(qResults);
			}
		}

		public numeric function CreateView(
			 string FileName
			,string DisplayName
			,string SectionFolderName
		) {
			if ( arguments.FileName EQ "Default" OR arguments.FileName EQ "default" ) {
				_View = New models._View(
					  FileName = arguments.FileName
					, DisplayName = "Main"
					, SectionFolderName = arguments.SectionFolderName
					, IsSection = 0
					, IsPublished = 1
					, ViewOrder = 1
				);
			}

			else if ( Find("ReadForm", arguments.FileName) OR Find("UpdateForm", arguments.FileName) ) {
				_View = New models._View(
					  FileName = arguments.FileName
					, DisplayName = "Main"
					, SectionFolderName = arguments.SectionFolderName
					, IsSection = 0
					, IsPublished = 0
					, ViewOrder = 99
				);
			}

			else {
				_View = New models._View(
					  FileName = arguments.FileName
					, DisplayName = arguments.DisplayName
					, SectionFolderName = arguments.SectionFolderName
					, IsSection = 0
					, IsPublished = 1
					, ViewOrder = 99
				);
			}
			EntitySave(_View);
			return _View.GetViewId();
		}

		public numeric function CreateSection(
			 string FileName
			,string DisplayName
			,string SectionFolderName
		) {

			_View = New models._View(
				  FileName = arguments.FileName
				, DisplayName = arguments.DisplayName
				, IsSection = 1
				, IsPublished = 1
				, ViewOrder = 99
			);
			EntitySave(_View);
			return _View.GetViewId();
		}
	</cfscript>
	
	<cffunction name="SelectSuperadminSection" access="public" returntype="query">
		<cfquery name="qSection">
		SELECT * FROM _View
		Where FileName = "flynn"
		</cfquery>
		<cfreturn qSection>
	</cffunction>
	
	<cffunction name="SelectWhereViewANDSection" access="public" returntype="query">
		<cfargument name="FileName" required="yes">
		<cfargument name="SectionFolderName" required="yes">
		<cfquery name="qView">
		SELECT * FROM _View
		Where FileName = "#arguments.FileName#"
		AND SectionFolderName = "#arguments.SectionFolderName#"
		</cfquery>
		<cfreturn qView>
	</cffunction>
	
	<cffunction name="InsertSection" access="public" returntype="numeric">
		<cfargument name="FileName" required="yes">
		<cfargument name="DisplayName" required="yes">
		<cfquery result="InsertSection">
		INSERT INTO _View
		(FileName, DisplayName, IsSection, IsPublished, ViewOrder, Icon)
		VALUES
		("#arguments.FileName#", "#camelToSpace(arguments.DisplayName, true)#", 1, 1, 99, "default")
		</cfquery>
		<cfset sectionID = InsertSection.GENERATED_KEY>
		<cfreturn sectionID>
	</cffunction>
	
	<!--- <cffunction name="CreateView" access="public" returntype="numeric">
		<cfargument name="FileName" required="yes">
		<cfargument name="DisplayName" required="yes">
		<cfargument name="SectionFolderName" required="yes">
		<cfif arguments.FileName EQ "Default" OR arguments.FileName EQ "default">
			<cfset defaultName = "Main">
			<cfelse>
			<cfset defaultName = arguments.FileName>
		</cfif>
		<cfquery result="qResult">
		INSERT INTO _View
		(FileName, DisplayName, SectionFolderName, IsSection, IsPublished, ViewOrder, Icon)
		VALUES
		("#defaultName#","#camelToSpace(arguments.DisplayName, true)#", "#arguments.SectionFolderName#", 0, 1, 99, "default.png")
		</cfquery>
		<cfreturn qResult.GENERATED_KEY>
	</cffunction> --->
	
	<cffunction name="DeleteViewsBySection" access="public" returntype="void">
		<cfargument name="FileName" required="yes">
		<cfquery>
		DELETE FROM _View
		Where SectionFolderName = "#arguments.FileName#"
		</cfquery>
	</cffunction>
	
	<cffunction name="DeleteView" access="public" returntype="void">
		<cfargument name="ViewId" required="yes">
		<cfquery>
		DELETE FROM _View
		Where ViewId = #arguments.ViewId#
		</cfquery>
	</cffunction>
	
	<!--- <cffunction name="JSONPView" access="remote" returntype="any" returnformat="plain" output="false">
		<cfargument name="callback" type="string" required="false">
		<cfquery name="qView">
		Select 
		_View.DisplayName, 
		_View.SectionId, 
		_View.ViewId, 
		_View.Content , 
		_View.FileName, 
		_View.ViewOrder, 
		_View.PUBLISHED,
		_View.DisplayName AS sectionname 
		FROM _View
		JOIN _View 
		ON _View.SectionId = _View.SectionId
		</cfquery>
		<cfset var data = qView>
		
		<!--- serialize --->
		<cfset data = serializeJSON(data)>
		
		<!--- wrap --->
		<cfif structKeyExists(arguments, "callback")>
			<cfset data = arguments.callback & "(" & data & ");">
		</cfif>
		<cfreturn data>
	</cffunction> --->
	
	<!--- <cffunction name="JSONView" access="remote" returntype="any" returnformat="JSON" output="false">
		<cfargument name="callback" type="string" required="false">
		<cfquery name="qView">
		Select 
		_View.DisplayName, 
		_View.SectionId, 
		_View.ViewId, 
		_View.Content, 
		_View.FileName, 
		_View.ViewOrder, 
		_View.PUBLISHED,
		_View.DisplayName AS sectionname 
		FROM _View
		JOIN _View 
		ON _View.SectionId = _View.SectionId
		</cfquery>
		<cfset var data = qView>
		<cfset data = QueryToStruct( data )>
		<!--- serialize --->
		<cfset data = serializeJSON(data)>
		<cfreturn data>
	</cffunction> --->
	
	<cffunction name="SelectWhereViewBySectionID" access="public" returntype="query">
		<cfargument name="viewName" required="yes">
		<cfargument name="sectionID" required="yes">
		<cfquery name="qView">
		Select ViewId FROM _View
		Where FileName = "#arguments.viewName#"
		AND SectionId = #arguments.sectionID#
		</cfquery>
		<cfreturn qView>
	</cffunction>
	
</cfcomponent>
