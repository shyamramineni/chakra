<%@ page import="com.chakra.registry.Registry" %>



<div class="fieldcontain ${hasErrors(bean: registryInstance, field: 'entryName', 'error')} required">
	<label for="entryName">
		<g:message code="registry.entryName.label" default="Entry Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="entryName" required="" value="${registryInstance?.entryName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: registryInstance, field: 'entryValue', 'error')} required">
	<label for="entryValue">
		<g:message code="registry.entryValue.label" default="Entry Value" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="entryValue" required="" value="${fieldValue(bean: registryInstance, field: 'entryValue')}"/>
</div>

