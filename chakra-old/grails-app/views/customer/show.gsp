<%@ page import="com.chakra.customer.Customer" %>

<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

--%><!doctype html>
<html>
	<head>
		<meta name="layout" content="main" />
		<g:set var="entityName" value="${message(code: 'customer.label', default: 'Customer')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body><%--
		<a href="#show-customer" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		--%><div class="nav" role="navigation"><%--
			
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				--%><li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			
		</div>
		<div id="show-customer" class="content scaffold-show" role="main">
			<h2><g:message code="default.show.label" args="[entityName]" /></h2>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<%--<ol class="property-list customer">
			
						
				<g:if test="${customerInstance?.customerId}">
				<li class="fieldcontain">
					<span id="customerId-label" class="property-label"><g:message code="customer.customerId.label" default="Customer Id" /></span>
					
						<span class="property-value" aria-labelledby="customerId"><g:fieldValue bean="${customerInstance}" field="customerId"/></span>
					
				</li>
				</g:if>
				
				<g:if test="${customerInstance?.customerName}">
				<li class="fieldcontain">
					<span id="customerName-label" class="property-label"><g:message code="customer.customerName.label" default="Customer Name" /></span>
					
						<span class="property-value" aria-labelledby="customerName-label"><g:fieldValue bean="${customerInstance}" field="customerName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.companyName}">
				<li class="fieldcontain">
					<span id="companyName-label" class="property-label"><g:message code="customer.companyName.label" default="Company Name" /></span>
					
						<span class="property-value" aria-labelledby="companyName-label"><g:fieldValue bean="${customerInstance}" field="companyName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.mobileNumber}">
				<li class="fieldcontain">
					<span id="mobileNumber-label" class="property-label"><g:message code="customer.mobileNumber.label" default="Mobile Number" /></span>
					
						<span class="property-value" aria-labelledby="mobileNumber-label"><g:fieldValue bean="${customerInstance}" field="mobileNumber"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.phoneNumber}">
				<li class="fieldcontain">
					<span id="phoneNumber-label" class="property-label"><g:message code="customer.phoneNumber.label" default="Phone Number" /></span>
					
						<span class="property-value" aria-labelledby="phoneNumber-label"><g:fieldValue bean="${customerInstance}" field="phoneNumber"/></span>
					
				</li>
				</g:if>
				
				<g:if test="${customerInstance?.email}">
				<li class="fieldcontain">
					<span id="email-label" class="property-label"><g:message code="customer.email.label" default="Email" /></span>
					
						<span class="property-value" aria-labelledby="email-label"><g:fieldValue bean="${customerInstance}" field="email"/></span>
					
				</li>
				</g:if>
				
				<g:if test="${customerInstance?.fax}">
				<li class="fieldcontain">
					<span id="fax-label" class="property-label"><g:message code="customer.fax.label" default="Fax" /></span>
					
						<span class="property-value" aria-labelledby="fax-label"><g:fieldValue bean="${customerInstance}" field="fax"/></span>
					
				</li>
				</g:if>
				
				<g:if test="${customerInstance?.address}">
				<li class="fieldcontain">
					<span id="address-label" class="property-label"><g:message code="customer.address.label" default="Address" /></span>
					
						<span class="property-value" aria-labelledby="address-label"><g:fieldValue bean="${customerInstance}" field="address"/></span>
					
				</li>
				</g:if>
			
			</ol>
			
			--%>
			<table class="table table-bordered">
							
				    <tr>
				        <th align="left">Customer Id:</th>
				        <td>${customerInstance.customerId}</td>
				    </tr>
				    <tr>
				        <th align="left">Customer Name:</th>
				        <td>${customerInstance.customerName}</td>
				    </tr>
				    <tr>
				        <th align="left">Company Name:</th>
				        <td>${customerInstance.companyName}</td>
				    </tr>
				    <tr>
				        <th align="left">Mobile Number:</th>
				        <td>${customerInstance.mobileNumber}</td>
				    </tr>
				    <tr>
				        <th align="left">Phone Number:</th>
				        <td>${customerInstance.phoneNumber}</td>
				    </tr>
				    <tr>
				        <th align="left">Email:</th>
				        <td>${customerInstance.email}</td>
				    </tr>
				    <tr>
				        <th align="left">Fax:</th>
				        <td>${customerInstance.fax}</td>
				    </tr>
				    <tr>
				        <th align="left">Address:</th>
				        <td>${customerInstance.address}</td>
				    </tr>
				    <tr>
				        <th align="left">Comments:</th>
				        <td>${customerInstance.comments}</td>
				    </tr>
				    						
			</table>
			
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${customerInstance?.id}" />
					
				
					<sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_SALES"><a class="btn btn-primary" href="<g:createLink action="create" controller="enquiry" params="['customer.id': customerInstance?.id]"/>">Create Enquiry</a></sec:ifAnyGranted>
					<%--<sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_SALES"><a class="btn btn-primary" href="<g:createLink action="create" controller="quotation" params="['customer.id': customerInstance?.id]"/>">Create Quotation</a></sec:ifAnyGranted>
					--%><g:link class="btn btn-primary" action="customerPdf" id="${customerInstance?.id}"><g:message code="default.button.print.label" default="Print" /></g:link>
					<sec:ifAnyGranted roles="ROLE_ADMIN"><g:link class="btn btn-primary" action="edit" id="${customerInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link></sec:ifAnyGranted>
					<sec:ifAnyGranted roles="ROLE_ADMIN"><g:actionSubmit class="btn btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Confirm Delete')}');" /></sec:ifAnyGranted>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
