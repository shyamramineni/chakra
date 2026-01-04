<%@ page import="com.chakra.production.WeldSideMeshReporting" %>



<div class="fieldcontain ${hasErrors(bean: weldSideMeshReportingInstance, field: 'machine', 'error')} required">
	<label for="machine">
		<g:message code="weldSideMeshReporting.machine.label" default="Machine" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="machine" name="machine.id" from="${com.chakra.config.Machine.list()}" optionKey="id" required="" value="${weldSideMeshReportingInstance?.machine?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: weldSideMeshReportingInstance, field: 'sideMesh', 'error')} required">
	<label for="sideMesh">
		<g:message code="weldSideMeshReporting.sideMesh.label" default="Side Mesh" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="sideMesh" name="sideMesh.id" from="${com.chakra.config.SideMesh.list()}" optionKey="id" required="" value="${weldSideMeshReportingInstance?.sideMesh?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: weldSideMeshReportingInstance, field: 'wireBrand', 'error')} required">
	<label for="wireBrand">
		<g:message code="weldSideMeshReporting.wireBrand.label" default="Wire Brand" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="wireBrand" name="wireBrand.id" from="${com.chakra.config.WireBrand.list()}" optionKey="id" required="" value="${weldSideMeshReportingInstance?.wireBrand?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: weldSideMeshReportingInstance, field: 'stockManufacturedTime', 'error')} required">
	<label for="stockManufacturedTime">
		<g:message code="weldSideMeshReporting.stockManufacturedTime.label" default="Stock Manufactured Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="stockManufacturedTime" precision="day"  value="${weldSideMeshReportingInstance?.stockManufacturedTime}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: weldSideMeshReportingInstance, field: 'totalQuantity', 'error')} required">
	<label for="totalQuantity">
		<g:message code="weldSideMeshReporting.totalQuantity.label" default="Total Quantity" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="totalQuantity" required="" value="${fieldValue(bean: weldSideMeshReportingInstance, field: 'totalQuantity')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: weldSideMeshReportingInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="weldSideMeshReporting.comments.label" default="Comments" />
		
	</label>
	<g:textArea name="comments" value="${weldSideMeshReportingInstance?.comments}"/>
</div>
