
<%@ page import="com.chakra.enquiry.Enquiry" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'enquiry.label', default: 'Enquiry')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-enquiry" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-enquiry" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<%--<ol class="property-list enquiry">
			
				<g:if test="${enquiryInstance?.source}">
				<li class="fieldcontain">
					<span id="source-label" class="property-label"><g:message code="enquiry.source.label" default="Source" /></span>
					
						<span class="property-value" aria-labelledby="source-label"><g:fieldValue bean="${enquiryInstance}" field="source"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${enquiryInstance?.createdBy}">
				<li class="fieldcontain">
					<span id="createdBy-label" class="property-label"><g:message code="enquiry.createdBy.label" default="Created By" /></span>
					
						<span class="property-value" aria-labelledby="createdBy-label"><g:link controller="user" action="show" id="${enquiryInstance?.createdBy?.id}">${enquiryInstance?.createdBy?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${enquiryInstance?.createdDate}">
				<li class="fieldcontain">
					<span id="createdDate-label" class="property-label"><g:message code="enquiry.createdDate.label" default="Created Date" /></span>
					
						<span class="property-value" aria-labelledby="createdDate-label"><g:formatDate date="${enquiryInstance?.createdDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${enquiryInstance?.lastEditedBy}">
				<li class="fieldcontain">
					<span id="lastEditedBy-label" class="property-label"><g:message code="enquiry.lastEditedBy.label" default="Last Edited By" /></span>
					
						<span class="property-value" aria-labelledby="lastEditedBy-label"><g:link controller="user" action="show" id="${enquiryInstance?.lastEditedBy?.id}">${enquiryInstance?.lastEditedBy?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${enquiryInstance?.lastEditedDate}">
				<li class="fieldcontain">
					<span id="lastEditedDate-label" class="property-label"><g:message code="enquiry.lastEditedDate.label" default="Last Edited Date" /></span>
					
						<span class="property-value" aria-labelledby="lastEditedDate-label"><g:formatDate date="${enquiryInstance?.lastEditedDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${enquiryInstance?.comments}">
				<li class="fieldcontain">
					<span id="comments-label" class="property-label"><g:message code="enquiry.comments.label" default="Comments" /></span>
					
						<span class="property-value" aria-labelledby="comments-label"><g:fieldValue bean="${enquiryInstance}" field="comments"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${enquiryInstance?.cagePartTypeList}">
				<li class="fieldcontain">
					<span id="cagePartTypeList-label" class="property-label"><g:message code="enquiry.cagePartTypeList.label" default="Cage Part Type List" /></span>
					
						<g:each in="${enquiryInstance.cagePartTypeList}" var="c">
						<span class="property-value" aria-labelledby="cagePartTypeList-label"><g:link controller="cagePartType" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${enquiryInstance?.customer}">
				<li class="fieldcontain">
					<span id="customer-label" class="property-label"><g:message code="enquiry.customer.label" default="Customer" /></span>
					
						<span class="property-value" aria-labelledby="customer-label"><g:link controller="customer" action="show" id="${enquiryInstance?.customer?.id}">${enquiryInstance?.customer?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${enquiryInstance?.enquiryDate}">
				<li class="fieldcontain">
					<span id="enquiryDate-label" class="property-label"><g:message code="enquiry.enquiryDate.label" default="Enquiry Date" /></span>
					
						<span class="property-value" aria-labelledby="enquiryDate-label"><g:formatDate date="${enquiryInstance?.enquiryDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${enquiryInstance?.enquiryId}">
				<li class="fieldcontain">
					<span id="enquiryId-label" class="property-label"><g:message code="enquiry.enquiryId.label" default="Enquiry Id" /></span>
					
						<span class="property-value" aria-labelledby="enquiryId-label"><g:fieldValue bean="${enquiryInstance}" field="enquiryId"/></span>
					
				</li>
				</g:if>
			
			</ol>
			
			--%>
			<table class="table table-bordered">
							
				    <tr>
				        <th align="left">Enquiry Id:</th>
				        <td>${enquiryInstance.enquiryId}</td>
				    </tr>
				    <tr>
				        <th align="left">Customer Name:</th>
				        <td>${enquiryInstance.customer.customerName}</td>
				    </tr>
				    <tr>
				        <th align="left">Source:</th>
				        <td>${enquiryInstance.enquirySource}</td>
				    </tr>
				    <tr>
				        <th align="left">Created By:</th>
				        <td>${enquiryInstance.createdBy}</td>
				    </tr>
				    <tr>
				        <th align="left">Created Date:</th>
				        <td>${enquiryInstance.createdDate}</td>
				    </tr>
				    <tr>
				        <th align="left">Cage Part Type List:</th>
				        <td>
				           	<g:each in="${enquiryInstance.cagePartTypeList}" var="c">
						    	${c.cagePartType}<br>
							</g:each>
						</td>
				    </tr>
				    <tr>
				        <th align="left">Last Edited By:</th>
				        <td>${enquiryInstance.lastEditedBy}</td>
				    </tr>
				    <tr>
				        <th align="left">Last Edited Date:</th>
				        <td>${enquiryInstance.lastEditedDate}</td>
				    </tr>
				    <tr>
				        <th align="left">Comments:</th>
				        <td>${enquiryInstance.comments}</td>
				    </tr>
				    <tr>
				        <th align="left">ReqReassign Desc:</th>
				        <td>${enquiryInstance?.reassignReqDescription}</td>
				    </tr>
				    <tr>
				    	<th align="left">File:</th>
				    	<g:each var="f" in="${files}">
				    	<g:if test="${enquiryInstance?.uploadFileId == f?.id}">
				    	
				    	<td><fileuploader:download 	id="${f.id}"
															errorAction="index"
															errorController="docs">${f.name}</fileuploader:download></td>
						</g:if>															
				    	</g:each>
				    </tr>
				    
				    
				    </table>
				<%--<g:if test="${enquiryInstance?.uploadFileId != null}">
		        	<fileuploader:download 	id="${enquiryInstance?.uploadFileId}"
					errorAction="list"
					errorController="enquiry">download</fileuploader:download>
				</g:if>
        	--%>
        	
        	<br>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${enquiryInstance?.id}" />
					<sec:ifAllGranted roles="ROLE_ADMIN"><g:link class="btn btn-primary" action="edit" id="${enquiryInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link></sec:ifAllGranted>
					<sec:ifAllGranted roles="ROLE_ADMIN"><g:actionSubmit class="btn btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></sec:ifAllGranted>
					<sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_SALES"><a class="btn btn-primary" href="<g:createLink action="quotation" controller="quotation" params="['enquiry': enquiryInstance?.id, 'customer': enquiryInstance?.customer?.id]"/>">Create Quotation</a></sec:ifAnyGranted>
					<g:if test ="${enquiryInstance.status != 'REALIZED'}">
					<g:if test ="${enquiryInstance.status != 'MANUAL QUOTATION'}">
					
					<g:if test ="${enquiryInstance.status == 'ASSIGNED'||enquiryInstance.status == 'ACCEPTED'}">					
					<a class="btn btn-primary" href="<g:createLink action="manualQuotation" controller="enquiry" params="['enquiry.id': enquiryInstance?.id]"/>">Manual Quotation</a>
					</g:if>
					<%--<a class="btn btn-primary" href="<g:createLink action="acceptEnquiry" controller="enquiry" params="['enquiry.id': enquiryInstance?.id, 'assigned.id':enquiryInstance?.assigned.id]"/>">Accept</a>
					<a class="btn btn-primary" href="<g:createLink action="requestReassign" controller="enquiry" params="['enquiry.id': enquiryInstance?.id, 'assigned.id':enquiryInstance?.assigned.id]"/>">Request Reassign</a>
					--%>
					<g:if test ="${enquiryInstance.status == 'REQUEST REASSIGN'}">
					<a class="btn btn-primary" href="<g:createLink action="denyRequest" controller="enquiry" params="['enquiry.id': enquiryInstance?.id, 'assigned.id':enquiryInstance?.assigned.id]"/>">Deny Request</a>					
					</g:if>
					</g:if>
					</g:if>
					<%--<a class="btn" href="<g:createLink action="create" controller="corder" params="['customer.id': customerInstance?.id]"/>">Create Order</a></span>
				--%></fieldset>
			</g:form>
		</div>
	</body>
</html>
