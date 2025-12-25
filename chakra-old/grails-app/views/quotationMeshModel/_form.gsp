<%@ page import="com.chakra.quotation.QuotationMeshModel" %>



<div class="fieldcontain ${hasErrors(bean: quotationMeshModelInstance, field: 'cageDesign', 'error')} required">
	<label for="cageDesign">
		<g:message code="quotationMeshModel.cageDesign.label" default="Cage Design" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="cageDesign" name="cageDesign.id" from="${com.chakra.config.CageDesign.list()}" optionKey="id" required="" value="${quotationMeshModelInstance?.cageDesign?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationMeshModelInstance, field: 'wireBrand', 'error')} ">
	<label for="wireBrand">
		<g:message code="quotationMeshModel.wireBrand.label" default="Wire Brand" />
		
	</label>
	<g:select id="wireBrand" name="wireBrand.id" from="${com.chakra.config.WireBrand.list()}" optionKey="id" value="${quotationMeshModelInstance?.wireBrand?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationMeshModelInstance, field: 'doubleBox', 'error')} ">
	<label for="doubleBox">
		<g:message code="quotationMeshModel.doubleBox.label" default="Double Box" />
		
	</label>
	<g:field type="number" name="doubleBox" value="${fieldValue(bean: quotationMeshModelInstance, field: 'doubleBox')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationMeshModelInstance, field: 'singleBox', 'error')} ">
	<label for="singleBox">
		<g:message code="quotationMeshModel.singleBox.label" default="Single Box" />
		
	</label>
	<g:field type="number" name="singleBox" value="${fieldValue(bean: quotationMeshModelInstance, field: 'singleBox')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationMeshModelInstance, field: 'costPerBird', 'error')} ">
	<label for="costPerBird">
		<g:message code="quotationMeshModel.costPerBird.label" default="Cost Per Bird" />
		
	</label>
	<g:field type="number" name="costPerBird" value="${fieldValue(bean: quotationMeshModelInstance, field: 'costPerBird')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationMeshModelInstance, field: 'noOfBirds', 'error')} ">
	<label for="noOfBirds">
		<g:message code="quotationMeshModel.noOfBirds.label" default="No Of Birds" />
		
	</label>
	<g:field type="number" name="noOfBirds" value="${fieldValue(bean: quotationMeshModelInstance, field: 'noOfBirds')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationMeshModelInstance, field: 'meshCost', 'error')} ">
	<label for="meshCost">
		<g:message code="quotationMeshModel.meshCost.label" default="Mesh Cost" />
		
	</label>
	<g:field type="number" name="meshCost" value="${fieldValue(bean: quotationMeshModelInstance, field: 'meshCost')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationMeshModelInstance, field: 'quotationMeshParts', 'error')} ">
	<label for="quotationMeshParts">
		<g:message code="quotationMeshModel.quotationMeshParts.label" default="Quotation Mesh Parts" />
		
	</label>
	<g:select name="quotationMeshParts" from="${com.chakra.quotation.QuotationMeshPart.list()}" multiple="multiple" optionKey="id" size="5" value="${quotationMeshModelInstance?.quotationMeshParts*.id}" class="many-to-many"/>
</div>

