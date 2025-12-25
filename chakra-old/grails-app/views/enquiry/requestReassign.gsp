
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
			<g:form controller="enquiry" action="requestReassignSubmit">
				<g:hiddenField name="enquiry" value="${enquiryInstance?.id}" />
				<g:hiddenField name="user" value="${userInstance?.id}" />
				<div class="fieldcontain ${hasErrors(bean: enquiryInstance, field: 'reassignReqDescription', 'error')} ">
					<label for="reassignReqDescription">
						<g:message code="enquiry.reassignReqDescription.label" default="Reassign Req Description" />
						
					</label>
					<g:textArea name="reassignReqDescription" value="${enquiryInstance?.reassignReqDescription}"/>
				</div>
				<g:submitButton name="create" class="btn-primary" value="${message(code: 'default.button.create.label', default: 'Submit')}" />
			</g:form>
		</div>
	</body>
</html>
