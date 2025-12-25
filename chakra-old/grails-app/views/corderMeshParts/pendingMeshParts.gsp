
<%@ page import="com.chakra.order.CorderMeshParts" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'orderMeshParts.label', default: 'OrderMeshParts')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-orderMeshParts" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-orderMeshParts" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="orderMeshParts.sheetSpecification.label" default="Sheet Specification" /></th>
					
						<th><g:message code="orderMeshParts.wireBrand.label" default="Wire Brand" /></th>
					
						<g:sortableColumn property="createdBy" title="${message(code: 'orderMeshParts.createdBy.label', default: 'Created By')}" />
					
						<g:sortableColumn property="createdDate" title="${message(code: 'orderMeshParts.createdDate.label', default: 'Created Date')}" />
					
						<g:sortableColumn property="lastEditedBy" title="${message(code: 'orderMeshParts.lastEditedBy.label', default: 'Last Edited By')}" />
					
						<g:sortableColumn property="editedDate" title="${message(code: 'orderMeshParts.editedDate.label', default: 'Edited Date')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${orderMeshPartsInstanceList}" status="i" var="orderMeshPartsInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${orderMeshPartsInstance.id}">${fieldValue(bean: orderMeshPartsInstance, field: "sheetSpecification")}</g:link></td>
					
						<td>${fieldValue(bean: orderMeshPartsInstance, field: "wireBrand")}</td>
					
						<td>${fieldValue(bean: orderMeshPartsInstance, field: "createdBy")}</td>
					
						<td><g:formatDate date="${orderMeshPartsInstance.createdDate}" /></td>
					
						<td>${fieldValue(bean: orderMeshPartsInstance, field: "lastEditedBy")}</td>
					
						<td><g:formatDate date="${orderMeshPartsInstance.editedDate}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${orderMeshPartsInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
