
<%@ page import="com.chakra.config.CagePartSpecFormula" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cagePartSpecFormula.label', default: 'CagePartSpecFormula')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-cagePartSpecFormula" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-cagePartSpecFormula" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
					
						<th><g:message code="cagePartSpecFormula.cagePart.label" default="Cage Part" /></th>
					
						<th><g:message code="cagePartSpecFormula.cagePartSpecification.label" default="Cage Part Specification" /></th>
					
						<g:sortableColumn property="formula" title="${message(code: 'cagePartSpecFormula.formula.label', default: 'Formula')}" />
						
						<th><g:message code="cagePartSpecFormula.description.label" default="Description" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${cagePartSpecFormulaInstanceList}" status="i" var="cagePartSpecFormulaInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${cagePartSpecFormulaInstance.id}">${fieldValue(bean: cagePartSpecFormulaInstance, field: "cagePart")}</g:link></td>
					
						<td>${fieldValue(bean: cagePartSpecFormulaInstance, field: "cagePartSpecification")}</td>
					
						<td>${fieldValue(bean: cagePartSpecFormulaInstance, field: "formula")}</td>
						
						<td>${fieldValue(bean: cagePartSpecFormulaInstance, field: "description")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<ul>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
			<div class="pagination">
				<g:paginate total="${cagePartSpecFormulaInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
