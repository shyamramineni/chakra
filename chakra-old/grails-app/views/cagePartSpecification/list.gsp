
<%@ page import="com.chakra.config.CagePartSpecification" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cagePartSpecification.label', default: 'CagePartSpecification')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-cagePartSpecification" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-cagePartSpecification" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
					
						<g:sortableColumn property="cagePartSpecification" title="${message(code: 'cagePartSpecification.cagePartSpecification.label', default: 'Cage Part Specification')}" />
					
						<th><g:message code="cagePartSpecification.cagePartType.label" default="Cage Part Type" /></th>
					
						<g:sortableColumn property="description" title="${message(code: 'cagePartSpecification.description.label', default: 'Description')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${cagePartSpecificationInstanceList}" status="i" var="cagePartSpecificationInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${cagePartSpecificationInstance.id}">${fieldValue(bean: cagePartSpecificationInstance, field: "cagePartSpecification")}</g:link></td>
					
						<td>${fieldValue(bean: cagePartSpecificationInstance, field: "cagePartType")}</td>
					
						<td>${fieldValue(bean: cagePartSpecificationInstance, field: "description")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<ul>
			<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
			<div class="pagination">
				<g:paginate total="${cagePartSpecificationInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
