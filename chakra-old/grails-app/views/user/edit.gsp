<%@ page import="com.chakra.security.User" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#edit-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="edit-user" class="content scaffold-edit" role="main">
			<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${userInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${userInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form method="post" >
				<g:hiddenField name="id" value="${userInstance?.id}" />
				<g:hiddenField name="version" value="${userInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
					<g:each var="entry" in="${roleMap}">
						<div class="help-block">
							<g:checkBox name="${entry.key.authority}" value="${entry.value}"/>
							<g:link controller='role' action='edit' id='${entry.key.id}'>${entry.key.authority.encodeAsHTML()}</g:link>
						</div>
				</g:each>
				</fieldset>
				<div
					class="fieldcontain ${hasErrors(bean: enquiryInstance, field: 'cagePartTypeList', 'error')} ">
					<label for="cagePartTypeList"> <g:message
							code="enquiry.cagePartTypeList.label"
							default="Cage Part Type List" />

					</label>
					<g:select name="cagePartTypeList"
						from="${com.chakra.config.CagePartType.list()}"
						multiple="multiple" optionKey="id" size="5"
						value="${enquiryInstance?.cagePartTypeList*.id}"
						class="many-to-many" />
				</div>
				<fieldset class="buttons">
					<sec:ifAllGranted roles="ROLE_ADMIN"><g:actionSubmit class="btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></sec:ifAllGranted>
					<sec:ifAllGranted roles="ROLE_ADMIN"><g:actionSubmit class="btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" formnovalidate="" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></sec:ifAllGranted>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
