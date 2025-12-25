
<%@ page import="com.chakra.quotation.QuotationMeshPart" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quotationMeshPart.label', default: 'QuotationMeshPart')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-quotationMeshPart" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-quotationMeshPart" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list quotationMeshPart">
			
				<g:if test="${quotationMeshPartInstance?.sheetSpecification}">
				<li class="fieldcontain">
					<span id="sheetSpecification-label" class="property-label"><g:message code="quotationMeshPart.sheetSpecification.label" default="Sheet Specification" /></span>
					
						<span class="property-value" aria-labelledby="sheetSpecification-label"><g:link controller="sheetSpecification" action="show" id="${quotationMeshPartInstance?.sheetSpecification?.id}">${quotationMeshPartInstance?.sheetSpecification?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationMeshPartInstance?.wireBrand}">
				<li class="fieldcontain">
					<span id="wireBrand-label" class="property-label"><g:message code="quotationMeshPart.wireBrand.label" default="Wire Brand" /></span>
					
						<span class="property-value" aria-labelledby="wireBrand-label"><g:link controller="wireBrand" action="show" id="${quotationMeshPartInstance?.wireBrand?.id}">${quotationMeshPartInstance?.wireBrand?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationMeshPartInstance?.noOfMeshParts}">
				<li class="fieldcontain">
					<span id="noOfMeshParts-label" class="property-label"><g:message code="quotationMeshPart.noOfMeshParts.label" default="No Of Mesh Parts" /></span>
					
						<span class="property-value" aria-labelledby="noOfMeshParts-label"><g:fieldValue bean="${quotationMeshPartInstance}" field="noOfMeshParts"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationMeshPartInstance?.wirePrice}">
				<li class="fieldcontain">
					<span id="wirePrice-label" class="property-label"><g:message code="quotationMeshPart.wirePrice.label" default="Wire Price" /></span>
					
						<span class="property-value" aria-labelledby="wirePrice-label"><g:fieldValue bean="${quotationMeshPartInstance}" field="wirePrice"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationMeshPartInstance?.createdBy}">
				<li class="fieldcontain">
					<span id="createdBy-label" class="property-label"><g:message code="quotationMeshPart.createdBy.label" default="Created By" /></span>
					
						<span class="property-value" aria-labelledby="createdBy-label"><g:fieldValue bean="${quotationMeshPartInstance}" field="createdBy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationMeshPartInstance?.createdDate}">
				<li class="fieldcontain">
					<span id="createdDate-label" class="property-label"><g:message code="quotationMeshPart.createdDate.label" default="Created Date" /></span>
					
						<span class="property-value" aria-labelledby="createdDate-label"><g:formatDate date="${quotationMeshPartInstance?.createdDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationMeshPartInstance?.lastEditedBy}">
				<li class="fieldcontain">
					<span id="lastEditedBy-label" class="property-label"><g:message code="quotationMeshPart.lastEditedBy.label" default="Last Edited By" /></span>
					
						<span class="property-value" aria-labelledby="lastEditedBy-label"><g:fieldValue bean="${quotationMeshPartInstance}" field="lastEditedBy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationMeshPartInstance?.editedDate}">
				<li class="fieldcontain">
					<span id="editedDate-label" class="property-label"><g:message code="quotationMeshPart.editedDate.label" default="Edited Date" /></span>
					
						<span class="property-value" aria-labelledby="editedDate-label"><g:formatDate date="${quotationMeshPartInstance?.editedDate}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${quotationMeshPartInstance?.id}" />
					<sec:ifAllGranted roles="ROLE_ADMIN,ROLES_SALES"><g:link class="edit" action="edit" id="${quotationMeshPartInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link></sec:ifAllGranted>
					<sec:ifAllGranted roles="ROLE_ADMIN"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></sec:ifAllGranted>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
