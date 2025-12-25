
<%@ page import="com.chakra.enquiry.Enquiry" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'enquiry.label', default: 'Enquiry')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-enquiry" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<%--<ul>
			<li><sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_SALES"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></sec:ifAnyGranted></li>
			</ul>
		--%><div id="list-enquiry" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered table-striped table-condensed">
				<thead>
					<tr>
						<th><g:message code="enquiry.customer.label" default="Enquiry Id" /></th>
						
						<th><g:message code="enquiry.customer.label" default="Customer" /></th>
						
						<th><g:message code="enquiry.edit.label" default="Source" /></th>
						
						<th><g:message code="enquiry.edit.label" default="Assigned" /></th>
					
						<th><g:message code="enquiry.edit.label" default="Created By" /></th>
						
						<g:sortableColumn property="createdDate" title="${message(code: 'enquiry.createdDate.label', default: 'Created Date')}" />
					
						<th><g:message code="enquiry.edit.label" default="Status" /></th>
						
						<th><g:message code="enquiry.edit.label" default="Cagepart Type" /></th>
						
						<th><g:message code="enquiry.edit.label" default="Action" /></th>
										
					</tr>
				</thead>
				<tbody>
				<g:each in="${enquiryInstanceList}" status="i" var="enquiryInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${enquiryInstance?.id}">${fieldValue(bean: enquiryInstance, field: "enquiryId")}</g:link></td>
						
						<td><g:link controller="customer" action="show" id="${enquiryInstance.customer.id}">${fieldValue(bean: enquiryInstance, field: "customer")}</g:link></td>
						
						<td>${fieldValue(bean: enquiryInstance, field: "enquirySource")}</td>
					
						<td>${fieldValue(bean: enquiryInstance, field: "assigned")}</td>
						
						<td>${fieldValue(bean: enquiryInstance, field: "createdBy")}</td>
					
						<td><g:formatDate date="${enquiryInstance.createdDate}" format="dd-MM-yyyy" /></td>
					
						<td>${fieldValue(bean: enquiryInstance, field: "status")}</td>
						
						<td>
							<g:each in="${enquiryInstance.cagePartTypeList}" var="c">
						    	${c.cagePartType}<br>
							</g:each>
						</td>
						
						<td>
							<g:link action="quotation" controller="quotation" params="['enquiry': enquiryInstance.id, 'customer': enquiryInstance?.customer.id]">Create Quotation</g:link><br>
						    <g:if test ="${enquiryInstance.status != 'REALIZED'}">
						    <g:if test ="${enquiryInstance.status != 'MANUAL QUOTATION'}">
						    <%--<sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_SALES"><g:link action="quotation" controller="quotation" params="['enquiry.id': enquiryInstance.id, 'customer.id': enquiryInstance?.customer.id]">Create Quotation</g:link></sec:ifAnyGranted><br>
						    </g:if>
						    <g:if test ="${enquiryInstance.status != 'MANUAL QUOTATION'}">
						    --%>
						    <g:if test ="${enquiryInstance.status == 'ACCEPTED'||enquiryInstance.status == 'ASSIGNED'}">
						    
						    <g:link action="manualQuotation" controller="enquiry" params="['enquiry.id': enquiryInstance.id, 'customer.id': enquiryInstance?.customer.id]">Manual Quotation</g:link><br>
						    </g:if>
						    <g:if test ="${enquiryInstance.status != 'ACCEPTED'}">
						    <sec:ifAllGranted roles="ROLE_ADMIN"><g:link class="editUser" action="editUser" id="${enquiryInstance?.id}">Reassign User</g:link></sec:ifAllGranted><br>
						    </g:if>
						    <g:if test ="${enquiryInstance.status == 'REQUEST REASSIGN'}">
						    <sec:ifAnyGranted roles="ROLE_ADMIN"><g:link action="denyRequest" controller="enquiry" params="['enquiry.id': enquiryInstance.id, 'assigned.id': enquiryInstance?.assigned.id]">Deny Request</g:link></sec:ifAnyGranted>
						    </g:if>
						    </g:if>
						    </g:if>
						</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<ul>
				<li><sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_SALES"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></sec:ifAnyGranted></li>
			</ul>
			<div class="pagination">
				<g:paginate total="${enquiryInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
