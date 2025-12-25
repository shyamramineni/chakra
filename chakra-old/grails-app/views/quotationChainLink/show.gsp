
<%@ page import="com.chakra.quotation.QuotationChainLink" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quotationChainLink.label', default: 'QuotationChainLink')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-quotationChainLink" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-quotationChainLink" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list quotationChainLink">
			
				<g:if test="${quotationChainLinkInstance?.linkMesh}">
				<li class="fieldcontain">
					<span id="linkMesh-label" class="property-label"><g:message code="quotationChainLink.linkMesh.label" default="Link Mesh" /></span>
					
						<span class="property-value" aria-labelledby="linkMesh-label"><g:link controller="linkMesh" action="show" id="${quotationChainLinkInstance?.linkMesh?.id}">${quotationChainLinkInstance?.linkMesh?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationChainLinkInstance?.wireBrand}">
				<li class="fieldcontain">
					<span id="wireBrand-label" class="property-label"><g:message code="quotationChainLink.wireBrand.label" default="Wire Brand" /></span>
					
						<span class="property-value" aria-labelledby="wireBrand-label"><g:link controller="wireBrand" action="show" id="${quotationChainLinkInstance?.wireBrand?.id}">${quotationChainLinkInstance?.wireBrand?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationChainLinkInstance?.length}">
				<li class="fieldcontain">
					<span id="length-label" class="property-label"><g:message code="quotationChainLink.length.label" default="Length" /></span>
					
						<span class="property-value" aria-labelledby="length-label"><g:fieldValue bean="${quotationChainLinkInstance}" field="length"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationChainLinkInstance?.height}">
				<li class="fieldcontain">
					<span id="height-label" class="property-label"><g:message code="quotationChainLink.height.label" default="Height" /></span>
					
						<span class="property-value" aria-labelledby="height-label"><g:fieldValue bean="${quotationChainLinkInstance}" field="height"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationChainLinkInstance?.noOfPieces}">
				<li class="fieldcontain">
					<span id="noOfPieces-label" class="property-label"><g:message code="quotationChainLink.noOfPieces.label" default="No Of Pieces" /></span>
					
						<span class="property-value" aria-labelledby="noOfPieces-label"><g:fieldValue bean="${quotationChainLinkInstance}" field="noOfPieces"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationChainLinkInstance?.squareFeets}">
				<li class="fieldcontain">
					<span id="squareFeets-label" class="property-label"><g:message code="quotationChainLink.squareFeets.label" default="Square Feets" /></span>
					
						<span class="property-value" aria-labelledby="squareFeets-label"><g:fieldValue bean="${quotationChainLinkInstance}" field="squareFeets"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationChainLinkInstance?.pricePerSqFt}">
				<li class="fieldcontain">
					<span id="pricePerSqFt-label" class="property-label"><g:message code="quotationChainLink.pricePerSqFt.label" default="Price Per Sq Ft" /></span>
					
						<span class="property-value" aria-labelledby="pricePerSqFt-label"><g:fieldValue bean="${quotationChainLinkInstance}" field="pricePerSqFt"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationChainLinkInstance?.createdBy}">
				<li class="fieldcontain">
					<span id="createdBy-label" class="property-label"><g:message code="quotationChainLink.createdBy.label" default="Created By" /></span>
					
						<span class="property-value" aria-labelledby="createdBy-label"><g:fieldValue bean="${quotationChainLinkInstance}" field="createdBy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationChainLinkInstance?.createdDate}">
				<li class="fieldcontain">
					<span id="createdDate-label" class="property-label"><g:message code="quotationChainLink.createdDate.label" default="Created Date" /></span>
					
						<span class="property-value" aria-labelledby="createdDate-label"><g:formatDate date="${quotationChainLinkInstance?.createdDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationChainLinkInstance?.editedDate}">
				<li class="fieldcontain">
					<span id="editedDate-label" class="property-label"><g:message code="quotationChainLink.editedDate.label" default="Edited Date" /></span>
					
						<span class="property-value" aria-labelledby="editedDate-label"><g:formatDate date="${quotationChainLinkInstance?.editedDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationChainLinkInstance?.lastEditedBy}">
				<li class="fieldcontain">
					<span id="lastEditedBy-label" class="property-label"><g:message code="quotationChainLink.lastEditedBy.label" default="Last Edited By" /></span>
					
						<span class="property-value" aria-labelledby="lastEditedBy-label"><g:fieldValue bean="${quotationChainLinkInstance}" field="lastEditedBy"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${quotationChainLinkInstance?.id}" />
					<g:link class="edit" action="edit" id="${quotationChainLinkInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
