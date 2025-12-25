<%@ page import="com.chakra.stock.Stock" %>





<%--<div class="fieldcontain ${hasErrors(bean: stockInstance, field: 'stockManufacturedTime', 'error')} required">
	<label for="stockManufacturedTime">
		<g:message code="stock.stockManufacturedTime.label" default="Stock Manufactured Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="stockManufacturedTime" precision="day"  value="${stockInstance?.stockManufacturedTime}"  />
</div>

--%>
<div class="fieldcontain ${hasErrors(bean: stockInstance, field: 'stockId', 'error')} ">
	<label for="stockId">
		<g:message code="stock.stockId.label" default="Stock Id" />
		
	</label>
	<g:textField name="stockId" value="${stockInstance?.stockId}"/>
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



<div class="fieldcontain ${hasErrors(bean: stockInstance, field: 'lastEditedDate', 'error')} required">
	<label for="lastEditedDate">
		<g:message code="stock.lastEditedDate.label" default="Start Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="lastEditedDate" precision="day"  value="${stockInstance?.lastEditedDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: stockInstance, field: 'createdDate', 'error')} required">
	<label for="createdDate">
		<g:message code="stock.createdDate.label" default="End Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="createdDate" precision="day"  value="${stockInstance?.createdDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: stockInstance, field: 'availabilityStatus', 'error')} ">
	<label for="availabilityStatus">
		<g:message code="stock.availabilityStatus.label" default="Availability Status" />
		
	</label>
	<g:checkBox name="availabilityStatus" value="${stockInstance?.availabilityStatus}" />
</div>





