
<%@ page import="com.chakra.config.CagePart" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cagePart.label', default: 'CagePart')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-cagePart" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			cc
		</div>
		<div id="list-cagePart" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
					
						<g:sortableColumn property="cagePartCode" title="${message(code: 'cagePart.cagePartCode.label', default: 'Cage Part Code')}" />
						
						<g:sortableColumn property="cagePart" title="${message(code: 'cagePart.cagePart.label', default: 'Cage Part')}" />
					
						<g:sortableColumn property="image" title="${message(code: 'cagePart.image.label', default: 'CagePart Image')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'cagePart.description.label', default: 'Description')}" />
					
						<%--<th><g:message code="cagePart.parentCagePart.label" default="Parent Cage Part" /></th>
					
						<g:sortableColumn property="formula" title="${message(code: 'cagePart.formula.label', default: 'Formula')}" />
					
					--%></tr>
				</thead>
				<tbody>
				<g:each in="${cagePartInstanceList}" status="i" var="cagePartInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>${fieldValue(bean: cagePartInstance, field: "cagePartCode")}</td>
					
						<td><g:link action="show" id="${cagePartInstance.id}">${fieldValue(bean: cagePartInstance, field: "cagePart")}</g:link></td>
					
						<td><img src="${createLink(action:'showImage', id:cagePartInstance?.id)}" /></td>						
					
						<td>${fieldValue(bean: cagePartInstance, field: "description")}</td>
					
						<%--<td>${fieldValue(bean: cagePartInstance, field: "parentCagePart")}</td>
					
						<td>${fieldValue(bean: cagePartInstance, field: "formula")}</td>
					
					--%></tr>
				</g:each>
				</tbody>
			</table>
			<ul>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
			<div class="pagination">
				<g:paginate total="${cagePartInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
