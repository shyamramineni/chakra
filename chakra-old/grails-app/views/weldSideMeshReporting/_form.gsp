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

<%--<div class="fieldcontain ${hasErrors(bean: weldSideMeshReportingInstance, field: 'weldSideMeshStock', 'error')} ">
	<label for="weldSideMeshStock">
		<g:message code="weldSideMeshReporting.weldSideMeshStock.label" default="Weld Side Mesh Stock" />
		
	</label>
	<g:select id="weldSideMeshStock" name="weldSideMeshStock.id" from="${com.chakra.stock.WeldSideMeshStock.list()}" optionKey="id" value="${weldSideMeshReportingInstance?.weldSideMeshStock?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: weldSideMeshReportingInstance, field: 'createdBy', 'error')} ">
	<label for="createdBy">
		<g:message code="weldSideMeshReporting.createdBy.label" default="Created By" />
		
	</label>
	<g:textField name="createdBy" value="${weldSideMeshReportingInstance?.createdBy}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: weldSideMeshReportingInstance, field: 'createdDate', 'error')} ">
	<label for="createdDate">
		<g:message code="weldSideMeshReporting.createdDate.label" default="Created Date" />
		
	</label>
	<g:datePicker name="createdDate" precision="day"  value="${weldSideMeshReportingInstance?.createdDate}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: weldSideMeshReportingInstance, field: 'lastEditedBy', 'error')} ">
	<label for="lastEditedBy">
		<g:message code="weldSideMeshReporting.lastEditedBy.label" default="Last Edited By" />
		
	</label>
	<g:textField name="lastEditedBy" value="${weldSideMeshReportingInstance?.lastEditedBy}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: weldSideMeshReportingInstance, field: 'editedDate', 'error')} ">
	<label for="editedDate">
		<g:message code="weldSideMeshReporting.editedDate.label" default="Edited Date" />
		
	</label>
	<g:datePicker name="editedDate" precision="day"  value="${weldSideMeshReportingInstance?.editedDate}" default="none" noSelection="['': '']" />
</div>

--%>

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

<%--<div class="fieldcontain ${hasErrors(bean: weldSideMeshReportingInstance, field: 'weldSideMeshReportingWireWeightList', 'error')} ">
	<label for="weldSideMeshReportingWireWeightList">
		<g:message code="weldSideMeshReporting.weldSideMeshReportingWireWeightList.label" default="Weld Side Mesh Reporting Wire Weight List" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${weldSideMeshReportingInstance?.weldSideMeshReportingWireWeightList?}" var="w">
    <li><g:link controller="weldSideMeshReportingWireWeight" action="show" id="${w.id}">${w?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="weldSideMeshReportingWireWeight" action="create" params="['weldSideMeshReporting.id': weldSideMeshReportingInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'weldSideMeshReportingWireWeight.label', default: 'WeldSideMeshReportingWireWeight')])}</g:link>
</li>
</ul>

</div>

--%>