<%@ page import="com.chakra.config.Machine" %>



<div class="fieldcontain ${hasErrors(bean: machineInstance, field: 'machineName', 'error')} required">
	<label for="machineName">
		<g:message code="machine.machineName.label" default="Machine Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="machineName" required="" value="${machineInstance?.machineName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: machineInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="machine.description.label" default="Description" />
		
	</label>
	<g:textArea name="description" value="${machineInstance?.description}"/>
</div>

