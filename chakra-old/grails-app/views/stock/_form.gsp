<%@ page import="com.chakra.stock.Stock" %>



<div class="fieldcontain ${hasErrors(bean: stockInstance, field: 'sheetSpec', 'error')} required">
	<label for="sheetSpec">
		<g:message code="stock.sheetSpec.label" default="Sheet Spec" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="sheetSpec" name="sheetSpec.id" from="${com.chakra.config.SheetSpecification.list()}" optionKey="id" required="" value="${stockInstance?.sheetSpec?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: stockInstance, field: 'noOfInStock', 'error')} required">
	<label for="noOfInStock">
		<g:message code="stock.noOfInStock.label" default="No Of In Stock" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="noOfInStock" required="" value="${fieldValue(bean: stockInstance, field: 'noOfInStock')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: stockInstance, field: 'noOfManufactured', 'error')} required">
	<label for="noOfManufactured">
		<g:message code="stock.noOfManufactured.label" default="No Of Manufactured" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="noOfManufactured" required="" value="${fieldValue(bean: stockInstance, field: 'noOfManufactured')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: stockInstance, field: 'stockManufacturedTime', 'error')} required">
	<label for="stockManufacturedTime">
		<g:message code="stock.stockManufacturedTime.label" default="Stock Manufactured Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="stockManufacturedTime" precision="day"  value="${stockInstance?.stockManufacturedTime}"  />
</div>

<%--<div class="fieldcontain ${hasErrors(bean: stockInstance, field: 'stockId', 'error')} ">
	<label for="stockId">
		<g:message code="stock.stockId.label" default="Stock Id" />
		
	</label>
	<g:textField name="stockId" value="${stockInstance?.stockId}"/>
</div>

--%><div class="fieldcontain ${hasErrors(bean: stockInstance, field: 'availabilityStatus', 'error')} ">
	<label for="availabilityStatus">
		<g:message code="stock.availabilityStatus.label" default="Availability Status" />
		
	</label>
	<g:checkBox name="availabilityStatus" value="${stockInstance?.availabilityStatus}" />
</div>

<div class="fieldcontain ${hasErrors(bean: stockInstance, field: 'machine', 'error')} required">
	<label for="machine">
		<g:message code="stock.machine.label" default="Machine" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="machine" name="machine.id" from="${com.chakra.config.Machine.list()}" optionKey="id" required="" value="${stockInstance?.machine?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: stockInstance, field: 'wireBrand', 'error')} required">
	<label for="wireBrand">
		<g:message code="stock.wireBrand.label" default="Wire Brand" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="wireBrand" name="wireBrand.id" from="${com.chakra.config.WireBrand.list()}" optionKey="id" required="" value="${stockInstance?.wireBrand?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: stockInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="stock.comments.label" default="Comments/Remarks" />
		
	</label>
	<g:textArea name="comments" value="${stockInstance?.comments}"/>
</div>

<%--<div class="fieldcontain ${hasErrors(bean: stockInstance, field: 'createdBy', 'error')} required">
	<label for="createdBy">
		<g:message code="stock.createdBy.label" default="Created By" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="createdBy" name="createdBy.id" from="${com.chakra.security.User.list()}" optionKey="id" required="" value="${stockInstance?.createdBy?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: stockInstance, field: 'createdDate', 'error')} required">
	<label for="createdDate">
		<g:message code="stock.createdDate.label" default="Created Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="createdDate" precision="day"  value="${stockInstance?.createdDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: stockInstance, field: 'lastEditedBy', 'error')} required">
	<label for="lastEditedBy">
		<g:message code="stock.lastEditedBy.label" default="Last Edited By" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="lastEditedBy" name="lastEditedBy.id" from="${com.chakra.security.User.list()}" optionKey="id" required="" value="${stockInstance?.lastEditedBy?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: stockInstance, field: 'lastEditedDate', 'error')} required">
	<label for="lastEditedDate">
		<g:message code="stock.lastEditedDate.label" default="Last Edited Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="lastEditedDate" precision="day"  value="${stockInstance?.lastEditedDate}"  />
</div>



--%><%--<div class="fieldcontain ${hasErrors(bean: stockInstance, field: 'stockOrderItems', 'error')} ">
	<label for="stockOrderItems">
		<g:message code="stock.stockOrderItems.label" default="Stock Order Items" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${stockInstance?.stockOrderItems?}" var="s">
    <li><g:link controller="stockOrder" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="stockOrder" action="create" params="['stock.id': stockInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'stockOrder.label', default: 'StockOrder')])}</g:link>
</li>
</ul>

</div>--%>



