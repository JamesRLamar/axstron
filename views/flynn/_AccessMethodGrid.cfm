<div class="bs-docs-example">
<cfinclude template="../../helpers/KendoHelper.cfm">
<cfoutput> #GetGrid( model="_AccessMethod", component = "services/_AccessMethodService.cfc", overwrite = false, include=true )# </cfoutput>
<script id="_AccessMethodTemplate" type="text/x-kendo-tmpl">
<cfoutput><a href="#APPLICATION.BASE_URL#/index.cfm/#Request.Section#/_AccessMethodReadForm?AccessMethodId=${ AccessMethodId }" class="btn">View _AccessMethod</a></cfoutput>
</script>
</div>
