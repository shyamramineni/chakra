
<%@ page import="com.chakra.notifications.Notification" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'notification.label', default: 'Notification')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-notification" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-notification" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="notifDisplay" title="${message(code: 'notification.notifDisplay.label', default: 'Notif Display')}" />
					
						<g:sortableColumn property="notifMsg" title="${message(code: 'notification.notifMsg.label', default: 'Notif Msg')}" />
					
						<g:sortableColumn property="notifUrl" title="${message(code: 'notification.notifUrl.label', default: 'Notif Url')}" />
					
						<th><g:message code="notification.user.label" default="User" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${notificationInstanceList}" status="i" var="notificationInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${notificationInstance.id}">${fieldValue(bean: notificationInstance, field: "notifDisplay")}</g:link></td>
					
						<td>${fieldValue(bean: notificationInstance, field: "notifMsg")}</td>
					
						<td>${fieldValue(bean: notificationInstance, field: "notifUrl")}</td>
					
						<td>${fieldValue(bean: notificationInstance, field: "user")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${notificationInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
