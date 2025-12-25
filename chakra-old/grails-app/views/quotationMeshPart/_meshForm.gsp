<%@ page import="com.chakra.quotation.QuotationMeshPart" %>



<div class="fieldcontain ${hasErrors(bean: quotationMeshPartInstance, field: 'sheetSpecification', 'error')} required">
	<label for="sheetSpecification">
		<g:message code="quotationMeshPart.sheetSpecification.label" default="Sheet Specification" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="sheetSpecification" name="sheetSpecification.id" from="${com.chakra.config.SheetSpecification.list()}" optionKey="id" required="" value="${quotationMeshPartInstance?.sheetSpecification?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationMeshPartInstance, field: 'wireBrand', 'error')} required">
	<label for="wireBrand">
		<g:message code="quotationMeshPart.wireBrand.label" default="Wire Brand" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="wireBrand" name="wireBrand.id" from="${com.chakra.config.WireBrand.list()}" optionKey="id" required="" value="${quotationMeshPartInstance?.wireBrand?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationMeshPartInstance, field: 'noOfMeshParts', 'error')} ">
	<label for="noOfMeshParts">
		<g:message code="quotationMeshPart.noOfMeshParts.label" default="No Of Mesh Parts" />
		
	</label>
	<g:field type="number" name="noOfMeshParts" value="${fieldValue(bean: quotationMeshPartInstance, field: 'noOfMeshParts')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationMeshPartInstance, field: 'wirePrice', 'error')} ">
	<label for="wirePrice">
		<g:message code="quotationMeshPart.wirePrice.label" default="Wire Price" />
		
	</label>
	<g:field type="number" name="wirePrice" value="${fieldValue(bean: quotationMeshPartInstance, field: 'wirePrice')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationMeshPartInstance, field: 'createdBy', 'error')} ">
	<label for="createdBy">
		<g:message code="quotationMeshPart.createdBy.label" default="Created By" />
		
	</label>
	<g:textField name="createdBy" value="${quotationMeshPartInstance?.createdBy}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationMeshPartInstance, field: 'createdDate', 'error')} ">
	<label for="createdDate">
		<g:message code="quotationMeshPart.createdDate.label" default="Created Date" />
		
	</label>
	<g:datePicker name="createdDate" precision="day"  value="${quotationMeshPartInstance?.createdDate}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: quotationMeshPartInstance, field: 'lastEditedBy', 'error')} ">
	<label for="lastEditedBy">
		<g:message code="quotationMeshPart.lastEditedBy.label" default="Last Edited By" />
		
	</label>
	<g:textField name="lastEditedBy" value="${quotationMeshPartInstance?.lastEditedBy}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationMeshPartInstance, field: 'editedDate', 'error')} ">
	<label for="editedDate">
		<g:message code="quotationMeshPart.editedDate.label" default="Edited Date" />
		
	</label>
	<g:datePicker name="editedDate" precision="day"  value="${quotationMeshPartInstance?.editedDate}" default="none" noSelection="['': '']" />
</div>

