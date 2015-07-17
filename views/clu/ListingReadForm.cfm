<div class="bs-docs-example">
<form action="" name="read" method="" class="form-horizontal">
<div class="control-group">
	<label for="ListAgentId" class="control-label">List&nbsp;Agent&nbsp;Id:</label>
	<div class="controls">
<input disabled type="text" name="ListAgentId" id="ListAgentId" value="<cfoutput>#Request.Listing.GetListAgentId()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="ListPrice" class="control-label">List&nbsp;Price:</label>
	<div class="controls">
<input disabled type="text" name="ListPrice" id="ListPrice" value="<cfoutput>#Request.Listing.GetListPrice()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="ListingDate" class="control-label">Listing&nbsp;Date:</label>
	<div class="controls">
<input disabled type="text" name="ListingDate" id="ListingDate" value="<cfoutput>#Request.Listing.GetListingDate()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="ListingStatus" class="control-label">Listing&nbsp;Status:</label>
	<div class="controls">
<input disabled type="text" name="ListingStatus" id="ListingStatus" value="<cfoutput>#Request.Listing.GetListingStatus()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="SellingAgentId" class="control-label">Selling&nbsp;Agent&nbsp;Id:</label>
	<div class="controls">
<input disabled type="text" name="SellingAgentId" id="SellingAgentId" value="<cfoutput>#Request.Listing.GetSellingAgentId()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="SoldDate" class="control-label">Sold&nbsp;Date:</label>
	<div class="controls">
<input disabled type="text" name="SoldDate" id="SoldDate" value="<cfoutput>#Request.Listing.GetSoldDate()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="SoldPrice" class="control-label">Sold&nbsp;Price:</label>
	<div class="controls">
<input disabled type="text" name="SoldPrice" id="SoldPrice" value="<cfoutput>#Request.Listing.GetSoldPrice()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="StreetName" class="control-label">Street&nbsp;Name:</label>
	<div class="controls">
<input disabled type="text" name="StreetName" id="StreetName" value="<cfoutput>#Request.Listing.GetStreetName()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="StreetNumber" class="control-label">Street&nbsp;Number:</label>
	<div class="controls">
<input disabled type="text" name="StreetNumber" id="StreetNumber" value="<cfoutput>#Request.Listing.GetStreetNumber()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="WithdrawnDate" class="control-label">Withdrawn&nbsp;Date:</label>
	<div class="controls">
<input disabled type="text" name="WithdrawnDate" id="WithdrawnDate" value="<cfoutput>#Request.Listing.GetWithdrawnDate()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="City" class="control-label">City:</label>
	<div class="controls">
<input disabled type="text" name="City" id="City" value="<cfoutput>#Request.Listing.GetCity()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="Category" class="control-label">Category:</label>
	<div class="controls">
<input disabled type="text" name="Category" id="Category" value="<cfoutput>#Request.Listing.GetCategory()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="ListingNumber" class="control-label">Listing&nbsp;Number:</label>
	<div class="controls">
<input disabled type="text" name="ListingNumber" id="ListingNumber" value="<cfoutput>#Request.Listing.GetListingNumber()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<label for="LeadSource" class="control-label">Lead&nbsp;Source:</label>
	<div class="controls">
<input disabled type="text" name="LeadSource" id="LeadSource" value="<cfoutput>#Request.Listing.GetLeadSource()#</cfoutput>"/>
	</div>
</div>
<div class="control-group">
	<div class="controls">
	<a href="<cfoutput>#APPLICATION.SES_URL#/#Request.Section#/ListingUpdateForm?ListingId=#Request.Listing.GetListingId()#</cfoutput>" class="btn btn-primary">Update</a>	<a href="#Delete" role="button" class="btn btn-warning" data-toggle="modal">Delete</a>	</div>
</div>
</form>
<div id="Delete" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
    <h3 id="myModalLabel">Delete Record</h3>
  </div>
  <div class="modal-body">
    <p>Are you sure you want to delete this record?</p>
  </div>
  <div class="modal-footer">
    <button class="btn btn-primary" data-dismiss="modal" aria-hidden="true">Cancel</button>
    <a href="<cfoutput>#APPLICATION.SES_URL#/#Request.Section#/ListingDelete?ListingId=#Request.Listing.GetListingId()#</cfoutput>" class="btn btn-warning">Confirm Delete</a>
  </div>
</div>
</div>
