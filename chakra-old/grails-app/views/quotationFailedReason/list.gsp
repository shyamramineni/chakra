
<%@ page import="com.chakra.config.QuotationFailedReason" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quotationFailedReason.label', default: 'QuotationFailedReason')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-quotationFailedReason" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-quotationFailedReason" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
					
						<g:sortableColumn property="quotationFailedReason" title="${message(code: 'quotationFailedReason.quotationFailedReason.label', default: 'Quotation Failed Reason')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'quotationFailedReason.description.label', default: 'Description')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${quotationFailedReasonInstanceList}" status="i" var="quotationFailedReasonInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${quotationFailedReasonInstance.id}">${fieldValue(bean: quotationFailedReasonInstance, field: "quotationFailedReason")}</g:link></td>
					
						<td>${fieldValue(bean: quotationFailedReasonInstance, field: "description")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<ul>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
			<div class="pagination">
				<g:paginate total="${quotationFailedReasonInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
