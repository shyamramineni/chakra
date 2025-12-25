
<%@ page import="com.chakra.enquiry.Enquiry" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'enquiry.label', default: 'User Enquiries')}" />
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
		<div id="list-enquiry" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
					
						<g:sortableColumn property="enquiryId" title="${message(code: 'enquiry.enquiryId.label', default: 'Enquiry Id')}" />
						
						<g:sortableColumn property="source" title="${message(code: 'enquiry.source.label', default: 'Source')}" />
						
						<g:sortableColumn property="assigned" title="${message(code: 'enquiry.assigned.label', default: 'Assigned')}" />
					
						<g:sortableColumn property="createdBy" title="${message(code: 'enquiry.createdBy.label', default: 'Created By')}" />
					
						<g:sortableColumn property="createdDate" title="${message(code: 'enquiry.createdDate.label', default: 'Created Date')}" />
					
						<g:sortableColumn property="status" title="${message(code: 'enquiry.status.label', default: 'Status')}" />
						
						<th><g:message code="enquiry.edit.label" default="Cagepart Type" /></th>
															
					</tr>
				</thead>
				<tbody>
				<g:each in="${noUserEnquiriesList}" status="i" var="enquiryInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${enquiryInstance.id}">${fieldValue(bean: enquiryInstance, field: "enquiryId")}</g:link></td>
						
						<td>${fieldValue(bean: enquiryInstance, field: "enquirySource")}</td>
					
						<td>${fieldValue(bean: enquiryInstance, field: "assigned")}</td>
						
						<td>${fieldValue(bean: enquiryInstance, field: "createdBy")}</td>
					
						<td><g:formatDate date="${enquiryInstance.createdDate}" format="dd-MM-yyyy" /></td>
					
						<td>${fieldValue(bean: enquiryInstance, field: "status")}</td>
						
						<td>${enquiryInstance.cagePartTypeList}</td>
											
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${enquiryInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
