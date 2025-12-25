
<%@ page import="com.chakra.quotation.QuotationModel" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quotationModel.label', default: 'QuotationModel')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-quotationModel" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-quotationModel" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="quotationModel.cageDesign.label" default="Cage Design" /></th>
					
						<th><g:message code="quotationModel.quotationMeshModel.label" default="Quotation Mesh Model" /></th>
					
						<g:sortableColumn property="noOfBirds" title="${message(code: 'quotationModel.noOfBirds.label', default: 'No Of Birds')}" />
					
						<g:sortableColumn property="cost" title="${message(code: 'quotationModel.cost.label', default: 'Cost')}" />
					
						<g:sortableColumn property="tax" title="${message(code: 'quotationModel.tax.label', default: 'Tax')}" />
					
						<g:sortableColumn property="totalCost" title="${message(code: 'quotationModel.totalCost.label', default: 'Total Cost')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${quotationModelInstanceList}" status="i" var="quotationModelInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${quotationModelInstance.id}">${fieldValue(bean: quotationModelInstance, field: "cageDesign")}</g:link></td>
					
						<td>${fieldValue(bean: quotationModelInstance, field: "quotationMeshModel")}</td>
					
						<td>${fieldValue(bean: quotationModelInstance, field: "noOfBirds")}</td>
					
						<td>${fieldValue(bean: quotationModelInstance, field: "cost")}</td>
					
						<td>${fieldValue(bean: quotationModelInstance, field: "tax")}</td>
					
						<td>${fieldValue(bean: quotationModelInstance, field: "totalCost")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${quotationModelInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
