<%@ page import="com.chakra.quotation.QuotationChainLinkModel" %>



<div class="fieldcontain ${hasErrors(bean: quotationChainLinkModelInstance, field: 'chainLinkCost', 'error')} ">
	<label for="chainLinkCost">
		<g:message code="quotationChainLinkModel.chainLinkCost.label" default="Chain Link Cost" />
		
	</label>
	<g:field type="number" name="chainLinkCost" value="${fieldValue(bean: quotationChainLinkModelInstance, field: 'chainLinkCost')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationChainLinkModelInstance, field: 'chainLinkDiscount', 'error')} ">
	<label for="chainLinkDiscount">
		<g:message code="quotationChainLinkModel.chainLinkDiscount.label" default="Chain Link Discount" />
		
	</label>
	<g:field type="number" name="chainLinkDiscount" value="${fieldValue(bean: quotationChainLinkModelInstance, field: 'chainLinkDiscount')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationChainLinkModelInstance, field: 'chainLinkDiscountPercent', 'error')} ">
	<label for="chainLinkDiscountPercent">
		<g:message code="quotationChainLinkModel.chainLinkDiscountPercent.label" default="Chain Link Discount Percent" />
		
	</label>
	<g:field type="number" name="chainLinkDiscountPercent" value="${fieldValue(bean: quotationChainLinkModelInstance, field: 'chainLinkDiscountPercent')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationChainLinkModelInstance, field: 'addValue', 'error')} ">
	<label for="addValue">
		<g:message code="quotationChainLinkModel.addValue.label" default="Add Value" />
		
	</label>
	<g:field type="number" name="addValue" value="${fieldValue(bean: quotationChainLinkModelInstance, field: 'addValue')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationChainLinkModelInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="quotationChainLinkModel.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${quotationChainLinkModelInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationChainLinkModelInstance, field: 'quotationChainLinkItems', 'error')} ">
	<label for="quotationChainLinkItems">
		<g:message code="quotationChainLinkModel.quotationChainLinkItems.label" default="Quotation Chain Link Items" />
		
	</label>
	<g:select name="quotationChainLinkItems" from="${com.chakra.quotation.QuotationChainLink.list()}" multiple="multiple" optionKey="id" size="5" value="${quotationChainLinkModelInstance?.quotationChainLinkItems*.id}" class="many-to-many"/>
</div>

