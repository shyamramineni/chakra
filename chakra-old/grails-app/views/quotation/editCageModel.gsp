<%@ page import="com.chakra.quotation.QuotationCagePart" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quotationCagePart.label', default: 'QuotationCagePart')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#edit-quotationCagePart" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="edit-quotationCagePart" class="content scaffold-edit" role="main">
			<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${quotationCagePartInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${quotationCagePartInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form method="post" controller="quotation" >
			    <g:hiddenField name="id" value="${quotationModelInstance?.quotationCagePartModel?.id}" />
				<g:hiddenField name="version" value="${quotationModelInstance?.quotationCagePartModel?.version}" />
				<g:hiddenField name="quotation" value="${quotationInstance?.id}" />
				<g:hiddenField name="quotationModel" value="${quotationModelInstance?.id}" />
				<fieldset class="cageForm">
					<g:render template="cageForm"/>
				</fieldset>
				<fieldset class="buttons">
					<sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_SALES"><g:actionSubmit class="btn btn-primary" action="updateCageModel" value="${message(code: 'default.button.update.label', default: 'Update')}" /></sec:ifAnyGranted>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
