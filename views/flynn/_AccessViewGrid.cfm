<div class="bs-docs-example">
<cfinclude template="../../helpers/KendoHelper.cfm">
<cfoutput> #GetGrid( model="_AccessView", component = "services/_AccessViewService.cfc", overwrite = false, include=true )# </cfoutput>
<script id="_AccessViewTemplate" type="text/x-kendo-tmpl">
<cfoutput><a href="#APPLICATION.BASE_URL#/index.cfm/#Request.Section#/_AccessViewReadForm?AccessViewId=${ AccessViewId }" class="btn">View _AccessView</a></cfoutput>
</script>
</div>
