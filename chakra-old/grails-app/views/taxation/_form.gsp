<%@ page import="com.chakra.config.Taxation" %>



<div class="fieldcontain ${hasErrors(bean: taxationInstance, field: 'taxation', 'error')} required">
	<label for="taxation">
		<g:message code="taxation.taxation.label" default="Taxation" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="taxation" required="" value="${taxationInstance?.taxation}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: taxationInstance, field: 'percent', 'error')} required">
	<label for="percent">
		<g:message code="taxation.percent.label" default="Percent" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="percent" required="" value="${fieldValue(bean: taxationInstance, field: 'percent')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: taxationInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="taxation.description.label" default="Description" />
		
	</label>
	<g:textArea name="description" value="${taxationInstance?.description}"/>
</div>

