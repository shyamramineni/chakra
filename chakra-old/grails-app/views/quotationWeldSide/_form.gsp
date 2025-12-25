<%@ page import="com.chakra.quotation.QuotationWeldSide" %>



<div class="fieldcontain ${hasErrors(bean: quotationWeldSideInstance, field: 'sideMesh', 'error')} required">
	<label for="sideMesh">
		<g:message code="quotationWeldSide.sideMesh.label" default="Side Mesh" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="sideMesh" name="sideMesh.id" from="${com.chakra.config.SideMesh.list()}" optionKey="id" required="" value="${quotationWeldSideInstance?.sideMesh?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationWeldSideInstance, field: 'wireBrand', 'error')} required">
	<label for="wireBrand">
		<g:message code="quotationWeldSide.wireBrand.label" default="Wire Brand" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="wireBrand" name="wireBrand.id" from="${com.chakra.config.WireBrand.list()}" optionKey="id" required="" value="${quotationWeldSideInstance?.wireBrand?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationWeldSideInstance, field: 'length', 'error')} required">
	<label for="length">
		<g:message code="quotationWeldSide.length.label" default="Length" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="length" required="" value="${fieldValue(bean: quotationWeldSideInstance, field: 'length')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationWeldSideInstance, field: 'height', 'error')} required">
	<label for="height">
		<g:message code="quotationWeldSide.height.label" default="Height" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="height" required="" value="${fieldValue(bean: quotationWeldSideInstance, field: 'height')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationWeldSideInstance, field: 'noOfPieces', 'error')} required">
	<label for="noOfPieces">
		<g:message code="quotationWeldSide.noOfPieces.label" default="No Of Pieces" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="noOfPieces" required="" value="${fieldValue(bean: quotationWeldSideInstance, field: 'noOfPieces')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationWeldSideInstance, field: 'squareFeets', 'error')} required">
	<label for="squareFeets">
		<g:message code="quotationWeldSide.squareFeets.label" default="Square Feets" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="squareFeets" required="" value="${fieldValue(bean: quotationWeldSideInstance, field: 'squareFeets')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationWeldSideInstance, field: 'pricePerSqFt', 'error')} required">
	<label for="pricePerSqFt">
		<g:message code="quotationWeldSide.pricePerSqFt.label" default="Price Per Sq Ft" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="pricePerSqFt" required="" value="${fieldValue(bean: quotationWeldSideInstance, field: 'pricePerSqFt')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationWeldSideInstance, field: 'weldSideItemCost', 'error')} required">
	<label for="weldSideItemCost">
		<g:message code="quotationWeldSide.weldSideItemCost.label" default="Weld Side Item Cost" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="weldSideItemCost" required="" value="${fieldValue(bean: quotationWeldSideInstance, field: 'weldSideItemCost')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationWeldSideInstance, field: 'createdBy', 'error')} ">
	<label for="createdBy">
		<g:message code="quotationWeldSide.createdBy.label" default="Created By" />
		
	</label>
	<g:textField name="createdBy" value="${quotationWeldSideInstance?.createdBy}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationWeldSideInstance, field: 'createdDate', 'error')} ">
	<label for="createdDate">
		<g:message code="quotationWeldSide.createdDate.label" default="Created Date" />
		
	</label>
	<g:datePicker name="createdDate" precision="day"  value="${quotationWeldSideInstance?.createdDate}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: quotationWeldSideInstance, field: 'lastEditedBy', 'error')} ">
	<label for="lastEditedBy">
		<g:message code="quotationWeldSide.lastEditedBy.label" default="Last Edited By" />
		
	</label>
	<g:textField name="lastEditedBy" value="${quotationWeldSideInstance?.lastEditedBy}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationWeldSideInstance, field: 'editedDate', 'error')} ">
	<label for="editedDate">
		<g:message code="quotationWeldSide.editedDate.label" default="Edited Date" />
		
	</label>
	<g:datePicker name="editedDate" precision="day"  value="${quotationWeldSideInstance?.editedDate}" default="none" noSelection="['': '']" />
</div>

