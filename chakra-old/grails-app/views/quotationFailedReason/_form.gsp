<%@ page import="com.chakra.config.QuotationFailedReason" %>



<div class="fieldcontain ${hasErrors(bean: quotationFailedReasonInstance, field: 'quotationFailedReason', 'error')} required">
	<label for="quotationFailedReason">
		<g:message code="quotationFailedReason.quotationFailedReason.label" default="Quotation Failed Reason" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="quotationFailedReason" required="" value="${quotationFailedReasonInstance?.quotationFailedReason}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationFailedReasonInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="quotationFailedReason.description.label" default="Description" />
		
	</label>
	<g:textArea name="description" value="${quotationFailedReasonInstance?.description}"/>
</div>

