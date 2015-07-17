<div class="bs-docs-example">
<cfinclude template="../../helpers/KendoHelper.cfm">
<cfoutput> #GetGrid( model="_User", component = "services/_UserService.cfc", overwrite = false, include=true )# </cfoutput>
<script id="_UserTemplate" type="text/x-kendo-tmpl">
<cfoutput><a href="#APPLICATION.BASE_URL#/index.cfm/#Request.Section#/_UserReadForm?UserId=${ UserId }" class="btn">View _User</a></cfoutput>
</script>
</div>
