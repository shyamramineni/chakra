
<%@ page import="com.chakra.quotation.QuotationMeshPart" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quotationMeshPart.label', default: 'QuotationMeshPart')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-quotationMeshPart" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-quotationMeshPart" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="quotationMeshPart.sheetSpecification.label" default="Sheet Specification" /></th>
					
						<th><g:message code="quotationMeshPart.wireBrand.label" default="Wire Brand" /></th>
					
						<g:sortableColumn property="noOfMeshParts" title="${message(code: 'quotationMeshPart.noOfMeshParts.label', default: 'No Of Mesh Parts')}" />
					
						<g:sortableColumn property="wirePrice" title="${message(code: 'quotationMeshPart.wirePrice.label', default: 'Wire Price')}" />
					
						<g:sortableColumn property="createdBy" title="${message(code: 'quotationMeshPart.createdBy.label', default: 'Created By')}" />
					
						<g:sortableColumn property="createdDate" title="${message(code: 'quotationMeshPart.createdDate.label', default: 'Created Date')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${quotationMeshPartInstanceList}" status="i" var="quotationMeshPartInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${quotationMeshPartInstance.id}">${fieldValue(bean: quotationMeshPartInstance, field: "sheetSpecification")}</g:link></td>
					
						<td>${fieldValue(bean: quotationMeshPartInstance, field: "wireBrand")}</td>
					
						<td>${fieldValue(bean: quotationMeshPartInstance, field: "noOfMeshParts")}</td>
					
						<td>${fieldValue(bean: quotationMeshPartInstance, field: "wirePrice")}</td>
					
						<td>${fieldValue(bean: quotationMeshPartInstance, field: "createdBy")}</td>
					
						<td><g:formatDate date="${quotationMeshPartInstance.createdDate}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${quotationMeshPartInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
