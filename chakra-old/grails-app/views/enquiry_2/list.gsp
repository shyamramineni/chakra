
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
		<div id="list-enquiry" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="enquiryId" title="${message(code: 'enquiry.enquiryId.label', default: 'Enquiry Id')}" />
					
						<th><g:message code="enquiry.assigned.label" default="Assigned" /></th>
					
						<th><g:message code="enquiry.createdBy.label" default="Created By" /></th>
					
						<g:sortableColumn property="createdDate" title="${message(code: 'enquiry.createdDate.label', default: 'Created Date')}" />
					
						<th><g:message code="enquiry.lastEditedBy.label" default="Last Edited By" /></th>
					
						<g:sortableColumn property="lastEditedDate" title="${message(code: 'enquiry.lastEditedDate.label', default: 'Last Edited Date')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${enquiryInstanceList}" status="i" var="enquiryInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${enquiryInstance.id}">${fieldValue(bean: enquiryInstance, field: "enquiryId")}</g:link></td>
					
						<td>${fieldValue(bean: enquiryInstance, field: "assigned")}</td>
					
						<td>${fieldValue(bean: enquiryInstance, field: "createdBy")}</td>
					
						<td><g:formatDate date="${enquiryInstance.createdDate}" /></td>
					
						<td>${fieldValue(bean: enquiryInstance, field: "lastEditedBy")}</td>
					
						<td><g:formatDate date="${enquiryInstance.lastEditedDate}" /></td>
					
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
