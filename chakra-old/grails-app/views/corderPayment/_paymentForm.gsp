<%@ page import="com.chakra.order.CorderPayment" %>



<g:hiddenField name="corder.id" value="${corderPaymentInstance?.corder?.id}" />
<g:hiddenField name="customer.id" value="${corderPaymentInstance?.customer?.id}" />

<%--<div class="fieldcontain ${hasErrors(bean: corderPaymentInstance, field: 'corder', 'error')} required">
	<label for="corder">
		<g:message code="corderPayment.corder.label" default="Corder" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="corder" name="corder.id" from="${com.chakra.order.Corder.list()}" optionKey="id" required="" value="${corderPaymentInstance?.corder?.id}" class="many-to-one"/>
</div>

--%>

<div class="fieldcontain ${hasErrors(bean: corderPaymentInstance, field: 'paymentAmount', 'error')} required">
	<label for="paymentAmount">
		<g:message code="corderPayment.paymentAmount.label" default="Payment Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="paymentAmount" required="" value="${fieldValue(bean: corderPaymentInstance, field: 'paymentAmount')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: corderPaymentInstance, field: 'paymentDate', 'error')} required">
	<label for="paymentDate">
		<g:message code="corderPayment.paymentDate.label" default="Payment Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="paymentDate" precision="day"  value="${corderPaymentInstance?.paymentDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: corderPaymentInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="corderPayment.comments.label" default="Comments/Remarks" />
		
	</label>
	<g:textArea name="comments" value="${corderPaymentInstance?.comments}"/>
</div>

<%--<div class="fieldcontain ${hasErrors(bean: corderPaymentInstance, field: 'createdBy', 'error')} required">
	<label for="createdBy">
		<g:message code="corderPayment.createdBy.label" default="Created By" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="createdBy" name="createdBy.id" from="${com.chakra.security.User.list()}" optionKey="id" required="" value="${corderPaymentInstance?.createdBy?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: corderPaymentInstance, field: 'createdDate', 'error')} required">
	<label for="createdDate">
		<g:message code="corderPayment.createdDate.label" default="Created Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="createdDate" precision="day"  value="${corderPaymentInstance?.createdDate}"  />
</div>

--%><%--<div class="fieldcontain ${hasErrors(bean: corderPaymentInstance, field: 'customer', 'error')} required">
	<label for="customer">
		<g:message code="corderPayment.customer.label" default="Customer" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="customer" name="customer.id" from="${com.chakra.customer.Customer.list()}" optionKey="id" required="" value="${corderPaymentInstance?.customer?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: corderPaymentInstance, field: 'lastEditedBy', 'error')} required">
	<label for="lastEditedBy">
		<g:message code="corderPayment.lastEditedBy.label" default="Last Edited By" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="lastEditedBy" name="lastEditedBy.id" from="${com.chakra.security.User.list()}" optionKey="id" required="" value="${corderPaymentInstance?.lastEditedBy?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: corderPaymentInstance, field: 'lastEditedDate', 'error')} required">
	<label for="lastEditedDate">
		<g:message code="corderPayment.lastEditedDate.label" default="Last Edited Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="lastEditedDate" precision="day"  value="${corderPaymentInstance?.lastEditedDate}"  />
</div>--%>



