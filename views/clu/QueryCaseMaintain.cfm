<cfscript>
local.Query = New services._UserService().QueryAllUsers();
writeDump(local.Query);
writeDump(local.Query.getMetaData().getColumnLabels());
</cfscript>

