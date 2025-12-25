<%@ page import="com.chakra.notifications.Notification" %>



<div class="fieldcontain ${hasErrors(bean: notificationInstance, field: 'notifDisplay', 'error')} ">
	<label for="notifDisplay">
		<g:message code="notification.notifDisplay.label" default="Notif Display" />
		
	</label>
	<g:checkBox name="notifDisplay" value="${notificationInstance?.notifDisplay}" />
</div>

<div class="fieldcontain ${hasErrors(bean: notificationInstance, field: 'notifMsg', 'error')} ">
	<label for="notifMsg">
		<g:message code="notification.notifMsg.label" default="Notif Msg" />
		
	</label>
	<g:textField name="notifMsg" value="${notificationInstance?.notifMsg}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: notificationInstance, field: 'notifUrl', 'error')} ">
	<label for="notifUrl">
		<g:message code="notification.notifUrl.label" default="Notif Url" />
		
	</label>
	<g:textField name="notifUrl" value="${notificationInstance?.notifUrl}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: notificationInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="notification.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="user" name="user.id" from="${com.chakra.security.User.list()}" optionKey="id" required="" value="${notificationInstance?.user?.id}" class="many-to-one"/>
</div>

