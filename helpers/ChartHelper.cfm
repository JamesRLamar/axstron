<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script>
$(document).ready(function() {
	<cfoutput>#toScript( DateFormat(Now(),"Full") , "ListingReportDate")#</cfoutput>
});
function DrawBrokerFeeChart(brokerfee,totalpaid,remainingfee) {

	// Create our data table.
	var data = new google.visualization.DataTable();

	var rawdata = [
	['Total Fees Due', brokerfee],
	['Total Fees Paid', totalpaid],
	['Fees Paid Difference', remainingfee]				
	];

	var goals = [''];

	data.addColumn('string', 'goal');
	for (var i = 0; i < rawdata.length; ++i)
	{
		data.addColumn('number', rawdata[i][0]);	
	}

	data.addRows(goals.length);	

	for (var j = 0; j < goals.length; ++j)
	{	
		data.setValue(j, 0, goals[j]);	
	}

	for (var i = 0; i < rawdata.length; ++i)
	{
		for (var j = 1; j < rawdata[i].length; ++j)
		{
			data.setValue(j-1, i+1, rawdata[i][j]);	
		}
	}

	// Create and draw the visualization.
	var div = $('#BrokerFeeChart');
	new google.visualization.ColumnChart(div.get(0)).draw(data, {
		title: 'Broker Fee Report',
		width: div.width() - 50,
		height: 250,
		legend: 'right',
		prefix: '$',
		yAxis: {title: '(dollars)'}
	});
};

function drawListingGoalChart(monthlylistinggoal, 
	monthlylistingtotal,
	monthlylistingdifference,
	annuallistingdifference) 
{
	// Create our data table.
	var data = new google.visualization.DataTable();

	var rawdata = [
	['Monthly goal', monthlylistinggoal],
	['Total listed this month', monthlylistingtotal],
	['Monthly progress', monthlylistingdifference],
	['Annual progress', annuallistingdifference]
	];

	var goals = [''];
	data.addColumn('string', 'goal');

	for (var i = 0; i < rawdata.length; ++i)
	{
		data.addColumn('number', rawdata[i][0]);
	}

	data.addRows(goals.length);

	for (var j = 0; j < goals.length; ++j)
	{
		data.setValue(j, 0, goals[j]);
	}

	for (var i = 0; i < rawdata.length; ++i)
	{
		for (var j = 1; j < rawdata[i].length; ++j)
		{
			data.setValue(j-1, i+1, rawdata[i][j]);
		}
	}
	// Create and draw the visualization.
	var div = $('#ListingGoalChart');
	var width = $('.tab-content').width();

	new google.visualization.ColumnChart(div.get(0)).draw(data, {
		title: 'Listing Report as of ' + ListingReportDate,
		width: width,
		height: 250,
		legend: 'bottom',
		prefix: '$',
		yAxis: {title: '(thousands)'}
	});
};

function drawClosingGoalChart(monthlyclosinggoal, monthlyclosingtotal, monthlyclosingdifference,
	annualclosingdifference, pendingtotal, monthlypendingshortage, annualpendingshortage ) 
{

	// Create our data table.
	var data = new google.visualization.DataTable();

	var rawdata = [
	['Monthly goal', monthlyclosinggoal],
	['Total sold this month', monthlyclosingtotal],
	['Total pending this month', pendingtotal],
	['Monthly progress', monthlyclosingdifference],
	['Monthly pending progress', monthlypendingshortage],
	['Annual progress', annualclosingdifference],
	['Annual pending progress', annualpendingshortage]
	];

	var goals = [''];
	data.addColumn('string', 'goal');

	for (var i = 0; i < rawdata.length; ++i)
	{
		data.addColumn('number', rawdata[i][0]);	
	}

	data.addRows(goals.length);

	for (var j = 0; j < goals.length; ++j)
	{	
		data.setValue(j, 0, goals[j]);	
	}

	for (var i = 0; i < rawdata.length; ++i)
	{
		for (var j = 1; j < rawdata[i].length; ++j)
		{
			data.setValue(j-1, i+1, rawdata[i][j]);	
		}
	}

	// Create and draw the visualization.
	var div = $('#ClosingGoalChart');
	var width = $('.tab-content').width();

	new google.visualization.ColumnChart(div.get(0)).draw(data, {
		title: 'Closing Report as of ' + ListingReportDate,
		width: width,
		height: 300,
		legend: 'bottom',
		prefix: '$',
		yAxis: {title: '(thousands)'}
	});
};
</script>


<!---<script type="text/javascript">
	google.load('visualization', '1', {'packages':['motionchart']});
	google.setOnLoadCallback(drawListingChart);
	google.setOnLoadCallback(drawClosingChart);
	function drawListingChart() {
	var data = new google.visualization.DataTable();
	data.addColumn('string', 'Parameter');
	data.addColumn('date', 'Date');
	data.addColumn('number', 'Amount');
	data.addRows([
	<cfoutput>
	#Request.listingMotionChartOutput#
	</cfoutput>
	]);
	var div = $('#tab-listing-charts');
	var chart = new google.visualization.MotionChart(document.getElementById('listing-charts'));
	var options = {};
	options['state'] =
	'{"yZoomedIn":false,"xZoomedDataMin":1328745600000,"colorOption":"UNIQUECOLOR","duration":{"timeUnit":"D","multiplier":1},"xZoomedDataMax":1338508800000,"sizeOption":"UNISIZE","xLambda":1,"dimensions":{"iconDimensions":["dim0"]},"showTrails":false,"yZoomedDataMax":4000000,"yAxisOption":"2","iconType":"LINE","time":"2012-06-01","playDuration":4533.333333333336,"yZoomedDataMin":-1000000,"orderedByY":false,"yLambda":1,"orderedByX":false,"nonSelectedAlpha":0.4,"xAxisOption":"TIME","uniColorForNonSelected":false,"iconKeySettings":[{"key":{"dim0":"Listing Goal"}},{"key":{"dim0":"Listing Total"}},{"key":{"dim0":"Monthly Difference"}},{"key":{"dim0":"Annual Difference"}}],"xZoomedIn":false};';
	options['width'] = div.width();
	options['height'] = 600;
	chart.draw(data, options);
	}
	function drawClosingChart() {
	var data = new google.visualization.DataTable();
	data.addColumn('string', 'Parameter');
	data.addColumn('date', 'Date');
	data.addColumn('number', 'Amount');
	data.addRows([
	<cfoutput>
	#Request.closingMotionChartOutput#
	</cfoutput>
	]);
	var div = $('#tab-closing-charts');
	var chart = new google.visualization.MotionChart(document.getElementById('closing-charts'));
	var options = {};
	options['state'] =
	'{"yZoomedIn":false,"xZoomedDataMin":1328745600000,"colorOption":"UNIQUECOLOR","duration":{"timeUnit":"D","multiplier":1},"xZoomedDataMax":1338508800000,"sizeOption":"UNISIZE","xLambda":1,"dimensions":{"iconDimensions":["dim0"]},"showTrails":false,"yZoomedDataMax":4000000,"yAxisOption":"2","iconType":"LINE","time":"2012-06-01","playDuration":4533.333333333336,"yZoomedDataMin":-1000000,"orderedByY":false,"yLambda":1,"orderedByX":false,"nonSelectedAlpha":0.4,"xAxisOption":"TIME","uniColorForNonSelected":false,"iconKeySettings":[{"key":{"dim0":"Closing Goal"}},{"key":{"dim0":"Closing Total"}},{"key":{"dim0":"Monthly Difference"}},{"key":{"dim0":"Annual Difference"}}],"xZoomedIn":false};';
	options['width'] = div.width();
	options['height'] = 600;
	chart.draw(data, options);
	}
</script> 
<script>
$(document).ready(function() {
	
	ListAgentId = '<cfoutput>#url.ListAgentId#</cfoutput>';
	
	//Load Listing Grid
	$.ajax({
		
		type: 'GET',
		
		url: '<cfoutput>#APPLICATION.BASE_URL#</cfoutput>/framework/.cfc?method=GetJS&viewRequest=kendoGridCRUDListingByAgentID&sectionRequest=generated',
		
		dataType: 'script',
		
		success: function(script, textStatus, jqXHR) {

		},
		
		error: function(xhr, textStatus, errorThrown) {

			alert('An error occurred while appending kendo script: ' + ( errorThrown ? errorThrown :	xhr.status ) );
		},
		
		complete: function(xhr, textStatus) {

		}
	});
	
	//Load Closings Grid
	$.ajax({
		
		type: 'GET',
		
		url: '<cfoutput>#APPLICATION.BASE_URL#</cfoutput>/framework/.cfc?method=GetJS&viewRequest=kendoGridCRUDListingClosingsByAgentID&sectionRequest=generated',
		
		dataType: 'script',
		
		success: function(script, textStatus, jqXHR) {

		},
		
		error: function(xhr, textStatus, errorThrown) {

			alert('An error occurred while appending kendo script: ' + ( errorThrown ? errorThrown :	xhr.status ) );
		},
		
		complete: function(xhr, textStatus) {

		}
	});
	
	//Load Canceled Grid
	$.ajax({
		
		type: 'GET',
		
		url: '<cfoutput>#APPLICATION.BASE_URL#</cfoutput>/framework/.cfc?method=GetJS&viewRequest=kendoGridCRUDListingCanceledByAgentID&sectionRequest=generated',
		
		dataType: 'script',
		
		success: function(script, textStatus, jqXHR) {

		},
		
		error: function(xhr, textStatus, errorThrown) {

			alert('An error occurred while appending kendo script: ' + ( errorThrown ? errorThrown :	xhr.status ) );
		},
		
		complete: function(xhr, textStatus) {

		}
	});
	
	//Load Earning Grid
	$.ajax({
		
		type: 'GET',
		
		url: '<cfoutput>#APPLICATION.BASE_URL#</cfoutput>/framework/.cfc?method=GetJS&viewRequest=kendoGridCRUDEarningByAgentID&sectionRequest=generated',
		
		dataType: 'script',
		
		success: function(script, textStatus, jqXHR) {

		},
		
		error: function(xhr, textStatus, errorThrown) {

			alert('An error occurred while appending kendo script: ' + ( errorThrown ? errorThrown :	xhr.status ) );
		},
		
		complete: function(xhr, textStatus) {

		}
	});
	
	//Load Closing Goals Grid
	$.ajax({
		
		type: 'GET',
		
		url: '<cfoutput>#APPLICATION.BASE_URL#</cfoutput>/framework/.cfc?method=GetJS&viewRequest=kendoGridCRUDClosingGoalAgent&sectionRequest=generated',
		
		dataType: 'script',
		
		success: function(script, textStatus, jqXHR) {

		},
		
		error: function(xhr, textStatus, errorThrown) {

			alert('An error occurred while appending kendo script: ' + ( errorThrown ? errorThrown :	xhr.status ) );
		},
		
		complete: function(xhr, textStatus) {

		}
	});
	
	//Load Listing Goals Grid
	$.ajax({
		
		type: 'GET',
		
		url: '<cfoutput>#APPLICATION.BASE_URL#</cfoutput>/framework/.cfc?method=GetJS&viewRequest=kendoGridCRUDlistingGoalAgent&sectionRequest=generated',
		
		dataType: 'script',
		
		success: function(script, textStatus, jqXHR) {

		},
		
		error: function(xhr, textStatus, errorThrown) {

			alert('An error occurred while appending kendo script: ' + ( errorThrown ? errorThrown :	xhr.status ) );
		},
		
		complete: function(xhr, textStatus) {

		}
	});
	
	//Load Broker Fees Grid
	$.ajax({
		
		type: 'GET',
		
		url: '<cfoutput>#APPLICATION.BASE_URL#</cfoutput>/framework/.cfc?method=GetJS&viewRequest=kendoGridCRUDBrokerFeeAgent&sectionRequest=generated',
		
		dataType: 'script',
		
		success: function(script, textStatus, jqXHR) {

		},
		
		error: function(xhr, textStatus, errorThrown) {

			alert('An error occurred while appending kendo script: ' + ( errorThrown ? errorThrown :	xhr.status ) );
		},
		
		complete: function(xhr, textStatus) {

		}
	});
	
});
</script> 
--->