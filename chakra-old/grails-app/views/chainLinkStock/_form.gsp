<%@ page import="com.chakra.stock.ChainLinkStock" %>



<div class="fieldcontain ${hasErrors(bean: chainLinkStockInstance, field: 'machine', 'error')} required">
	<label for="machine">
		<g:message code="chainLinkStock.machine.label" default="Machine" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="machine" name="machine.id" from="${com.chakra.config.Machine.list()}" optionKey="id" required="" value="${chainLinkStockInstance?.machine?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: chainLinkStockInstance, field: 'wireBrand', 'error')} required">
	<label for="wireBrand">
		<g:message code="chainLinkStock.wireBrand.label" default="Wire Brand" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="wireBrand" name="wireBrand.id" from="${com.chakra.config.WireBrand.list()}" optionKey="id" required="" value="${chainLinkStockInstance?.wireBrand?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: chainLinkStockInstance, field: 'noOfManufactured', 'error')} required">
	<label for="noOfManufactured">
		<g:message code="chainLinkStock.noOfManufactured.label" default="No Of Manufactured" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="noOfManufactured" required="" value="${fieldValue(bean: chainLinkStockInstance, field: 'noOfManufactured')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: chainLinkStockInstance, field: 'noOfInStock', 'error')} required">
	<label for="noOfInStock">
		<g:message code="chainLinkStock.noOfInStock.label" default="No Of In Stock" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="noOfInStock" required="" value="${fieldValue(bean: chainLinkStockInstance, field: 'noOfInStock')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: chainLinkStockInstance, field: 'linkMesh', 'error')} required">
	<label for="linkMesh">
		<g:message code="chainLinkStock.linkMesh.label" default="Link Mesh" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="linkMesh" name="linkMesh.id" from="${com.chakra.config.LinkMesh.list()}" optionKey="id" required="" value="${chainLinkStockInstance?.linkMesh?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: chainLinkStockInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="chainLinkStock.comments.label" default="Comments" />
		
	</label>
	<g:textField name="comments" value="${chainLinkStockInstance?.comments}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: chainLinkStockInstance, field: 'chainLinkStockId', 'error')} ">
	<label for="chainLinkStockId">
		<g:message code="chainLinkStock.chainLinkStockId.label" default="Chain Link Stock Id" />
		
	</label>
	<g:textField name="chainLinkStockId" value="${chainLinkStockInstance?.chainLinkStockId}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: chainLinkStockInstance, field: 'createdBy', 'error')} ">
	<label for="createdBy">
		<g:message code="chainLinkStock.createdBy.label" default="Created By" />
		
	</label>
	<g:select id="createdBy" name="createdBy.id" from="${com.chakra.security.User.list()}" optionKey="id" value="${chainLinkStockInstance?.createdBy?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: chainLinkStockInstance, field: 'createdDate', 'error')} ">
	<label for="createdDate">
		<g:message code="chainLinkStock.createdDate.label" default="Created Date" />
		
	</label>
	<g:datePicker name="createdDate" precision="day"  value="${chainLinkStockInstance?.createdDate}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: chainLinkStockInstance, field: 'lastEditedBy', 'error')} ">
	<label for="lastEditedBy">
		<g:message code="chainLinkStock.lastEditedBy.label" default="Last Edited By" />
		
	</label>
	<g:select id="lastEditedBy" name="lastEditedBy.id" from="${com.chakra.security.User.list()}" optionKey="id" value="${chainLinkStockInstance?.lastEditedBy?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: chainLinkStockInstance, field: 'lastEditedDate', 'error')} ">
	<label for="lastEditedDate">
		<g:message code="chainLinkStock.lastEditedDate.label" default="Last Edited Date" />
		
	</label>
	<g:datePicker name="lastEditedDate" precision="day"  value="${chainLinkStockInstance?.lastEditedDate}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: chainLinkStockInstance, field: 'availabilityStatus', 'error')} ">
	<label for="availabilityStatus">
		<g:message code="chainLinkStock.availabilityStatus.label" default="Availability Status" />
		
	</label>
	<g:checkBox name="availabilityStatus" value="${chainLinkStockInstance?.availabilityStatus}" />
</div>

<div class="fieldcontain ${hasErrors(bean: chainLinkStockInstance, field: 'chainLinkStockOrderItems', 'error')} ">
	<label for="chainLinkStockOrderItems">
		<g:message code="chainLinkStock.chainLinkStockOrderItems.label" default="Chain Link Stock Order Items" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${chainLinkStockInstance?.chainLinkStockOrderItems?}" var="c">
    <li><g:link controller="chainLinkStockOrder" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="chainLinkStockOrder" action="create" params="['chainLinkStock.id': chainLinkStockInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'chainLinkStockOrder.label', default: 'ChainLinkStockOrder')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: chainLinkStockInstance, field: 'stockManufacturedTime', 'error')} required">
	<label for="stockManufacturedTime">
		<g:message code="chainLinkStock.stockManufacturedTime.label" default="Stock Manufactured Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="stockManufacturedTime" precision="day"  value="${chainLinkStockInstance?.stockManufacturedTime}"  />
</div>

