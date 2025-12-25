
<%@ page import="com.chakra.quotation.QuotationModel" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quotationModel.label', default: 'QuotationModel')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-quotationModel" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-quotationModel" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list quotationModel">
			
				<g:if test="${quotationModelInstance?.cageDesign}">
				<li class="fieldcontain">
					<span id="cageDesign-label" class="property-label"><g:message code="quotationModel.cageDesign.label" default="Cage Design" /></span>
					
						<span class="property-value" aria-labelledby="cageDesign-label"><g:link controller="cageDesign" action="show" id="${quotationModelInstance?.cageDesign?.id}">${quotationModelInstance?.cageDesign?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationModelInstance?.quotationMeshModel}">
				<li class="fieldcontain">
					<span id="quotationMeshModel-label" class="property-label"><g:message code="quotationModel.quotationMeshModel.label" default="Quotation Mesh Model" /></span>
					
						<span class="property-value" aria-labelledby="quotationMeshModel-label"><g:link controller="quotationMeshModel" action="show" id="${quotationModelInstance?.quotationMeshModel?.id}">${quotationModelInstance?.quotationMeshModel?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationModelInstance?.quotationCageParts}">
				<li class="fieldcontain">
					<span id="quotationCageParts-label" class="property-label"><g:message code="quotationModel.quotationCageParts.label" default="Quotation Cage Parts" /></span>
					
						<g:each in="${quotationModelInstance.quotationCageParts}" var="q">
						<span class="property-value" aria-labelledby="quotationCageParts-label"><g:link controller="quotationCagePart" action="show" id="${q.id}">${q?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${quotationModelInstance?.noOfBirds}">
				<li class="fieldcontain">
					<span id="noOfBirds-label" class="property-label"><g:message code="quotationModel.noOfBirds.label" default="No Of Birds" /></span>
					
						<span class="property-value" aria-labelledby="noOfBirds-label"><g:fieldValue bean="${quotationModelInstance}" field="noOfBirds"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationModelInstance?.cost}">
				<li class="fieldcontain">
					<span id="cost-label" class="property-label"><g:message code="quotationModel.cost.label" default="Cost" /></span>
					
						<span class="property-value" aria-labelledby="cost-label"><g:fieldValue bean="${quotationModelInstance}" field="cost"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationModelInstance?.tax}">
				<li class="fieldcontain">
					<span id="tax-label" class="property-label"><g:message code="quotationModel.tax.label" default="Tax" /></span>
					
						<span class="property-value" aria-labelledby="tax-label"><g:fieldValue bean="${quotationModelInstance}" field="tax"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationModelInstance?.totalCost}">
				<li class="fieldcontain">
					<span id="totalCost-label" class="property-label"><g:message code="quotationModel.totalCost.label" default="Total Cost" /></span>
					
						<span class="property-value" aria-labelledby="totalCost-label"><g:fieldValue bean="${quotationModelInstance}" field="totalCost"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationModelInstance?.taxation}">
				<li class="fieldcontain">
					<span id="taxation-label" class="property-label"><g:message code="quotationModel.taxation.label" default="Taxation" /></span>
					
						<span class="property-value" aria-labelledby="taxation-label"><g:link controller="taxation" action="show" id="${quotationModelInstance?.taxation?.id}">${quotationModelInstance?.taxation?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${quotationModelInstance?.id}" />
					<g:link class="edit" action="edit" id="${quotationModelInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
