
<%@ page import="com.chakra.quotation.QuotationMeshModel" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quotationMeshModel.label', default: 'QuotationMeshModel')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-quotationMeshModel" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-quotationMeshModel" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="quotationMeshModel.cageDesign.label" default="Cage Design" /></th>
					
						<th><g:message code="quotationMeshModel.wireBrand.label" default="Wire Brand" /></th>
					
						<g:sortableColumn property="doubleBox" title="${message(code: 'quotationMeshModel.doubleBox.label', default: 'Double Box')}" />
					
						<g:sortableColumn property="singleBox" title="${message(code: 'quotationMeshModel.singleBox.label', default: 'Single Box')}" />
					
						<g:sortableColumn property="costPerBird" title="${message(code: 'quotationMeshModel.costPerBird.label', default: 'Cost Per Bird')}" />
					
						<g:sortableColumn property="noOfBirds" title="${message(code: 'quotationMeshModel.noOfBirds.label', default: 'No Of Birds')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${quotationMeshModelInstanceList}" status="i" var="quotationMeshModelInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${quotationMeshModelInstance.id}">${fieldValue(bean: quotationMeshModelInstance, field: "cageDesign")}</g:link></td>
					
						<td>${fieldValue(bean: quotationMeshModelInstance, field: "wireBrand")}</td>
					
						<td>${fieldValue(bean: quotationMeshModelInstance, field: "doubleBox")}</td>
					
						<td>${fieldValue(bean: quotationMeshModelInstance, field: "singleBox")}</td>
					
						<td>${fieldValue(bean: quotationMeshModelInstance, field: "costPerBird")}</td>
					
						<td>${fieldValue(bean: quotationMeshModelInstance, field: "noOfBirds")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${quotationMeshModelInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
