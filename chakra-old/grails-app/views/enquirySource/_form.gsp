<%@ page import="com.chakra.config.EnquirySource" %>



<div class="fieldcontain ${hasErrors(bean: enquirySourceInstance, field: 'enquirySource', 'error')} required">
	<label for="enquirySource">
		<g:message code="enquirySource.enquirySource.label" default="Enquiry Source" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="enquirySource" required="" value="${enquirySourceInstance?.enquirySource}"/>
</div>

