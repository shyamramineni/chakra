
<%@ page import="com.chakra.order.CorderPayment" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'corderPayment.label', default: 'CorderPayment')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<%--<a href="#show-corderPayment" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		--%><div class="nav" role="navigation"><%--
	
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				--%><li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
	
		</div>
		<div id="show-corderPayment" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list corderPayment">
			
				<g:if test="${corderPaymentInstance?.corder}">
				<li class="fieldcontain">
					<span id="corder-label" class="property-label"><g:message code="corderPayment.corder.label" default="Corder" /></span>
					
						<span class="property-value" aria-labelledby="corder-label"><g:link controller="corder" action="show" id="${corderPaymentInstance?.corder?.id}">${corderPaymentInstance?.corder?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${corderPaymentInstance?.createdBy}">
				<li class="fieldcontain">
					<span id="createdBy-label" class="property-label"><g:message code="corderPayment.createdBy.label" default="Created By" /></span>
					
						<span class="property-value" aria-labelledby="createdBy-label"><g:link controller="user" action="show" id="${corderPaymentInstance?.createdBy?.id}">${corderPaymentInstance?.createdBy?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${corderPaymentInstance?.createdDate}">
				<li class="fieldcontain">
					<span id="createdDate-label" class="property-label"><g:message code="corderPayment.createdDate.label" default="Created Date" /></span>
					
						<span class="property-value" aria-labelledby="createdDate-label"><g:formatDate date="${corderPaymentInstance?.createdDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${corderPaymentInstance?.customer}">
				<li class="fieldcontain">
					<span id="customer-label" class="property-label"><g:message code="corderPayment.customer.label" default="Customer" /></span>
					
						<span class="property-value" aria-labelledby="customer-label"><g:link controller="customer" action="show" id="${corderPaymentInstance?.customer?.id}">${corderPaymentInstance?.customer?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${corderPaymentInstance?.lastEditedBy}">
				<li class="fieldcontain">
					<span id="lastEditedBy-label" class="property-label"><g:message code="corderPayment.lastEditedBy.label" default="Last Edited By" /></span>
					
						<span class="property-value" aria-labelledby="lastEditedBy-label"><g:link controller="user" action="show" id="${corderPaymentInstance?.lastEditedBy?.id}">${corderPaymentInstance?.lastEditedBy?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${corderPaymentInstance?.lastEditedDate}">
				<li class="fieldcontain">
					<span id="lastEditedDate-label" class="property-label"><g:message code="corderPayment.lastEditedDate.label" default="Last Edited Date" /></span>
					
						<span class="property-value" aria-labelledby="lastEditedDate-label"><g:formatDate date="${corderPaymentInstance?.lastEditedDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${corderPaymentInstance?.paymentAmount}">
				<li class="fieldcontain">
					<span id="paymentAmount-label" class="property-label"><g:message code="corderPayment.paymentAmount.label" default="Payment Amount" /></span>
					
						<span class="property-value" aria-labelledby="paymentAmount-label"><g:fieldValue bean="${corderPaymentInstance}" field="paymentAmount"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${corderPaymentInstance?.paymentDate}">
				<li class="fieldcontain">
					<span id="paymentDate-label" class="property-label"><g:message code="corderPayment.paymentDate.label" default="Payment Date" /></span>
					
						<span class="property-value" aria-labelledby="paymentDate-label"><g:formatDate date="${corderPaymentInstance?.paymentDate}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${corderPaymentInstance?.id}" />
					<sec:ifAllGranted roles="ROLE_ADMIN"><g:link class="btn-primary" action="edit" id="${corderPaymentInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link></sec:ifAllGranted>
					<sec:ifAllGranted roles="ROLE_ADMIN"><g:actionSubmit class="btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></sec:ifAllGranted>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
