<%@ page import="com.chakra.config.SheetSpecification" %>



<div class="fieldcontain ${hasErrors(bean: sheetSpecificationInstance, field: 'sheetSpecId', 'error')} ">
	<label for="sheetSpecId">
		<g:message code="sheetSpecification.sheetSpecId.label" default="Sheet Spec Id" />
		
	</label>
	<g:textField name="sheetSpecId" value="${sheetSpecificationInstance?.sheetSpecId}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sheetSpecificationInstance, field: 'sheetName', 'error')} required">
	<label for="sheetName">
		<g:message code="sheetSpecification.sheetName.label" default="Sheet Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="sheetName" required="" value="${sheetSpecificationInstance?.sheetName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sheetSpecificationInstance, field: 'projection', 'error')} required">
	<label for="projection">
		<g:message code="sheetSpecification.projection.label" default="Projection" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="projection" required="" value="${fieldValue(bean: sheetSpecificationInstance, field: 'projection')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sheetSpecificationInstance, field: 'width', 'error')} required">
	<label for="width">
		<g:message code="sheetSpecification.width.label" default="Width" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="width" required="" value="${fieldValue(bean: sheetSpecificationInstance, field: 'width')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sheetSpecificationInstance, field: 'length', 'error')} required">
	<label for="length">
		<g:message code="sheetSpecification.length.label" default="Length" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="length" required="" value="${fieldValue(bean: sheetSpecificationInstance, field: 'length')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sheetSpecificationInstance, field: 'pitch', 'error')} required">
	<label for="pitch">
		<g:message code="sheetSpecification.pitch.label" default="Pitch" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="pitch" required="" value="${fieldValue(bean: sheetSpecificationInstance, field: 'pitch')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sheetSpecificationInstance, field: 'crossWireDiameter', 'error')} required">
	<label for="crossWireDiameter">
		<g:message code="sheetSpecification.crossWireDiameter.label" default="Cross Wire Diameter" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="crossWireDiameter" required="" value="${fieldValue(bean: sheetSpecificationInstance, field: 'crossWireDiameter')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sheetSpecificationInstance, field: 'lineWireDiameter1', 'error')} required">
	<label for="lineWireDiameter1">
		<g:message code="sheetSpecification.lineWireDiameter1.label" default="Line Wire Diameter1" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="lineWireDiameter1" required="" value="${fieldValue(bean: sheetSpecificationInstance, field: 'lineWireDiameter1')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sheetSpecificationInstance, field: 'lineWireDiameter2', 'error')} required">
	<label for="lineWireDiameter2">
		<g:message code="sheetSpecification.lineWireDiameter2.label" default="Line Wire Diameter2" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="lineWireDiameter2" required="" value="${fieldValue(bean: sheetSpecificationInstance, field: 'lineWireDiameter2')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sheetSpecificationInstance, field: 'noOfLineWires1', 'error')} required">
	<label for="noOfLineWires1">
		<g:message code="sheetSpecification.noOfLineWires1.label" default="No Of Line Wires1" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="noOfLineWires1" required="" value="${fieldValue(bean: sheetSpecificationInstance, field: 'noOfLineWires1')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sheetSpecificationInstance, field: 'noOfLineWires2', 'error')} required">
	<label for="noOfLineWires2">
		<g:message code="sheetSpecification.noOfLineWires2.label" default="No Of Line Wires2" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="noOfLineWires2" required="" value="${fieldValue(bean: sheetSpecificationInstance, field: 'noOfLineWires2')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sheetSpecificationInstance, field: 'textual', 'error')} ">
	<label for="textual">
		<g:message code="sheetSpecification.textual.label" default="Textual" />
		
	</label>
	<g:textField name="textual" value="${sheetSpecificationInstance?.textual}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sheetSpecificationInstance, field: 'factoryPitch', 'error')} ">
	<label for="factoryPitch">
		<g:message code="sheetSpecification.factoryPitch.label" default="Factory Pitch" />
		
	</label>
	<g:textField name="factoryPitch" value="${sheetSpecificationInstance?.factoryPitch}"/>
</div>

<%--<div class="fieldcontain ${hasErrors(bean: sheetSpecificationInstance, field: 'sheetWeight', 'error')} required">
	<label for="sheetWeight">
		<g:message code="sheetSpecification.sheetWeight.label" default="Sheet Weight" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="sheetWeight" required="" value="${fieldValue(bean: sheetSpecificationInstance, field: 'sheetWeight')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sheetSpecificationInstance, field: 'noOfCrossWires', 'error')} required">
	<label for="noOfCrossWires">
		<g:message code="sheetSpecification.noOfCrossWires.label" default="No Of Cross Wires" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="noOfCrossWires" required="" value="${fieldValue(bean: sheetSpecificationInstance, field: 'noOfCrossWires')}"/>
</div>--%>

<div class="fieldcontain ${hasErrors(bean: sheetSpecificationInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="sheetSpecification.description.label" default="Description" />
		
	</label>
	<g:textArea name="description" value="${sheetSpecificationInstance?.description}"/>
</div>



