<%@ page import="com.chakra.rawmaterial.WireReceiptReporting" %>



<div class="fieldcontain ${hasErrors(bean: wireReceiptReportingInstance, field: 'wireBrand', 'error')} required">
	<label for="wireBrand">
		<g:message code="wireReceiptReporting.wireBrand.label" default="Wire Brand" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="wireBrand" name="wireBrand.id" from="${com.chakra.config.WireBrand.list()}" optionKey="id" required="" value="${wireReceiptReportingInstance?.wireBrand?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: wireReceiptReportingInstance, field: 'wireDiameter', 'error')} required">
	<label for="wireDiameter">
		<g:message code="wireReceiptReporting.wireDiameter.label" default="Wire Diameter" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="wireDiameter" required="" value="${fieldValue(bean: wireReceiptReportingInstance, field: 'wireDiameter')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: wireReceiptReportingInstance, field: 'purchaseDate', 'error')} required">
	<label for="purchaseDate">
		<g:message code="wireReceiptReporting.purchaseDate.label" default="Purchase Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="purchaseDate" precision="day"  value="${wireReceiptReportingInstance?.purchaseDate}"  />
</div>

<%--<div class="fieldcontain ${hasErrors(bean: wireReceiptReportingInstance, field: 'weightInStock', 'error')} required">
	<label for="weightInStock">
		<g:message code="wireReceiptReporting.weightInStock.label" default="Weight In Stock" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="weightInStock" required="" value="${fieldValue(bean: wireReceiptReportingInstance, field: 'weightInStock')}"/>
</div>--%>

<div class="fieldcontain ${hasErrors(bean: wireReceiptReportingInstance, field: 'weightPurchased', 'error')} required">
	<label for="weightPurchased">
		<g:message code="wireReceiptReporting.weightPurchased.label" default="Weight Purchased" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="weightPurchased" required="" value="${fieldValue(bean: wireReceiptReportingInstance, field: 'weightPurchased')}"/>
</div>

<%--<div class="fieldcontain ${hasErrors(bean: wireReceiptReportingInstance, field: 'availabilityStatus', 'error')} ">
	<label for="availabilityStatus">
		<g:message code="wireReceiptReporting.availabilityStatus.label" default="Availability Status" />
		
	</label>
	<g:checkBox name="availabilityStatus" value="${wireReceiptReportingInstance?.availabilityStatus}" />
</div>--%>

	<div class="fieldcontain ${hasErrors(bean: wireReceiptReportingInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="wireReceiptReporting.comments.label" default="Comments/Remarks" />
		
	</label>
	<g:textArea name="comments" value="${wireReceiptReportingInstance?.comments}"/>
</div>


<%--
<div class="fieldcontain ${hasErrors(bean: wireReceiptReportingInstance, field: 'productionReportingWireWeightList', 'error')} ">
	<label for="productionReportingWireWeightList">
		<g:message code="wireReceiptReporting.productionReportingWireWeightList.label" default="Production Reporting Wire Weight List" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${wireReceiptReportingInstance?.productionReportingWireWeightList?}" var="p">
    <li><g:link controller="productionReportingWireWeight" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="productionReportingWireWeight" action="create" params="['wireReceiptReporting.id': wireReceiptReportingInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'productionReportingWireWeight.label', default: 'ProductionReportingWireWeight')])}</g:link>
</li>
</ul>
 --%>
</div>
