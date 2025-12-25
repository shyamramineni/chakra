
<%@ page import="com.chakra.production.ChainLinkReporting" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'chainLinkReporting.label', default: 'ChainLinkReporting')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-chainLinkReporting" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-chainLinkReporting" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
					
						<th><g:message code="chainLinkReporting.machine.label" default="Machine" /></th>
					
						<th><g:message code="chainLinkReporting.linkMesh.label" default="Link Mesh" /></th>
					
						<th><g:message code="chainLinkReporting.wireBrand.label" default="Wire Brand" /></th>
					
						<th><g:message code="chainLinkReporting.chainLinkStock.label" default="Chain Link Stock" /></th>
					
						<g:sortableColumn property="createdBy" title="${message(code: 'chainLinkReporting.createdBy.label', default: 'Created By')}" />
					
						<g:sortableColumn property="createdDate" title="${message(code: 'chainLinkReporting.createdDate.label', default: 'Created Date')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${chainLinkReportingInstanceList}" status="i" var="chainLinkReportingInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${chainLinkReportingInstance.id}">${fieldValue(bean: chainLinkReportingInstance, field: "machine")}</g:link></td>
					
						<td>${fieldValue(bean: chainLinkReportingInstance, field: "linkMesh")}</td>
					
						<td>${fieldValue(bean: chainLinkReportingInstance, field: "wireBrand")}</td>
					
						<td>${fieldValue(bean: chainLinkReportingInstance, field: "chainLinkStock")}</td>
					
						<td>${fieldValue(bean: chainLinkReportingInstance, field: "createdBy")}</td>
					
						<td><g:formatDate date="${chainLinkReportingInstance.createdDate}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<ul>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
			<div class="pagination">
				<g:paginate total="${chainLinkReportingInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
