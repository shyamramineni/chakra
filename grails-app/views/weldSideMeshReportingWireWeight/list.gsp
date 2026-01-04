
<%@ page import="com.chakra.production.WeldSideMeshReportingWireWeight" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'weldSideMeshReportingWireWeight.label', default: 'WeldSideMeshReportingWireWeight')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-weldSideMeshReportingWireWeight" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-weldSideMeshReportingWireWeight" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
					
						<%--<th><g:message code="weldSideMeshReportingWireWeight.weldSideMeshReporting.label" default="Weld Side Mesh Reporting" /></th>
					
						<th><g:message code="weldSideMeshReportingWireWeight.wireReceiptReporting.label" default="Wire Receipt Reporting" /></th>
					
						--%><th><g:message code="weldSideMeshReportingWireWeight.wireBrand.label" default="Wire Brand" /></th>
						
						<g:sortableColumn property="diameter" title="${message(code: 'weldSideMeshReportingWireWeight.diameter.label', default: 'Diameter')}" />
						
						<g:sortableColumn property="wireConsumptionDate" title="${message(code: 'weldSideMeshReportingWireWeight.wireConsumptionDate.label', default: 'Wire Consumption Date')}" />
					
						<g:sortableColumn property="weight" title="${message(code: 'weldSideMeshReportingWireWeight.weight.label', default: 'Weight')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${weldSideMeshReportingWireWeightInstanceList}" status="i" var="weldSideMeshReportingWireWeightInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						
						<td>${weldSideMeshReportingWireWeightInstance[0]}</td>
						<td>${weldSideMeshReportingWireWeightInstance[1]}</td>
						<td>${weldSideMeshReportingWireWeightInstance[2]}</td>
						<td>${weldSideMeshReportingWireWeightInstance[3]}</td>
						<%--<td><g:link action="show" id="${weldSideMeshReportingWireWeightInstance.id}">${fieldValue(bean: weldSideMeshReportingWireWeightInstance, field: "weldSideMeshReporting")}</g:link></td>
					
						<td>${fieldValue(bean: weldSideMeshReportingWireWeightInstance, field: "wireReceiptReporting")}</td>
					
						<td>${fieldValue(bean: weldSideMeshReportingWireWeightInstance, field: "diameter")}</td>
					
						<td>${fieldValue(bean: weldSideMeshReportingWireWeightInstance, field: "weight")}</td>
					
						<td>${fieldValue(bean: weldSideMeshReportingWireWeightInstance, field: "wireBrand")}</td>
					
						<td><g:formatDate date="${weldSideMeshReportingWireWeightInstance.wireConsumptionDate}" /></td>	--%>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${weldSideMeshReportingWireWeightInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
