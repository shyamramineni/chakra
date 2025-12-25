
<%@ page import="com.chakra.stock.WeldSideMeshStock" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'weldSideMeshStock.label', default: 'WeldSideMeshStock')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-weldSideMeshStock" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-weldSideMeshStock" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
					
						<th><g:message code="weldSideMeshStock.machine.label" default="Machine" /></th>
					
						<th><g:message code="weldSideMeshStock.wireBrand.label" default="Wire Brand" /></th>
					
						<g:sortableColumn property="noOfManufactured" title="${message(code: 'weldSideMeshStock.noOfManufactured.label', default: 'No Of Manufactured')}" />
					
						<g:sortableColumn property="noOfInStock" title="${message(code: 'weldSideMeshStock.noOfInStock.label', default: 'No Of In Stock')}" />
					
						<th><g:message code="weldSideMeshStock.sideMesh.label" default="Side Mesh" /></th>
					
						<g:sortableColumn property="comments" title="${message(code: 'weldSideMeshStock.comments.label', default: 'Comments')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${weldSideMeshStockInstanceList}" status="i" var="weldSideMeshStockInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${weldSideMeshStockInstance.id}">${fieldValue(bean: weldSideMeshStockInstance, field: "machine")}</g:link></td>
					
						<td>${fieldValue(bean: weldSideMeshStockInstance, field: "wireBrand")}</td>
					
						<td>${fieldValue(bean: weldSideMeshStockInstance, field: "noOfManufactured")}</td>
					
						<td>${fieldValue(bean: weldSideMeshStockInstance, field: "noOfInStock")}</td>
					
						<td>${fieldValue(bean: weldSideMeshStockInstance, field: "sideMesh")}</td>
					
						<td>${fieldValue(bean: weldSideMeshStockInstance, field: "comments")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${weldSideMeshStockInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
