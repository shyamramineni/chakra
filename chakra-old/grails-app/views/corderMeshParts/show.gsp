
<%@ page import="com.chakra.order.CorderMeshParts" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'orderMeshParts.label', default: 'OrderMeshParts')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-orderMeshParts" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-orderMeshParts" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list orderMeshParts">
			
				<g:if test="${orderMeshPartsInstance?.sheetSpecification}">
				<li class="fieldcontain">
					<span id="sheetSpecification-label" class="property-label"><g:message code="orderMeshParts.sheetSpecification.label" default="Sheet Specification" /></span>
					
						<span class="property-value" aria-labelledby="sheetSpecification-label"><g:link controller="sheetSpecification" action="show" id="${orderMeshPartsInstance?.sheetSpecification?.id}">${orderMeshPartsInstance?.sheetSpecification?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${orderMeshPartsInstance?.wireBrand}">
				<li class="fieldcontain">
					<span id="wireBrand-label" class="property-label"><g:message code="orderMeshParts.wireBrand.label" default="Wire Brand" /></span>
					
						<span class="property-value" aria-labelledby="wireBrand-label"><g:link controller="wireBrand" action="show" id="${orderMeshPartsInstance?.wireBrand?.id}">${orderMeshPartsInstance?.wireBrand?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${orderMeshPartsInstance?.createdBy}">
				<li class="fieldcontain">
					<span id="createdBy-label" class="property-label"><g:message code="orderMeshParts.createdBy.label" default="Created By" /></span>
					
						<span class="property-value" aria-labelledby="createdBy-label"><g:fieldValue bean="${orderMeshPartsInstance}" field="createdBy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${orderMeshPartsInstance?.createdDate}">
				<li class="fieldcontain">
					<span id="createdDate-label" class="property-label"><g:message code="orderMeshParts.createdDate.label" default="Created Date" /></span>
					
						<span class="property-value" aria-labelledby="createdDate-label"><g:formatDate date="${orderMeshPartsInstance?.createdDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${orderMeshPartsInstance?.lastEditedBy}">
				<li class="fieldcontain">
					<span id="lastEditedBy-label" class="property-label"><g:message code="orderMeshParts.lastEditedBy.label" default="Last Edited By" /></span>
					
						<span class="property-value" aria-labelledby="lastEditedBy-label"><g:fieldValue bean="${orderMeshPartsInstance}" field="lastEditedBy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${orderMeshPartsInstance?.editedDate}">
				<li class="fieldcontain">
					<span id="editedDate-label" class="property-label"><g:message code="orderMeshParts.editedDate.label" default="Edited Date" /></span>
					
						<span class="property-value" aria-labelledby="editedDate-label"><g:formatDate date="${orderMeshPartsInstance?.editedDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${orderMeshPartsInstance?.corder}">
				<li class="fieldcontain">
					<span id="corder-label" class="property-label"><g:message code="orderMeshParts.corder.label" default="Corder" /></span>
					
						<span class="property-value" aria-labelledby="corder-label"><g:link controller="corder" action="show" id="${orderMeshPartsInstance?.corder?.id}">${orderMeshPartsInstance?.corder?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${orderMeshPartsInstance?.noOfMeshParts}">
				<li class="fieldcontain">
					<span id="noOfMeshParts-label" class="property-label"><g:message code="orderMeshParts.noOfMeshParts.label" default="No Of Mesh Parts" /></span>
					
						<span class="property-value" aria-labelledby="noOfMeshParts-label"><g:fieldValue bean="${orderMeshPartsInstance}" field="noOfMeshParts"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${orderMeshPartsInstance?.id}" />
					<sec:ifAllGranted roles="ROLE_ADMIN"><g:link class="edit" action="edit" id="${orderMeshPartsInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link></sec:ifAllGranted>
					<sec:ifAllGranted roles="ROLE_ADMIN"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></sec:ifAllGranted>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
