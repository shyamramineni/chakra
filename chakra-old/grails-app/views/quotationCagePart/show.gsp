
<%@ page import="com.chakra.quotation.QuotationCagePart" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quotationCagePart.label', default: 'QuotationCagePart')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-quotationCagePart" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-quotationCagePart" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list quotationCagePart">
			
				<g:if test="${quotationCagePartInstance?.cagePartSpecFormula}">
				<li class="fieldcontain">
					<span id="cagePartSpecFormula-label" class="property-label"><g:message code="quotationCagePart.cagePartSpecFormula.label" default="Cage Part Spec Formula" /></span>
					
						<span class="property-value" aria-labelledby="cagePartSpecFormula-label"><g:link controller="cagePartSpecFormula" action="show" id="${quotationCagePartInstance?.cagePartSpecFormula?.id}">${quotationCagePartInstance?.cagePartSpecFormula?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationCagePartInstance?.costOfCagePart}">
				<li class="fieldcontain">
					<span id="costOfCagePart-label" class="property-label"><g:message code="quotationCagePart.costOfCagePart.label" default="Cost Of Cage Part" /></span>
					
						<span class="property-value" aria-labelledby="costOfCagePart-label"><g:fieldValue bean="${quotationCagePartInstance}" field="costOfCagePart"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationCagePartInstance?.noOfCageParts}">
				<li class="fieldcontain">
					<span id="noOfCageParts-label" class="property-label"><g:message code="quotationCagePart.noOfCageParts.label" default="No Of Cage Parts" /></span>
					
						<span class="property-value" aria-labelledby="noOfCageParts-label"><g:fieldValue bean="${quotationCagePartInstance}" field="noOfCageParts"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationCagePartInstance?.priceOfEachCagePart}">
				<li class="fieldcontain">
					<span id="priceOfEachCagePart-label" class="property-label"><g:message code="quotationCagePart.priceOfEachCagePart.label" default="Price Of Each Cage Part" /></span>
					
						<span class="property-value" aria-labelledby="priceOfEachCagePart-label"><g:fieldValue bean="${quotationCagePartInstance}" field="priceOfEachCagePart"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${quotationCagePartInstance?.id}" />
					<g:link class="edit" action="edit" id="${quotationCagePartInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
