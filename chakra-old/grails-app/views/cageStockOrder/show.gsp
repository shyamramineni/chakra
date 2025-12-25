
<%@ page import="com.chakra.stock.CageStockOrder" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cageStockOrder.label', default: 'CageStockOrder')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-cageStockOrder" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-cageStockOrder" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list cageStockOrder">
			
				<g:if test="${cageStockOrderInstance?.comments}">
				<li class="fieldcontain">
					<span id="comments-label" class="property-label"><g:message code="cageStockOrder.comments.label" default="Comments" /></span>
					
						<span class="property-value" aria-labelledby="comments-label"><g:fieldValue bean="${cageStockOrderInstance}" field="comments"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${cageStockOrderInstance?.createdBy}">
				<li class="fieldcontain">
					<span id="createdBy-label" class="property-label"><g:message code="cageStockOrder.createdBy.label" default="Created By" /></span>
					
						<span class="property-value" aria-labelledby="createdBy-label"><g:link controller="user" action="show" id="${cageStockOrderInstance?.createdBy?.id}">${cageStockOrderInstance?.createdBy?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${cageStockOrderInstance?.createdDate}">
				<li class="fieldcontain">
					<span id="createdDate-label" class="property-label"><g:message code="cageStockOrder.createdDate.label" default="Created Date" /></span>
					
						<span class="property-value" aria-labelledby="createdDate-label"><g:formatDate date="${cageStockOrderInstance?.createdDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${cageStockOrderInstance?.lastEditedBy}">
				<li class="fieldcontain">
					<span id="lastEditedBy-label" class="property-label"><g:message code="cageStockOrder.lastEditedBy.label" default="Last Edited By" /></span>
					
						<span class="property-value" aria-labelledby="lastEditedBy-label"><g:link controller="user" action="show" id="${cageStockOrderInstance?.lastEditedBy?.id}">${cageStockOrderInstance?.lastEditedBy?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${cageStockOrderInstance?.lastEditedDate}">
				<li class="fieldcontain">
					<span id="lastEditedDate-label" class="property-label"><g:message code="cageStockOrder.lastEditedDate.label" default="Last Edited Date" /></span>
					
						<span class="property-value" aria-labelledby="lastEditedDate-label"><g:formatDate date="${cageStockOrderInstance?.lastEditedDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${cageStockOrderInstance?.cageStock}">
				<li class="fieldcontain">
					<span id="cageStock-label" class="property-label"><g:message code="cageStockOrder.cageStock.label" default="Cage Stock" /></span>
					
						<span class="property-value" aria-labelledby="cageStock-label"><g:link controller="cageStock" action="show" id="${cageStockOrderInstance?.cageStock?.id}">${cageStockOrderInstance?.cageStock?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${cageStockOrderInstance?.cageStockForOrder}">
				<li class="fieldcontain">
					<span id="cageStockForOrder-label" class="property-label"><g:message code="cageStockOrder.cageStockForOrder.label" default="Cage Stock For Order" /></span>
					
						<span class="property-value" aria-labelledby="cageStockForOrder-label"><g:fieldValue bean="${cageStockOrderInstance}" field="cageStockForOrder"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${cageStockOrderInstance?.cageStockOrderBlockTime}">
				<li class="fieldcontain">
					<span id="cageStockOrderBlockTime-label" class="property-label"><g:message code="cageStockOrder.cageStockOrderBlockTime.label" default="Cage Stock Order Block Time" /></span>
					
						<span class="property-value" aria-labelledby="cageStockOrderBlockTime-label"><g:formatDate date="${cageStockOrderInstance?.cageStockOrderBlockTime}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${cageStockOrderInstance?.corder}">
				<li class="fieldcontain">
					<span id="corder-label" class="property-label"><g:message code="cageStockOrder.corder.label" default="Corder" /></span>
					
						<span class="property-value" aria-labelledby="corder-label"><g:link controller="corder" action="show" id="${cageStockOrderInstance?.corder?.id}">${cageStockOrderInstance?.corder?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${cageStockOrderInstance?.id}" />
					<g:link class="edit" action="edit" id="${cageStockOrderInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
