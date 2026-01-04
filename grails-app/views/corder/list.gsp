
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
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered table-striped table-condensed">
				<thead>
					<tr>
					
					
						<g:sortableColumn property="orderId" title="${message(code: 'corder.orderId.label', default: 'Order Id')}" />
						
						<th><g:message code="corder.customer.label" default="Customer" /></th>
						
						<th><g:message code="corder.quotation.label" default="Quotation" /></th>
											
						<th><g:message code="corder.totalCost.label" default="TotalCost" /></th>
						
						<%--<th><g:message code="corder.balance.label" default="Balance" /></th>
						
						<th><g:message code="corder.noOfBirds.label" default="NoOfBirds" /></th>
						
						<th><g:message code="corder.costPerBird.label" default="CostPerBird" /></th>
						
						--%><th><g:message code="corder.deliveryDate.label" default="DeliverDate" /></th>												
					
						<th><g:message code="corder.status.label" default="Status" /></th>
						
						<th><g:message code="corder.paymentStatus.label" default="PaymentStatus" /></th>
						
						<th><g:message code="corder.shippingStatus.label" default="ShippingStatus" /></th>
						
						<th><g:message code="corder.action.label" default="Action" /></th>									
						
					
					</tr>
				</thead>
				<tbody>
								
				<g:each in="${corderInstanceList}" status="i" var="corderInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
											
						<td><g:link action="show" id="${corderInstance.id}">${fieldValue(bean: corderInstance, field: "orderId")}</g:link></td>
						
						<td>${fieldValue(bean: corderInstance, field: "customer")}</td>
						
						<td>${fieldValue(bean: corderInstance, field: "quotation")}</td>
						
						<td><g:formatNumber number="${corderInstance.totalCost}" type="number" maxFractionDigits="2" roundingMode="HALF_UP" /></td>
						
						<%--<td><g:formatNumber number="${corderInstance.balance}" type="number" maxFractionDigits="2" roundingMode="HALF_UP"/></td>
						
					    <td><g:formatNumber number="${corderInstance.noOfBirds}" type="number" maxFractionDigits="2" roundingMode="HALF_UP"/></td>
						
						<td><g:formatNumber number="${corderInstance.costPerBird}" type="number" maxFractionDigits="2" roundingMode="HALF_UP"/></td>
						
						--%><td><g:formatDate date="${corderInstance.deliveryDate}" format="dd-MM-yyyy"/></td>
						
						<td>${fieldValue(bean: corderInstance, field: "status")}</td>
						
						<td><g:link controller="corder" action="corderPayments" params="['corder':corderInstance.id]"><g:formatNumber number="${(corderInstance?.balance/corderInstance?.totalCost)*100}" type="number" maxFractionDigits="2"/>% DUE</g:link></td>
						
						<td>${fieldValue(bean: corderInstance, field: "shippingStatus")}</td>
						
						<td><g:link action="blockStock" id="${corderInstance?.id}"><g:message code="default.button.blockStock.label" default="Block Stock" /></g:link>/<g:link action="partLoad" id="${corderInstance?.id}"><g:message code="default.button.blockStock.label" default="Part Load" /></g:link></td>
						
					</tr>
				</g:each>
				</tbody>
			</table>
			
			<%--<table>
			       <tr>
					    <th>
					        Customer Name
					    </th>
					    <td>
					        <g:textField id="customerName" name="customerName" value=""/>
					    </td>
					    <td>
					        <g:form controller="corder" action="customer">
                                <g:hiddenField name="customerName" value="${customerName}" />
                                <div class="buttons">
                                    <span class="button"> <g:submitButton name="customer" value="Submit" /></span>
                                </div>     
                            </g:form>
					    </td>
					</tr>			
			</table>
			--%>
			<ul>
			    <li><g:link action="search">Search Order</g:link></li>
			</ul>
			<div class="pagination">
				<g:paginate total="${corderInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
