
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
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
					
						<th><g:message code="wireReceiptReporting.wireBrand.label" default="Wire Brand" /></th>
					
						<g:sortableColumn property="wireDiameter" title="${message(code: 'wireReceiptReporting.wireDiameter.label', default: 'Wire Diameter')}" />
					
						<g:sortableColumn property="weightPurchased" title="${message(code: 'wireReceiptReporting.wireDiameter.label', default: 'Weight Purchased')}" />
						
						<g:sortableColumn property="weightInStock" title="${message(code: 'wireReceiptReporting.wireDiameter.label', default: 'Weight InStock')}" />
						
						<th><g:message code="wireReceiptReporting.availabilityStatus.label" default="Availability Status" /></th>	
							
										
					</tr>
				</thead>
				<tbody>
				<g:each in="${wireReceiptReportingInstanceList}" status="i" var="wireReceiptReportingInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${wireReceiptReportingInstance.id}">${fieldValue(bean: wireReceiptReportingInstance, field: "wireBrand")}</g:link></td>
					
						<td>${fieldValue(bean: wireReceiptReportingInstance, field: "wireDiameter")}</td>
					
						<td>${fieldValue(bean: wireReceiptReportingInstance, field: "weightPurchased")}</td>
						
						<td>${fieldValue(bean: wireReceiptReportingInstance, field: "weightInStock")}</td>
						
						<td>${fieldValue(bean: wireReceiptReportingInstance, field: "availabilityStatus")}</td>
					
						
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<ul>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
			<div class="pagination">
				<g:paginate total="${wireReceiptReportingInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
