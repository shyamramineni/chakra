<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="com.chakra.customer.Customer" %>
<%@page defaultCodec="html" %>

<html>
	<head>
		<meta name="layout" content="main" />
		<g:set var="entityName" value="${message(code: 'customer.label', default: 'Quotation')}" />
		<title>Quotation</title>
		<style type="text/css">
			
			table {
				
				border-collapse: collapse;
				width:100%;
				border-color: #000;
			}
			
			
			body {
				font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
				font-size: 9px;
				line-height: 10px;
				color: #333;
			}
			
		</style>
		<link rel="stylesheet" href="/chakrap/static/css/main.css"	type="text/css"/>
		<!-- <link href="/Chakra/static/bundle-bundle_bootstrap_head.css" type="text/css" rel="stylesheet" media="screen, projection" /> -->
		
	</head>
	<body><%--
		<a href="#show-customer" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			
		</div>--%>
		<div class="container">
			<div class="row">
	  			<div class="span12">
	  				<div id="grailsLogo" align="center" role="banner">
						<rendering:inlineJpeg bytes="${imageBytes}" />
					</div>	
				</div>
			</div>
  			
		
			<div id="show-customer" class="content scaffold-show" role="main">
				<h3>Quotation</h3>
				<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
				</g:if>
				
				<table border="1" class="table table-bordered">
				    <tr>
				        <th align="center">Quotation Id:</th>
				        <td>${quotationInstance?.quotationId}</td>
				        <th align="center">Status:</th>
				        <td>${quotationInstance?.status}</td>
				        <th align="center">Created By:</th>
				        <td>${quotationInstance?.createdBy}</td>
				    </tr>
				</table>
				<br/><br/>
				<table border="1" class="table table-bordered">
				    <tr>
				    	<th align="center">Created Date:</th>
				        <td><g:formatDate format="dd-MM-yyyy" date="${quotationInstance?.createdDate}"/></td>
				        <th align="center">EnquiryId:</th>
				        <td>${quotationInstance?.enquiry?.enquiryId}</td>
				        <th align="center">Taxation:</th>
				        <td>${quotationInstance?.quotationModels?.taxation[0]}</td>
				    </tr>
				</table>
				<br/><br/>
				<table border="1" class="table table-bordered">
				    <tr>
				    	<th align="center">Customer:</th>
				        <td>${quotationInstance?.customer?.customerName}</td>
				        <th align="center">Company:</th>
				        <td>${quotationInstance?.customer?.companyName}</td>
				        <th align="center">Mobile:</th>
				        <td>${quotationInstance?.customer?.mobileNumber}</td>
				    </tr>
				</table> 
				<br/><br/>
				<table border="1" class="table table-bordered">
					<g:each in="${quotationModelInstance}" var="quotationModel">
				    	<tr>
				    		<th colspan="2">${quotationModel?.cageDesign}:</th>				    		
				    	</tr>
					</g:each>
					<g:if test="${quotationInstance?.isMeshQuotation}">
					<g:each in="${quotationModelInstance?.quotationMeshModel}" var="meshModel">
						<tr>
							<th align="left">Mesh:</th>
		    				<th align="left">${meshModel?.costPerBird}</th>
		    			</tr>
					</g:each>
					<g:each in="${quotationModelInstance?.quotationMeshModel?.quotationMeshParts}" var="meshParts">
						<tr>
							<td align="left">${meshParts?.sheetSpecification}:</td>
							<td align="left">${meshParts?.noOfMeshParts}</td>
						</tr>
					</g:each>
					</g:if>
					<g:if test="${quotationInstance?.isCageQuotation}">
					<g:each in="${quotationModelInstance?.quotationCagePartModel?.quotationCagePartSpecs}" var="cagePartSpec">
						<tr>
							<th align="left">${cagePartSpec?.cagePartSpecification}:</th>
					    	<th>${cagePartSpec?.costPerBird}</th>
						</tr>
					<g:each in="${cagePartSpec?.quotationCageParts}" var="cagePart">
						<tr>
							<td align="left">${cagePart?.cagePartSpecFormula}</td>
							<td>${cagePart?.noOfCageParts}</td>
						</tr>
					</g:each>	
					</g:each>	
					</g:if>
						<tr>
				    		<th align="left">Net CostPerBird:</th>
				    		<th colspan="2">${quotationModelInstance?.costPerBird}</th>
				    	</tr>					
					
				</table>				
	  	</div>
	  </div>	
	</body>
</html>
