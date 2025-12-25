<%@ page import="com.chakra.stock.StockOrder" %>



<div class="fieldcontain ${hasErrors(bean: stockOrderInstance, field: 'corder', 'error')} required">
	<label for="corder">
		<g:message code="stockOrder.corder.label" default="Corder" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="corder" name="corder.id" from="${com.chakra.order.Corder.list()}" optionKey="id" required="" value="${stockOrderInstance?.corder?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: stockOrderInstance, field: 'stock', 'error')} required">
	<label for="stock">
		<g:message code="stockOrder.stock.label" default="Stock" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="stock" name="stock.id" from="${com.chakra.stock.Stock.list()}" optionKey="id" required="" value="${stockOrderInstance?.stock?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: stockOrderInstance, field: 'stockForOrder', 'error')} required">
	<label for="stockForOrder">
		<g:message code="stockOrder.stockForOrder.label" default="Stock For Order" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="stockForOrder" required="" value="${fieldValue(bean: stockOrderInstance, field: 'stockForOrder')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: stockOrderInstance, field: 'stockOrderBlockTime', 'error')} required">
	<label for="stockOrderBlockTime">
		<g:message code="stockOrder.stockOrderBlockTime.label" default="Stock Order Block Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="stockOrderBlockTime" precision="day"  value="${stockOrderInstance?.stockOrderBlockTime}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: stockOrderInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="stockOrder.comments.label" default="Comments/Remarks" />
		
	</label>
	<g:textArea name="comments" value="${stockOrderInstance?.comments}"/>
</div>

<%--<div class="fieldcontain ${hasErrors(bean: stockOrderInstance, field: 'createdBy', 'error')} required">
	<label for="createdBy">
		<g:message code="stockOrder.createdBy.label" default="Created By" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="createdBy" name="createdBy.id" from="${com.chakra.security.User.list()}" optionKey="id" required="" value="${stockOrderInstance?.createdBy?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: stockOrderInstance, field: 'createdDate', 'error')} required">
	<label for="createdDate">
		<g:message code="stockOrder.createdDate.label" default="Created Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="createdDate" precision="day"  value="${stockOrderInstance?.createdDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: stockOrderInstance, field: 'lastEditedBy', 'error')} required">
	<label for="lastEditedBy">
		<g:message code="stockOrder.lastEditedBy.label" default="Last Edited By" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="lastEditedBy" name="lastEditedBy.id" from="${com.chakra.security.User.list()}" optionKey="id" required="" value="${stockOrderInstance?.lastEditedBy?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: stockOrderInstance, field: 'lastEditedDate', 'error')} required">
	<label for="lastEditedDate">
		<g:message code="stockOrder.lastEditedDate.label" default="Last Edited Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="lastEditedDate" precision="day"  value="${stockOrderInstance?.lastEditedDate}"  />
</div>



--%>