
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
			<table>
				<thead>
					<tr>
					
						<th><g:message code="stock.sheetSpec.label" default="Sheet Spec Name" /></th>
						
						<th><g:message code="stock.noOfManufactured.label" default="No Of Manufactured" /></th>
					
						<g:sortableColumn property="stockManufacturedTime" title="${message(code: 'stock.stockManufacturedTime.label', default: 'Manufactured Date')}" />
					
						<th><g:message code="stock.noOfInStock.label" default="No Of In Stock" /></th>
					 
						<th><g:message code="stock.machine.label" default="Machine" /></th>
					
						<g:sortableColumn property="availabilityStatus" title="${message(code: 'stock.availabilityStatus.label', default: 'Availability Status')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${stockInstanceList}" status="i" var="stockInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>${fieldValue(bean: stockInstance, field: "sheetSpec")}</td>
						
						<td>${fieldValue(bean: stockInstance, field: "noOfManufactured")}</td>
						
						<td><g:formatDate date="${stockInstance.stockManufacturedTime}" format="dd-MM-yyyy" /></td>
					
						<td>${fieldValue(bean: stockInstance, field: "noOfInStock")}</td>
					
						<td>${fieldValue(bean: stockInstance, field: "machine")}</td>
										
						<td><g:link action="show" id="${stockInstance.id}">${fieldValue(bean: stockInstance, field: "availabilityStatus")}</g:link></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${stockInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
