<%@ page import="com.chakra.production.ProductionReportingWireWeight" %>



<div class="fieldcontain ${hasErrors(bean: productionReportingWireWeightInstance, field: 'diameter', 'error')} required">
	<label for="diameter">
		<g:message code="productionReportingWireWeight.diameter.label" default="Diameter" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="diameter" required="" value="${fieldValue(bean: productionReportingWireWeightInstance, field: 'diameter')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: productionReportingWireWeightInstance, field: 'productionReporting', 'error')} required">
	<label for="productionReporting">
		<g:message code="productionReportingWireWeight.productionReporting.label" default="Production Reporting" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="productionReporting" name="productionReporting.id" from="${com.chakra.production.ProductionReporting.list()}" optionKey="id" required="" value="${productionReportingWireWeightInstance?.productionReporting?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: productionReportingWireWeightInstance, field: 'weight', 'error')} required">
	<label for="weight">
		<g:message code="productionReportingWireWeight.weight.label" default="Weight" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="weight" required="" value="${fieldValue(bean: productionReportingWireWeightInstance, field: 'weight')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: productionReportingWireWeightInstance, field: 'wireBrand', 'error')} required">
	<label for="wireBrand">
		<g:message code="productionReportingWireWeight.wireBrand.label" default="Wire Brand" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="wireBrand" name="wireBrand.id" from="${com.chakra.config.WireBrand.list()}" optionKey="id" required="" value="${productionReportingWireWeightInstance?.wireBrand?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: productionReportingWireWeightInstance, field: 'wireConsumptionDate', 'error')} required">
	<label for="wireConsumptionDate">
		<g:message code="productionReportingWireWeight.wireConsumptionDate.label" default="Wire Consumption Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="wireConsumptionDate" precision="day"  value="${productionReportingWireWeightInstance?.wireConsumptionDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: productionReportingWireWeightInstance, field: 'wireReceiptReporting', 'error')} required">
	<label for="wireReceiptReporting">
		<g:message code="productionReportingWireWeight.wireReceiptReporting.label" default="Wire Receipt Reporting" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="wireReceiptReporting" name="wireReceiptReporting.id" from="${com.chakra.rawmaterial.WireReceiptReporting.list()}" optionKey="id" required="" value="${productionReportingWireWeightInstance?.wireReceiptReporting?.id}" class="many-to-one"/>
</div>
