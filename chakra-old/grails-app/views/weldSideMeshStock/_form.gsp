<%@ page import="com.chakra.stock.WeldSideMeshStock" %>



<div class="fieldcontain ${hasErrors(bean: weldSideMeshStockInstance, field: 'machine', 'error')} required">
	<label for="machine">
		<g:message code="weldSideMeshStock.machine.label" default="Machine" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="machine" name="machine.id" from="${com.chakra.config.Machine.list()}" optionKey="id" required="" value="${weldSideMeshStockInstance?.machine?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: weldSideMeshStockInstance, field: 'wireBrand', 'error')} required">
	<label for="wireBrand">
		<g:message code="weldSideMeshStock.wireBrand.label" default="Wire Brand" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="wireBrand" name="wireBrand.id" from="${com.chakra.config.WireBrand.list()}" optionKey="id" required="" value="${weldSideMeshStockInstance?.wireBrand?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: weldSideMeshStockInstance, field: 'noOfManufactured', 'error')} required">
	<label for="noOfManufactured">
		<g:message code="weldSideMeshStock.noOfManufactured.label" default="No Of Manufactured" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="noOfManufactured" required="" value="${fieldValue(bean: weldSideMeshStockInstance, field: 'noOfManufactured')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: weldSideMeshStockInstance, field: 'noOfInStock', 'error')} required">
	<label for="noOfInStock">
		<g:message code="weldSideMeshStock.noOfInStock.label" default="No Of In Stock" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="noOfInStock" required="" value="${fieldValue(bean: weldSideMeshStockInstance, field: 'noOfInStock')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: weldSideMeshStockInstance, field: 'sideMesh', 'error')} required">
	<label for="sideMesh">
		<g:message code="weldSideMeshStock.sideMesh.label" default="Side Mesh" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="sideMesh" name="sideMesh.id" from="${com.chakra.config.SideMesh.list()}" optionKey="id" required="" value="${weldSideMeshStockInstance?.sideMesh?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: weldSideMeshStockInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="weldSideMeshStock.comments.label" default="Comments" />
		
	</label>
	<g:textField name="comments" value="${weldSideMeshStockInstance?.comments}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: weldSideMeshStockInstance, field: 'weldSideMeshStockId', 'error')} ">
	<label for="weldSideMeshStockId">
		<g:message code="weldSideMeshStock.weldSideMeshStockId.label" default="Weld Side Mesh Stock Id" />
		
	</label>
	<g:textField name="weldSideMeshStockId" value="${weldSideMeshStockInstance?.weldSideMeshStockId}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: weldSideMeshStockInstance, field: 'createdBy', 'error')} ">
	<label for="createdBy">
		<g:message code="weldSideMeshStock.createdBy.label" default="Created By" />
		
	</label>
	<g:select id="createdBy" name="createdBy.id" from="${com.chakra.security.User.list()}" optionKey="id" value="${weldSideMeshStockInstance?.createdBy?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: weldSideMeshStockInstance, field: 'createdDate', 'error')} ">
	<label for="createdDate">
		<g:message code="weldSideMeshStock.createdDate.label" default="Created Date" />
		
	</label>
	<g:datePicker name="createdDate" precision="day"  value="${weldSideMeshStockInstance?.createdDate}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: weldSideMeshStockInstance, field: 'lastEditedBy', 'error')} ">
	<label for="lastEditedBy">
		<g:message code="weldSideMeshStock.lastEditedBy.label" default="Last Edited By" />
		
	</label>
	<g:select id="lastEditedBy" name="lastEditedBy.id" from="${com.chakra.security.User.list()}" optionKey="id" value="${weldSideMeshStockInstance?.lastEditedBy?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: weldSideMeshStockInstance, field: 'lastEditedDate', 'error')} ">
	<label for="lastEditedDate">
		<g:message code="weldSideMeshStock.lastEditedDate.label" default="Last Edited Date" />
		
	</label>
	<g:datePicker name="lastEditedDate" precision="day"  value="${weldSideMeshStockInstance?.lastEditedDate}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: weldSideMeshStockInstance, field: 'availabilityStatus', 'error')} ">
	<label for="availabilityStatus">
		<g:message code="weldSideMeshStock.availabilityStatus.label" default="Availability Status" />
		
	</label>
	<g:checkBox name="availabilityStatus" value="${weldSideMeshStockInstance?.availabilityStatus}" />
</div>

<div class="fieldcontain ${hasErrors(bean: weldSideMeshStockInstance, field: 'stockManufacturedTime', 'error')} required">
	<label for="stockManufacturedTime">
		<g:message code="weldSideMeshStock.stockManufacturedTime.label" default="Stock Manufactured Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="stockManufacturedTime" precision="day"  value="${weldSideMeshStockInstance?.stockManufacturedTime}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: weldSideMeshStockInstance, field: 'weldSideMeshStockOrderItems', 'error')} ">
	<label for="weldSideMeshStockOrderItems">
		<g:message code="weldSideMeshStock.weldSideMeshStockOrderItems.label" default="Weld Side Mesh Stock Order Items" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${weldSideMeshStockInstance?.weldSideMeshStockOrderItems?}" var="w">
    <li><g:link controller="weldSideMeshStockOrder" action="show" id="${w.id}">${w?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="weldSideMeshStockOrder" action="create" params="['weldSideMeshStock.id': weldSideMeshStockInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'weldSideMeshStockOrder.label', default: 'WeldSideMeshStockOrder')])}</g:link>
</li>
</ul>

</div>

