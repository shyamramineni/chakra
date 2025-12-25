
<%@ page import="com.chakra.quotation.Quotation" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quotation.label', default: 'Quotation')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-quotation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
				<li><g:link action="search">Search</g:link></li>
			</ul>
		</div>
		<div id="list-quotation" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
					
						<g:sortableColumn property="cageLength" title="${message(code: 'quotation.cageLength.label', default: 'Cage Length')}" />
					
						<th><g:message code="quotation.createdBy.label" default="Created By" /></th>
					
						<g:sortableColumn property="createdDate" title="${message(code: 'quotation.createdDate.label', default: 'Created Date')}" />
					
						<th><g:message code="quotation.customer.label" default="Customer" /></th>
					
						<g:sortableColumn property="fulls" title="${message(code: 'quotation.fulls.label', default: 'Fulls')}" />
					
						<g:sortableColumn property="halfs" title="${message(code: 'quotation.halfs.label', default: 'Halfs')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${quotationInstanceList}" status="i" var="quotationInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${quotationInstance.id}">${fieldValue(bean: quotationInstance, field: "cageLength")}</g:link></td>
					
						<td>${fieldValue(bean: quotationInstance, field: "createdBy")}</td>
					
						<td><g:formatDate date="${quotationInstance.createdDate}" /></td>
					
						<td>${fieldValue(bean: quotationInstance, field: "customer")}</td>
					
						<td>${fieldValue(bean: quotationInstance, field: "fulls")}</td>
					
						<td>${fieldValue(bean: quotationInstance, field: "halfs")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${quotationInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
