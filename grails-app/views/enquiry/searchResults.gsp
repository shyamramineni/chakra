
<%@ page import="com.chakra.enquiry.Enquiry" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'enquiry.label', default: 'Enquiry')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<%--<a href="#list-enquiry" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		--%><div class="nav" role="navigation">
			<%--
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				--%><li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			
		</div>
		<div id="list-enquiry" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			 <g:if test="${enquiryInstanceList?.size() > 0}">
			<table>
				<thead>
					<tr>
					
								
						<g:sortableColumn property="customerName" title="${message(code: 'enquiry.customerName.label', default: 'Customer')}" />
					
						<g:sortableColumn property="enquiryDate" title="${message(code: 'enquiry.enquiryDate.label', default: 'Enquiry Date')}" />
						
						<th><g:message code="enquiry.source.label" default="Source" /></th>
						
						<th><g:message code="enquiry.createdBy.label" default="Created By" /></th>
					
						<g:sortableColumn property="createdDate" title="${message(code: 'enquiry.createdDate.label', default: 'Created Date')}" />
					
						<th><g:message code="enquiry.lastEditedBy.label" default="Last Edited By" /></th>
															
														
					</tr>
				</thead>
				<tbody>
				<g:each in="${enquiryInstanceList}" status="i" var="enquiryInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${enquiryInstance.id}">${fieldValue(bean: enquiryInstance, field: "customer")}</g:link></td>
					
						<td><g:formatDate date="${enquiryInstance.enquiryDate}" /></td>
						
						<td>${fieldValue(bean: enquiryInstance, field: "enquirySource")}</td>
						
						<td>${fieldValue(bean: enquiryInstance, field: "createdBy")}</td>
					
						<td><g:formatDate date="${enquiryInstance.createdDate}" /></td>
					
						<td>${fieldValue(bean: enquiryInstance, field: "lastEditedBy")}</td>
															
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination-centered">
				<g:paginate total="${enquiryInstanceTotal}" />
			</div>
			</g:if>
		</div>
	</body>
</html>
