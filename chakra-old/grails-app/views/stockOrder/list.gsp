
<%@ page import="com.chakra.stock.StockOrder" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'stockOrder.label', default: 'StockOrder')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-stockOrder" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-stockOrder" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="stockOrder.corder.label" default="Corder" /></th>
					
						<th><g:message code="stockOrder.createdBy.label" default="Created By" /></th>
					
						<g:sortableColumn property="createdDate" title="${message(code: 'stockOrder.createdDate.label', default: 'Created Date')}" />
					
						<th><g:message code="stockOrder.lastEditedBy.label" default="Last Edited By" /></th>
					
						<g:sortableColumn property="lastEditedDate" title="${message(code: 'stockOrder.lastEditedDate.label', default: 'Last Edited Date')}" />
					
						<th><g:message code="stockOrder.stock.label" default="Stock" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${stockOrderInstanceList}" status="i" var="stockOrderInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${stockOrderInstance.id}">${fieldValue(bean: stockOrderInstance, field: "corder")}</g:link></td>
					
						<td>${fieldValue(bean: stockOrderInstance, field: "createdBy")}</td>
					
						<td><g:formatDate date="${stockOrderInstance.createdDate}" /></td>
					
						<td>${fieldValue(bean: stockOrderInstance, field: "lastEditedBy")}</td>
					
						<td><g:formatDate date="${stockOrderInstance.lastEditedDate}" /></td>
					
						<td>${fieldValue(bean: stockOrderInstance, field: "stock")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${stockOrderInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
