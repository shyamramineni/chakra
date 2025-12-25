
<%@ page import="com.chakra.order.CorderPayment" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'corderPayment.label', default: 'CorderPayment')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body><%--
		<a href="#list-corderPayment" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		--%><div class="nav" role="navigation">
	
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
	
		</div>
		<div id="list-corderPayment" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
					
						<th><g:message code="corderPayment.corder.label" default="Corder" /></th>
					
						<th><g:message code="corderPayment.createdBy.label" default="Created By" /></th>
					
						<g:sortableColumn property="createdDate" title="${message(code: 'corderPayment.createdDate.label', default: 'Created Date')}" />
					
						<th><g:message code="corderPayment.customer.label" default="Customer" /></th>
					
						<th><g:message code="corderPayment.lastEditedBy.label" default="Last Edited By" /></th>
					
						<g:sortableColumn property="lastEditedDate" title="${message(code: 'corderPayment.lastEditedDate.label', default: 'Last Edited Date')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${corderPaymentInstanceList}" status="i" var="corderPaymentInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${corderPaymentInstance.id}">${fieldValue(bean: corderPaymentInstance, field: "corder")}</g:link></td>
					
						<td>${fieldValue(bean: corderPaymentInstance, field: "createdBy")}</td>
					
						<td><g:formatDate date="${corderPaymentInstance.createdDate}" /></td>
					
						<td>${fieldValue(bean: corderPaymentInstance, field: "customer")}</td>
					
						<td>${fieldValue(bean: corderPaymentInstance, field: "lastEditedBy")}</td>
					
						<td><g:formatDate date="${corderPaymentInstance.lastEditedDate}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination-centered">
				<g:paginate total="${corderPaymentInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
