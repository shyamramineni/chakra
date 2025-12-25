<%@ page import="com.chakra.config.CagePart" %>



<div class="fieldcontain ${hasErrors(bean: cagePartInstance, field: 'cagePart', 'error')} required">
	<label for="cagePart">
		<g:message code="cagePart.cagePart.label" default="Cage Part" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="cagePart" required="" value="${cagePartInstance?.cagePart}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cagePartInstance, field: 'cagePartCode', 'error')} ">
	<label for="cagePartCode">
		<g:message code="cagePart.cagePartCode.label" default="Cage Part Code" />
		
	</label>
	<g:textField name="cagePartCode" value="${cagePartInstance?.cagePartCode}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cagePartInstance, field: 'cagePartImage', 'error')} ">
	<label for="image">
		<g:message code="cagePart.cagePartImage.label" default="CagePart Image" />
		
	</label>
	<input type="file" id="cagePartImage" name="cagePartImage" />
</div>

<div class="fieldcontain ${hasErrors(bean: cagePartInstance, field: 'parentCagePart', 'error')} ">
	<label for="parentCagePart">
		<g:message code="cagePart.parentCagePart.label" default="Parent Cage Part" />
		
	</label>
	<g:select id="parentCagePart" name="parentCagePart.id" from="${com.chakra.config.CagePart.list()}" optionKey="id" value="${cagePartInstance?.parentCagePart?.id}" class="many-to-one" noSelection="['null': 'Select']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cagePartInstance, field: 'formula', 'error')} ">
	<label for="formula">
		<g:message code="cagePart.formula.label" default="Formula" />
		
	</label>
	<g:textField name="formula" value="${cagePartInstance?.formula}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cagePartInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="cagePart.description.label" default="Description" />
		
	</label>
	<g:textArea name="description" value="${cagePartInstance?.description}"/>
</div>