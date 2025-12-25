
<%@ page import="com.chakra.quotation.QuotationChainLinkModel" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quotationChainLinkModel.label', default: 'QuotationChainLinkModel')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-quotationChainLinkModel" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-quotationChainLinkModel" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="chainLinkCost" title="${message(code: 'quotationChainLinkModel.chainLinkCost.label', default: 'Chain Link Cost')}" />
					
						<g:sortableColumn property="chainLinkDiscount" title="${message(code: 'quotationChainLinkModel.chainLinkDiscount.label', default: 'Chain Link Discount')}" />
					
						<g:sortableColumn property="chainLinkDiscountPercent" title="${message(code: 'quotationChainLinkModel.chainLinkDiscountPercent.label', default: 'Chain Link Discount Percent')}" />
					
						<g:sortableColumn property="addValue" title="${message(code: 'quotationChainLinkModel.addValue.label', default: 'Add Value')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'quotationChainLinkModel.description.label', default: 'Description')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${quotationChainLinkModelInstanceList}" status="i" var="quotationChainLinkModelInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${quotationChainLinkModelInstance.id}">${fieldValue(bean: quotationChainLinkModelInstance, field: "chainLinkCost")}</g:link></td>
					
						<td>${fieldValue(bean: quotationChainLinkModelInstance, field: "chainLinkDiscount")}</td>
					
						<td>${fieldValue(bean: quotationChainLinkModelInstance, field: "chainLinkDiscountPercent")}</td>
					
						<td>${fieldValue(bean: quotationChainLinkModelInstance, field: "addValue")}</td>
					
						<td>${fieldValue(bean: quotationChainLinkModelInstance, field: "description")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${quotationChainLinkModelInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
