<cfinclude template="includes/bootstrap-head.cfm">
<body>
	<cfinclude template="includes/error-header.cfm">
	<cfloop from="1" to="#StructCount(Request.ViewPath)#" index="v">
		<cfinclude template="#Request.ViewPath[v]["path"]#">
	</cfloop>
</body>
</html>