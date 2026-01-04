
<%@ page import="com.chakra.production.ProductionReportingWireWeight" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'productionReportingWireWeight.label', default: 'ProductionReportingWireWeight')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-productionReportingWireWeight" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-productionReportingWireWeight" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
					
						<%--<th><g:message code="productionReportingWireWeight.productionReporting.label" default="Production Reporting" /></th>
					
						--%><th><g:message code="productionReportingWireWeight.wireBrand.label" default="Wire Brand" /></th>
						
						<g:sortableColumn property="diameter" title="${message(code: 'productionReportingWireWeight.diameter.label', default: 'Diameter')}" />
						
						<g:sortableColumn property="wireConsumptionDate" title="${message(code: 'productionReportingWireWeight.wireConsumptionDate.label', default: 'Wire Consumption Date')}" />
						
						<g:sortableColumn property="weight" title="${message(code: 'productionReportingWireWeight.weight.label', default: 'Weight')}" />
					
						<%--<th><g:message code="productionReportingWireWeight.wireReceiptReporting.label" default="Wire Receipt Reporting" /></th>
					
					--%></tr>
				</thead>
				<tbody>
				<g:each in="${productionReportingWireWeightInstanceList}" status="i" var="productionReportingWireWeightInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<%--<td>${fieldValue(bean: productionReportingWireWeightInstance, field: "productionReporting")}</td>
					
						--%><td>${productionReportingWireWeightInstance[0]}</td>
						
						<td>${productionReportingWireWeightInstance[1]}</td>
						
						<td>${productionReportingWireWeightInstance[2]}</td>
										
						<td>${productionReportingWireWeightInstance[3]}</td>
					
						<%--<td>${fieldValue(bean: productionReportingWireWeightInstance, field: "wireReceiptReporting")}</td>
					
					--%></tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${productionReportingWireWeightInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
