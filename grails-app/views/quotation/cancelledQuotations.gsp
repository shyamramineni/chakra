
<%@ page import="com.chakra.quotation.Quotation" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quotation.label', default: 'Cancelled Quotations')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-quotation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-quotation" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
					
						<th><g:message code="quotation.orderId.label" default="Quotation Id" /></th>
												
						<th><g:message code="quotation.customer.label" default="Customer Id" /></th>
						
						<th><g:message code="quotation.customer.label" default="Customer Name" /></th>
						
						<th><g:message code="quotation.quotationFailedReason.label" default="Quotation Failed Reason" /></th>
						
						<th><g:message code="quotation.status.label" default="Status" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${quotationInstanceList}" status="i" var="quotationInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${quotationInstance.id}">${fieldValue(bean: quotationInstance, field: "quotationId")}</g:link></td>
						
						<td><g:link controller="customer" action="show" id="${quotationInstance.id}">${fieldValue(bean: quotationInstance, field: "customer.customerId")}</g:link></td>
						
						<td>${fieldValue(bean: quotationInstance, field: "customer.customerName")}</td>
						
						<td>${fieldValue(bean: quotationInstance, field: "quotationFailedReason")}</td>
						
						<td>${fieldValue(bean: quotationInstance, field: "status")}</td>
						
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${quotationInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
