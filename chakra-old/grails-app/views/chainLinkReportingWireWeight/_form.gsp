<%@ page import="com.chakra.production.ChainLinkReportingWireWeight" %>



<div class="fieldcontain ${hasErrors(bean: chainLinkReportingWireWeightInstance, field: 'chainLinkReporting', 'error')} required">
	<label for="chainLinkReporting">
		<g:message code="chainLinkReportingWireWeight.chainLinkReporting.label" default="Chain Link Reporting" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="chainLinkReporting" name="chainLinkReporting.id" from="${com.chakra.production.ChainLinkReporting.list()}" optionKey="id" required="" value="${chainLinkReportingWireWeightInstance?.chainLinkReporting?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: chainLinkReportingWireWeightInstance, field: 'wireReceiptReporting', 'error')} required">
	<label for="wireReceiptReporting">
		<g:message code="chainLinkReportingWireWeight.wireReceiptReporting.label" default="Wire Receipt Reporting" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="wireReceiptReporting" name="wireReceiptReporting.id" from="${com.chakra.rawmaterial.WireReceiptReporting.list()}" optionKey="id" required="" value="${chainLinkReportingWireWeightInstance?.wireReceiptReporting?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: chainLinkReportingWireWeightInstance, field: 'diameter', 'error')} required">
	<label for="diameter">
		<g:message code="chainLinkReportingWireWeight.diameter.label" default="Diameter" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="diameter" required="" value="${fieldValue(bean: chainLinkReportingWireWeightInstance, field: 'diameter')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: chainLinkReportingWireWeightInstance, field: 'weight', 'error')} required">
	<label for="weight">
		<g:message code="chainLinkReportingWireWeight.weight.label" default="Weight" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="weight" required="" value="${fieldValue(bean: chainLinkReportingWireWeightInstance, field: 'weight')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: chainLinkReportingWireWeightInstance, field: 'wireBrand', 'error')} required">
	<label for="wireBrand">
		<g:message code="chainLinkReportingWireWeight.wireBrand.label" default="Wire Brand" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="wireBrand" name="wireBrand.id" from="${com.chakra.config.WireBrand.list()}" optionKey="id" required="" value="${chainLinkReportingWireWeightInstance?.wireBrand?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: chainLinkReportingWireWeightInstance, field: 'wireConsumptionDate', 'error')} required">
	<label for="wireConsumptionDate">
		<g:message code="chainLinkReportingWireWeight.wireConsumptionDate.label" default="Wire Consumption Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="wireConsumptionDate" precision="day"  value="${chainLinkReportingWireWeightInstance?.wireConsumptionDate}"  />
</div>

