<%@ page import="com.chakra.order.CorderMeshParts" %>



<div class="fieldcontain ${hasErrors(bean: orderMeshPartsInstance, field: 'sheetSpecification', 'error')} required">
	<label for="sheetSpecification">
		<g:message code="orderMeshParts.sheetSpecification.label" default="Sheet Specification" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="sheetSpecification" name="sheetSpecification.id" from="${com.chakra.config.SheetSpecification.list()}" optionKey="id" required="" value="${orderMeshPartsInstance?.sheetSpecification?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: orderMeshPartsInstance, field: 'wireBrand', 'error')} required">
	<label for="wireBrand">
		<g:message code="orderMeshParts.wireBrand.label" default="Wire Brand" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="wireBrand" name="wireBrand.id" from="${com.chakra.config.WireBrand.list()}" optionKey="id" required="" value="${orderMeshPartsInstance?.wireBrand?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: orderMeshPartsInstance, field: 'createdBy', 'error')} ">
	<label for="createdBy">
		<g:message code="orderMeshParts.createdBy.label" default="Created By" />
		
	</label>
	<g:textField name="createdBy" value="${orderMeshPartsInstance?.createdBy}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: orderMeshPartsInstance, field: 'createdDate', 'error')} ">
	<label for="createdDate">
		<g:message code="orderMeshParts.createdDate.label" default="Created Date" />
		
	</label>
	<g:datePicker name="createdDate" precision="day"  value="${orderMeshPartsInstance?.createdDate}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: orderMeshPartsInstance, field: 'lastEditedBy', 'error')} ">
	<label for="lastEditedBy">
		<g:message code="orderMeshParts.lastEditedBy.label" default="Last Edited By" />
		
	</label>
	<g:textField name="lastEditedBy" value="${orderMeshPartsInstance?.lastEditedBy}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: orderMeshPartsInstance, field: 'editedDate', 'error')} ">
	<label for="editedDate">
		<g:message code="orderMeshParts.editedDate.label" default="Edited Date" />
		
	</label>
	<g:datePicker name="editedDate" precision="day"  value="${orderMeshPartsInstance?.editedDate}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: orderMeshPartsInstance, field: 'corder', 'error')} required">
	<label for="corder">
		<g:message code="orderMeshParts.corder.label" default="Corder" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="corder" name="corder.id" from="${com.chakra.order.Corder.list()}" optionKey="id" required="" value="${orderMeshPartsInstance?.corder?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: orderMeshPartsInstance, field: 'noOfMeshParts', 'error')} required">
	<label for="noOfMeshParts">
		<g:message code="orderMeshParts.noOfMeshParts.label" default="No Of Mesh Parts" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="noOfMeshParts" required="" value="${fieldValue(bean: orderMeshPartsInstance, field: 'noOfMeshParts')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: orderMeshPartsInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="orderMeshParts.comments.label" default="Comments/Remarks" />
		
	</label>
	<g:textArea name="comments" value="${orderMeshPartsInstance?.comments}"/>
</div>

