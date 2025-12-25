
<%@ page import="com.chakra.config.CageDesign" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cageDesign.label', default: 'CageDesign')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-cageDesign" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><sec:ifAnyGranted roles="ROLE_ADMIN"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></sec:ifAnyGranted></li>
			</ul>
		</div>
		<div id="list-cageDesign" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
					
						<g:sortableColumn property="cageDesign" title="${message(code: 'cageDesign.cageDesign.label', default: 'Cage Design')}" />
					
						<g:sortableColumn property="sheetLength" title="${message(code: 'cageDesign.sheetLength.label', default: 'Sheet Length')}" />
					
						<g:sortableColumn property="noOfBirdsPerCageSingleBox" title="${message(code: 'cageDesign.noOfBirdsPerCageSingleBox.label', default: 'No Of Birds Per Cage Single Box')}" />
					
						<g:sortableColumn property="noOfBirdsPerCageDoubleBox" title="${message(code: 'cageDesign.noOfBirdsPerCageDoubleBox.label', default: 'No Of Birds Per Cage Double Box')}" />
					
						<g:sortableColumn property="noOfPartitionsPerSheetLength" title="${message(code: 'cageDesign.noOfPartitionsPerSheetLength.label', default: 'No Of Partitions Per Sheet Length')}" />
					
						<g:sortableColumn property="noOfSingleBottomsPerSheet" title="${message(code: 'cageDesign.noOfSingleBottomsPerSheet.label', default: 'No Of Single Bottoms Per Sheet')}" />
						
						<g:sortableColumn property="action" title="${message(code: 'cageDesign.action.label', default: 'Action')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${cageDesignInstanceList}" status="i" var="cageDesignInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${cageDesignInstance.id}">${fieldValue(bean: cageDesignInstance, field: "cageDesign")}</g:link></td>
					
						<td>${fieldValue(bean: cageDesignInstance, field: "sheetLength")}</td>
					
						<td>${fieldValue(bean: cageDesignInstance, field: "noOfBirdsPerCageSingleBox")}</td>
					
						<td>${fieldValue(bean: cageDesignInstance, field: "noOfBirdsPerCageDoubleBox")}</td>
					
						<td>${fieldValue(bean: cageDesignInstance, field: "noOfPartitionsPerSheetLength")}</td>
					
						<td>${fieldValue(bean: cageDesignInstance, field: "noOfSingleBottomsPerSheet")}</td>
						
						<g:if test="${cageDesignInstance?.isCustom == false}">
						<td><g:link action="customCageDesign" params="["cageDesign":cageDesignInstance.id]">Custom Design</g:link></td>
						</g:if>
					</tr>
				</g:each>
				</tbody>
			</table>
			<ul>
			<li><sec:ifAnyGranted roles="ROLE_ADMIN"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></sec:ifAnyGranted></li>
			</ul>
			<div class="pagination">
				<g:paginate total="${cageDesignInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
