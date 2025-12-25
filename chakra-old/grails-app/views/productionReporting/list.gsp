
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
			<table class="table table-bordered">
				<thead>
					<tr>
						
						
						<th><g:message code="productionReporting.sheetSpecifcation.label" default="Sheet Specifcation" /></th>
						
						<th><g:message code="productionReporting.machine.label" default="Machine" /></th>
						
						<th><g:message code="productionReporting.wireBrand.label" default="Wire Brand" /></th>
						
						<th><g:message code="productionReporting.totalQuantity.label" default="TotalQuantity" /></th>
						
						<th><g:message code="productionReporting.totalQuantity.label" default="ManufacturedTime" /></th>
						
						<th><g:message code="productionReporting.totalQuantity.label" default="Action" /></th>				
						
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${productionReportingInstanceList}" status="i" var="productionReportingInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${productionReportingInstance.id}">${fieldValue(bean: productionReportingInstance, field: "sheetSpecifcation")}</g:link></td>
						
						<td>${fieldValue(bean: productionReportingInstance, field: "machine")}</td>
						
						<td>${fieldValue(bean: productionReportingInstance, field: "wireBrand")}</td>
						
						<td>${fieldValue(bean: productionReportingInstance, field: "totalQuantity")}</td>
						
						<td>${fieldValue(bean: productionReportingInstance, field: "stockManufacturedTime")}</td>
						
						<td><sec:ifAllGranted roles="ROLE_ADMIN"><g:link action="repair" params="["productionReporting":productionReportingInstance.id]">Repair </g:link>/</sec:ifAllGranted>
						<g:link action="cancel" params="["productionReporting":productionReportingInstance.id]">Cancel</g:link>
						</td>
																
					</tr>
				</g:each>
				</tbody>
			</table>
			<ul>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
				<%--<li><g:link action="search">Search</g:link></li>
			--%></ul>
			<div class="pagination">
				<g:paginate total="${productionReportingInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
