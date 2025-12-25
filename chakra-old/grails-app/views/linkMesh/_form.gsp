<%@ page import="com.chakra.config.LinkMesh" %>



<div class="fieldcontain ${hasErrors(bean: linkMeshInstance, field: 'holeSize', 'error')} required">
	<label for="holeSize">
		<g:message code="linkMesh.holeSize.label" default="Hole Size" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="holeSize" required="" value="${linkMeshInstance?.holeSize}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: linkMeshInstance, field: 'wireDiameter', 'error')} required">
	<label for="wireDiameter">
		<g:message code="linkMesh.wireDiameter.label" default="Wire Diameter" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="wireDiameter" required="" value="${fieldValue(bean: linkMeshInstance, field: 'wireDiameter')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: linkMeshInstance, field: 'weight', 'error')} required">
	<label for="weight">
		<g:message code="linkMesh.weight.label" default="Weight" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="weight" required="" value="${fieldValue(bean: linkMeshInstance, field: 'weight')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: linkMeshInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="linkMesh.description.label" default="Description" />
		
	</label>
	<g:textArea name="description" value="${linkMeshInstance?.description}"/>
</div>

