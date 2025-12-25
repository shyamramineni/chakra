<%@ page import="com.chakra.customer.Customer" %>


<div class="fieldcontain ${hasErrors(bean: customerInstance, field: 'companyName', 'error')} ">
	<label for="companyName">
		<g:message code="customer.companyName.label" default="Company Name" />
		<span class="required-indicator">*</span> </label>
	<g:textField name="companyName" required="" value="${customerInstance?.companyName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: customerInstance, field: 'customerName', 'error')} ">
	<label for="customerName">
		<g:message code="customer.customerName.label" default="Customer Name" />
		<span class="required-indicator">*</span> </label>
	</label>
	<g:textField name="customerName" required="" value="${customerInstance?.customerName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: customerInstance, field: 'email', 'error')} ">
	<label for="email">
		<g:message code="customer.email.label" default="Email" />
		
	</label>
	<g:textField name="email" value="${customerInstance?.email}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: customerInstance, field: 'mobileNumber', 'error')} ">
	<label for="mobileNumber">
		<g:message code="customer.mobileNumber.label" default="Mobile Number" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="mobileNumber" required="" value="${customerInstance?.mobileNumber}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: customerInstance, field: 'phoneNumber', 'error')} ">
	<label for="phoneNumber">
		<g:message code="customer.phoneNumber.label" default="Phone Number" />
		
	</label>
	<g:textField name="phoneNumber" value="${customerInstance?.phoneNumber}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: customerInstance, field: 'fax', 'error')} ">
	<label for="fax">
		<g:message code="customer.fax.label" default="Fax" />
		
	</label>
	<g:textField name="fax" value="${customerInstance?.fax}"/>
</div>

<div class="address ${hasErrors(bean: customerInstance, field: 'address', 'error')} ">
	<label for="address">
		<g:message code="customer.address.label" default="Address" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="address" required="" value="${customerInstance?.address}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: customerInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="customer.comments.label" default="Comments/Remarks" />
		
	</label>
	<g:textArea name="comments" value="${customerInstance?.comments}"/>
</div>

<%--
<div class="fieldcontain ${hasErrors(bean: customerInstance, field: 'customerId', 'error')} ">
	<label for="customerId">
		<g:message code="customer.customerId.label" default="Customer Id" />
		
	</label>
	<g:textField name="customerId" value="${customerInstance?.customerId}"/>
</div>
 --%>