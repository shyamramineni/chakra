<%@ page import="com.chakra.stock.Stock" %>

<div class="fieldcontain ${hasErrors(bean: stockInstance, field: 'machine', 'error')} required">
	<label for="machine">
		<g:message code="stock.machine.label" default="Machine" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="machine" name="machine.id" from="${com.chakra.config.Machine.list()}" optionKey="id" required="" value="${stockInstance?.machine?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: stockInstance, field: 'sheetSpec', 'error')} required">
	<label for="sheetSpec">
		<g:message code="stock.sheetSpec.label" default="Sheet Spec" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="sheetSpec" name="sheetSpec.id" from="${com.chakra.config.SheetSpecification.list()}" optionKey="id" required="" value="${stockInstance?.sheetSpec?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: stockInstance, field: 'wireBrand', 'error')} required">
	<label for="wireBrand">
		<g:message code="stock.wireBrand.label" default="Wire Brand" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="wireBrand" name="wireBrand.id" from="${com.chakra.config.WireBrand.list()}" optionKey="id" required="" value="${stockInstance?.wireBrand?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: stockInstance, field: 'noOfManufactured', 'error')} required">
	<label for="noOfManufactured">
		<g:message code="stock.noOfManufactured.label" default="No Of Manufactured" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="noOfManufactured" value="${fieldValue(bean: stockInstance, field: 'noOfManufactured')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: stockInstance, field: 'noOfInStock', 'error')} required">
    <label for="noOfInStock">
        <g:message code="stock.noOfInStock.label" default="No In Stock" />
        <span class="required-indicator">*</span>
    </label>
    <g:field name="noOfInStock" value="${fieldValue(bean: stockInstance, field: 'noOfInStock')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: stockInstance, field: 'stockManufacturedTime', 'error')} ">
    <label for="stockManufacturedTime">
        <g:message code="stock.stockManufacturedTime.label" default="Manufactured Time" />
        
    </label>
    <g:datePicker name="stockManufacturedTime" precision="day"  value="${stockInstance?.stockManufacturedTime}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: stockInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="stock.comments.label" default="Comments" />
		
	</label>
	<g:textArea name="comments" cols="40" rows="5" maxlength="500" value="${stockInstance?.comments}"/>
</div>
