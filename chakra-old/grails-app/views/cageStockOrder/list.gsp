
<%@ page import="com.chakra.stock.CageStockOrder" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cageStockOrder.label', default: 'CageStockOrder')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-cageStockOrder" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-cageStockOrder" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
					
						<g:sortableColumn property="comments" title="${message(code: 'cageStockOrder.comments.label', default: 'Comments')}" />
					
						<th><g:message code="cageStockOrder.createdBy.label" default="Created By" /></th>
					
						<g:sortableColumn property="createdDate" title="${message(code: 'cageStockOrder.createdDate.label', default: 'Created Date')}" />
					
						<th><g:message code="cageStockOrder.lastEditedBy.label" default="Last Edited By" /></th>
					
						<g:sortableColumn property="lastEditedDate" title="${message(code: 'cageStockOrder.lastEditedDate.label', default: 'Last Edited Date')}" />
					
						<th><g:message code="cageStockOrder.cageStock.label" default="Cage Stock" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${cageStockOrderInstanceList}" status="i" var="cageStockOrderInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${cageStockOrderInstance.id}">${fieldValue(bean: cageStockOrderInstance, field: "comments")}</g:link></td>
					
						<td>${fieldValue(bean: cageStockOrderInstance, field: "createdBy")}</td>
					
						<td><g:formatDate date="${cageStockOrderInstance.createdDate}" /></td>
					
						<td>${fieldValue(bean: cageStockOrderInstance, field: "lastEditedBy")}</td>
					
						<td><g:formatDate date="${cageStockOrderInstance.lastEditedDate}" /></td>
					
						<td>${fieldValue(bean: cageStockOrderInstance, field: "cageStock")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${cageStockOrderInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
