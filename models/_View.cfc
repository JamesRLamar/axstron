<cfcomponent hint="I am a View" output="false" persistent="true">	
	<cfproperty name="ViewId" hint="Unique ID" type="numeric" ormtype="int" fieldtype="id" generator="identity"/>
	<cfproperty name="SectionFolderName" hint="Parent Section" type="string"/>
	<cfproperty name="DisplayName" hint="Public Name" type="string"/>
	<cfproperty name="FileName" hint="File name of View" type="string"/>
	<cfproperty name="ViewOrder" hint="View Order" type="numeric" ormtype="int" default="99"/>
	<cfproperty name="IsPublished" type="numeric" ormtype="int" default="1"/>
	<cfproperty name="IsSection" type="numeric" ormtype="int" default="0"/>
	<cfproperty name="Icon" hint="Icon" type="string"/>
	<cfproperty name="Content" hint="HTML Content" type="string" ormtype="text" />

	<cfset _Tron = New services._Tron()>
	
	<cffunction name="init" hint="constructor" access="public" returntype="_View" output="false">
		<cfargument name="SectionFolderName" type="string" default="">
		<cfargument name="DisplayName" type="string" default="">
		<cfargument name="FileName" type="string" default="">
		<cfargument name="ViewOrder" type="numeric" default="99">
		<cfargument name="IsPublished" type="numeric" default="1">
		<cfargument name="IsSection" type="numeric" default="0">
		<cfargument name="Icon" type="string" default="">
		<cfargument name="Content" type="string" default="">
		
		<cfscript>
			THIS.setSectionFolderName(arguments.SectionFolderName);
			THIS.setDisplayName(arguments.DisplayName);
			THIS.setFileName(arguments.FileName);
			THIS.setViewOrder(arguments.ViewOrder);
			THIS.setIsPublished(arguments.IsPublished);
			THIS.setIsSection(arguments.IsSection);
			THIS.setIcon(arguments.Icon);
			THIS.setContent(arguments.Content);
			
			return this;
		</cfscript>
	</cffunction>

	<cffunction name="SetDisplayName" returntype="void">
		<cfargument name="DisplayName" type="string" required="yes">
		<cfset variables.DisplayName = _Tron.camelToSpace(arguments.DisplayName)>
	</cffunction>
	
	<!--- <cffunction name="SelectViewsBySection" access="public" returntype="query">
		<cfargument name="SectionFolderName" type="string" required="yes">
		<cfquery name="qView">
	       SELECT * FROM _View
		   Where SectionFolderName =  "#arguments.SectionFolderName#"
		   AND FileName != "default"
		   AND IsPublished = 1
		   ORDER By ViewOrder ASC, DisplayName ASC
	      </cfquery>
		<cfreturn qView>
	</cffunction>
	
	<cffunction name="QueryPublishedSection" access="public" returntype="query">
		<cfargument name="FileName" required="yes">
		<cfquery name="qSection">
		SELECT * FROM _View
		Where FileName = "#arguments.FileName#"
		AND IsSection = 1
		</cfquery>
		<cfreturn qSection>
	</cffunction>
	
	<cffunction name="SelectPublishedSections" access="public" returntype="query">
		<cfquery name="qSection">
		SELECT * FROM _View
		Where IsPublished = 1
		AND IsSection = 1
		ORDER By ViewOrder ASC
		</cfquery>
		<cfreturn qSection>
	</cffunction>
	
	<cffunction name="SelectSuperadminSection" access="public" returntype="query">
		<cfquery name="qSection">
		SELECT * FROM _View
		Where FileName = "superadmin"
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
	
	<cffunction name="INSERTSection" access="public" returntype="numeric">
		<cfargument name="FileName" required="yes">
		<cfargument name="DisplayName" required="yes">
		<cfquery result="INSERTSection">
		INSERT INTO _View
		(FileName, DisplayName, IsSection, IsPublished, ViewOrder, Icon)
		VALUES
		("#arguments.FileName#", "#camelToSpace(arguments.DisplayName, true)#", 1, 1, 99, "default")
		</cfquery>
		<cfset sectionID = INSERTSection.GENERATED_KEY>
		<cfreturn sectionID>
	</cffunction>
	
	<cffunction name="InsertView" access="public" returntype="numeric">
		<cfargument name="FileName" required="yes">
		<cfargument name="DisplayName" required="yes">
		<cfargument name="SectionFolderName" required="yes">
		<cfquery result="InsertView">
		INSERT INTO _View
		(FileName, DisplayName, SectionFolderName, IsSection, IsPublished, ViewOrder, Icon)
		VALUES
		("#arguments.FileName#","#Replace(arguments.DisplayName, "_", " ", "All")#", "#arguments.SectionFolderName#", 0, 1, 99, "default.png")
		</cfquery>
		<cfset viewID = InsertView.GENERATED_KEY>
		<cfreturn viewID>
	</cffunction>
	
	<cffunction name="DELETEViewsBySection" access="public" returntype="void">
		<cfargument name="FileName" required="yes">
		<cfquery>
		DELETE FROM _View
		Where SectionFolderName = "#arguments.FileName#"
		</cfquery>
	</cffunction>
	
	<cffunction name="DELETEView" access="public" returntype="void">
		<cfargument name="ViewId" required="yes">
		<cfquery>
		DELETE FROM _View
		Where ViewId = #arguments.ViewId#
		</cfquery>
	</cffunction>
	
	<cffunction name="JSONPView" access="remote" returntype="any" returnformat="plain" output="false">
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
	</cffunction>
	
	<cffunction name="JSONView" access="remote" returntype="any" returnformat="JSON" output="false">
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
	</cffunction>
	
	<cffunction name="SelectWhereViewBySectionID" access="public" returntype="query">
		<cfargument name="viewName" required="yes">
		<cfargument name="sectionID" required="yes">
		<cfquery name="qView">
		Select ViewId FROM _View
		Where FileName = "#arguments.viewName#"
		AND SectionId = #arguments.sectionID#
		</cfquery>
		<cfreturn qView>
	</cffunction> --->
	
</cfcomponent>
