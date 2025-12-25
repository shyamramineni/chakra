
<%@ page import="com.chakra.order.Corder" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'corder.label', default: 'Corder CagePart')}" />
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
			<h2><g:message code="default.findCorderByMeshPart.label" args="[entityName]" default="Corders CageParts" /></h2>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
										
						<th><g:message code="corder.orderId.label" default="Order Id" /></th>
					
						<th><g:message code="corder.customer.label" default="Customer" /></th>
						
						<th><g:message code="corder.paymentStatus.label" default="PaymentStatus" /></th>
						
						<th><g:message code="corder.shippingStatus.label" default="ShippingStatus" /></th>
						
						<th><g:message code="corder.noOfMeshParts.label" default="No Of MeshParts" /></th>						
					
					</tr>
				</thead>
				<tbody>
				
				<g:each in="${corderCagePartInstanceList}" status="i" var="corderInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
										
						<td><g:link action="show" id="${corderInstance.corder.id}">${fieldValue(bean: corderInstance, field: "corder.orderId")}</g:link></td>
												
						<td><g:link action="show" controller="customer" id="${corderInstance.corder.customer.id}">${fieldValue(bean: corderInstance, field: "corder.customer")}</g:link></td>
						
						<td><g:formatNumber number="${(corderInstance.corder.balance/corderInstance.corder.totalCost)*100}" type="number" maxFractionDigits="2"/>% DUE</td>
						
						<td>${fieldValue(bean: corderInstance, field: "corder.shippingStatus")}</td>
						
						<td>${corderInstance.noOfCageParts}</td>
						
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${corderCagePartInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
