<%@ page import="com.chakra.production.CagePartReporting" %>



<div class="fieldcontain ${hasErrors(bean: cagePartReportingInstance, field: 'cagePartSpecFormula', 'error')} required">
	<label for="cagePartSpecFormula">
		<g:message code="cagePartReporting.cagePartSpecFormula.label" default="Cage Part Spec Formula" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="cagePartSpecFormula" name="cagePartSpecFormula.id" from="${com.chakra.config.CagePartSpecFormula.list()}" optionKey="id" required="" value="${cagePartReportingInstance?.cagePartSpecFormula?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cagePartReportingInstance, field: 'stockPurchasedTime', 'error')} required">
	<label for="stockPurchasedTime">
		<g:message code="cagePartReporting.stockPurchasedTime.label" default="Stock Purchased Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="stockPurchasedTime" precision="day"  value="${cagePartReportingInstance?.stockPurchasedTime}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: cagePartReportingInstance, field: 'totalQuantity', 'error')} required">
	<label for="totalQuantity">
		<g:message code="cagePartReporting.totalQuantity.label" default="Total Quantity" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="totalQuantity" required="" value="${fieldValue(bean: cagePartReportingInstance, field: 'totalQuantity')}"/>
</div>

<%--<div class="fieldcontain ${hasErrors(bean: cagePartReportingInstance, field: 'cageStock', 'error')} ">
	<label for="cageStock">
		<g:message code="cagePartReporting.cageStock.label" default="Cage Stock" />
		
	</label>
	<g:select id="cageStock" name="cageStock.id" from="${com.chakra.stock.CageStock.list()}" optionKey="id" value="${cagePartReportingInstance?.cageStock?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cagePartReportingInstance, field: 'createdBy', 'error')} ">
	<label for="createdBy">
		<g:message code="cagePartReporting.createdBy.label" default="Created By" />
		
	</label>
	<g:textField name="createdBy" value="${cagePartReportingInstance?.createdBy}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cagePartReportingInstance, field: 'createdDate', 'error')} ">
	<label for="createdDate">
		<g:message code="cagePartReporting.createdDate.label" default="Created Date" />
		
	</label>
	<g:datePicker name="createdDate" precision="day"  value="${cagePartReportingInstance?.createdDate}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: cagePartReportingInstance, field: 'lastEditedBy', 'error')} ">
	<label for="lastEditedBy">
		<g:message code="cagePartReporting.lastEditedBy.label" default="Last Edited By" />
		
	</label>
	<g:textField name="lastEditedBy" value="${cagePartReportingInstance?.lastEditedBy}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cagePartReportingInstance, field: 'editedDate', 'error')} ">
	<label for="editedDate">
		<g:message code="cagePartReporting.editedDate.label" default="Edited Date" />
		
	</label>
	<g:datePicker name="editedDate" precision="day"  value="${cagePartReportingInstance?.editedDate}" default="none" noSelection="['': '']" />
</div>

--%><div class="fieldcontain ${hasErrors(bean: cagePartReportingInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="cagePartReporting.comments.label" default="Comments" />
		
	</label>
	<g:textArea name="comments" value="${cagePartReportingInstance?.comments}"/>
</div>



