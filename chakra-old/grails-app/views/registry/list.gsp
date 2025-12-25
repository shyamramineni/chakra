
<%@ page import="com.chakra.registry.Registry" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'registry.label', default: 'Registry')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-registry" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-registry" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
					
						<g:sortableColumn property="entryName" title="${message(code: 'registry.entryName.label', default: 'Entry Name')}" />
					
						<g:sortableColumn property="entryValue" title="${message(code: 'registry.entryValue.label', default: 'Entry Value')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${registryInstanceList}" status="i" var="registryInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${registryInstance.id}">${fieldValue(bean: registryInstance, field: "entryName")}</g:link></td>
					
						<td>${fieldValue(bean: registryInstance, field: "entryValue")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<ul>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
			<div class="pagination">
				<g:paginate total="${registryInstanceTotal}" />
			</div>			
		</div>
	</body>
</html>
