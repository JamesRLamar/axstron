<!DOCTYPE html>
<html lang="en">
<head>
	<title>
	<cfoutput>#APPLICATION.TITLE#</cfoutput>
	</title>
	<cfoutput>
	<meta charset="UTF-8">
	<meta name="description" content="#APPLICATION.META_DESCRIPTION#" />
	<!--- <meta name="viewport" content="width=device-width, initial-scale=1.0"> --->
	
	<link href="#APPLICATION.ASSET_PATH#/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
	<link href="#APPLICATION.ASSET_PATH#/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css">
	<link href="#APPLICATION.ASSET_PATH#/bootstrap/css/datepicker.css" rel="stylesheet" type="text/css">
	
	<link rel="shortcut icon" type="image/x-icon" href="#APPLICATION.ASSET_PATH#/images/favicon.ico">
	<link rel="icon" type="image/png" href="#APPLICATION.ASSET_PATH#/images/favicon.png">
	
	<script src="#APPLICATION.ASSET_PATH#/js/common/jquery.min.js" type="text/javascript"></script>
	<script src="#APPLICATION.ASSET_PATH#/js/common/jquery.validate.js" type="text/javascript"></script>
	
	<script src="#APPLICATION.ASSET_PATH#/bootstrap/js/bootstrap.min.js"></script>
	<script src="#APPLICATION.ASSET_PATH#/bootstrap/js/bootstrap-datepicker.js"></script>
	</cfoutput>
</head>
