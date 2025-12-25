<%@ page import="com.chakra.stock.CageStockOrder" %>



<div class="fieldcontain ${hasErrors(bean: cageStockOrderInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="cageStockOrder.comments.label" default="Comments" />
		
	</label>
	<g:textField name="comments" value="${cageStockOrderInstance?.comments}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cageStockOrderInstance, field: 'createdBy', 'error')} ">
	<label for="createdBy">
		<g:message code="cageStockOrder.createdBy.label" default="Created By" />
		
	</label>
	<g:select id="createdBy" name="createdBy.id" from="${com.chakra.security.User.list()}" optionKey="id" value="${cageStockOrderInstance?.createdBy?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cageStockOrderInstance, field: 'createdDate', 'error')} ">
	<label for="createdDate">
		<g:message code="cageStockOrder.createdDate.label" default="Created Date" />
		
	</label>
	<g:datePicker name="createdDate" precision="day"  value="${cageStockOrderInstance?.createdDate}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: cageStockOrderInstance, field: 'lastEditedBy', 'error')} ">
	<label for="lastEditedBy">
		<g:message code="cageStockOrder.lastEditedBy.label" default="Last Edited By" />
		
	</label>
	<g:select id="lastEditedBy" name="lastEditedBy.id" from="${com.chakra.security.User.list()}" optionKey="id" value="${cageStockOrderInstance?.lastEditedBy?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cageStockOrderInstance, field: 'lastEditedDate', 'error')} ">
	<label for="lastEditedDate">
		<g:message code="cageStockOrder.lastEditedDate.label" default="Last Edited Date" />
		
	</label>
	<g:datePicker name="lastEditedDate" precision="day"  value="${cageStockOrderInstance?.lastEditedDate}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: cageStockOrderInstance, field: 'cageStock', 'error')} required">
	<label for="cageStock">
		<g:message code="cageStockOrder.cageStock.label" default="Cage Stock" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="cageStock" name="cageStock.id" from="${com.chakra.stock.CageStock.list()}" optionKey="id" required="" value="${cageStockOrderInstance?.cageStock?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cageStockOrderInstance, field: 'cageStockForOrder', 'error')} required">
	<label for="cageStockForOrder">
		<g:message code="cageStockOrder.cageStockForOrder.label" default="Cage Stock For Order" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="cageStockForOrder" required="" value="${fieldValue(bean: cageStockOrderInstance, field: 'cageStockForOrder')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cageStockOrderInstance, field: 'cageStockOrderBlockTime', 'error')} required">
	<label for="cageStockOrderBlockTime">
		<g:message code="cageStockOrder.cageStockOrderBlockTime.label" default="Cage Stock Order Block Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="cageStockOrderBlockTime" precision="day"  value="${cageStockOrderInstance?.cageStockOrderBlockTime}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: cageStockOrderInstance, field: 'corder', 'error')} required">
	<label for="corder">
		<g:message code="cageStockOrder.corder.label" default="Corder" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="corder" name="corder.id" from="${com.chakra.order.Corder.list()}" optionKey="id" required="" value="${cageStockOrderInstance?.corder?.id}" class="many-to-one"/>
</div>

