<%@ page import="com.chakra.stock.CageStock" %>



<div class="fieldcontain ${hasErrors(bean: cageStockInstance, field: 'noOfPurchased', 'error')} required">
	<label for="noOfPurchased">
		<g:message code="cageStock.noOfPurchased.label" default="No Of Purchased" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="noOfPurchased" required="" value="${fieldValue(bean: cageStockInstance, field: 'noOfPurchased')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cageStockInstance, field: 'noOfInStock', 'error')} required">
	<label for="noOfInStock">
		<g:message code="cageStock.noOfInStock.label" default="No Of In Stock" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="noOfInStock" required="" value="${fieldValue(bean: cageStockInstance, field: 'noOfInStock')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cageStockInstance, field: 'cagePartSpecFormula', 'error')} required">
	<label for="cagePartSpecFormula">
		<g:message code="cageStock.cagePartSpecFormula.label" default="Cage Part Spec Formula" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="cagePartSpecFormula" name="cagePartSpecFormula.id" from="${com.chakra.config.CagePartSpecFormula.list()}" optionKey="id" required="" value="${cageStockInstance?.cagePartSpecFormula?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cageStockInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="cageStock.comments.label" default="Comments" />
		
	</label>
	<g:textField name="comments" value="${cageStockInstance?.comments}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cageStockInstance, field: 'cageStockId', 'error')} ">
	<label for="cageStockId">
		<g:message code="cageStock.cageStockId.label" default="Cage Stock Id" />
		
	</label>
	<g:textField name="cageStockId" value="${cageStockInstance?.cageStockId}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cageStockInstance, field: 'createdBy', 'error')} ">
	<label for="createdBy">
		<g:message code="cageStock.createdBy.label" default="Created By" />
		
	</label>
	<g:select id="createdBy" name="createdBy.id" from="${com.chakra.security.User.list()}" optionKey="id" value="${cageStockInstance?.createdBy?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cageStockInstance, field: 'createdDate', 'error')} ">
	<label for="createdDate">
		<g:message code="cageStock.createdDate.label" default="Created Date" />
		
	</label>
	<g:datePicker name="createdDate" precision="day"  value="${cageStockInstance?.createdDate}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: cageStockInstance, field: 'lastEditedBy', 'error')} ">
	<label for="lastEditedBy">
		<g:message code="cageStock.lastEditedBy.label" default="Last Edited By" />
		
	</label>
	<g:select id="lastEditedBy" name="lastEditedBy.id" from="${com.chakra.security.User.list()}" optionKey="id" value="${cageStockInstance?.lastEditedBy?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cageStockInstance, field: 'lastEditedDate', 'error')} ">
	<label for="lastEditedDate">
		<g:message code="cageStock.lastEditedDate.label" default="Last Edited Date" />
		
	</label>
	<g:datePicker name="lastEditedDate" precision="day"  value="${cageStockInstance?.lastEditedDate}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: cageStockInstance, field: 'availabilityStatus', 'error')} ">
	<label for="availabilityStatus">
		<g:message code="cageStock.availabilityStatus.label" default="Availability Status" />
		
	</label>
	<g:checkBox name="availabilityStatus" value="${cageStockInstance?.availabilityStatus}" />
</div>

<div class="fieldcontain ${hasErrors(bean: cageStockInstance, field: 'cageStockOrderItems', 'error')} ">
	<label for="cageStockOrderItems">
		<g:message code="cageStock.cageStockOrderItems.label" default="Cage Stock Order Items" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${cageStockInstance?.cageStockOrderItems?}" var="c">
    <li><g:link controller="cageStockOrder" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="cageStockOrder" action="create" params="['cageStock.id': cageStockInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'cageStockOrder.label', default: 'CageStockOrder')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: cageStockInstance, field: 'purchasedTime', 'error')} required">
	<label for="purchasedTime">
		<g:message code="cageStock.purchasedTime.label" default="Purchased Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="purchasedTime" precision="day"  value="${cageStockInstance?.purchasedTime}"  />
</div>

