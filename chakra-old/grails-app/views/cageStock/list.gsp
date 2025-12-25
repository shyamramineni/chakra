
<%@ page import="com.chakra.stock.CageStock" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cageStock.label', default: 'CageStock')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-cageStock" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-cageStock" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
					
						<th><g:message code="cageStock.cageStockId.label" default="Cage Stock Id" /></th>
						
						<th><g:message code="cageStock.cagePartSpecFormula.label" default="Cage Part Name" /></th>
						
						<th><g:message code="cageStock.noOfPurchased.label" default="No Of Purchased" /></th>
						
						<th><g:message code="cageStock.noOfInStock.label" default="No Of InStock" /></th>
						
						<th><g:message code="cageStock.purchasedTime.label" default="Purchased Date" /></th>
						
						<th><g:message code="cageStock.availabilityStatus.label" default="Availability Status" /></th>
						
					</tr>
				</thead>
				<tbody>
				<g:each in="${cageStockInstanceList}" status="i" var="cageStockInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${cageStockInstance.id}">${fieldValue(bean: cageStockInstance, field: "cageStockId")}</g:link></td>
					
						<td>${fieldValue(bean: cageStockInstance, field: "cagePart")}</td>
					
						<td>${fieldValue(bean: cageStockInstance, field: "noOfPurchased")}</td>
					
						<td>${fieldValue(bean: cageStockInstance, field: "noOfInStock")}</td>
					
						<td>${fieldValue(bean: cageStockInstance, field: "purchasedTime")}</td>
					
						<td>${fieldValue(bean: cageStockInstance, field: "availabilityStatus")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${cageStockInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
