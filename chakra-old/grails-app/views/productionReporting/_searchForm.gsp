<%@ page import="com.chakra.production.ProductionReporting" %>




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

<div class="fieldcontain ${hasErrors(bean: productionReportingInstance, field: 'createdDate', 'error')} required">
	<label for="createdDate">
		<g:message code="productionReporting.createdDate.label" default="Start Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="createdDate" precision="day"  value="${productionReportingInstance?.createdDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: productionReportingInstance, field: 'editedDate', 'error')} required">
	<label for="editedDate">
		<g:message code="productionReporting.editedDate.label" default="End Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="editedDate" precision="day"  value="${productionReportingInstance?.editedDate}"  />
</div>





