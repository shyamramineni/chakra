
<%@ page import="com.chakra.notifications.Notification" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'notification.label', default: 'Notification')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-notification" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-notification" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list notification">
			
				<g:if test="${notificationInstance?.notifDisplay}">
				<li class="fieldcontain">
					<span id="notifDisplay-label" class="property-label"><g:message code="notification.notifDisplay.label" default="Notif Display" /></span>
					
						<span class="property-value" aria-labelledby="notifDisplay-label"><g:formatBoolean boolean="${notificationInstance?.notifDisplay}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${notificationInstance?.notifMsg}">
				<li class="fieldcontain">
					<span id="notifMsg-label" class="property-label"><g:message code="notification.notifMsg.label" default="Notif Msg" /></span>
					
						<span class="property-value" aria-labelledby="notifMsg-label"><g:fieldValue bean="${notificationInstance}" field="notifMsg"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${notificationInstance?.notifUrl}">
				<li class="fieldcontain">
					<span id="notifUrl-label" class="property-label"><g:message code="notification.notifUrl.label" default="Notif Url" /></span>
					
						<span class="property-value" aria-labelledby="notifUrl-label"><g:fieldValue bean="${notificationInstance}" field="notifUrl"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${notificationInstance?.user}">
				<li class="fieldcontain">
					<span id="user-label" class="property-label"><g:message code="notification.user.label" default="User" /></span>
					
						<span class="property-value" aria-labelledby="user-label"><g:link controller="user" action="show" id="${notificationInstance?.user?.id}">${notificationInstance?.user?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${notificationInstance?.id}" />
					<g:link class="edit" action="edit" id="${notificationInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
