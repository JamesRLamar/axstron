<cfset _Flynn = New services._Flynn()>
<div class="bs-docs-example">
	<form name="CRUD" action="<cfoutput>#APPLICATION.SES_URL#</cfoutput>/flynn/buildCRUD" method="get" preservedata="yes" class="form-horizontal">
	<cfif IsDefined("url.model")>
		<cfset _Flynn.BuildCRUD(model = url.model, section = url.section, protect = url.protect, makeview = url.makeview)>
	</cfif>
	<div class="control-group">
		<label class="control-label" for="model">Model:</label>
		<div class="controls">
			<input type="text" name="model">
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" for="section">Section:</label>
		<div class="controls">
			<input type="text" name="section">
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" for="makeview">Make standalone:</label>
		<div class="controls">
			<select name="makeview">
				<option value="true">TRUE</option>
				<option value="false">FALSE</option>
			</select>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" for="protect">Protect from overwrite:</label>
		<div class="controls">
			<select name="protect">
				<option value="true">TRUE</option>
				<option value="false">FALSE</option>
			</select>
		</div>
	</div>
	<div class="control-group">
		<div class="controls">
		<input type="submit" name="submit" value="submit" class="btn">
		</div>
	</div>
</form>
<br>
<br>
<br>
<cfform name="CRUD" action="#APPLICATION.SES_URL#/flynn/buildCRUD" method="get" preservedata="yes">
	<cfif IsDefined("url.build")>
		<cfset tables = DbInfo(type="tables")>
		<cfloop from="1" to="#tables.RecordCount#" index="table">
			<h5>
				<cfoutput>Building TEST #tables["TABLENAME"][table]# (Protected) ...</cfoutput>
			</h5>
			<cfoutput>#_Flynn.BuildCRUD(model = tables["TABLENAME"][table], section = "test", class = "form", protect = true)#</cfoutput>
			<p>complete :)</p>
		</cfloop>
		DONE!!!
	</cfif>
	<cfif IsDefined("url.rebuild")>
		<cfset tables = DbInfo(type="tables")>
		<cfloop from="1" to="#tables.RecordCount#" index="table">
			<h5>
				<cfoutput>Building TEST #tables["TABLENAME"][table]#...</cfoutput>
			</h5>
			<cfoutput>#_Flynn.BuildCRUD(model = tables["TABLENAME"][table], section = "test", class = "form", protect = false)#</cfoutput>
			<p>complete :)</p>
		</cfloop>
		DONE!!!
	</cfif>
	<cfif IsDefined("url.buildview")>
		<cfset tables = DbInfo(type="tables")>
		<cfloop from="1" to="#tables.RecordCount#" index="table">
			<h5>
				<cfoutput>Building TEST #tables["TABLENAME"][table]# (Protected) ...</cfoutput>
			</h5>
			<cfoutput>#_Flynn.BuildCRUD(model = tables["TABLENAME"][table], section = "test", class = "form", protect = true, makeview = true)#</cfoutput>
			<p>complete :)</p>
		</cfloop>
		DONE!!!
	</cfif>
	<cfif IsDefined("url.rebuildview")>
		<cfset tables = DbInfo(type="tables")>
		<cfloop from="1" to="#tables.RecordCount#" index="table">
			<h5>
				<cfoutput>Building TEST #tables["TABLENAME"][table]#...</cfoutput>
			</h5>
			<cfoutput>#_Flynn.BuildCRUD(model = tables["TABLENAME"][table], section = "test", class = "form", protect = false, makeview = true)#</cfoutput>
			<p>complete :)</p>
		</cfloop>
		DONE!!!
	</cfif>
	<fieldset class="grey-bg">
		<legend>
			<a href="#">
				Make Standalone Views
			</a>
		</legend>
		<div class="float-left gutter-right">
			<input type="submit" name="buildview" value="MAKE" class="btn">
			<br>
			<br>
			<input type="submit" name="rebuildview" value="RE-MAKE" class="btn">
		</div>
	</fieldset>
	<br>
	<hr>
	<fieldset class="grey-bg">
		<legend>
			<a href="#">
				Make Included Partial Views
			</a>
		</legend>
		<div class="float-left gutter-right">
			<input type="submit" name="build" value="MAKE" class="btn">
			<br>
			<br>
			<input type="submit" name="rebuild" value="RE-MAKE" class="btn">
		</div>
	</fieldset>
</cfform>
</div>