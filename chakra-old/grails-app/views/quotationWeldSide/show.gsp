
<%@ page import="com.chakra.quotation.QuotationWeldSide" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quotationWeldSide.label', default: 'QuotationWeldSide')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-quotationWeldSide" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-quotationWeldSide" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list quotationWeldSide">
			
				<g:if test="${quotationWeldSideInstance?.sideMesh}">
				<li class="fieldcontain">
					<span id="sideMesh-label" class="property-label"><g:message code="quotationWeldSide.sideMesh.label" default="Side Mesh" /></span>
					
						<span class="property-value" aria-labelledby="sideMesh-label"><g:link controller="sideMesh" action="show" id="${quotationWeldSideInstance?.sideMesh?.id}">${quotationWeldSideInstance?.sideMesh?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationWeldSideInstance?.wireBrand}">
				<li class="fieldcontain">
					<span id="wireBrand-label" class="property-label"><g:message code="quotationWeldSide.wireBrand.label" default="Wire Brand" /></span>
					
						<span class="property-value" aria-labelledby="wireBrand-label"><g:link controller="wireBrand" action="show" id="${quotationWeldSideInstance?.wireBrand?.id}">${quotationWeldSideInstance?.wireBrand?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationWeldSideInstance?.length}">
				<li class="fieldcontain">
					<span id="length-label" class="property-label"><g:message code="quotationWeldSide.length.label" default="Length" /></span>
					
						<span class="property-value" aria-labelledby="length-label"><g:fieldValue bean="${quotationWeldSideInstance}" field="length"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationWeldSideInstance?.height}">
				<li class="fieldcontain">
					<span id="height-label" class="property-label"><g:message code="quotationWeldSide.height.label" default="Height" /></span>
					
						<span class="property-value" aria-labelledby="height-label"><g:fieldValue bean="${quotationWeldSideInstance}" field="height"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationWeldSideInstance?.noOfPieces}">
				<li class="fieldcontain">
					<span id="noOfPieces-label" class="property-label"><g:message code="quotationWeldSide.noOfPieces.label" default="No Of Pieces" /></span>
					
						<span class="property-value" aria-labelledby="noOfPieces-label"><g:fieldValue bean="${quotationWeldSideInstance}" field="noOfPieces"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationWeldSideInstance?.squareFeets}">
				<li class="fieldcontain">
					<span id="squareFeets-label" class="property-label"><g:message code="quotationWeldSide.squareFeets.label" default="Square Feets" /></span>
					
						<span class="property-value" aria-labelledby="squareFeets-label"><g:fieldValue bean="${quotationWeldSideInstance}" field="squareFeets"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationWeldSideInstance?.pricePerSqFt}">
				<li class="fieldcontain">
					<span id="pricePerSqFt-label" class="property-label"><g:message code="quotationWeldSide.pricePerSqFt.label" default="Price Per Sq Ft" /></span>
					
						<span class="property-value" aria-labelledby="pricePerSqFt-label"><g:fieldValue bean="${quotationWeldSideInstance}" field="pricePerSqFt"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationWeldSideInstance?.weldSideItemCost}">
				<li class="fieldcontain">
					<span id="weldSideItemCost-label" class="property-label"><g:message code="quotationWeldSide.weldSideItemCost.label" default="Weld Side Item Cost" /></span>
					
						<span class="property-value" aria-labelledby="weldSideItemCost-label"><g:fieldValue bean="${quotationWeldSideInstance}" field="weldSideItemCost"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationWeldSideInstance?.createdBy}">
				<li class="fieldcontain">
					<span id="createdBy-label" class="property-label"><g:message code="quotationWeldSide.createdBy.label" default="Created By" /></span>
					
						<span class="property-value" aria-labelledby="createdBy-label"><g:fieldValue bean="${quotationWeldSideInstance}" field="createdBy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationWeldSideInstance?.createdDate}">
				<li class="fieldcontain">
					<span id="createdDate-label" class="property-label"><g:message code="quotationWeldSide.createdDate.label" default="Created Date" /></span>
					
						<span class="property-value" aria-labelledby="createdDate-label"><g:formatDate date="${quotationWeldSideInstance?.createdDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationWeldSideInstance?.lastEditedBy}">
				<li class="fieldcontain">
					<span id="lastEditedBy-label" class="property-label"><g:message code="quotationWeldSide.lastEditedBy.label" default="Last Edited By" /></span>
					
						<span class="property-value" aria-labelledby="lastEditedBy-label"><g:fieldValue bean="${quotationWeldSideInstance}" field="lastEditedBy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationWeldSideInstance?.editedDate}">
				<li class="fieldcontain">
					<span id="editedDate-label" class="property-label"><g:message code="quotationWeldSide.editedDate.label" default="Edited Date" /></span>
					
						<span class="property-value" aria-labelledby="editedDate-label"><g:formatDate date="${quotationWeldSideInstance?.editedDate}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${quotationWeldSideInstance?.id}" />
					<g:link class="edit" action="edit" id="${quotationWeldSideInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
