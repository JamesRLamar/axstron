<div class="bs-docs-example">
<form action="<cfoutput>#APPLICATION.SES_URL#/#Request.Section#/</cfoutput>ListingCreate" name="create" method="post" class="form-horizontal">
<div class="control-group">
	<label for="ListAgentId" class="control-label">List&nbsp;Agent&nbsp;Id:</label>
	<div class="controls">
		<input type="text" name="ListAgentId" id="ListAgentId"/>
	</div>
</div>
<div class="control-group">
	<label for="ListPrice" class="control-label">List&nbsp;Price:</label>
	<div class="controls">
		<input type="text" name="ListPrice" id="ListPrice"/>
	</div>
</div>
<div class="control-group">
	<label for="ListingDate" class="control-label">Listing&nbsp;Date:</label>
	<div class="controls">
		<input type="text" name="ListingDate" id="ListingDate"/>
	</div>
</div>
<div class="control-group">
	<label for="ListingStatus" class="control-label">Listing&nbsp;Status:</label>
	<div class="controls">
		<input type="text" name="ListingStatus" id="ListingStatus"/>
	</div>
</div>
<div class="control-group">
	<label for="SellingAgentId" class="control-label">Selling&nbsp;Agent&nbsp;Id:</label>
	<div class="controls">
		<input type="text" name="SellingAgentId" id="SellingAgentId"/>
	</div>
</div>
<div class="control-group">
	<label for="SoldDate" class="control-label">Sold&nbsp;Date:</label>
	<div class="controls">
		<input type="text" name="SoldDate" id="SoldDate"/>
	</div>
</div>
<div class="control-group">
	<label for="SoldPrice" class="control-label">Sold&nbsp;Price:</label>
	<div class="controls">
		<input type="text" name="SoldPrice" id="SoldPrice"/>
	</div>
</div>
<div class="control-group">
	<label for="StreetName" class="control-label">Street&nbsp;Name:</label>
	<div class="controls">
		<input type="text" name="StreetName" id="StreetName"/>
	</div>
</div>
<div class="control-group">
	<label for="StreetNumber" class="control-label">Street&nbsp;Number:</label>
	<div class="controls">
		<input type="text" name="StreetNumber" id="StreetNumber"/>
	</div>
</div>
<div class="control-group">
	<label for="WithdrawnDate" class="control-label">Withdrawn&nbsp;Date:</label>
	<div class="controls">
		<input type="text" name="WithdrawnDate" id="WithdrawnDate"/>
	</div>
</div>
<div class="control-group">
	<label for="City" class="control-label">City:</label>
	<div class="controls">
		<input type="text" name="City" id="City"/>
	</div>
</div>
<div class="control-group">
	<label for="Category" class="control-label">Category:</label>
	<div class="controls">
		<input type="text" name="Category" id="Category"/>
	</div>
</div>
<div class="control-group">
	<label for="ListingNumber" class="control-label">Listing&nbsp;Number:</label>
	<div class="controls">
		<input type="text" name="ListingNumber" id="ListingNumber"/>
	</div>
</div>
<div class="control-group">
	<label for="LeadSource" class="control-label">Lead&nbsp;Source:</label>
	<div class="controls">
		<input type="text" name="LeadSource" id="LeadSource"/>
	</div>
</div>
<div class="control-group">
	<div class="controls">
	<input type="submit" name="submit" value="Submit" class="btn btn-primary" />
	</div>
</div>
</form>
</div>
