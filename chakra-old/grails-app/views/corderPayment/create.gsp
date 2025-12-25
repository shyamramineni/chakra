<%@ page import="com.chakra.order.CorderPayment" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'corderPayment.label', default: 'CorderPayment')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
		<%--<a href="#create-corderPayment" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		--%><div class="nav" role="navigation">
			<%--
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				--%><li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>

		</div>
		<div id="create-corderPayment" class="content scaffold-create" role="main">
			<h1><g:message code="default.create.label" args="[entityName]" /></h1>
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
			<g:form action="save" >
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<sec:ifAllGranted roles="ROLE_ADMIN"><g:submitButton name="create" class="btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" /></sec:ifAllGranted>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
