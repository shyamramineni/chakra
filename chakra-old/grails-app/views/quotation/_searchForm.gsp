<%@ page import="com.chakra.quotation.Quotation" %>



<div class="fieldcontain ${hasErrors(bean: quotationInstance, field: 'lastEditedDate', 'error')} ">
	<label for="lastEditedDate">
		<g:message code="quotation.lastEditedDate.label" default="Start Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="lastEditedDate" precision="day"  value="${quotationInstance?.lastEditedDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: quotationInstance, field: 'createdDate', 'error')} ">
	<label for="createdDate">
		<g:message code="quotation.createdDate.label" default="End Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="createdDate" precision="day"  value="${quotationInstance?.createdDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: quotationInstance, field: 'quotationId', 'error')} ">
	<label for="quotationId">
		<g:message code="quotation.quotationId.label" default="Quotation Id" />
		
	</label>
	<g:textField name="quotationId" value="${quotationInstance?.quotationId}"/>
</div>



<%--<div class="fieldcontain ${hasErrors(bean: quotationInstance, field: 'customer', 'error')} required">
	<label for="customer">
		<g:message code="quotation.customer.label" default="Customer" />
		<span class="required-indicator">*</span>
	</label>
	${quotationInstance.customer.customerName}
</div>

<div class="fieldcontain ${hasErrors(bean: quotationInstance, field: 'cageLength', 'error')} ">
	<label for="cageLength">
		<g:message code="quotation.cageLength.label" default="Cage Length" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="cageLength" required="" value="${fieldValue(bean: quotationInstance, field: 'cageLength')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationInstance, field: 'fulls', 'error')} ">
	<label for="fulls">
		<g:message code="quotation.fulls.label" default="Fulls" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="fulls" required="" value="${fieldValue(bean: quotationInstance, field: 'fulls')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationInstance, field: 'halfs', 'error')} ">
	<label for="halfs">
		<g:message code="quotation.halfs.label" default="Halfs" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="halfs" required="" value="${fieldValue(bean: quotationInstance, field: 'halfs')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationInstance, field: 'tiers', 'error')} ">
	<label for="tiers">
		<g:message code="quotation.tiers.label" default="Tiers" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="tiers" required="" value="${fieldValue(bean: quotationInstance, field: 'tiers')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationInstance, field: 'noOfCuttingsInShed', 'error')} ">
	<label for="noOfCuttingsInShed">
		<g:message code="quotation.noOfCuttingsInShed.label" default="No Of Cuttings In Shed" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="noOfCuttingsInShed" required="" value="${fieldValue(bean: quotationInstance, field: 'noOfCuttingsInShed')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="quotation.status.label" default="Status" />
		
	</label>
	<g:textField name="status" value="${quotationInstance?.status}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quotationInstance, field: 'createdBy', 'error')} ">
	<label for="createdBy">
		<g:message code="quotation.createdBy.label" default="Created By" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="createdBy" name="createdBy.id" from="${com.chakra.security.User.list()}" optionKey="id" required="" value="${quotationInstance?.createdBy?.id}" class="many-to-one"/>
</div>--%>



<%--<div class="fieldcontain ${hasErrors(bean: quotationInstance, field: 'lastEditedBy', 'error')} ">
	<label for="lastEditedBy">
		<g:message code="quotation.lastEditedBy.label" default="Last Edited By" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="lastEditedBy" name="lastEditedBy.id" from="${com.chakra.security.User.list()}" optionKey="id" required="" value="${quotationInstance?.lastEditedBy?.id}" class="many-to-one"/>
</div>

--%>

<%--<div class="fieldcontain ${hasErrors(bean: quotationInstance, field: 'quotationModels', 'error')} ">
	<label for="quotationModels">
		<g:message code="quotation.quotationModels.label" default="Quotation Models" />
		
	</label>
	<g:select name="quotationModels" from="${com.chakra.quotation.QuotationModels.list()}" multiple="multiple" optionKey="id" size="5" value="${quotationInstance?.quotationModels*.id}" class="many-to-many"/>
</div>





--%>