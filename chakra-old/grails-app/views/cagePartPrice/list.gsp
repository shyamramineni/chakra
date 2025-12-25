
<%@ page import="com.chakra.config.CagePartPrice" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cagePartPrice.label', default: 'CagePartPrice')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-cagePartPrice" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-cagePartPrice" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
					
						<g:sortableColumn property="description" title="${message(code: 'cagePartPrice.description.label', default: 'Cage Part')}" />
					
						<th><g:message code="cagePartPrice.cagePart.label" default="Price" /></th>
					
						<g:sortableColumn property="price" title="${message(code: 'cagePartPrice.price.label', default: 'Description')}" />
					
						<g:sortableColumn property="startDate" title="${message(code: 'cagePartPrice.startDate.label', default: 'Start Date')}" />
						
						<g:sortableColumn property="endDate" title="${message(code: 'cagePartPrice.endDate.label', default: 'End Date')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${cagePartPriceInstanceList}" status="i" var="cagePartPriceInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${cagePartPriceInstance.id}">${fieldValue(bean: cagePartPriceInstance, field: "cagePart")}</g:link></td>
					
						<td>${fieldValue(bean: cagePartPriceInstance, field: "price")}</td>
					
						<td>${fieldValue(bean: cagePartPriceInstance, field: "description")}</td>
					
						<td><g:formatDate date="${cagePartPriceInstance.startDate}" /></td>
						
						<td><g:formatDate date="${cagePartPriceInstance.endDate}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<ul>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
			<div class="pagination">
				<g:paginate total="${cagePartPriceInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
