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
