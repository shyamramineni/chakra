
<%@ page import="com.chakra.stock.StockOrder" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'stockOrder.label', default: 'StockOrder')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-stockOrder" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-stockOrder" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list stockOrder">
			
				<g:if test="${stockOrderInstance?.corder}">
				<li class="fieldcontain">
					<span id="corder-label" class="property-label"><g:message code="stockOrder.corder.label" default="Corder" /></span>
					
						<span class="property-value" aria-labelledby="corder-label"><g:link controller="corder" action="show" id="${stockOrderInstance?.corder?.id}">${stockOrderInstance?.corder?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${stockOrderInstance?.createdBy}">
				<li class="fieldcontain">
					<span id="createdBy-label" class="property-label"><g:message code="stockOrder.createdBy.label" default="Created By" /></span>
					
						<span class="property-value" aria-labelledby="createdBy-label"><g:link controller="user" action="show" id="${stockOrderInstance?.createdBy?.id}">${stockOrderInstance?.createdBy?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${stockOrderInstance?.createdDate}">
				<li class="fieldcontain">
					<span id="createdDate-label" class="property-label"><g:message code="stockOrder.createdDate.label" default="Created Date" /></span>
					
						<span class="property-value" aria-labelledby="createdDate-label"><g:formatDate date="${stockOrderInstance?.createdDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${stockOrderInstance?.lastEditedBy}">
				<li class="fieldcontain">
					<span id="lastEditedBy-label" class="property-label"><g:message code="stockOrder.lastEditedBy.label" default="Last Edited By" /></span>
					
						<span class="property-value" aria-labelledby="lastEditedBy-label"><g:link controller="user" action="show" id="${stockOrderInstance?.lastEditedBy?.id}">${stockOrderInstance?.lastEditedBy?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${stockOrderInstance?.lastEditedDate}">
				<li class="fieldcontain">
					<span id="lastEditedDate-label" class="property-label"><g:message code="stockOrder.lastEditedDate.label" default="Last Edited Date" /></span>
					
						<span class="property-value" aria-labelledby="lastEditedDate-label"><g:formatDate date="${stockOrderInstance?.lastEditedDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${stockOrderInstance?.stock}">
				<li class="fieldcontain">
					<span id="stock-label" class="property-label"><g:message code="stockOrder.stock.label" default="Stock" /></span>
					
						<span class="property-value" aria-labelledby="stock-label"><g:link controller="stock" action="show" id="${stockOrderInstance?.stock?.id}">${stockOrderInstance?.stock?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${stockOrderInstance?.stockForOrder}">
				<li class="fieldcontain">
					<span id="stockForOrder-label" class="property-label"><g:message code="stockOrder.stockForOrder.label" default="Stock For Order" /></span>
					
						<span class="property-value" aria-labelledby="stockForOrder-label"><g:fieldValue bean="${stockOrderInstance}" field="stockForOrder"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${stockOrderInstance?.stockOrderBlockTime}">
				<li class="fieldcontain">
					<span id="stockOrderBlockTime-label" class="property-label"><g:message code="stockOrder.stockOrderBlockTime.label" default="Stock Order Block Time" /></span>
					
						<span class="property-value" aria-labelledby="stockOrderBlockTime-label"><g:formatDate date="${stockOrderInstance?.stockOrderBlockTime}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${stockOrderInstance?.id}" />
					<sec:ifAllGranted roles="ROLE_ADMIN,ROLE_PRODMANAGER"><g:link class="edit" action="edit" id="${stockOrderInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link></sec:ifAllGranted>
					<sec:ifAllGranted roles="ROLE_ADMIN,ROLE_PRODMANAGER"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></sec:ifAllGranted>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
