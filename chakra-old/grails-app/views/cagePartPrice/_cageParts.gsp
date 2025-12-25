<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="com.chakra.customer.Customer" %>



<html>
	<head>
		<meta name="layout" content="main" />
		<g:set var="entityName" value="${message(code: 'customer.label', default: 'Customer')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
		<style type="text/css">
			#margins {
				margin-top: auto;
				margin-bottom: auto;
				margin-right: auto;
				margin-left: auto;
			}
			table {
				max-width: 100%;
				border-collapse: collapse;
				border-spacing: 0;
			}
		</style>
		<link rel="stylesheet" href="/Chakra/static/css/main.css"	type="text/css"/>
		<link href="/Chakra/static/bundle-bundle_bootstrap_head.css" type="text/css" rel="stylesheet" media="screen, projection" />
		
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
				<h3><g:message code="CageParts" args="[entityName]" /></h3>
				<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
				</g:if>
				
				<table  cellpadding="5" border="1" width="100%">
				<thead>
					<tr>
						<th><g:message code="cagePartPrice.cagePartId.label" default="Cage Part Id" /></th>
								
						<th><g:message code="cagePartPrice.cagePartSpecFormula.label" default="Cage Part Spec Formula" /></th>
						
						<th><g:message code="cagePartPrice.price.label" default="Price" /></th>
						
					</tr>
				</thead>
				<tbody>
				<g:each in="${com.chakra.config.CagePartPrice.list()}" status="i" var="cagePartPriceInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
                        <td>${cagePartPriceInstance.cagePartId}</td> 						
						<td>
							<![CDATA[
							${cagePartPriceInstance.cagePartSpecFormula}
							]]>
						</td>
						<td>${cagePartPriceInstance.price}</td>
											
					</tr>
				</g:each>
				</tbody>
			</table>
				
				
			</div>
	  </div>	
	</body>
</html>

