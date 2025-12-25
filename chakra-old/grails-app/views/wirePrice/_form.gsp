<%@ page import="com.chakra.config.WirePrice" %>



<div class="fieldcontain ${hasErrors(bean: wirePriceInstance, field: 'wireBrand', 'error')} required">
	<label for="wireBrand">
		<g:message code="wirePrice.wireBrand.label" default="Wire Brand" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="wireBrand" name="wireBrand.id" from="${com.chakra.config.WireBrand.list()}" optionKey="id" required="" value="${wirePriceInstance?.wireBrand?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: wirePriceInstance, field: 'wireDiameter', 'error')} required">
	<label for="wireDiameter">
		<g:message code="wirePrice.wireDiameter.label" default="Wire Diameter" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="wireDiameter" required="" value="${fieldValue(bean: wirePriceInstance, field: 'wireDiameter')}"/>
</div>

<%--<div class="fieldcontain ${hasErrors(bean: wirePriceInstance, field: 'price', 'error')} required">
	<label for="price">
		<g:message code="wirePrice.price.label" default="Price" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="price" required="" value="${fieldValue(bean: wirePriceInstance, field: 'price')}"/>
</div>

--%>

<div class="fieldcontain ${hasErrors(bean: wirePriceInstance, field: 'wirePrice', 'error')} required">
	<label for="wirePrice">
		<g:message code="wirePrice.wirePrice.label" default="Wire Price" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="wirePrice" required="" value="${fieldValue(bean: wirePriceInstance, field: 'wirePrice')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: wirePriceInstance, field: 'wastage', 'error')} required">
	<label for="wastage">
		<g:message code="wirePrice.wastage.label" default="Wastage" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="wastage" required="" value="${fieldValue(bean: wirePriceInstance, field: 'wastage')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: wirePriceInstance, field: 'conversion', 'error')} required">
	<label for="conversion">
		<g:message code="wirePrice.conversion.label" default="Conversion" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="conversion" required="" value="${fieldValue(bean: wirePriceInstance, field: 'conversion')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: wirePriceInstance, field: 'freightHandlingPerMetricTon', 'error')} required">
	<label for="freightHandlingPerMetricTon">
		<g:message code="wirePrice.freightHandlingPerMetricTon.label" default="Freight Handling Per Metric Ton" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="freightHandlingPerMetricTon" required="" value="${fieldValue(bean: wirePriceInstance, field: 'freightHandlingPerMetricTon')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: wirePriceInstance, field: 'wirePriceTrending', 'error')} required">
	<label for="wirePriceTrending">
		<g:message code="wirePrice.wirePriceTrending.label" default="Wire Price Trending" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="wirePriceTrending" required="" value="${fieldValue(bean: wirePriceInstance, field: 'wirePriceTrending')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: wirePriceInstance, field: 'startDate', 'error')} required">
	<label for="startDate">
		<g:message code="wirePrice.startDate.label" default="Start Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="startDate" precision="day"  value="${wirePriceInstance?.startDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: wirePriceInstance, field: 'endDate', 'error')} required">
	<label for="endDate">
		<g:message code="wirePrice.endDate.label" default="End Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="endDate" precision="day"  value="${wirePriceInstance?.endDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: wirePriceInstance, field: 'sheetSpecDiscount', 'error')} ">
	<label for="sheetSpecDiscount">
		<g:message code="wirePrice.sheetSpecDiscount.label" default="SheetSpec Discount" />
		
	</label>
	<g:textField name="sheetSpecDiscount" value="${wirePriceInstance?.sheetSpecDiscount}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: wirePriceInstance, field: 'chainLinkDiscount', 'error')} ">
	<label for="chainLinkDiscount">
		<g:message code="wirePrice.chainLinkDiscount.label" default="ChainLink Discount" />
		
	</label>
	<g:textField name="chainLinkDiscount" value="${wirePriceInstance?.chainLinkDiscount}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: wirePriceInstance, field: 'weldSideMeshDiscount', 'error')} ">
	<label for="weldSideMeshDiscount">
		<g:message code="wirePrice.weldSideMeshDiscount.label" default="WeldSideMesh Discount" />
		
	</label>
	<g:textField name="weldSideMeshDiscount" value="${wirePriceInstance?.weldSideMeshDiscount}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: wirePriceInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="wirePrice.description.label" default="Description" />
		
	</label>
	<g:textArea name="description" value="${wirePriceInstance?.description}"/>
</div>

