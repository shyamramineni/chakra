<%@ page import="com.chakra.order.CorderCageParts" %>



<div class="fieldcontain ${hasErrors(bean: corderCagePartsInstance, field: 'cagePartSpecFormula', 'error')} ">
	<label for="cagePartSpecFormula">
		<g:message code="corderCageParts.cagePartSpecFormula.label" default="Cage Part Spec Formula" />
		
	</label>
	<g:select id="cagePartSpecFormula" name="cagePartSpecFormula.id" from="${com.chakra.config.CagePartSpecFormula.list()}" optionKey="id" value="${corderCagePartsInstance?.cagePartSpecFormula?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: corderCagePartsInstance, field: 'noOfCageParts', 'error')} ">
	<label for="noOfCageParts">
		<g:message code="corderCageParts.noOfCageParts.label" default="No Of Cage Parts" />
		
	</label>
	<g:field type="number" name="noOfCageParts" value="${fieldValue(bean: corderCagePartsInstance, field: 'noOfCageParts')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: corderCagePartsInstance, field: 'priceOfEachCagePart', 'error')} ">
	<label for="priceOfEachCagePart">
		<g:message code="corderCageParts.priceOfEachCagePart.label" default="Price Of Each Cage Part" />
		
	</label>
	<g:field type="number" name="priceOfEachCagePart" value="${fieldValue(bean: corderCagePartsInstance, field: 'priceOfEachCagePart')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: corderCagePartsInstance, field: 'costOfCagePart', 'error')} ">
	<label for="costOfCagePart">
		<g:message code="corderCageParts.costOfCagePart.label" default="Cost Of Cage Part" />
		
	</label>
	<g:field type="number" name="costOfCagePart" value="${fieldValue(bean: corderCagePartsInstance, field: 'costOfCagePart')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: corderCagePartsInstance, field: 'cageCost', 'error')} ">
	<label for="cageCost">
		<g:message code="corderCageParts.cageCost.label" default="Cage Cost" />
		
	</label>
	<g:field type="number" name="cageCost" value="${fieldValue(bean: corderCagePartsInstance, field: 'cageCost')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: corderCagePartsInstance, field: 'corder', 'error')} required">
	<label for="corder">
		<g:message code="corderCageParts.corder.label" default="Corder" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="corder" name="corder.id" from="${com.chakra.order.Corder.list()}" optionKey="id" required="" value="${corderCagePartsInstance?.corder?.id}" class="many-to-one"/>
</div>

