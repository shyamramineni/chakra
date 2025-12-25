<%@ page import="com.chakra.enquiry.Enquiry" %>



<div class="fieldcontain">
	<label for="customerName">
		<g:message code="customer.customerName.label" default="Customer Name" />
		
	</label>
	<g:textField name="customerName" value="${params?.customerName}"/>
</div>

<div class="fieldcontain">
	<label for="mobileNumber">
		<g:message code="customer.mobileNumber.label" default="Mobile Number" />
		
	</label>
	<g:textField name="mobileNumber" value="${params?.mobileNumber}"/>
</div>

<div class="fieldcontain">
	<label for="enquiryDate">
		<g:message code="enquiry.enquiryDate.label" default="Enquiry Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="enquiryDate" precision="day"  value="${new Date()}"  />
</div>

