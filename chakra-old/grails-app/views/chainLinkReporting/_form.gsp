<%@ page import="com.chakra.production.ChainLinkReporting" %>



<div class="fieldcontain ${hasErrors(bean: chainLinkReportingInstance, field: 'machine', 'error')} required">
	<label for="machine">
		<g:message code="chainLinkReporting.machine.label" default="Machine" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="machine" name="machine.id" from="${com.chakra.config.Machine.list()}" optionKey="id" required="" value="${chainLinkReportingInstance?.machine?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: chainLinkReportingInstance, field: 'linkMesh', 'error')} required">
	<label for="linkMesh">
		<g:message code="chainLinkReporting.linkMesh.label" default="Link Mesh" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="linkMesh" name="linkMesh.id" from="${com.chakra.config.LinkMesh.list()}" optionKey="id" required="" value="${chainLinkReportingInstance?.linkMesh?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: chainLinkReportingInstance, field: 'wireBrand', 'error')} required">
	<label for="wireBrand">
		<g:message code="chainLinkReporting.wireBrand.label" default="Wire Brand" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="wireBrand" name="wireBrand.id" from="${com.chakra.config.WireBrand.list()}" optionKey="id" required="" value="${chainLinkReportingInstance?.wireBrand?.id}" class="many-to-one"/>
</div>

<%--<div class="fieldcontain ${hasErrors(bean: chainLinkReportingInstance, field: 'chainLinkStock', 'error')} ">
	<label for="chainLinkStock">
		<g:message code="chainLinkReporting.chainLinkStock.label" default="Chain Link Stock" />
		
	</label>
	<g:select id="chainLinkStock" name="chainLinkStock.id" from="${com.chakra.stock.ChainLinkStock.list()}" optionKey="id" value="${chainLinkReportingInstance?.chainLinkStock?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: chainLinkReportingInstance, field: 'createdBy', 'error')} ">
	<label for="createdBy">
		<g:message code="chainLinkReporting.createdBy.label" default="Created By" />
		
	</label>
	<g:textField name="createdBy" value="${chainLinkReportingInstance?.createdBy}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: chainLinkReportingInstance, field: 'createdDate', 'error')} ">
	<label for="createdDate">
		<g:message code="chainLinkReporting.createdDate.label" default="Created Date" />
		
	</label>
	<g:datePicker name="createdDate" precision="day"  value="${chainLinkReportingInstance?.createdDate}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: chainLinkReportingInstance, field: 'lastEditedBy', 'error')} ">
	<label for="lastEditedBy">
		<g:message code="chainLinkReporting.lastEditedBy.label" default="Last Edited By" />
		
	</label>
	<g:textField name="lastEditedBy" value="${chainLinkReportingInstance?.lastEditedBy}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: chainLinkReportingInstance, field: 'editedDate', 'error')} ">
	<label for="editedDate">
		<g:message code="chainLinkReporting.editedDate.label" default="Edited Date" />
		
	</label>
	<g:datePicker name="editedDate" precision="day"  value="${chainLinkReportingInstance?.editedDate}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: chainLinkReportingInstance, field: 'chainLinkReportingWireWeightList', 'error')} ">
	<label for="chainLinkReportingWireWeightList">
		<g:message code="chainLinkReporting.chainLinkReportingWireWeightList.label" default="Chain Link Reporting Wire Weight List" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${chainLinkReportingInstance?.chainLinkReportingWireWeightList?}" var="c">
    <li><g:link controller="chainLinkReportingWireWeight" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="chainLinkReportingWireWeight" action="create" params="['chainLinkReporting.id': chainLinkReportingInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'chainLinkReportingWireWeight.label', default: 'ChainLinkReportingWireWeight')])}</g:link>
</li>
</ul>

</div>

--%>

<div class="fieldcontain ${hasErrors(bean: chainLinkReportingInstance, field: 'totalQuantity', 'error')} required">
	<label for="totalQuantity">
		<g:message code="chainLinkReporting.totalQuantity.label" default="Total Quantity" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="totalQuantity" required="" value="${fieldValue(bean: chainLinkReportingInstance, field: 'totalQuantity')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: chainLinkReportingInstance, field: 'stockManufacturedTime', 'error')} required">
	<label for="stockManufacturedTime">
		<g:message code="chainLinkReporting.stockManufacturedTime.label" default="Stock Manufactured Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="stockManufacturedTime" precision="day"  value="${chainLinkReportingInstance?.stockManufacturedTime}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: chainLinkReportingInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="chainLinkReporting.comments.label" default="Comments" />
		
	</label>
	<g:textArea name="comments" value="${chainLinkReportingInstance?.comments}"/>
</div>



