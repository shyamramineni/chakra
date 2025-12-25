
<%@ page import="com.chakra.quotation.QuotationChainLink" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quotationChainLink.label', default: 'QuotationChainLink')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-quotationChainLink" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-quotationChainLink" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="quotationChainLink.linkMesh.label" default="Link Mesh" /></th>
					
						<th><g:message code="quotationChainLink.wireBrand.label" default="Wire Brand" /></th>
					
						<g:sortableColumn property="length" title="${message(code: 'quotationChainLink.length.label', default: 'Length')}" />
					
						<g:sortableColumn property="height" title="${message(code: 'quotationChainLink.height.label', default: 'Height')}" />
					
						<g:sortableColumn property="noOfPieces" title="${message(code: 'quotationChainLink.noOfPieces.label', default: 'No Of Pieces')}" />
					
						<g:sortableColumn property="squareFeets" title="${message(code: 'quotationChainLink.squareFeets.label', default: 'Square Feets')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${quotationChainLinkInstanceList}" status="i" var="quotationChainLinkInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${quotationChainLinkInstance.id}">${fieldValue(bean: quotationChainLinkInstance, field: "linkMesh")}</g:link></td>
					
						<td>${fieldValue(bean: quotationChainLinkInstance, field: "wireBrand")}</td>
					
						<td>${fieldValue(bean: quotationChainLinkInstance, field: "length")}</td>
					
						<td>${fieldValue(bean: quotationChainLinkInstance, field: "height")}</td>
					
						<td>${fieldValue(bean: quotationChainLinkInstance, field: "noOfPieces")}</td>
					
						<td>${fieldValue(bean: quotationChainLinkInstance, field: "squareFeets")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${quotationChainLinkInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
