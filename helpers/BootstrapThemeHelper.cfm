<cfscript>
_ViewSvc = new services._ViewService();

_Tron = New services._Tron();

public void function GetNavbar() {
	
	var qSections = _ViewSvc.QueryAllPublishedSections();

	writeOutput('<div class="navbar">
				<div class="navbar-inner">
					<div class="container"> 
					<a class="btn btn-navbar" data-toggle="collapse" data-target=".navbar-responsive-collapse">
					 <span class="icon-bar"></span> 
					 <span class="icon-bar"></span> 
					 <span class="icon-bar"></span> 
					 </a> 
						<div class="nav-collapse collapse navbar-responsive-collapse">
							<ul class="nav">');
			
	for (s = 1; s LTE qSections.RecordCount; s++) {

		var SectionFolderName = qSections["FileName"][s];
		
		if ( _Tron.GrantViewAccess( Section = SectionFolderName ) ) {
								
			var qViews = _ViewSvc.QueryPublishedViewsBySection( SectionFolderName );

			if ( SectionFolderName == Request.Section && qViews.RecordCount ) {
				writeOutput( '<li class="active dropdown">' );
				writeOutput( '<a href="' & APPLICATION.SES_URL & '/' & SectionFolderName & '" class="dropdown-toggle" data-toggle="dropdown">' & qSections["DisplayName"][s] ); //& '<b class="caret"></b></a>');
				writeOutput( GetNavbarViews( qViews ) );
				writeOutput('</li>');
			}
			else if ( SectionFolderName == Request.Section && !qViews.RecordCount ) {
				writeOutput( '<li class="active">' );
				writeOutput( '<a href="' & APPLICATION.SES_URL & '/' & SectionFolderName & '">' & qSections["DisplayName"][s] & '</a></li>');
			}
			else if ( SectionFolderName != Request.Section && qViews.RecordCount ) {
				writeOutput( '<li class="dropdown">' );
				writeOutput( '<a href="' & APPLICATION.SES_URL & '/' & SectionFolderName & '" class="dropdown-toggle" data-toggle="dropdown">' & qSections["DisplayName"][s] );//& '<b class="caret"></b></a>');
				writeOutput( GetNavbarViews( qViews ) );
				writeOutput('</li>');
			}
			else if ( SectionFolderName != Request.Section && !qViews.RecordCount ) {
				writeOutput( '<li>' );
				writeOutput( '<a href="' & APPLICATION.SES_URL & '/' & SectionFolderName & '">' & qSections["DisplayName"][s] & '</a>' & '</li>');
			}			
		}
	}	

	writeOutput( '</ul>');

	if( IsDefined("SESSION.USER.USERNAME") ) {
		writeOutput('<ul class="nav pull-right">
						<li><a href="' & APPLICATION.SES_URL & '/default/_UserAccountForm">' & SESSION.USER.USERNAME & '</a></li>
						<li class="divider-vertical"></li>
						<li><a href="' & APPLICATION.SES_URL & '/login/logout">Logout</a></li>
						<li class="divider-vertical"></li>
                      <li><a href="mailto:' & APPLICATION.SUPPORT_EMAIL & '">Support</a></li>
                 </ul>');
	}

	else {
		writeOutput('<ul class="nav pull-right">
						<li><a href="##">Welcome Guest</a></li>
						<li class="divider-vertical"></li>
						<li><a href="' & APPLICATION.SES_URL & '/login">Login</a></li>
						<li class="divider-vertical"></li>
                      <li><a href="mailto:' & APPLICATION.SUPPORT_EMAIL & '">Support</a></li>
                 </ul>');
	}
	
	writeOutput( '				</li>
							</ul>
						</div>
						<!-- /.nav-collapse --> 
					</div>
				</div>
				<!-- /navbar-inner --> 
			</div>' );
	
}

private void function GetNavbarViews( 

	required any qViews
	
	){
		
		writeOutput( '<ul class="dropdown-menu">' );
		
		for (v = 1; v LTE qViews.RecordCount; v++) {
							
			if ( _Tron.GrantViewAccess( Section = qViews.SectionFolderName, View = qViews["FileName"][v] ) ) {
				
				writeOutput( '<li><a href="'
				& APPLICATION.SES_URL 
				& '/'
				& qViews.SectionFolderName
				& '/'
				& qViews["FileName"][v]
				& '">' 
				& qViews["DisplayName"][v]
				& '</a></li>' );
			}
		}
		
		writeOutput( '</ul>' );
}

public void function GetBreadCrumbs(string Section = Request.Section, string View = Request.View) {
			
	var qSection = _ViewSvc.QueryPublishedSection( arguments.Section );
	var qView = _ViewSvc.QueryPublishedView( arguments.View, arguments.Section  );
	
	writeOutput( '<ul class="breadcrumb">' );

	if ( NOT IsNull(qView) && NOT IsNull(qSection) ) {

		if (arguments.Section == "default" && arguments.View == "default") {

			writeOutput( '<li><a href="'
			& APPLICATION.SES_URL
			& '" class="active">Home</a></li>' );
		}

		else if (arguments.Section == "default" && arguments.View != "default") {
					
			writeOutput( '<li><a href="'
			& APPLICATION.SES_URL
			& '/'
			& arguments.Section
			& '">' 
			& qSection.DisplayName 
			& '</a><span class="divider">/</span></li>' );
			
			writeOutput( '<li><a href="'
			& APPLICATION.SES_URL
			& '/'
			& arguments.Section
			& '/'
			& arguments.View
			& '" class="active">' 
			& qView.DisplayName 
			& '</a></li>' );
		}

		else {

			writeOutput( '<li><a href="'
			& APPLICATION.SES_URL
			& '">Home</a><span class="divider">/</span></li>' );
					
			writeOutput( '<li><a href="'
			& APPLICATION.SES_URL
			& '/'
			& arguments.Section
			& '">' 
			& qSection.DisplayName 
			& '</a><span class="divider">/</span></li>' );
			
			writeOutput( '<li><a href="'
			& APPLICATION.SES_URL
			& '/'
			& arguments.Section
			& '/'
			& arguments.View
			& '" class="active">' 
			& qView.DisplayName 
			& '</a></li>' );
		}
	}

	writeOutput( '</ul>' );
}

public void function GetSectionLinks( 
	string Section = Request.Section 
) {
					
	if ( _Tron.GrantViewAccess( section = arguments.section ) ) {
		
		writeOutput( '<h3><a href="'
		& APPLICATION.SES_URL 
		& '/' 
		& arguments.section
		& '">'
		& UCASE( arguments.section )
		& '</a></h3>');
		
		writeOutput( '<ul>' );
		
		writeOutput( GetViewLinks( arguments.section ) );
		
		writeOutput( '</ul>' );
	}
}

public void function GetViewLinks(
	string Section = Request.Section
){
	
	var qViews = _ViewSvc.QueryPublishedViewsBySection( arguments.Section );

	for (v = 1; v LTE qViews.RecordCount; v++) {
						
		if ( _Tron.GrantViewAccess( Section = arguments.Section, View = qViews["FileName"][v]  ) ) {
			
			writeOutput( '<li><p><a href="'
			& APPLICATION.SES_URL 
			& '/'
			& arguments.Section
			& '/'
			& qViews["FileName"][v]
			& '">'
			& UCASE(qViews["DisplayName"][v])
			& '</a></p></li>' );
		}
	}
}
</cfscript>