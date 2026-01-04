
<%@ page import="com.chakra.order.Corder" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'corder.label', default: 'Shipped Order')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-corder" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-corder" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list corder">
			
				<g:if test="${corderInstance?.customer}">
				<li class="fieldcontain">
					<span id="customer-label" class="property-label"><g:message code="corder.customer.label" default="Customer" /></span>
					
						<span class="property-value" aria-labelledby="customer-label">${corderInstance?.customer?.encodeAsHTML()}</span>
					
				</li>
				</g:if>
				
				<%--<g:if test="${corderInstance?.quotation}">
				<li class="fieldcontain">
					<span id="quotation-label" class="property-label"><g:message code="corder.quotation.label" default="Quotation" /></span>
					
						<span class="property-value" aria-labelledby="quotation-label"><g:link controller="quotation" action="show" id="${corderInstance?.quotation?.id}">${corderInstance?.quotation?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
				
				--%><g:if test="${corderInstance?.orderId}">
				<li class="fieldcontain">
					<span id="orderId-label" class="property-label"><g:message code="corder.orderId.label" default="Order Id" /></span>
					
						<span class="property-value" aria-labelledby="orderId-label"><g:fieldValue bean="${corderInstance}" field="orderId"/></span>
					
				</li>
				</g:if>
				
				<g:if test="${corderInstance?.cageDesign}">
				<li class="fieldcontain">
					<span id="cageDesign-label" class="property-label"><g:message code="corder.cageDesign.label" default="Cage Design" /></span>
					
						<span class="property-value" aria-labelledby="cageDesign-label">${corderInstance?.cageDesign?.encodeAsHTML()}</span>
					
				</li>
				</g:if>
				
				<g:if test="${corderInstance?.wireBrand}">
				<li class="fieldcontain">
					<span id="wireBrand-label" class="property-label"><g:message code="corder.wireBrand.label" default="Wire Brand" /></span>
					
						<span class="property-value" aria-labelledby="wireBrand-label">${corderInstance?.wireBrand?.encodeAsHTML()}</span>
					
				</li>
				</g:if>
				
				<g:if test="${corderInstance?.status}">
				<li class="fieldcontain">
					<span id="status-label" class="property-label"><g:message code="corder.status.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="status-label"><g:fieldValue bean="${corderInstance}" field="status"/></span>
					
				</li>
				</g:if>
				
				<g:if test="${corderInstance?.deliveryDate}">
				<li class="fieldcontain">
					<span id="enquiryDate-label" class="property-label"><g:message code="corder.deliveryDate.label" default="Delivery Date" /></span>
					
						<span class="property-value" aria-labelledby="deliveryDate-label"><g:formatDate date="${corderInstance?.deliveryDate}" format="dd-MM-yyyy" /></span>
					
				</li>
				</g:if>
				
				
				
				<g:if test="${corderInstance?.totalCost}">
				<li class="fieldcontain">
					<span id="totalCost-label" class="property-label"><g:message code="corder.totalCost.label" default="Total Cost" /></span>
					
						<span class="property-value" aria-labelledby="totalCost-label"><g:fieldValue bean="${corderInstance}" field="totalCost" /></span>
					
				</li>
				</g:if>	
				
				<g:if test="${corderInstance?.balance}">
				<li class="fieldcontain">
					<span id="balance-label" class="property-label"><g:message code="corder.balance.label" default="Balance" /></span>
					
						<span class="property-value" aria-labelledby="balance-label"><g:fieldValue bean="${corderInstance}" field="balance"/></span>
					
				</li>
				</g:if>			
									
				<g:if test="${corderInstance?.noOfBirds}">
				<li class="fieldcontain">
					<span id="noOfBirds-label" class="property-label"><g:message code="corder.noOfBirds.label" default="No Of Birds" /></span>
					
						<span class="property-value" aria-labelledby="noOfBirds-label"><g:fieldValue bean="${corderInstance}" field="noOfBirds"/></span>
					
				</li>
				</g:if>
				
				<g:if test="${corderInstance?.costPerBird}">
				<li class="fieldcontain">
					<span id="costPerBird-label" class="property-label"><g:message code="corder.costPerBird.label" default="Cost Per Bird" /></span>
					
						<span class="property-value" aria-labelledby="costPerBird-label"><g:fieldValue bean="${corderInstance}" field="costPerBird"/></span>
					
				</li>
				</g:if>
				
				<g:if test="${corderInstance?.paymentStatus}">
				<li class="fieldcontain">
					<span id="paymentStatus-label" class="property-label"><g:message code="corder.paymentStatus.label" default="Payment Status" /></span>
					
						<span class="property-value" aria-labelledby="paymentStatus-label"><g:fieldValue bean="${corderInstance}" field="paymentStatus"/></span>
					
				</li>
				</g:if>
									
				<g:if test="${corderInstance?.shippingStatus}">
				<li class="fieldcontain">
					<span id="shippingStatus-label" class="property-label"><g:message code="corder.shippingStatus.label" default="Shipping Status" /></span>
					
						<span class="property-value" aria-labelledby="shippingStatus-label"><g:fieldValue bean="${corderInstance}" field="shippingStatus"/></span>
					
				</li>
				</g:if>
				
				<%--<g:if test="${corderInstance?.createdBy}">
				<li class="fieldcontain">
					<span id="createdBy-label" class="property-label"><g:message code="corder.createdBy.label" default="Created By" /></span>
					
						<span class="property-value" aria-labelledby="createdBy-label"><g:link controller="user" action="show" id="${corderInstance?.createdBy?.id}">${corderInstance?.createdBy?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${corderInstance?.createdDate}">
				<li class="fieldcontain">
					<span id="createdDate-label" class="property-label"><g:message code="corder.createdDate.label" default="Created Date" /></span>
					
						<span class="property-value" aria-labelledby="createdDate-label"><g:formatDate date="${corderInstance?.createdDate}" /></span>
					
				</li>
				</g:if>
				
				<g:if test="${corderInstance?.lastEditedBy}">
				<li class="fieldcontain">
					<span id="lastEditedBy-label" class="property-label"><g:message code="corder.lastEditedBy.label" default="Last Edited By" /></span>
					
						<span class="property-value" aria-labelledby="lastEditedBy-label"><g:link controller="user" action="show" id="${corderInstance?.lastEditedBy?.id}">${corderInstance?.lastEditedBy?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${corderInstance?.lastEditedDate}">
				<li class="fieldcontain">
					<span id="lastEditedDate-label" class="property-label"><g:message code="corder.lastEditedDate.label" default="Last Edited Date" /></span>
					
						<span class="property-value" aria-labelledby="lastEditedDate-label"><g:formatDate date="${corderInstance?.lastEditedDate}" /></span>
					
				</li>
				</g:if>
				
				--%><%--<g:if test="${corderInstance?.corderPayments}">
				<li class="fieldcontain">
					<span id="corderPayments-label" class="property-label"><g:message code="corder.corderPayments.label" default="Corder Payments" /></span>
					
						<g:each in="${corderInstance.corderPayments}" var="c">
						<span class="property-value" aria-labelledby="corderPayments-label"><g:link controller="corderPayment" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				--%><%--<g:if test="${corderInstance?.cageLength}">
				<li class="fieldcontain">
					<span id="cageLength-label" class="property-label"><g:message code="corder.cageLength.label" default="Cage Length" /></span>
					
						<span class="property-value" aria-labelledby="cageLength-label"><g:fieldValue bean="${corderInstance}" field="cageLength"/></span>
					
				</li>
				</g:if>
			
				--%>
			
				
			
				
			
				
			
				<%--<g:if test="${corderInstance?.doubleBox}">
				<li class="fieldcontain">
					<span id="doubleBox-label" class="property-label"><g:message code="corder.doubleBox.label" default="Double Box" /></span>
					
						<span class="property-value" aria-labelledby="doubleBox-label"><g:fieldValue bean="${corderInstance}" field="doubleBox"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${corderInstance?.fulls}">
				<li class="fieldcontain">
					<span id="fulls-label" class="property-label"><g:message code="corder.fulls.label" default="Fulls" /></span>
					
						<span class="property-value" aria-labelledby="fulls-label"><g:fieldValue bean="${corderInstance}" field="fulls"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${corderInstance?.halfs}">
				<li class="fieldcontain">
					<span id="halfs-label" class="property-label"><g:message code="corder.halfs.label" default="Halfs" /></span>
					
						<span class="property-value" aria-labelledby="halfs-label"><g:fieldValue bean="${corderInstance}" field="halfs"/></span>
					
				</li>
				</g:if>
			
				--%
			
				
			
				<%--<g:if test="${corderInstance?.noOfCuttingsInShed}">
				<li class="fieldcontain">
					<span id="noOfCuttingsInShed-label" class="property-label"><g:message code="corder.noOfCuttingsInShed.label" default="No Of Cuttings In Shed" /></span>
					
						<span class="property-value" aria-labelledby="noOfCuttingsInShed-label"><g:fieldValue bean="${corderInstance}" field="noOfCuttingsInShed"/></span>
					
				</li>
				</g:if>
			
				--%
			
				
			
				
			
				<%--<g:if test="${corderInstance?.singleBox}">
				<li class="fieldcontain">
					<span id="singleBox-label" class="property-label"><g:message code="corder.singleBox.label" default="Single Box" /></span>
					
						<span class="property-value" aria-labelledby="singleBox-label"><g:fieldValue bean="${corderInstance}" field="singleBox"/></span>
					
				</li>
				</g:if>
			
				--%>
			
				<%--<g:if test="${corderInstance?.tiers}">
				<li class="fieldcontain">
					<span id="tiers-label" class="property-label"><g:message code="corder.tiers.label" default="Tiers" /></span>
					
						<span class="property-value" aria-labelledby="tiers-label"><g:fieldValue bean="${corderInstance}" field="tiers"/></span>
					
				</li>
				</g:if>
			
				--%>
				<g:if test="${corderInstance?.corderMeshParts}">
				<li class="fieldcontain">
					<span id="orderMeshParts-label" class="property-label"><g:message code="corder.orderMeshParts.label" default="Order Mesh Parts" /></span>
					
						<g:each in="${corderInstance.corderMeshParts}" var="o">
						<br>
						<%--<span class="property-value" aria-labelledby="orderMeshParts-label"><g:link controller="orderMeshParts" action="show" id="${o.id}">${o?.encodeAsHTML()}</g:link></span>
						 --%><span class="property-value" aria-labelledby="orderMeshParts-label">${o?.encodeAsHTML()}</span>
						</g:each>
					
				</li>
				</g:if>
				
				
				<g:if test="${corderInstance?.corderPayments}">
				<li class="fieldcontain">
					<span id="corderPayments-label" class="property-label"><g:message code="corder.corderPayments.label" default="Corder Payments" /></span>
					
						<g:each in="${corderInstance.corderPayments}" var="c">
						<br>
						<!-- <span class="property-value" aria-labelledby="corderPayments-label"><g:link controller="corderPayment" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></span>  -->
						<span class="property-value" aria-labelledby="corderPayments-label">${c?.encodeAsHTML()}</span>
						</g:each>
					
				</li>
				</g:if>
				
				<g:if test="${totalPayment}">
				<li class="fieldcontain">
					<span id="wireBrand-label" class="property-label"><g:message code="corder.wireBrand.label" default="Total Payment " /></span>
					
						<span class="property-value" aria-labelledby="wireBrand-label">${totalPayment}</span>
					
				</li>
				</g:if>
								
				<%--<g:if test="${true}">
				<g:link controller="corderPayment" action="create" params="['corder.id': corderInstance?.id, 'customer.id': corderInstance?.customer?.id]">${message(code: 'default.add.label', args: [message(code: 'corderPayment.label', default: 'CorderPayment')])}</g:link>
				</g:if>
						
			--%></ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${corderInstance?.id}" />
					<g:actionSubmit class="btn-primary" action="updateShippingStatus" value="Ship Order" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
