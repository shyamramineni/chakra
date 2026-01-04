<%@ page import="com.chakra.order.CorderPayment" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'corderPayment.label', default: 'CorderPayment')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body><%--
		<a href="#edit-corderPayment" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		--%><div class="nav" role="navigation">
			<%--
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				--%><li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			
		</div>
		<div id="edit-corderPayment" class="content scaffold-edit" role="main">
			<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${corderPaymentInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${corderPaymentInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form method="post" controller="corder">
				<g:hiddenField name="id" value="${corderInstance?.id}" />
				<g:hiddenField name="version" value="${corderInstance?.version}" />
											
				<fieldset class="paymentForm">
					<g:render template="paymentForm"/>
				</fieldset>
				<fieldset class="buttons">
					<g:actionSubmit class="save" action="updatePayment" value="${message(code: 'default.button.update.label', default: 'Update')}" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
