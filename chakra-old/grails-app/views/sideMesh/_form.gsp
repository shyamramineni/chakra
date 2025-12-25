<%@ page import="com.chakra.config.SideMesh" %>



<div class="fieldcontain ${hasErrors(bean: sideMeshInstance, field: 'holeSize', 'error')} required">
	<label for="holeSize">
		<g:message code="sideMesh.holeSize.label" default="Hole Size" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="holeSize" required="" value="${sideMeshInstance?.holeSize}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sideMeshInstance, field: 'wireDiameter', 'error')} required">
	<label for="wireDiameter">
		<g:message code="sideMesh.wireDiameter.label" default="Wire Diameter" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="wireDiameter" required="" value="${fieldValue(bean: sideMeshInstance, field: 'wireDiameter')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sideMeshInstance, field: 'weight', 'error')} required">
	<label for="weight">
		<g:message code="sideMesh.weight.label" default="Weight" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="weight" required="" value="${fieldValue(bean: sideMeshInstance, field: 'weight')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sideMeshInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="sideMesh.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${sideMeshInstance?.description}"/>
</div>

