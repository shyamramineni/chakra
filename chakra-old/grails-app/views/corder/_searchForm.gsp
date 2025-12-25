<%@ page import="com.chakra.order.Corder" %>



<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'lastEditedDate', 'error')}">
	<label for="lastEditedDate">
		<g:message code="corder.lastEditedDate.label" default="Start Date" />
		
	</label>
	<g:datePicker name="lastEditedDate" precision="day"  value="${corderInstance?.lastEditedDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'createdDate', 'error')} ">
	<label for="createdDate">
		<g:message code="corder.createdDate.label" default="End Date" />
		
	</label>
	<g:datePicker name="createdDate" precision="day"  value="${corderInstance?.createdDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'status', 'error')} ">
	<label for="orderId">
		<g:message code="corder.status.label" default="Status" />
		
	</label>
	<g:textField name="status" value="${corderInstance?.status}"/>
</div>

