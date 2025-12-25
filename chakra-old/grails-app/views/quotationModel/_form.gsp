<%@ page import="com.chakra.quotation.QuotationModel" %>



<div class="fieldcontain ${hasErrors(bean: quotationModelInstance, field: 'cageDesign', 'error')} required">
	<label for="cageDesign">
		<g:message code="quotationModel.cageDesign.label" default="Cage Design" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="cageDesign" name="cageDesign.id" from="${com.chakra.config.CageDesign.list()}" optionKey="id" required="" value="${quotationModelInstance?.cageDesign?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationModelInstance, field: 'quotationMeshModel', 'error')} ">
	<label for="quotationMeshModel">
		<g:message code="quotationModel.quotationMeshModel.label" default="Quotation Mesh Model" />
		
	</label>
	<g:select id="quotationMeshModel" name="quotationMeshModel.id" from="${com.chakra.quotation.QuotationMeshModel.list()}" optionKey="id" value="${quotationModelInstance?.quotationMeshModel?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationModelInstance, field: 'quotationCageParts', 'error')} ">
	<label for="quotationCageParts">
		<g:message code="quotationModel.quotationCageParts.label" default="Quotation Cage Parts" />
		
	</label>
	<g:select name="quotationCageParts" from="${com.chakra.quotation.QuotationCagePart.list()}" multiple="multiple" optionKey="id" size="5" value="${quotationModelInstance?.quotationCageParts*.id}" class="many-to-many"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationModelInstance, field: 'noOfBirds', 'error')} required">
	<label for="noOfBirds">
		<g:message code="quotationModel.noOfBirds.label" default="No Of Birds" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="noOfBirds" required="" value="${fieldValue(bean: quotationModelInstance, field: 'noOfBirds')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationModelInstance, field: 'cost', 'error')} required">
	<label for="cost">
		<g:message code="quotationModel.cost.label" default="Cost" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="cost" required="" value="${fieldValue(bean: quotationModelInstance, field: 'cost')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationModelInstance, field: 'tax', 'error')} required">
	<label for="tax">
		<g:message code="quotationModel.tax.label" default="Tax" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="tax" required="" value="${fieldValue(bean: quotationModelInstance, field: 'tax')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationModelInstance, field: 'totalCost', 'error')} required">
	<label for="totalCost">
		<g:message code="quotationModel.totalCost.label" default="Total Cost" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="totalCost" required="" value="${fieldValue(bean: quotationModelInstance, field: 'totalCost')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationModelInstance, field: 'taxation', 'error')} required">
	<label for="taxation">
		<g:message code="quotationModel.taxation.label" default="Taxation" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="taxation" name="taxation.id" from="${com.chakra.config.Taxation.list()}" optionKey="id" required="" value="${quotationModelInstance?.taxation?.id}" class="many-to-one"/>
</div>

