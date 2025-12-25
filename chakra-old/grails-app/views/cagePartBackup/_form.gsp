<%@ page import="com.chakra.config.CagePart" %>



<div class="fieldcontain ${hasErrors(bean: cagePartInstance, field: 'cagePart', 'error')} required">
	<label for="cagePart">
		<g:message code="cagePart.cagePart.label" default="Cage Part" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="cagePart" required="" value="${cagePartInstance?.cagePart}"/>
</div>

<%--<div class="fieldcontain ${hasErrors(bean: cagePartInstance, field: 'cagePartCode', 'error')} required">
	<label for="cagePartCode">
		<g:message code="cagePart.cagePartCode.label" default="Cage Part Code" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="cagePartCode" required="" value="${cagePartInstance?.cagePartCode}"/>
</div>
--%>
<div class="fieldcontain ${hasErrors(bean: cagePartInstance, field: 'image', 'error')} ">
	<label for="image">
		<g:message code="cagePart.image.label" default="Image" />
		
	</label>
	<input type="file" id="image" name="image" />
</div>

<div class="fieldcontain ${hasErrors(bean: cagePartInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="cagePart.description.label" default="Description" />
		
	</label>
	<g:textArea name="description" value="${cagePartInstance?.description}"/>
</div>

