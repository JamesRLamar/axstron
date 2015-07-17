<div class="bs-docs-example">
<cfinclude template="../../helpers/KendoHelper.cfm">
<cfoutput> #GetGrid( model="_View", component = "services/_ViewService.cfc", overwrite = false, include=true )# </cfoutput>
<script id="_ViewTemplate" type="text/x-kendo-tmpl">
<cfoutput><a href="#APPLICATION.BASE_URL#/index.cfm/#Request.Section#/_ViewReadForm?ViewId=${ ViewId }" class="btn">View Details</a></cfoutput>
</script>
<script type="text/x-kendo-template" id="template">				
	<div class="toolbar">
	<label class="search-label" for="search">Search:</label>
	<input type="search" id="search" style="width: 230px"></input>
	</div>
</script>
<style scoped>
#grid .k-toolbar
{
min-height: 27px;
}
.search-label
{
vertical-align: middle;
padding-right: .5em;
}
#search
{
vertical-align: middle;
.toolbar {
float: left;					
margin-left: .8em;					
}
</style>
</div>
