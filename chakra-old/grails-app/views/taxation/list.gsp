
<%@ page import="com.chakra.config.Taxation" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'taxation.label', default: 'Taxation')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-taxation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-taxation" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
					
						<g:sortableColumn property="taxation" title="${message(code: 'taxation.taxation.label', default: 'Taxation')}" />
					
						<g:sortableColumn property="percent" title="${message(code: 'taxation.percent.label', default: 'Percent')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'taxation.description.label', default: 'Description')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${taxationInstanceList}" status="i" var="taxationInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${taxationInstance.id}">${fieldValue(bean: taxationInstance, field: "taxation")}</g:link></td>
					
						<td>${fieldValue(bean: taxationInstance, field: "percent")}</td>
					
						<td>${fieldValue(bean: taxationInstance, field: "description")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<ul>
			    <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
			<div class="pagination">
				<g:paginate total="${taxationInstanceTotal}" />
			</div>			
		</div>
	</body>
</html>
