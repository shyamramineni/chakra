
<%@ page import="com.chakra.order.CorderCageParts" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'corderCageParts.label', default: 'CorderCageParts')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-corderCageParts" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-corderCageParts" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="corderCageParts.cagePartSpecFormula.label" default="Cage Part Spec Formula" /></th>
					
						<g:sortableColumn property="noOfCageParts" title="${message(code: 'corderCageParts.noOfCageParts.label', default: 'No Of Cage Parts')}" />
					
						<g:sortableColumn property="priceOfEachCagePart" title="${message(code: 'corderCageParts.priceOfEachCagePart.label', default: 'Price Of Each Cage Part')}" />
					
						<g:sortableColumn property="costOfCagePart" title="${message(code: 'corderCageParts.costOfCagePart.label', default: 'Cost Of Cage Part')}" />
					
						<g:sortableColumn property="cageCost" title="${message(code: 'corderCageParts.cageCost.label', default: 'Cage Cost')}" />
					
						<th><g:message code="corderCageParts.corder.label" default="Corder" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${corderCagePartsInstanceList}" status="i" var="corderCagePartsInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${corderCagePartsInstance.id}">${fieldValue(bean: corderCagePartsInstance, field: "cagePartSpecFormula")}</g:link></td>
					
						<td>${fieldValue(bean: corderCagePartsInstance, field: "noOfCageParts")}</td>
					
						<td>${fieldValue(bean: corderCagePartsInstance, field: "priceOfEachCagePart")}</td>
					
						<td>${fieldValue(bean: corderCagePartsInstance, field: "costOfCagePart")}</td>
					
						<td>${fieldValue(bean: corderCagePartsInstance, field: "cageCost")}</td>
					
						<td>${fieldValue(bean: corderCagePartsInstance, field: "corder")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${corderCagePartsInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
