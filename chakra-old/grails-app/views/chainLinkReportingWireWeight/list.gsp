
<%@ page import="com.chakra.production.ChainLinkReportingWireWeight" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'chainLinkReportingWireWeight.label', default: 'ChainLinkReportingWireWeight')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-chainLinkReportingWireWeight" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-chainLinkReportingWireWeight" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
					
						<th><g:message code="chainLinkReportingWireWeight.wireBrand.label" default="Wire Brand" /></th>
						
						<g:sortableColumn property="diameter" title="${message(code: 'chainLinkReportingWireWeight.diameter.label', default: 'Diameter')}" />
										
						<g:sortableColumn property="wireConsumptionDate" title="${message(code: 'chainLinkReportingWireWeight.wireConsumptionDate.label', default: 'Wire Consumption Date')}" />
						
						<g:sortableColumn property="weight" title="${message(code: 'chainLinkReportingWireWeight.weight.label', default: 'Weight')}" />
						
					</tr>
				</thead>
				<tbody>
				<g:each in="${chainLinkReportingWireWeightInstanceList}" status="i" var="chainLinkReportingWireWeightInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>${chainLinkReportingWireWeightInstance[0]}</td>
						
						<td>${chainLinkReportingWireWeightInstance[1]}</td>
						
						<td>${chainLinkReportingWireWeightInstance[2]}</td>
						
						<td>${chainLinkReportingWireWeightInstance[3]}</td>							
						
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${chainLinkReportingWireWeightInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
