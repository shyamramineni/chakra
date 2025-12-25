
<%@ page import="com.chakra.config.WireBrand" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'wireBrand.label', default: 'WireBrand')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-wireBrand" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><sec:ifAnyGranted roles="ROLE_ADMIN"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></sec:ifAnyGranted></li>
			</ul>
		</div>
		<div id="list-wireBrand" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
					
						<g:sortableColumn property="wireBrand" title="${message(code: 'wireBrand.wireBrand.label', default: 'Wire Brand')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'wireBrand.description.label', default: 'Description')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${wireBrandInstanceList}" status="i" var="wireBrandInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${wireBrandInstance.id}">${fieldValue(bean: wireBrandInstance, field: "wireBrand")}</g:link></td>
					
						<td>${fieldValue(bean: wireBrandInstance, field: "description")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<ul>
			<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
			<div class="pagination">
				<g:paginate total="${wireBrandInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
