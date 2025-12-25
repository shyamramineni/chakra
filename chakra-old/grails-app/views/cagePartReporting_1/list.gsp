
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
					
						<th><g:message code="cagePartReporting.cagePartSpecFormula.label" default="Cage Part Name" /></th>
					
						<th><g:message code="cagePartReporting.totalQuantity.label" default="Total Quantity" /></th>
					
						<th><g:message code="cagePartReporting.stockPurchasedTime.label" default="Stock Purchased Date" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${cagePartReportingInstanceList}" status="i" var="cagePartReportingInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${cagePartReportingInstance.id}">${fieldValue(bean: cagePartReportingInstance, field: "cagePartSpecFormula")}</g:link></td>
					
						<td>${fieldValue(bean: cagePartReportingInstance, field: "totalQuantity")}</td>
					
						<td>${fieldValue(bean: cagePartReportingInstance, field: "stockPurchasedTime")}</td>
										
					</tr>
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
