<%@ page import="com.chakra.enquiry.Enquiry" %>



<div class="fieldcontain ${hasErrors(bean: enquiryInstance, field: 'enquiryId', 'error')} ">
	<label for="enquiryId">
		<g:message code="enquiry.enquiryId.label" default="Enquiry Id" />
		
	</label>
	<g:textField name="enquiryId" value="${enquiryInstance?.enquiryId}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: enquiryInstance, field: 'assigned', 'error')} ">
	<label for="assigned">
		<g:message code="enquiry.assigned.label" default="Assigned" />
		
	</label>
	<g:select id="assigned" name="assigned.id" from="${com.chakra.security.User.list()}" optionKey="id" value="${enquiryInstance?.assigned?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: enquiryInstance, field: 'createdBy', 'error')} ">
	<label for="createdBy">
		<g:message code="enquiry.createdBy.label" default="Created By" />
		
	</label>
	<g:select id="createdBy" name="createdBy.id" from="${com.chakra.security.User.list()}" optionKey="id" value="${enquiryInstance?.createdBy?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: enquiryInstance, field: 'createdDate', 'error')} ">
	<label for="createdDate">
		<g:message code="enquiry.createdDate.label" default="Created Date" />
		
	</label>
	<g:datePicker name="createdDate" precision="day"  value="${enquiryInstance?.createdDate}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: enquiryInstance, field: 'lastEditedBy', 'error')} ">
	<label for="lastEditedBy">
		<g:message code="enquiry.lastEditedBy.label" default="Last Edited By" />
		
	</label>
	<g:select id="lastEditedBy" name="lastEditedBy.id" from="${com.chakra.security.User.list()}" optionKey="id" value="${enquiryInstance?.lastEditedBy?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: enquiryInstance, field: 'lastEditedDate', 'error')} ">
	<label for="lastEditedDate">
		<g:message code="enquiry.lastEditedDate.label" default="Last Edited Date" />
		
	</label>
	<g:datePicker name="lastEditedDate" precision="day"  value="${enquiryInstance?.lastEditedDate}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: enquiryInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="enquiry.comments.label" default="Comments" />
		
	</label>
	<g:textField name="comments" value="${enquiryInstance?.comments}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: enquiryInstance, field: 'cagePartTypeList', 'error')} ">
	<label for="cagePartTypeList">
		<g:message code="enquiry.cagePartTypeList.label" default="Cage Part Type List" />
		
	</label>
	<g:select name="cagePartTypeList" from="${com.chakra.config.CagePartType.list()}" multiple="multiple" optionKey="id" size="5" value="${enquiryInstance?.cagePartTypeList*.id}" class="many-to-many"/>
</div>

<div class="fieldcontain ${hasErrors(bean: enquiryInstance, field: 'customer', 'error')} required">
	<label for="customer">
		<g:message code="enquiry.customer.label" default="Customer" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="customer" name="customer.id" from="${com.chakra.customer.Customer.list()}" optionKey="id" required="" value="${enquiryInstance?.customer?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: enquiryInstance, field: 'enquiryDate', 'error')} required">
	<label for="enquiryDate">
		<g:message code="enquiry.enquiryDate.label" default="Enquiry Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="enquiryDate" precision="day"  value="${enquiryInstance?.enquiryDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: enquiryInstance, field: 'enquirySource', 'error')} required">
	<label for="enquirySource">
		<g:message code="enquiry.enquirySource.label" default="Enquiry Source" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="enquirySource" name="enquirySource.id" from="${com.chakra.config.EnquirySource.list()}" optionKey="id" required="" value="${enquiryInstance?.enquirySource?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: enquiryInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="enquiry.status.label" default="Status" />
		
	</label>
	<g:textField name="status" value="${enquiryInstance?.status}"/>
</div>

