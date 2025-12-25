<%@ page import="com.chakra.quotation.QuotationWeldSideModel" %>



<div class="fieldcontain ${hasErrors(bean: quotationWeldSideModelInstance, field: 'weldSideCost', 'error')} ">
	<label for="weldSideCost">
		<g:message code="quotationWeldSideModel.weldSideCost.label" default="Weld Side Cost" />
		
	</label>
	<g:field type="number" name="weldSideCost" value="${fieldValue(bean: quotationWeldSideModelInstance, field: 'weldSideCost')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationWeldSideModelInstance, field: 'weldSideDiscount', 'error')} ">
	<label for="weldSideDiscount">
		<g:message code="quotationWeldSideModel.weldSideDiscount.label" default="Weld Side Discount" />
		
	</label>
	<g:field type="number" name="weldSideDiscount" value="${fieldValue(bean: quotationWeldSideModelInstance, field: 'weldSideDiscount')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationWeldSideModelInstance, field: 'weldSideDiscountPercent', 'error')} ">
	<label for="weldSideDiscountPercent">
		<g:message code="quotationWeldSideModel.weldSideDiscountPercent.label" default="Weld Side Discount Percent" />
		
	</label>
	<g:field type="number" name="weldSideDiscountPercent" value="${fieldValue(bean: quotationWeldSideModelInstance, field: 'weldSideDiscountPercent')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationWeldSideModelInstance, field: 'netWeldSideCost', 'error')} ">
	<label for="netWeldSideCost">
		<g:message code="quotationWeldSideModel.netWeldSideCost.label" default="Net Weld Side Cost" />
		
	</label>
	<g:field type="number" name="netWeldSideCost" value="${fieldValue(bean: quotationWeldSideModelInstance, field: 'netWeldSideCost')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationWeldSideModelInstance, field: 'quotationWeldSideItems', 'error')} ">
	<label for="quotationWeldSideItems">
		<g:message code="quotationWeldSideModel.quotationWeldSideItems.label" default="Quotation Weld Side Items" />
		
	</label>
	<g:select name="quotationWeldSideItems" from="${com.chakra.quotation.QuotationWeldSide.list()}" multiple="multiple" optionKey="id" size="5" value="${quotationWeldSideModelInstance?.quotationWeldSideItems*.id}" class="many-to-many"/>
</div>

