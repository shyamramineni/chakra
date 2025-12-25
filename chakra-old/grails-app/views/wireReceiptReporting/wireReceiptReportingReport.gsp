
<%@ page import="com.chakra.rawmaterial.WireReceiptReporting" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'wireReceiptReporting.label', default: 'WireReceiptReporting')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-wireReceiptReporting" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-wireReceiptReporting" class="content scaffold-list" role="main">
			<h1><g:message code="default.wireReceiptReporting" args="[entityName]" default="Wire Inventory Report"  /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
					
						<th><g:message code="wireReceiptReporting.wireBrand.label" default="Wire Brand" /></th>
						
						<th><g:message code="wireReceiptReporting.wireDiameter.label" default="Wire Diameter" /></th>
						
						<th><g:message code="wireReceiptReporting.weightInStock.label" default="WeightInStock" /></th>
					
								
										
					</tr>
				</thead>
				<tbody>
				<g:each in="${wireReceiptReportingInstanceList}" status="i" var="wireReceiptReportingInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>${wireReceiptReportingInstance[0]}</td>
					
						<td>${wireReceiptReportingInstance[1]}</td>
						
						<td>${wireReceiptReportingInstance[2]}</td>
						
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${wireReceiptReportingInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
