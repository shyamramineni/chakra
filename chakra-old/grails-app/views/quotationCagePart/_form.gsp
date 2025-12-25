<%@ page import="com.chakra.quotation.QuotationCagePart" %>



<div class="fieldcontain ${hasErrors(bean: quotationCagePartInstance, field: 'cagePartSpecFormula', 'error')} required">
	<label for="cagePartSpecFormula">
		<g:message code="quotationCagePart.cagePartSpecFormula.label" default="Cage Part Spec Formula" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="cagePartSpecFormula" name="cagePartSpecFormula.id" from="${com.chakra.config.CagePartSpecFormula.list()}" optionKey="id" required="" value="${quotationCagePartInstance?.cagePartSpecFormula?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationCagePartInstance, field: 'costOfCagePart', 'error')} required">
	<label for="costOfCagePart">
		<g:message code="quotationCagePart.costOfCagePart.label" default="Cost Of Cage Part" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="costOfCagePart" required="" value="${fieldValue(bean: quotationCagePartInstance, field: 'costOfCagePart')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationCagePartInstance, field: 'noOfCageParts', 'error')} required">
	<label for="noOfCageParts">
		<g:message code="quotationCagePart.noOfCageParts.label" default="No Of Cage Parts" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="noOfCageParts" required="" value="${fieldValue(bean: quotationCagePartInstance, field: 'noOfCageParts')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationCagePartInstance, field: 'priceOfEachCagePart', 'error')} required">
	<label for="priceOfEachCagePart">
		<g:message code="quotationCagePart.priceOfEachCagePart.label" default="Price Of Each Cage Part" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="priceOfEachCagePart" required="" value="${fieldValue(bean: quotationCagePartInstance, field: 'priceOfEachCagePart')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationCagePartInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="quotationCagePart.comments.label" default="Comments/Remarks" />
		
	</label>
	<g:textArea name="comments" value="${quotationCagePartInstance?.comments}"/>
</div>

