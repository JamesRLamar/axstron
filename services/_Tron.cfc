<cfcomponent name="_Tron" output="false" extends="scaffold.Scaffold">
	<cfscript>
	include "functions/authentication.cfm";
	include "functions/crud.cfm";
	include "functions/dbinfo.cfm";

	public boolean function VerifyRemoteToken(string RemoteToken) {
		
		//add comparison between hash and hash of logged in user id
		//store user id as cfloginuser username
		var verified = false;
		if ( SESSION.REMOTE_TOKEN == arguments.RemoteToken ) {
			verified = true;
		}
		return verified;
	}
	
	//METHODS MUST BE REGISTERED IN _AccessMethod TABLE FOR EACH VIEW THEY ARE CALLED IN
	
	public boolean function GrantMethodAccess(string RemoteToken, string Component, string MethodName) output="true" {
		
		var verified = false;
		
		_MethodArray = EntityLoad("_AccessMethod", {Component = arguments.Component, MethodName = arguments.MethodName});

		writeOutput("_MethodArray");
		
		if ( VerifyRemoteToken(arguments.RemoteToken) ) {

			// ONLY RETURNS TRUE FOR FLYNN
			if ( GrantViewAccess() ) {

				verified = true;
				return verified;
				break;
			}

			else if ( ArrayLen(_MethodArray) >= 1 ) {

				for (i = 1; i LTE ArrayLen(_MethodArray); i++) { 
				
					var _Method = _MethodArray[i];
					
					if ( GrantViewAccess( Section = _Method.GetSection(), View = _Method.GetView() ) ) {
						
						verified = true;
						return verified;
						break;
					}
				}	
			}
		}
		return verified;
	}
	
	public any function GrantViewAccess(
	
		 string RoleName = GetUserRoles()
		
		,string Section = ""
		
		,string View = ""
		
	) output="false" {
					
		var accessReply = false;
					
		if ( arguments.RoleName == "Flynn" ) {
			
			accessReply = true;
			
			writeOutput("<h3>FLYNN</h3>");
			
			return accessReply;
		
			break;
		}
		
		else {
			
			var _AccessViewArray = EntityLoad("_AccessView", { RoleName = arguments.RoleName } );
			
			writeDump(var = _AccessViewArray, label= "_AccessArray");
			
			for (i = 1; i LTE ArrayLen(_AccessViewArray); i++) { 
				
				var _AccessView = _AccessViewArray[i];
				
				writeDump(_AccessView);
				
				writeOutput( "<h3>Access Section: " & _AccessView.GetSection() & " | Arguments Section: " & arguments.Section );
				
				if ( _AccessView.GetSection() == "ALL" ) {
						
					accessReply = true;
					
					return accessReply;
								
					break;
				}
				
				else if ( _AccessView.GetSection() == arguments.Section ) {
														
					if ( _AccessView.GetView() EQ "ALL" ) {
						
						accessReply = true;
						
						return accessReply;
				
						break;
					}
					
					else if ( _AccessView.GetView() == arguments.View ) {
							
						accessReply = true;
						
						return accessReply;
				
						break;
					}
				}
			}			
		}

		return accessReply;
	}
	</cfscript>
	<cffunction name="InitApplication" returntype="void">		
		<cfquery>
			DROP TABLE IF EXISTS _accessmethod;
		</cfquery>
		<cfquery>
		CREATE TABLE _accessmethod (
		  AccessMethodId int(11) NOT NULL AUTO_INCREMENT,
		  Component varchar(255) DEFAULT NULL,
		  MethodName varchar(255) DEFAULT NULL,
		  Section varchar(255) DEFAULT NULL,
		  View varchar(255) DEFAULT NULL,
		  PRIMARY KEY (AccessMethodId)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8;
		</cfquery>
		<cfquery>

		-- ----------------------------
		-- Records of _accessmethod
		-- ----------------------------

		-- ----------------------------
		-- Table structure for _accessview
		-- ----------------------------
		DROP TABLE IF EXISTS _accessview;
		</cfquery>
		<cfquery>
		CREATE TABLE _accessview (
		  AccessViewId int(11) NOT NULL AUTO_INCREMENT,
		  Section varchar(255) DEFAULT NULL,
		  View varchar(255) DEFAULT NULL,
		  RoleName varchar(255) DEFAULT NULL,
		  PRIMARY KEY (AccessViewId)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8;
		</cfquery>
		<cfquery>

		-- ----------------------------
		-- Records of _accessview
		-- ----------------------------

		-- ----------------------------
		-- Table structure for _error
		-- ----------------------------
		DROP TABLE IF EXISTS _error;
		</cfquery>
		<cfquery>
		CREATE TABLE _error (
		  ErrorId int(11) NOT NULL AUTO_INCREMENT,
		  ErrorName longtext,
		  StackTrace longtext,
		  ErrorDate varchar(255) DEFAULT NULL,
		  PRIMARY KEY (ErrorId)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8;
		</cfquery>
		<cfquery>

		-- ----------------------------
		-- Records of _error
		-- ----------------------------

		-- ----------------------------
		-- Table structure for _user
		-- ----------------------------
		DROP TABLE IF EXISTS _user;
		</cfquery>
		<cfquery>
		CREATE TABLE _user (
		  UserId int(11) NOT NULL AUTO_INCREMENT,
		  UserName varchar(255) DEFAULT NULL,
		  Email varchar(255) DEFAULT NULL,
		  Password varchar(255) DEFAULT NULL,
		  RoleName varchar(255) DEFAULT NULL,
		  Status varchar(255) DEFAULT NULL,
		  LastLogin varchar(255) DEFAULT NULL,
		  PRIMARY KEY (UserId)
		) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
		</cfquery>
		<cfquery>

		-- ----------------------------
		-- Records of _user
		-- ----------------------------
		INSERT INTO _user VALUES ('1', 'AXS Tron', '#APPLICATION.SUPPORT_EMAIL#', '#HashPassword("admin")#', 'Flynn', 'Active', '');
		</cfquery>
		<cfquery>

		-- ----------------------------
		-- Table structure for _view
		-- ----------------------------
		DROP TABLE IF EXISTS _view;
		</cfquery>
		<cfquery>
		CREATE TABLE _view (
		  ViewId int(11) NOT NULL AUTO_INCREMENT,
		  SectionFolderName varchar(255) DEFAULT NULL,
		  DisplayName varchar(255) DEFAULT NULL,
		  FileName varchar(255) DEFAULT NULL,
		  ViewOrder int(11) DEFAULT NULL,
		  IsPublished int(11) DEFAULT NULL,
		  IsSection int(11) DEFAULT NULL,
		  Icon varchar(255) DEFAULT NULL,
		  Content longtext,
		  PRIMARY KEY (ViewId)
		) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;
		</cfquery>
		<cfquery>

		-- ----------------------------
		-- Records of _view
		-- ----------------------------
		INSERT INTO _view VALUES ('1', '', 'Clu', 'clu', '99', '1', '1', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('2', 'clu', 'A Test', 'aTest', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('3', 'clu', 'Break Test', 'BreakTest', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('4', 'clu', 'Main', 'default', '1', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('5', 'clu', 'Encrypt', 'encrypt', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('6', 'clu', 'Form Insert', 'FormInsert', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('7', 'clu', 'Get Artists', 'getArtists', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('8', 'clu', 'Glue', 'glue', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('9', 'clu', 'Hash', 'hash', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('10', 'clu', 'Hash Passwords', 'hashPasswords', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('11', 'clu', 'Hash Test', 'hashTest', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('12', 'clu', 'Hide Textarea', 'HideTextarea', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('13', 'clu', 'Json Array', 'jsonArray', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('14', 'clu', 'Json Insert', 'jsonInsert', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('15', 'clu', 'J S O N Parse Test', 'JSONParseTest', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('16', 'clu', 'Json Update', 'jsonUpdate', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('17', 'clu', 'Kendo Bind', 'kendoBind', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('18', 'clu', 'Kendo Grid', 'kendoGrid', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('19', 'clu', 'Kendo Grid Filter By Auto Suggest', 'kendoGridFilterByAutoSuggest', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('20', 'clu', 'Listing Create Form', 'ListingCreateForm', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('21', 'clu', 'Main', 'ListingReadForm', '99', '0', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('22', 'clu', 'Main', 'ListingUpdateForm', '99', '0', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('23', 'clu', 'O R M Get Generated Key', 'ORMGetGeneratedKey', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('24', 'clu', 'O R M Passing Child Object', 'ORMPassingChildObject', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('25', 'clu', 'O R M Record Count', 'ORMRecordCount', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('26', 'clu', 'O R M Reload', 'ORMReload', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('27', 'clu', 'O R M Test9', 'ORMTest9', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('28', 'clu', 'Query Case Maintain', 'QueryCaseMaintain', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('29', 'clu', 'Tron Data Access Test', 'TronDataAccessTest', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('30', 'clu', 'Tron View Access Test', 'TronViewAccessTest', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('31', '', 'Home', 'default', '1', '1', '1', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('32', 'default', 'Main', 'Default', '1', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('33', 'default', 'Error', '_Error', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('34', 'default', 'Error Dev', '_ErrorDev', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('35', 'default', 'Error Review', '_ErrorReview', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('36', 'default', 'Send Error', '_SendError', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('37', 'default', 'User Account Form', '_UserAccountForm', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('38', 'default', 'User Create Form', '_UserCreateForm', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('39', 'default', 'User Grid', '_UserGrid', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('40', 'default', 'Main', '_UserReadForm', '99', '0', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('41', 'default', 'Main', '_UserUpdateForm', '99', '0', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('42', '', 'Flynn', 'flynn', '99', '1', '1', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('43', 'flynn', 'Build C R U D', 'BuildCRUD', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('44', 'flynn', 'Column List', 'ColumnList', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('45', 'flynn', 'Main', 'Default', '1', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('46', 'flynn', 'Navigation Purge Links', 'NavigationPurgeLinks', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('47', 'flynn', 'Navigation Rebuild Links', 'NavigationRebuildLinks', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('48', 'flynn', 'Register Remote Methods', 'RegisterRemoteMethods', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('49', 'flynn', 'Access Method Create Form', '_AccessMethodCreateForm', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('50', 'flynn', 'Access Method Grid', '_AccessMethodGrid', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('51', 'flynn', 'Main', '_AccessMethodReadForm', '99', '0', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('52', 'flynn', 'Main', '_AccessMethodUpdateForm', '99', '0', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('53', 'flynn', 'Access View Create Form', '_AccessViewCreateForm', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('54', 'flynn', 'Access View Grid', '_AccessViewGrid', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('55', 'flynn', 'Main', '_AccessViewReadForm', '99', '0', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('56', 'flynn', 'Main', '_AccessViewUpdateForm', '99', '0', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('57', 'flynn', 'User Create Form', '_UserCreateForm', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('58', 'flynn', 'User Grid', '_UserGrid', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('59', 'flynn', 'Main', '_UserReadForm', '99', '0', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('60', 'flynn', 'Main', '_UserUpdateForm', '99', '0', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('61', 'flynn', 'View Create Form', '_ViewCreateForm', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('62', 'flynn', 'View Grid', '_ViewGrid', '99', '1', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('63', 'flynn', 'Main', '_ViewReadForm', '99', '0', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('64', 'flynn', 'Main', '_ViewUpdateForm', '99', '0', '0', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('65', '', 'Login', 'login', '99', '0', '1', '', '');
		</cfquery>
		<cfquery>
		INSERT INTO _view VALUES ('66', 'login', 'Main', 'default', '1', '1', '0', '', '');
		</cfquery>
	</cffunction>

</cfcomponent>
