
<%@ page import="com.chakra.production.WeldSideMeshReporting" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'weldSideMeshReporting.label', default: 'WeldSideMeshReporting')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-weldSideMeshReporting" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-weldSideMeshReporting" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
					
						<th><g:message code="weldSideMeshReporting.machine.label" default="Machine" /></th>
					
						<th><g:message code="weldSideMeshReporting.sideMesh.label" default="Side Mesh" /></th>
					
						<th><g:message code="weldSideMeshReporting.wireBrand.label" default="Wire Brand" /></th>
					
						<th><g:message code="weldSideMeshReporting.weldSideMeshStock.label" default="Weld Side Mesh Stock" /></th>
					
						<g:sortableColumn property="createdBy" title="${message(code: 'weldSideMeshReporting.createdBy.label', default: 'Created By')}" />
					
						<g:sortableColumn property="createdDate" title="${message(code: 'weldSideMeshReporting.createdDate.label', default: 'Created Date')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${weldSideMeshReportingInstanceList}" status="i" var="weldSideMeshReportingInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${weldSideMeshReportingInstance.id}">${fieldValue(bean: weldSideMeshReportingInstance, field: "machine")}</g:link></td>
					
						<td>${fieldValue(bean: weldSideMeshReportingInstance, field: "sideMesh")}</td>
					
						<td>${fieldValue(bean: weldSideMeshReportingInstance, field: "wireBrand")}</td>
					
						<td>${fieldValue(bean: weldSideMeshReportingInstance, field: "weldSideMeshStock")}</td>
					
						<td>${fieldValue(bean: weldSideMeshReportingInstance, field: "createdBy")}</td>
					
						<td><g:formatDate date="${weldSideMeshReportingInstance.createdDate}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<ul>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
			<div class="pagination">
				<g:paginate total="${weldSideMeshReportingInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
