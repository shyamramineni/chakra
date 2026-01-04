
<%@ page import="com.chakra.order.Corder" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'wireReceiptReporting.label', default: 'WireRequired')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-wireReceiptReporting" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div align="right">
			${new Date()}
		</div>
		<div id="list-wireReceiptReporting" class="content scaffold-list" role="main">
			<h1><g:message code="default.wireReceiptReporting" args="[entityName]" default="Wire Required Report"  /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
					
						<th><g:message code="wireReceiptReporting.wireBrand.label" default="Wire Brand" /></th>
						
						<th><g:message code="wireReceiptReporting.wireDiameter.label" default="Wire Diameter" /></th>
						
						<th><g:message code="wireReceiptReporting.weightInStock.label" default="MeshPart" /></th>
						
						<th><g:message code="wireReceiptReporting.weightInStock.label" default="ChainLink" /></th>
						
						<th><g:message code="wireReceiptReporting.weightInStock.label" default="WeldSideMesh" /></th>
						
						<th><g:message code="wireReceiptReporting.weightInStock.label" default="Total" /></th>
						
						<th><g:message code="wireReceiptReporting.weightInStock.label" default="Available Wire" /></th>
						
						<th><g:message code="wireReceiptReporting.wireRequired.label" default="Wire Required" /></th>			
								
										
					</tr>
				</thead>
				<tbody>
				<g:each in="${wireRequiredList}" status="i" var="wireRequiredInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>${wireRequiredInstance[0]}</td>
					
						<td>${wireRequiredInstance[1]}</td>
						
						<td><g:formatNumber number="${wireRequiredInstance[2]}" type="number" maxFractionDigits="2" /></td>
						
						<td><g:formatNumber number="${wireRequiredInstance[3]}" type="number" maxFractionDigits="2" /></td>
						
						<td><g:formatNumber number="${wireRequiredInstance[4]}" type="number" maxFractionDigits="2" /></td>
						
						<td><g:formatNumber number="${wireRequiredInstance[5]}" type="number" maxFractionDigits="2" /></td>	
						
						<td>${wireRequiredInstance[6]}</td>
						
						<td><g:formatNumber number="${wireRequiredInstance[7]}" type="number" maxFractionDigits="2" /></td>					
					
					</tr>
				</g:each>
				</tbody>
			</table>
		</div>
	</body>
</html>
