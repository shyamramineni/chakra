
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
				<%--<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				--%><li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-enquiry" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			
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
				    						
			</table>
				<%--<g:if test="${enquiryInstance?.uploadFileId != null}">
	        	<fileuploader:download 	id="${enquiryInstance?.uploadFileId}"
				errorAction="list"
				errorController="enquiry">download</fileuploader:download>
			</g:if>
        	--%><br>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${enquiryInstance?.id}" />
					<g:link class="btn btn-primary" action="edit" id="${enquiryInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="btn btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					
					<g:if test ="${enquiryInstance.status != 'REALIZED'}">
					<g:if test ="${enquiryInstance.status == 'ASSIGNED'}">
						<a class="btn btn-primary" href="<g:createLink action="acceptEquiry" controller="enquiry" params="['enquiry.id': enquiryInstance?.id, 'assigned.id':enquiryInstance?.assigned.id]"/>">Accept</a>
						<a class="btn btn-primary" href="<g:createLink action="requestReassign" controller="enquiry" params="['enquiry.id': enquiryInstance?.id, 'assigned.id':enquiryInstance?.assigned.id]"/>">Request Reassign</a>
					</g:if>
					<g:if test ="${enquiryInstance.status == 'ACCEPTED'}">
						<a class="btn btn-primary" href="<g:createLink action="quotation" controller="quotation" params="['id': enquiryInstance?.id, 'customer': enquiryInstance?.customer?.id]"/>">Create Quotation</a>
						<a class="btn btn-primary" href="<g:createLink action="manualQuotation" controller="enquiry" params="['enquiry.id': enquiryInstance?.id]"/>">Manual Quotation</a>
					</g:if>
					</g:if>
					
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
