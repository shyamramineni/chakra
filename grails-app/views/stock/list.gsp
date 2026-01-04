<%@ page import="com.chakra.stock.Stock" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'stock.label', default: 'Stock')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-stock" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
				<li><g:link action="search">Search</g:link></li>
			</ul>
		</div>
		<div id="list-stock" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
						
						<th><g:message code="stock.stockId.label" default="StockId" /></th>
						
						<th><g:message code="stock.sheetSpec.label" default="Sheet Spec Name" /></th>
						
						<th><g:message code="stock.wireBrand.label" default="Wire Brand" /></th>
						
						<th><g:message code="stock.machine.label" default="Machine" /></th>
						
						<th><g:message code="stock.noOfManufactured.label" default="No Of Manufactured" /></th>
						
						<th><g:message code="stock.noOfInStock.label" default="InStock" /></th>					
											
						<th><g:message code="stock.stockManufacturedTime.label" default="Manufactured Date" /></th>
						
						<th><g:message code="stock.availabilityStatus.label" default="Availability Status" /></th>
					 
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${stockInstanceList}" status="i" var="stockInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${stockInstance.id}">${fieldValue(bean: stockInstance, field: "stockId")}</g:link></td>
					
						<td>${fieldValue(bean: stockInstance, field: "sheetSpec")}</td>
						
						<td>${fieldValue(bean: stockInstance, field: "wireBrand")}</td>
						
						<td>${fieldValue(bean: stockInstance, field: "machine")}</td>
						
						<td>${fieldValue(bean: stockInstance, field: "noOfManufactured")}</td>
						
						<td>${fieldValue(bean: stockInstance, field: "noOfInStock")}</td>
						
						<td><g:formatDate date="${stockInstance.stockManufacturedTime}" format="dd-MM-yyyy" /></td>
																				
						<td>${fieldValue(bean: stockInstance, field: "availabilityStatus")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<ul>
			    <li><g:link action="search">Search Stock</g:link></li>
			</ul>
			<div class="pagination">
				<g:paginate total="${stockInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
