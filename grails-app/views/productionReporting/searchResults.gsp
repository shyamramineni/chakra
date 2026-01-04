
<%@ page import="com.chakra.production.ProductionReporting" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'productionReporting.label', default: 'ProductionReporting')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-productionReporting" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
				<li><g:link action="search">Search</g:link></li>
			</ul>
		</div>
		<div id="list-productionReporting" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="createdBy" title="${message(code: 'productionReporting.createdBy.label', default: 'Created By')}" />
					
						<g:sortableColumn property="createdDate" title="${message(code: 'productionReporting.createdDate.label', default: 'Created Date')}" />
					
						<g:sortableColumn property="editedDate" title="${message(code: 'productionReporting.editedDate.label', default: 'Edited Date')}" />
					
						<g:sortableColumn property="lastEditedBy" title="${message(code: 'productionReporting.lastEditedBy.label', default: 'Last Edited By')}" />
					
						<th><g:message code="productionReporting.machine.label" default="Machine" /></th>
					
						<th><g:message code="productionReporting.sheetSpecifcation.label" default="Sheet Specifcation" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${productionReportingInstanceList}" status="i" var="productionReportingInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${productionReportingInstance.id}">${fieldValue(bean: productionReportingInstance, field: "createdBy")}</g:link></td>
					
						<td><g:formatDate date="${productionReportingInstance.createdDate}" /></td>
					
						<td><g:formatDate date="${productionReportingInstance.editedDate}" /></td>
					
						<td>${fieldValue(bean: productionReportingInstance, field: "lastEditedBy")}</td>
					
						<td>${fieldValue(bean: productionReportingInstance, field: "machine")}</td>
					
						<td>${fieldValue(bean: productionReportingInstance, field: "sheetSpecifcation")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${productionReportingInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
