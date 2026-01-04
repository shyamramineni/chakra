
<%@ page import="com.chakra.order.Corder" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'corder.label', default: 'Corder')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body><%--
		<a href="#list-corder" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		--%><div class="nav" role="navigation"><%--
	
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				--%><li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
				<li><g:link action="search">Search</g:link></li>
	
		</div>
		<div id="list-corder" class="content scaffold-list" role="main">
			<h1>Customer Orders</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			
			<table class="table table-bordered">
				<thead>
						
					<tr>
										
						<th><g:message code="corder.OrderId.label" default="Order Id" /></th>
					
						<th><g:message code="corder.customer.label" default="Customer" /></th>
						
						<%--<th><g:message code="corder.quotation.label" default="Quotation" /></th>
											
						<th><g:message code="corder.totalCost.label" default="Total Cost" /></th>
						
						<th><g:message code="corder.balance.label" default="Balance" /></th>
						
						--%><th><g:message code="corder.deliveryDate.label" default="DeliveryDate" /></th>												
					
						<th><g:message code="corder.paymentStatus.label" default="PaymentStatus" /></th>
						
						<th><g:message code="corder.shippingStatus.label" default="ShippingStatus" /></th>
									
					</tr>
				</thead>
				<tbody>
				<g:each in="${customerOrderList}" status="i" var="corderInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						
						<td><g:link action="show" id="${corderInstance.id}">${fieldValue(bean: corderInstance, field: "orderId")}</g:link></td>
						
						<td>${corderInstance.customer.customerName}</td>
						
						<%--<td><g:link action="show" controller="quotation" id="${corderInstance.quotation.id}">${fieldValue(bean: corderInstance, field: "quotation")}</g:link></td>
						
						<td>${fieldValue(bean: corderInstance, field: "totalCost")}</td>
					
						<td>${fieldValue(bean: corderInstance, field: "balance")}</td>
					
						--%><td><g:formatDate date="${corderInstance.deliveryDate}" /></td>
						
						<td><g:formatNumber number="${(corderInstance.balance/corderInstance.totalCost)*100}" type="number" maxFractionDigits="2"/>% DUE</td>
						
						<td>${fieldValue(bean: corderInstance, field: "shippingStatus")}</td>
						
						
						
					</tr>
				</g:each>
				</tbody>
			</table>
			<%--<div class="pagination">
				<g:paginate total="${customerOrderListTotal}" />
			</div>
		--%></div>
	</body>
</html>
