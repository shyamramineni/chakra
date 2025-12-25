
<%@ page import="com.chakra.quotation.QuotationWeldSide" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quotationWeldSide.label', default: 'QuotationWeldSide')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-quotationWeldSide" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-quotationWeldSide" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="quotationWeldSide.sideMesh.label" default="Side Mesh" /></th>
					
						<th><g:message code="quotationWeldSide.wireBrand.label" default="Wire Brand" /></th>
					
						<g:sortableColumn property="length" title="${message(code: 'quotationWeldSide.length.label', default: 'Length')}" />
					
						<g:sortableColumn property="height" title="${message(code: 'quotationWeldSide.height.label', default: 'Height')}" />
					
						<g:sortableColumn property="noOfPieces" title="${message(code: 'quotationWeldSide.noOfPieces.label', default: 'No Of Pieces')}" />
					
						<g:sortableColumn property="squareFeets" title="${message(code: 'quotationWeldSide.squareFeets.label', default: 'Square Feets')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${quotationWeldSideInstanceList}" status="i" var="quotationWeldSideInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${quotationWeldSideInstance.id}">${fieldValue(bean: quotationWeldSideInstance, field: "sideMesh")}</g:link></td>
					
						<td>${fieldValue(bean: quotationWeldSideInstance, field: "wireBrand")}</td>
					
						<td>${fieldValue(bean: quotationWeldSideInstance, field: "length")}</td>
					
						<td>${fieldValue(bean: quotationWeldSideInstance, field: "height")}</td>
					
						<td>${fieldValue(bean: quotationWeldSideInstance, field: "noOfPieces")}</td>
					
						<td>${fieldValue(bean: quotationWeldSideInstance, field: "squareFeets")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${quotationWeldSideInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
