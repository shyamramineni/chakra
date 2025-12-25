
<%@ page import="com.chakra.quotation.QuotationMeshModel" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quotationMeshModel.label', default: 'QuotationMeshModel')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-quotationMeshModel" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-quotationMeshModel" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list quotationMeshModel">
			
				<g:if test="${quotationMeshModelInstance?.cageDesign}">
				<li class="fieldcontain">
					<span id="cageDesign-label" class="property-label"><g:message code="quotationMeshModel.cageDesign.label" default="Cage Design" /></span>
					
						<span class="property-value" aria-labelledby="cageDesign-label"><g:link controller="cageDesign" action="show" id="${quotationMeshModelInstance?.cageDesign?.id}">${quotationMeshModelInstance?.cageDesign?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationMeshModelInstance?.wireBrand}">
				<li class="fieldcontain">
					<span id="wireBrand-label" class="property-label"><g:message code="quotationMeshModel.wireBrand.label" default="Wire Brand" /></span>
					
						<span class="property-value" aria-labelledby="wireBrand-label"><g:link controller="wireBrand" action="show" id="${quotationMeshModelInstance?.wireBrand?.id}">${quotationMeshModelInstance?.wireBrand?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationMeshModelInstance?.doubleBox}">
				<li class="fieldcontain">
					<span id="doubleBox-label" class="property-label"><g:message code="quotationMeshModel.doubleBox.label" default="Double Box" /></span>
					
						<span class="property-value" aria-labelledby="doubleBox-label"><g:fieldValue bean="${quotationMeshModelInstance}" field="doubleBox"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationMeshModelInstance?.singleBox}">
				<li class="fieldcontain">
					<span id="singleBox-label" class="property-label"><g:message code="quotationMeshModel.singleBox.label" default="Single Box" /></span>
					
						<span class="property-value" aria-labelledby="singleBox-label"><g:fieldValue bean="${quotationMeshModelInstance}" field="singleBox"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationMeshModelInstance?.costPerBird}">
				<li class="fieldcontain">
					<span id="costPerBird-label" class="property-label"><g:message code="quotationMeshModel.costPerBird.label" default="Cost Per Bird" /></span>
					
						<span class="property-value" aria-labelledby="costPerBird-label"><g:fieldValue bean="${quotationMeshModelInstance}" field="costPerBird"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationMeshModelInstance?.noOfBirds}">
				<li class="fieldcontain">
					<span id="noOfBirds-label" class="property-label"><g:message code="quotationMeshModel.noOfBirds.label" default="No Of Birds" /></span>
					
						<span class="property-value" aria-labelledby="noOfBirds-label"><g:fieldValue bean="${quotationMeshModelInstance}" field="noOfBirds"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationMeshModelInstance?.meshCost}">
				<li class="fieldcontain">
					<span id="meshCost-label" class="property-label"><g:message code="quotationMeshModel.meshCost.label" default="Mesh Cost" /></span>
					
						<span class="property-value" aria-labelledby="meshCost-label"><g:fieldValue bean="${quotationMeshModelInstance}" field="meshCost"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationMeshModelInstance?.quotationMeshParts}">
				<li class="fieldcontain">
					<span id="quotationMeshParts-label" class="property-label"><g:message code="quotationMeshModel.quotationMeshParts.label" default="Quotation Mesh Parts" /></span>
					
						<g:each in="${quotationMeshModelInstance.quotationMeshParts}" var="q">
						<span class="property-value" aria-labelledby="quotationMeshParts-label"><g:link controller="quotationMeshPart" action="show" id="${q.id}">${q?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${quotationMeshModelInstance?.id}" />
					<g:link class="edit" action="edit" id="${quotationMeshModelInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
