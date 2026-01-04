
<%@ page import="com.chakra.production.CagePartReporting" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cagePartReporting.label', default: 'CagePartReporting')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-cagePartReporting" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-cagePartReporting" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
					
						<th><g:message code="cagePartReporting.cagePart.label" default="Cage Part" /></th>
						
						<th><g:message code="cagePartReporting.totalQuantity.label" default="Total Quantity" /></th>
					
						<th><g:message code="cagePartReporting.stockPurchasedTime.label" default="Stock Purchased Date" /></th>
					
						<%--<th><g:message code="cagePartReporting.cageStock.label" default="Cage Stock" /></th>
					
						<g:sortableColumn property="createdBy" title="${message(code: 'cagePartReporting.createdBy.label', default: 'Created By')}" />
					
						<g:sortableColumn property="createdDate" title="${message(code: 'cagePartReporting.createdDate.label', default: 'Created Date')}" />
					
						<g:sortableColumn property="lastEditedBy" title="${message(code: 'cagePartReporting.lastEditedBy.label', default: 'Last Edited By')}" />
					
						<g:sortableColumn property="editedDate" title="${message(code: 'cagePartReporting.editedDate.label', default: 'Edited Date')}" />
					
					--%></tr>
				</thead>
				<tbody>
				<g:each in="${cagePartReportingInstanceList}" status="i" var="cagePartReportingInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${cagePartReportingInstance.id}">${fieldValue(bean: cagePartReportingInstance, field: "cagePart")}</g:link></td>
						
						<td>${fieldValue(bean: cagePartReportingInstance, field: "totalQuantity")}</td>
					
						<td>${fieldValue(bean: cagePartReportingInstance, field: "stockPurchasedTime")}</td>
					
						<%--<td>${fieldValue(bean: cagePartReportingInstance, field: "cageStock")}</td>
					
						<td>${fieldValue(bean: cagePartReportingInstance, field: "createdBy")}</td>
					
						<td><g:formatDate date="${cagePartReportingInstance.createdDate}" /></td>
					
						<td>${fieldValue(bean: cagePartReportingInstance, field: "lastEditedBy")}</td>
					
						<td><g:formatDate date="${cagePartReportingInstance.editedDate}" /></td>
					
					--%></tr>
				</g:each>
				</tbody>
			</table>
			<ul>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
			<div class="pagination">
				<g:paginate total="${cagePartReportingInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
