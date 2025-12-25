<%@ page import="com.chakra.config.WireBrand" %>



<div class="fieldcontain ${hasErrors(bean: wireBrandInstance, field: 'wireBrand', 'error')} required">
	<label for="wireBrand">
		<g:message code="wireBrand.wireBrand.label" default="Wire Brand" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="wireBrand" required="" value="${wireBrandInstance?.wireBrand}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: wireBrandInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="wireBrand.description.label" default="Description" />
		
	</label>
	<g:textArea name="description" value="${wireBrandInstance?.description}"/>
</div>

