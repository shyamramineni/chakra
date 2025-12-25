<%@ page import="com.chakra.config.CagePartPrice" %>



<div class="fieldcontain ${hasErrors(bean: cagePartPriceInstance, field: 'cagePart', 'error')} required">
	<label for="cagePart">
		<g:message code="cagePartPrice.cagePart.label" default="Cage Part" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="cagePart" name="cagePart.id" from="${com.chakra.config.CagePart.list()}" optionKey="id" required="" value="${cagePartPriceInstance?.cagePart?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cagePartPriceInstance, field: 'price', 'error')} required">
	<label for="price">
		<g:message code="cagePartPrice.price.label" default="Price" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="price" required="" value="${fieldValue(bean: cagePartPriceInstance, field: 'price')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cagePartPriceInstance, field: 'startDate', 'error')} required">
	<label for="startDate">
		<g:message code="cagePartPrice.startDate.label" default="Start Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="startDate" precision="day"  value="${cagePartPriceInstance?.startDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: cagePartPriceInstance, field: 'endDate', 'error')} required">
	<label for="endDate">
		<g:message code="cagePartPrice.endDate.label" default="End Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="endDate" precision="day"  value="${cagePartPriceInstance?.endDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: cagePartPriceInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="cagePartPrice.description.label" default="Description" />
		
	</label>
	<g:textArea name="description" value="${cagePartPriceInstance?.description}"/>
</div>