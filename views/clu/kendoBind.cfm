<article class="container12">
	<section>
		<div class="block-border">
			<div class="block-content">
				<div class="h1">
					<cfoutput>
					#NavigationBlockHeading()#
					</cfoutput>
				</div>
				<div id="tab-home" class="with-margin" style="height:auto;">
					<form action="<cfoutput>#APPLICATION.SES_URL#</cfoutput>/family/processPaymentNextForm" name="form" id="form" method="post" class="form">
						<fieldset>
							<div class="float-left gutter-right">
								<label for="PAYMENTID">Select PAYMENT ACCOUNT:</label>
								<input id="input" placeholder="Select payment account..." />
							</div>
						</fieldset>
						<input type="submit" name="submit" value="Submit" class="button" />
						<input type="hidden" name="FAMILYID" value="<cfoutput>#url.FAMILYID#</cfoutput>" />
						<input type="hidden" name="Excluded" value="" />
					</form>
					<cfform action="#APPLICATION.SES_URL#/family/acctpaymentCreate" name="CCARD" method="post" class="form">
					<fieldset>
						<div class="float-left gutter-right">
							<label for="CREDITCARDTYPEID">CREDITCARD TYPE ID:</label>
							<select name="CREDITCARDTYPEID" id="CREDITCARDTYPEID">
								<option value="1">Mastercard</option>
								<option value="2">VISA</option>
								<option value="3">Discover</option>
								<option value="4">AMX</option>
							</select>
						</div>
						<div class="float-left gutter-right">
							<label for="CARDNUMBER">CARD NUMBER:</label>
							<input type="text" name="CARDNUMBER" id="CARDNUMBER"/>
						</div>
						<div class="float-left gutter-right">
							<label for="CARDHOLDER">CARD HOLDER NAME:</label>
							<input type="text" name="CARDHOLDER" id="CARDHOLDER"/>
						</div>
						<div class="float-left gutter-right">
							<label for="CVVCODE">CVV CODE:</label>
							<input type="text" name="CVVCODE" id="CVVCODE"/>
						</div>
						<div class="float-left gutter-right">
							<label for="EXPIRATIONDATE">EXPIRATION DATE:</label>
							<input class="datepicker" type="text" name="EXPIRATIONDATE" id="EXPIRATIONDATE" value=""/>
							<img src="<cfoutput>#APPLICATION.ASSET_PATH#</cfoutput>/images/icons/fugue/calendar-month.png" width="16" height="16">
						</div>
						<div class="float-left gutter-right">
							<label for="DESCRIPTION">DESCRIPTION:</label>
							<input type="text" name="DESCRIPTION" id="DESCRIPTION"/>
						</div>
					</fieldset>
					<input type="submit" name="submit" value="Submit" class="button" />
					<input type="hidden" name="Excluded" value="" />
					</cfform>
				</div>
			</div>
		</div>
	</section>
	<div class="clear">
	</div>
</article>
<script>
$(document).ready(function() {
	
	$("#CCARD").hide();
	
	// create ComboBox from input HTML element
	$("#input").kendoComboBox({
	dataTextField: "text",
	dataValueField: "value",
	dataSource: [
	    { text: "James Lamar ****2055 (CCARD)", value: "1" },
	    { text: "Aimee Lamar ****1435 (BANK)", value: "2" },
	    { text: "NEW CREDIT CARD", value: "0" },
	    { text: "NEW BANK ACCOUNT", value: "-1" }
	],
	filter: "contains",
	suggest: true,
	width: "500px",
	index: 1
	});
	
	var combobox = $("#input").data("kendoComboBox");
	
	combobox.list.width(400);
	combobox.bind("change", function(e) {

	    if (combobox.value() == 0 ) {
		    
		$("#CCARD").show();
	    }
	});
});
</script>