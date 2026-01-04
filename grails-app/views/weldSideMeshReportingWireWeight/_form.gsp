<%@ page import="com.chakra.production.WeldSideMeshReportingWireWeight" %>



<div class="fieldcontain ${hasErrors(bean: weldSideMeshReportingWireWeightInstance, field: 'weldSideMeshReporting', 'error')} required">
	<label for="weldSideMeshReporting">
		<g:message code="weldSideMeshReportingWireWeight.weldSideMeshReporting.label" default="Weld Side Mesh Reporting" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="weldSideMeshReporting" name="weldSideMeshReporting.id" from="${com.chakra.production.WeldSideMeshReporting.list()}" optionKey="id" required="" value="${weldSideMeshReportingWireWeightInstance?.weldSideMeshReporting?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: weldSideMeshReportingWireWeightInstance, field: 'wireReceiptReporting', 'error')} required">
	<label for="wireReceiptReporting">
		<g:message code="weldSideMeshReportingWireWeight.wireReceiptReporting.label" default="Wire Receipt Reporting" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="wireReceiptReporting" name="wireReceiptReporting.id" from="${com.chakra.rawmaterial.WireReceiptReporting.list()}" optionKey="id" required="" value="${weldSideMeshReportingWireWeightInstance?.wireReceiptReporting?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: weldSideMeshReportingWireWeightInstance, field: 'diameter', 'error')} required">
	<label for="diameter">
		<g:message code="weldSideMeshReportingWireWeight.diameter.label" default="Diameter" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="diameter" required="" value="${fieldValue(bean: weldSideMeshReportingWireWeightInstance, field: 'diameter')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: weldSideMeshReportingWireWeightInstance, field: 'weight', 'error')} required">
	<label for="weight">
		<g:message code="weldSideMeshReportingWireWeight.weight.label" default="Weight" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="weight" required="" value="${fieldValue(bean: weldSideMeshReportingWireWeightInstance, field: 'weight')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: weldSideMeshReportingWireWeightInstance, field: 'wireBrand', 'error')} required">
	<label for="wireBrand">
		<g:message code="weldSideMeshReportingWireWeight.wireBrand.label" default="Wire Brand" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="wireBrand" name="wireBrand.id" from="${com.chakra.config.WireBrand.list()}" optionKey="id" required="" value="${weldSideMeshReportingWireWeightInstance?.wireBrand?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: weldSideMeshReportingWireWeightInstance, field: 'wireConsumptionDate', 'error')} required">
	<label for="wireConsumptionDate">
		<g:message code="weldSideMeshReportingWireWeight.wireConsumptionDate.label" default="Wire Consumption Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="wireConsumptionDate" precision="day"  value="${weldSideMeshReportingWireWeightInstance?.wireConsumptionDate}"  />
</div>
