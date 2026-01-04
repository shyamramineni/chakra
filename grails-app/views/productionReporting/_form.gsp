<%@ page import="com.chakra.production.ProductionReporting" %>

<div class="fieldcontain ${hasErrors(bean: productionReportingInstance, field: 'machine', 'error')} required">
	<label for="machine">
		<g:message code="productionReporting.machine.label" default="Machine" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="machine" name="machine.id" from="${com.chakra.config.Machine.list()}" optionKey="id" required="" value="${productionReportingInstance?.machine?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: productionReportingInstance, field: 'sheetSpecifcation', 'error')} required">
	<label for="sheetSpecifcation">
		<g:message code="productionReporting.sheetSpecifcation.label" default="Sheet Specifcation" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="sheetSpecifcation" name="sheetSpecifcation.id" from="${com.chakra.config.SheetSpecification.list()}" optionKey="id" required="" value="${productionReportingInstance?.sheetSpecifcation?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: productionReportingInstance, field: 'stockManufacturedTime', 'error')} required">
	<label for="stockManufacturedTime">
		<g:message code="productionReporting.stockManufacturedTime.label" default="Stock Manufactured Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="stockManufacturedTime" precision="day"  value="${productionReportingInstance?.stockManufacturedTime}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: productionReportingInstance, field: 'totalQuantity', 'error')} required">
	<label for="totalQuantity">
		<g:message code="productionReporting.totalQuantity.label" default="Total Quantity" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="totalQuantity" required="" value="${fieldValue(bean: productionReportingInstance, field: 'totalQuantity')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: productionReportingInstance, field: 'mending', 'error')} required">
	<label for="Mending">
		<g:message code="productionReporting.mending.label" default="Mending" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="mending" required="" value="${fieldValue(bean: productionReportingInstance, field: 'mending')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: productionReportingInstance, field: 'wireBrand', 'error')} required">
	<label for="wireBrand">
		<g:message code="productionReporting.wireBrand.label" default="Wire Brand" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="wireBrand" name="wireBrand.id" from="${com.chakra.config.WireBrand.list()}" optionKey="id" required="" value="${productionReportingInstance?.wireBrand?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: productionReportingInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="productionReporting.comments.label" default="Comments/Remarks" />
		
	</label>
	<g:textArea name="comments" value="${productionReportingInstance?.comments}"/>
</div>
