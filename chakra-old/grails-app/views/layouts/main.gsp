
<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title><g:layoutTitle default="Grails" /></title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%--<link rel="shortcut icon"
	href="${resource(dir: 'images', file: 'favicon.ico')}"
	type="image/x-icon">
--%><link rel="apple-touch-icon"
	href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
<link rel="apple-touch-icon" sizes="114x114"
	href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
<r:require modules="bootstrap" />
<link rel="stylesheet" href="${resource(dir: 'css', file: 'mobile.css')}" type="text/css">
<g:layoutHead />
<r:layoutResources />
<link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}"	type="text/css">
</head>
<style type="text/css">
#margins {
	margin-top: auto;
	margin-bottom: auto;
	margin-right: auto;
	margin-left: auto;
}
</style>
<body>

	<div class="container-fluid">

		<div class="row-fluid">
  			<div class="span6"><div id="grailsLogo" role="banner">
				<a href="${request.contextPath}"><img src="${resource(dir: 'images', file: 'grails_logo.jpg')}"	alt="Chakra" /> </a>
			</div>
		</div>
			<div class="span6">
				<div id="loginblock">
					<sec:ifLoggedIn>Welcome Back <sec:username />! <g:link
							controller='logout' action='index'>Logout</g:link>
					</sec:ifLoggedIn>
					<sec:ifNotLoggedIn>
						<g:link controller='login' action='auth'>Login</g:link>
					</sec:ifNotLoggedIn>
				</div>

			</div>
		</div>



		<div class="navbar">
			<div class="navbar-inner">
				<div class="container">
				
					<sec:ifAllGranted roles="ROLE_ADMIN">
						<ul class="nav">
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown">Config<b class="caret"></b>
							</a>
								<ul class="dropdown-menu">
									<li><g:link action="list" controller="sheetSpecification">SheetSpecification</g:link>
									</li>
									<li><g:link action="list" controller="cageDesign">CageDesign</g:link>
									</li>
									<li><g:link action="list"
											controller="cageDesignSheetSpecFormula">CageDesignSheetSpecFormula</g:link>
									</li>
									<li><g:link action="list" controller="cagePartType">CagePartType</g:link>
									</li>
									<li><g:link action="list" controller="cagePart">CagePart</g:link>
									</li>
									<li><g:link action="list"
											controller="cagePartSpecification">CagePartSpecification</g:link>
									</li>
									<li><g:link action="list" controller="cagePartPrice">CagePartPrice</g:link>
									</li>
									<li><g:link action="list" controller="cagePartSpecFormula">CagePartSpecFormula</g:link>
									</li>
									<li><g:link action="list" controller="wireBrand">WireBrand</g:link>
									</li>
									<li><g:link action="list" controller="wirePrice">WirePrice</g:link>
									</li>
									<li><g:link action="list" controller="enquirySource">Enquiry Source</g:link>
									</li>
									<li><g:link action="list" controller="taxation">Taxation</g:link>
									</li>
									<li><g:link action="list" controller="machine">Machine</g:link>
									</li>
									<li><g:link action="list" controller="registry">Registry</g:link>
									</li>
									<li><g:link action="list" controller="linkMesh">Link Mesh</g:link>
									</li>
									<li><g:link action="list" controller="sideMesh">Side Mesh</g:link>
									</li>
									<li><g:link action="list" controller="quotationFailedReason">Quotation Failed Reason</g:link>
									</li>
								</ul></li>
						</ul>

						<ul class="nav">
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown">Products<b class="caret"></b>
							</a>
								<ul class="dropdown-menu">
									<li><g:link action="sheetPriceReport" controller="sheetSpecification">Mesh Parts</g:link></li>
									<li><g:link action="cagePriceReport" controller="cagePartPrice">Cage Parts</g:link></li>
									<li><g:link action="sideMeshPriceReport" controller="sideMesh">Side Mesh</g:link></li>
									<li><g:link action="linkMeshPriceReport" controller="linkMesh">Link Mesh</g:link></li>				
								</ul></li>
						</ul>

						<ul class="nav">
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown">Customer<b class="caret"></b>
							</a>
								<ul class="dropdown-menu">
									<li><g:link action="list" controller="customer">Customer</g:link>
									</li>
								</ul></li>
						</ul>

						<ul class="nav">
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown">Enquiry<b class="caret"></b>
							</a>
								<ul class="dropdown-menu">
									<li><g:link action="list" controller="enquiry">Enquiry</g:link>
									</li>
									<li><g:link action="enquiryUserReport"
											controller="enquiry">Enquiry User Report</g:link>
									<li><g:link action="enquiryUnassigned"
											controller="enquiry">Enquiry Un Assigned</g:link></li>
								</ul></li>
						</ul>


						<ul class="nav">
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown">Quotation<b class="caret"></b>
							</a>
								<ul class="dropdown-menu">
									<li><g:link action="list" controller="quotation">Quotation</g:link>
									</li>
									<li><g:link action="cancelledQuotations" controller="quotation">Cancelled Quotations Report</g:link></li>
									<li><g:link action="create" controller="quotationPlanner">Quotation Planner</g:link>
									</li>
									<li><g:link action="quotationCart" controller="quotation">Quotation Cart</g:link>
									</li>
									<li><g:link action="quotationChainLink" controller="quotation">Chain Link</g:link>
									</li>
									<li><g:link action="quotationWeldSide" controller="quotation">Weld Side Mesh</g:link>
									</li>
								</ul></li>
						</ul>

						<ul class="nav">
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown">Order<b class="caret"></b>
							</a>
								<ul class="dropdown-menu">
									<li><g:link action="list" controller="corder">Order</g:link>
									</li>
									<li><g:link action="customerOrder" controller="corder">Customer Order Report</g:link>
									</li>
									<li><g:link action="pendingMeshParts" controller="corder">Pending Mesh Order Report</g:link>
									</li>
									<li><g:link action="pendingCageParts" controller="corder">Pending Cage Order Report</g:link>
									</li>
									<li><g:link action="pendingOrderPayments"
											controller="corder">Pending Order Payments</g:link></li>
									<li><g:link action="blockedOrders" controller="corder">Blocked Orders</g:link>
									</li>
									<li><g:link action="shippedOrders" controller="corder">Shipped Orders</g:link>
									</li>
									<li><g:link action="pendingChainLink" controller="corder">Pending ChainLink Order Report</g:link>
									</li>
									<li><g:link action="pendingWeldSide" controller="corder">Pending WeldSide Order Report</g:link>
									</li>
								</ul></li>
						</ul>
						<ul class="nav">
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown">Production<b class="caret"></b>
							</a>
								<ul class="dropdown-menu">
									<li><g:link action="list" controller="productionReporting">Production Reporting</g:link>
									</li>
									<li><g:link action="list" controller="cagePartReporting">CagePart Reporting</g:link>
									</li>
									<li><g:link action="list" controller="chainLinkReporting">ChainLink Reporting</g:link>
									</li>
									<li><g:link action="list" controller="weldSideMeshReporting">WeldSideMesh Reporting</g:link>
									</li>
									<li><g:link action="list" controller="productionReportingWireWeight">ProductionReporting WireWeight</g:link>
									</li>
									<li><g:link action="list" controller="chainLinkReportingWireWeight">ChainLinkReporting WireWeight</g:link>
									</li>
									<li><g:link action="list" controller="weldSideMeshReportingWireWeight">WeldSideMeshReporting WireWeight</g:link>
									</li>									
								</ul></li>
						</ul>
						<ul class="nav">
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown">Stock<b class="caret"></b>
							</a>
								<ul class="dropdown-menu">
									<li><g:link action="list" controller="stock">Stock</g:link>
									</li>
									
									<li><g:link action="list" controller="cageStock">Cage Stock</g:link>
									</li>
									
									<li><g:link action="list" controller="chainLinkStock">ChainLink Stock</g:link>
									</li>
									
									<li><g:link action="list" controller="weldSideMeshStock">WeldSideMesh Stock</g:link>
									</li>

									<li><g:link action="stockReport" controller="stock">Stock Report</g:link>
									</li>
									
									<li><g:link action="cageStockReport" controller="cageStock">Cage Stock Report</g:link>
									</li>
									
									<li><g:link action="chainLinkStockReport" controller="chainLinkStock">ChainLink Stock Report</g:link>
									</li>
									
									<li><g:link action="weldSideMeshStockReport" controller="weldSideMeshStock">WeldSideMesh Stock Report</g:link>
									</li>

									<li><g:link action="search" controller="stock">Search</g:link>
									</li>


								</ul></li>
						</ul>

						<ul class="nav">
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown">Raw Material<b class="caret"></b>
							</a>
								<ul class="dropdown-menu">
									<li><g:link action="list"
											controller="WireReceiptReporting">Raw Material</g:link></li>
									<li><g:link action="wireReceiptReportingReport"
											controller="WireReceiptReporting">Raw Material Report</g:link>
									</li>
									<li><g:link action="wireRequiredReport"
											controller="corder">Wire Report</g:link></li>


								</ul></li>
						</ul>

						<ul class="nav">
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown">Security<b class="caret"></b>
							</a>
								<ul class="dropdown-menu">

									<li><g:link action="list" controller="role">Roles</g:link>
									</li>


									<li><g:link action="list" controller="user">Users</g:link>
									</li>


								</ul></li>
						</ul>
					</sec:ifAllGranted>


					<sec:ifAllGranted roles="ROLE_SALES">

						<ul class="nav">
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown">Products<b class="caret"></b>
							</a>
								<ul class="dropdown-menu">
									<li><g:link action="sheetPriceReport"
											controller="sheetSpecification">Mesh Parts</g:link></li>
									<li><g:link action="cagePriceReport"
											controller="cagePartPrice">Cage Parts</g:link></li>
								</ul></li>
						</ul>

						<ul class="nav">
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown">Customer<b class="caret"></b>
							</a>
								<ul class="dropdown-menu">
									<li><g:link action="list" controller="customer">Customer</g:link>
									</li>
								</ul></li>
						</ul>

						<ul class="nav">
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown">Enquiry<b class="caret"></b>
							</a>
								<ul class="dropdown-menu">
									<li><g:link action="enquiryBySales" controller="enquiry">Enquiry</g:link>
									</li>
								</ul></li>
						</ul>


						<ul class="nav">
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown">Quotation<b class="caret"></b>
							</a>
								<ul class="dropdown-menu">
									<li><g:link action="quotationBySales" controller="quotation">Quotation</g:link>
									</li>
									<li><g:link action="create" controller="quotationPlanner">Quotation Planner</g:link>
									</li>
									<li><g:link action="quotationCart" controller="quotation">Quotation Cart</g:link>
									</li>
									<li><g:link action="quotationChainLink" controller="quotation">Chain Link</g:link>
									</li>
									<li><g:link action="quotationWeldSide" controller="quotation">Weld Side Mesh</g:link>
									</li>
									<%-- <li><g:link action="list" controller="quotationCagePart">QuotationCagePart</g:link>
									</li>
									<li><g:link action="list" controller="quotationModels">QuotationModels</g:link>
									</li>--%>
								</ul></li>
						</ul>

						<ul class="nav">
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown">Order<b class="caret"></b>
							</a>
								<ul class="dropdown-menu">
									<li><g:link action="corderBySales" controller="corder">Order</g:link>
									</li>
									<li><g:link action="pendingMeshParts" controller="corder">Pending Order Report</g:link>
									</li>
									<li><g:link action="blockedOrders" controller="corder">Blocked Orders</g:link>
									</li>
									<li><g:link action="shippedOrders" controller="corder">Shipped Orders</g:link>
									</li>
								</ul></li>
						</ul>

					</sec:ifAllGranted>

					<sec:ifAllGranted roles="ROLE_PRODMANAGER">

						<ul class="nav">
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown">Order<b class="caret"></b>
							</a>
								<ul class="dropdown-menu">
									<li><g:link action="list" controller="corder">Order</g:link>
									</li>
									<li><g:link action="pendingMeshParts" controller="corder">Pending Order Report</g:link>
									</li>
									<li><g:link action="blockedOrders" controller="corder">Blocked Orders</g:link>
									</li>
									<li><g:link action="shippedOrders" controller="corder">Shipped Orders</g:link>
									</li>
								</ul></li>
						</ul>
						<ul class="nav">
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown">Production<b class="caret"></b>
							</a>
								<ul class="dropdown-menu">
									<li><g:link action="list" controller="productionReporting">ProductionReporting</g:link>
									</li>
									<li><g:link action="list"
											controller="productionReportingWireWeight">ProductionReportingWireWeight</g:link>
									</li>
								</ul></li>
						</ul>
						<ul class="nav">
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown">Stock<b class="caret"></b>
							</a>
								<ul class="dropdown-menu">
									<li><g:link action="list" controller="stock">Stock</g:link>
									</li>

									<li><g:link action="stockReport" controller="stock">Stock Report</g:link>
									</li>

									<li><g:link action="search" controller="stock">Search</g:link>
									</li>


								</ul></li>
						</ul>


						<ul class="nav">
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown">Raw Material<b class="caret"></b>
							</a>
								<ul class="dropdown-menu">
									<li><g:link action="list"
											controller="WireReceiptReporting">Raw Material</g:link></li>
									<li><g:link action="wireReceiptReportingReport"
											controller="WireReceiptReporting">Raw Material Report</g:link>
									</li>
								</ul></li>
						</ul>


					</sec:ifAllGranted>



				</div>


				<!-- <ul class="nav">
	  						<li class="dropdown"><a href="#">Config</a> </li>
	  						<li><g:link action="list" controller="cageDesign"> </g:link></li>
	  						<li><a href="#">SheetSpecification</a></li>
						</ul>
						
						 -->


			</div>
		</div><%--
		/*<style type="text/css">
		h1, h2{
		text-align:left;
		}
		</style>
		<style type="text/css">
		label {
	    font-weight: bold;
	    display: block;
	    width: 30%;
    	float: left;
    	text-align: right;
		}
		label:after {
		content: ":"
		}
		fieldset textField:before{
		content: "  "
		}
		fieldset textField {
    	width: 65%;
    	margin-left: 10px;
    	padding: 6px;
    	float:left;
		}
		</style>
​		
		<style type="text/css">
label {
	font-weight: bold;
	display: block;
	width: 180px;
	float: left;
}

label:after {
	content: ": "
}
</style>
		<style type="text/css">
fieldset legend {
	background: #CCA383;
	padding: 6px;
	font-weight: bold;
}
</style>--%>
		<g:layoutBody />
		<div class="footer" role="contentinfo"></div>
		<div id="spinner" class="spinner" style="display: none;">
			<g:message code="spinner.alt" default="Loading&hellip;" />
		</div>
		<g:javascript library="application" />
		<r:layoutResources />
	</div>
</body>
</html>