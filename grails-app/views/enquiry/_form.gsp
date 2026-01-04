<%@ page import="com.chakra.enquiry.Enquiry" %>

<div class="fieldcontain ${hasErrors(bean: enquiryInstance, field: 'enquirySource', 'error')} required">
	<label for="enquirySource">
		<g:message code="enquiry.enquirySource.label" default="Enquiry Source" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="enquirySource" name="enquirySource.id" from="${com.chakra.config.EnquirySource.list()}" optionKey="id" required="" value="${enquiryInstance?.enquirySource?.id}" class="many-to-one"/>
</div>

<%--<div class="fieldcontain ${hasErrors(bean: enquiryInstance, field: 'source', 'error')} required">
	<label for="source">
		<g:message code="enquiry.source.label" default="Source" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="source" from="${enquiryInstance.constraints.source.inList}" required="" value="${enquiryInstance?.source}" valueMessagePrefix="enquiry.source"/>
</div>

<div class="fieldcontain ${hasErrors(bean: enquiryInstance, field: 'enquiryId', 'error')} ">
	<label for="enquiryId">
		<g:message code="enquiry.enquiryId.label" default="Enquiry Id" />
		
	</label>
	<g:textField name="enquiryId" value="${enquiryInstance?.enquiryId}"/>
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
</div>--%>



<%--<div class="fieldcontain ${hasErrors(bean: enquiryInstance, field: 'assigned', 'error')} required">
	<label for="assigned">
		<g:message code="enquiry.assigned.label" default="Assigned" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="assigned" name="assigned.id" from="${com.chakra.security.User.list()}" optionKey="id" required="" value="${enquiryInstance?.assigned?.id}" class="many-to-one"/>
</div>--%>

<div class="fieldcontain ${hasErrors(bean: enquiryInstance, field: 'cagePartTypeList', 'error')} ">
	<label for="cagePartTypeList">
		<g:message code="enquiry.cagePartTypeList.label" default="Cage Part Type List" />
		
	</label>
	<g:select name="cagePartTypeList" from="${com.chakra.config.CagePartType.list()}" multiple="multiple" optionKey="id" size="5" value="${enquiryInstance?.cagePartTypeList*.id}" class="many-to-many"/>

	<%--<g:each in="${com.chakra.config.CagePartType.list()}"  var= "cagePart">
		${cagePart}<g:checkBox name="cagePartTypeList" multiple="multiple" value="${cageDesignInstance?.enquiryInstance?.cagePartTypeList*.id}" class="many-to-many"/><br>
	</g:each>
	<g:each in="${com.chakra.config.CagePartType.list(sort: 'id', order: 'asc')}" var="cagePart" status="i">
    <g:checkBox name="cagePartTypeList" value="${enquiryInstance?.cagePartTypeList*.id}" optionKey="id" checked="" />
    <label for="cagePart">${cagePart}</label><br>
	</g:each>--%>
</div>

<%--<div class="fieldcontain ${hasErrors(bean: enquiryInstance, field: 'cagePartTypeList', 'error')} ">
	<label for="cagePartTypeList">
		<g:message code="enquiry.cagePartTypeList.label" default="Cage Part Type List" />		
	</label>
	<g:each in="${com.chakra.config.CagePartType.list()}" var="cagePartType" status="i">
	    <g:checkBox name="cagePartTypeList" value="${cagePartType.id}" checked="${enquiryInstance?.cagePartTypeList?.contains(cagePartType)?:''}" />${cagePartType}<br> 
		<g:checkBox name="cagePartTypeList" value="${cagePartType.id}" checked="${enquiryInstance?.cagePartTypeList*.id}" />${cagePartType}<br>    
	</g:each>
</div>

--%><div class="fieldcontain ${hasErrors(bean: enquiryInstance, field: 'customer', 'error')} required">
	<label for="customer">
		<g:message code="enquiry.customer.label" default="Customer" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="customer" name="customer.id" from="${com.chakra.customer.Customer.list()}" optionKey="id" required="" value="${enquiryInstance?.customer?.id}" class="many-to-one"/>
</div>
<!-- 
<script type="text/template" id="customer_tile_content-initial">
<div class="customer-content-container">
	<table class="customer-content-container-space-divider">
	<tr>
		<td class="customer-content-container-input-area">
			<div>
				<table>
					<tr>
						<td><input type="text" id="companyname-input" class="textfield-initial" /></td>
					</tr>
					<tr>
						<td><input type="text" id="custname-input" class="textfield-initial" /></td>
					</tr>
					<tr>
						<td><input type="text" id="mobile-input" class="textfield-initial" /></td>
					</tr>
					<tr>
						<td><input type="text" id="address-input" class="textfield-initial" /></td>
					</tr>
					<tr style="display:none;" name="extra">
						<td><input type="text" name="email" id="email-input" class="textfield-initial" /></td>
					</tr>
					<tr style="display:none;" name="extra">
						<td><input type="text" name="phoneno" id="phoneno-input" class="textfield-initial" /></td>
					</tr>
					<tr style="display:none;" name="extra">
						<td><input type="text" name="fax" id="fax-input" class="textfield-initial" /></td>
					</tr>
					<tr style="display:none;" name="extra">
						<td><textarea name="comments" id="comments-input" class="textfield-initial"></textarea></td>
					</tr>
				</table>
				<input type="button" value="Search" id="search-btn" class="btn-custom" />
				<input type="button" value="Add" id="add-btn" class="btn-custom" /><br />
				<input type="button" value="Add with Additional Fields" id="addwithaddl-btn" class="btn-custom" /><br />
			</div>
		</td>
		<td class="customer-content-container-results-area">
			<table>
				<tr class="search-table-header">
					<th name="id">&nbsp;</th>
					<th name="compname">Company Name</th>
					<th name="custname">Customer Name</th>
					<th name="mobile">Mobile No</th>
					<th name="address">Address</th>
				</tr>
			</table>
		</td>
	</tr>
	</table>
</div>
</script>
<script type="text/template" id="customer_tile_content-final">
<div class="customer-content-container">
	<table>
		<tr>
			<td><span class="info_label">Customer Name:</span><span class="info_data"><%= custname %></span></td>
			<td><span class="info_label">Company Name:</span><span class="info_data"><%= compname %></span></td>
			<td><span class="info_label">Mobile:</span><span class="info_data"><%= mobile %></span></td>
		</tr>
	</table>
</div>
</script>
<script type="text/template" id="customer_search_result_entry">
	<tr class="search-result">
		<td name="id"><input type="radio" name=<%= '<'+'%= id %'+'>' %></td>
		<td name="compname"><%= '<'+'%= custname %'+'>' %></td>
		<td name="custname"><%= '<'+'%= compname %'+'>' %></td>
		<td name="mobile"><%= '<'+'%= mobile %'+'>' %></td>
		<td name="address"></td>
	</tr>
</script>
<div id="container">
    
    <div id="customer_tile" class="quotation-page-tile">
    </div> 	
</div>   
 -->
<div class="fieldcontain ${hasErrors(bean: enquiryInstance, field: 'enquiryDate', 'error')} required">
	<label for="enquiryDate">
		<g:message code="enquiry.enquiryDate.label" default="Enquiry Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="enquiryDate" precision="day"  value="${enquiryInstance?.enquiryDate}"  />
</div>

<%--<div class="fieldcontain ${hasErrors(bean: enquiryInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="enquiry.status.label" default="Status" />
		
	</label>
	<g:textField name="status" value="${enquiryInstance?.status}"/>
</div>

--%><div class="fieldcontain ${hasErrors(bean: enquiryInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="enquiry.comments.label" default="Comments" />
		
	</label>
	<g:textArea name="comments" value="${enquiryInstance?.comments}"/>
</div>
