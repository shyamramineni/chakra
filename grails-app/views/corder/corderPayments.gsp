
<%@ page import="com.chakra.order.Corder" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'corder.label', default: 'Order Payments')}" />
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
			<h1>Order Payments</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			
			<table class="table table-bordered">
				<thead>
						
					<tr>
										
						<th><g:message code="corder.OrderId.label" default="Order Id" /></th>
					
						<th><g:message code="corder.customer.label" default="Customer" /></th>
						
						<th><g:message code="corder.quotation.label" default="Cost" /></th>
						
						<th><g:message code="corder.deliveryDate.label" default="Tax" /></th>												
					
						<th><g:message code="corder.paymentStatus.label" default="Total Cost" /></th>
											
						<th><g:message code="corder.totalCost.label" default="Payment Date" /></th>
						
						<th><g:message code="corder.balance.label" default="Payment Amount" /></th>
						
						<th><g:message code="corder.balance.label" default="Balance" /></th>
									
					</tr>
				</thead>
				<tbody>
				<g:each in="${corderPaymentList}" status="i" var="corderPaymentInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${corderPaymentInstance.corder.id}">${fieldValue(bean: corderPaymentInstance, field: "corder.orderId")}</g:link></td>
						
						<td>${corderPaymentInstance.customer.customerName}</td>
						
						<td>${fieldValue(bean: corderPaymentInstance, field: "corder.cost")}</td>
						
						<td>${fieldValue(bean: corderPaymentInstance, field: "corder.tax")}</td>
						
						<td>${fieldValue(bean: corderPaymentInstance, field: "corder.totalCost")}</td>
						
						<td>${fieldValue(bean: corderPaymentInstance, field: "paymentDate")}</td>
					
						<td>${fieldValue(bean: corderPaymentInstance, field: "paymentAmount")}</td>
					
						<td>${fieldValue(bean: corderPaymentInstance, field: "corder.balance")}</td>					
						
						
					</tr>
				</g:each>
				</tbody>
			</table>
			
			<g:if test="${true}">
                <g:link controller="corderPayment" action="create" params="['corder.id': corderInstance?.id, 'customer.id': corderInstance?.customer?.id]">${message(code: 'default.add.label', args: [message(code: 'corderPayment.label', default: 'CorderPayment')])}</g:link>	
            </g:if>
			<%--<div class="pagination">
				<g:paginate total="${customerOrderListTotal}" />
			</div>
		
		 	
		--%></div>
	</body>
</html>
