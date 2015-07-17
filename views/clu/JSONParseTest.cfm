<article class="container12"> <section>
<div class="block-border">
<div class="block-content">
<cfhttp
url='http://webbware.gonautilus.com/framework/MEND.cfc?method=GLUE_SELECT_JSON&model=mend_user'>
<!--- The result is a JSON-formatted string that represents a structure.
Convert it to a ColdFusion structure. --->
<cfset myJSON=DeserializeJSON(#cfhttp.FileContent#)>
<!--- Display the results. --->
<cfoutput>
<h1>Results of search for "ColdFusion 9"</h1>
<p>There were #myJSON.ResultSet.totalResultsAvailable# Entries.<br>
	Here are the first #myJSON.ResultSet.totalResultsReturned#.</p>
<cfloop index="i" from="1" to="#myJSON.ResultSet.totalResultsReturned#">
	<h3><a href="#myJSON.ResultSet.Result[i].URL#"> #myJSON.ResultSet.Result[i].Title#</a></h3>
	#myJSON.ResultSet.Result[i].Summary#
</cfloop>
</cfoutput>
</div>
</div>
</section>
<div class="clear"> </div>
</article> 