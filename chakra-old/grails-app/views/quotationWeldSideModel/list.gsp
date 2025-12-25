
<%@ page import="com.chakra.quotation.QuotationWeldSideModel" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quotationWeldSideModel.label', default: 'QuotationWeldSideModel')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-quotationWeldSideModel" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-quotationWeldSideModel" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="weldSideCost" title="${message(code: 'quotationWeldSideModel.weldSideCost.label', default: 'Weld Side Cost')}" />
					
						<g:sortableColumn property="weldSideDiscount" title="${message(code: 'quotationWeldSideModel.weldSideDiscount.label', default: 'Weld Side Discount')}" />
					
						<g:sortableColumn property="weldSideDiscountPercent" title="${message(code: 'quotationWeldSideModel.weldSideDiscountPercent.label', default: 'Weld Side Discount Percent')}" />
					
						<g:sortableColumn property="netWeldSideCost" title="${message(code: 'quotationWeldSideModel.netWeldSideCost.label', default: 'Net Weld Side Cost')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${quotationWeldSideModelInstanceList}" status="i" var="quotationWeldSideModelInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${quotationWeldSideModelInstance.id}">${fieldValue(bean: quotationWeldSideModelInstance, field: "weldSideCost")}</g:link></td>
					
						<td>${fieldValue(bean: quotationWeldSideModelInstance, field: "weldSideDiscount")}</td>
					
						<td>${fieldValue(bean: quotationWeldSideModelInstance, field: "weldSideDiscountPercent")}</td>
					
						<td>${fieldValue(bean: quotationWeldSideModelInstance, field: "netWeldSideCost")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${quotationWeldSideModelInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
