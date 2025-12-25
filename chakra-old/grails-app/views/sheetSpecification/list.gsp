
<%@ page import="com.chakra.config.SheetSpecification" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'sheetSpecification.label', default: 'SheetSpecification')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-sheetSpecification" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><sec:ifAnyGranted roles="ROLE_ADMIN"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></sec:ifAnyGranted></li>
			</ul>
		</div>
		<div id="list-sheetSpecification" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
					
						<g:sortableColumn property="sheetName" title="${message(code: 'sheetSpecification.sheetName.label', default: 'Sheet Name')}" />
					
						<g:sortableColumn property="projection" title="${message(code: 'sheetSpecification.projection.label', default: 'Projection')}" />
					
						<g:sortableColumn property="width" title="${message(code: 'sheetSpecification.width.label', default: 'Width')}" />
					
						<g:sortableColumn property="length" title="${message(code: 'sheetSpecification.length.label', default: 'Length')}" />
					
						<g:sortableColumn property="pitch" title="${message(code: 'sheetSpecification.pitch.label', default: 'Pitch')}" />
						
						<g:sortableColumn property="pitch" title="${message(code: 'sheetSpecification.pitch.label', default: 'Factory Pitch')}" />
						
						<g:sortableColumn property="pitch" title="${message(code: 'noOfCrossWires.pitch.label', default: 'No Of CrossWires')}" />
					
						<g:sortableColumn property="crossWireDiameter" title="${message(code: 'sheetSpecification.sheetWeight.label', default: 'Sheet Weight')}" />							
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${sheetSpecificationInstanceList}" status="i" var="sheetSpecificationInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${sheetSpecificationInstance.id}">${fieldValue(bean: sheetSpecificationInstance, field: "sheetName")}</g:link></td>
					
						<td>${fieldValue(bean: sheetSpecificationInstance, field: "projection")}</td>
					
						<td>${fieldValue(bean: sheetSpecificationInstance, field: "width")}</td>
					
						<td>${fieldValue(bean: sheetSpecificationInstance, field: "length")}</td>
					
						<td>${fieldValue(bean: sheetSpecificationInstance, field: "pitch")}</td>
						
						<td>${fieldValue(bean: sheetSpecificationInstance, field: "factoryPitch")}</td>
						
						<td>${fieldValue(bean: sheetSpecificationInstance, field: "noOfCrossWires")}</td>
					
						<td>${fieldValue(bean: sheetSpecificationInstance, field: "sheetWeight")}</td>
						
					</tr>
				</g:each>
				</tbody>
			</table>
			<ul>
			<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
			<div class="pagination">
				<g:paginate total="${sheetSpecificationInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
