
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
					
						<g:sortableColumn property="quotationId" title="${message(code: 'quotation.orderId.label', default: 'Quotation Id')}" />
												
						<th><g:message code="quotation.customer.label" default="Customer" /></th>
						
						<g:sortableColumn property="cageLength" title="${message(code: 'quotation.cageLength.label', default: 'Cage Length')}" />
					
						<g:sortableColumn property="fulls" title="${message(code: 'quotation.fulls.label', default: 'Fulls')}" />
					
						<g:sortableColumn property="halfs" title="${message(code: 'quotation.halfs.label', default: 'Halfs')}" />
					
						<g:sortableColumn property="tiers" title="${message(code: 'quotation.tiers.label', default: 'Tiers')}" />
					
						<g:sortableColumn property="noOfCuttingsInShed" title="${message(code: 'quotation.noOfCuttingsInShed.label', default: 'No Of Cuttings In Shed')}" />
					
						<g:sortableColumn property="noOfSheds" title="${message(code: 'quotation.noOfSheds.label', default: 'No Of Sheds')}" />
						
						<g:sortableColumn property="status" title="${message(code: 'quotation.noOfSheds.label', default: 'Status')}" />
						
						<th><g:message code="quotation.action.label" default="Action" /></th>
						<%--<g:sortableColumn property="action" title="${message(code: 'quotation.noOfSheds.label', default: 'Action')}" />
					
					--%></tr>
				</thead>
				<tbody>
				<g:each in="${quotationInstanceList}" status="i" var="quotationInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link url ="http://localhost:8080/chakrap/quotation/quotation#/qid/${quotationInstance.id}" id="${quotationInstance.id}">${fieldValue(bean: quotationInstance, field: "quotationId")}</g:link></td>
						
						<td>${fieldValue(bean: quotationInstance, field: "customer")}</td>
						
						<td>${fieldValue(bean: quotationInstance, field: "cageLength")}</td>
					
						<td>${fieldValue(bean: quotationInstance, field: "fulls")}</td>
					
						<td>${fieldValue(bean: quotationInstance, field: "halfs")}</td>
					
						<td>${fieldValue(bean: quotationInstance, field: "tiers")}</td>
					
						<td>${fieldValue(bean: quotationInstance, field: "noOfCuttingsInShed")}</td>
					
						<td>${fieldValue(bean: quotationInstance, field: "noOfSheds")}</td>
						
						<td>${fieldValue(bean: quotationInstance, field: "status")}</td>
						
						<g:if test="${quotationInstance.status != 'CANCELLED'}">
						
						<td><sec:ifAllGranted roles="ROLE_ADMIN"><g:link action="cancelQuotation" params="["quotation":quotationInstance.id]">Cancel Quotation</g:link></sec:ifAllGranted></td>
						
						</g:if>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<ul>
			    <li><g:link class="create" controller="quotationPlanner" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			    <li><g:link action="search">Search Quotation</g:link></li>
			</ul>
			<div class="pagination">
				<g:paginate total="${quotationInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
