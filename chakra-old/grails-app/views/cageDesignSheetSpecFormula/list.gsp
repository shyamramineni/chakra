
<%@ page import="com.chakra.config.CageDesignSheetSpecFormula" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cageDesignSheetSpecFormula.label', default: 'CageDesignSheetSpecFormula')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<r:require module="export"/>
	</head>
	<body>
		<a href="#list-cageDesignSheetSpecFormula" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-cageDesignSheetSpecFormula" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
					
						<th><g:message code="cageDesignSheetSpecFormula.sheetSpecification.label" default="Sheet Specification" /></th>
					
						<th><g:message code="cageDesignSheetSpecFormula.cageDesign.label" default="Cage Design" /></th>
					
						<g:sortableColumn property="formula" title="${message(code: 'cageDesignSheetSpecFormula.formula.label', default: 'Formula')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'cageDesignSheetSpecFormula.description.label', default: 'Description')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${cageDesignSheetSpecFormulaInstanceList}" status="i" var="cageDesignSheetSpecFormulaInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${cageDesignSheetSpecFormulaInstance.id}">${fieldValue(bean: cageDesignSheetSpecFormulaInstance, field: "sheetSpecification")}</g:link></td>
					
						<td>${fieldValue(bean: cageDesignSheetSpecFormulaInstance, field: "cageDesign")}</td>
					
						<td>${fieldValue(bean: cageDesignSheetSpecFormulaInstance, field: "formula")}</td>
					
						<td>${fieldValue(bean: cageDesignSheetSpecFormulaInstance, field: "description")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<ul>
			<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
			<div class="pagination">
				<g:paginate total="${cageDesignSheetSpecFormulaInstanceTotal}" />
			</div>
			<div>
		    	<export:formats formats="['csv', 'excel', 'ods', 'pdf', 'rtf', 'xml']"  />
			</div>
		</div>
	</body>
</html>
