
<%@ page import="com.chakra.order.CorderCageParts" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'corderCageParts.label', default: 'CorderCageParts')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-corderCageParts" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-corderCageParts" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list corderCageParts">
			
				<g:if test="${corderCagePartsInstance?.cagePartSpecFormula}">
				<li class="fieldcontain">
					<span id="cagePartSpecFormula-label" class="property-label"><g:message code="corderCageParts.cagePartSpecFormula.label" default="Cage Part Spec Formula" /></span>
					
						<span class="property-value" aria-labelledby="cagePartSpecFormula-label"><g:link controller="cagePartSpecFormula" action="show" id="${corderCagePartsInstance?.cagePartSpecFormula?.id}">${corderCagePartsInstance?.cagePartSpecFormula?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${corderCagePartsInstance?.noOfCageParts}">
				<li class="fieldcontain">
					<span id="noOfCageParts-label" class="property-label"><g:message code="corderCageParts.noOfCageParts.label" default="No Of Cage Parts" /></span>
					
						<span class="property-value" aria-labelledby="noOfCageParts-label"><g:fieldValue bean="${corderCagePartsInstance}" field="noOfCageParts"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${corderCagePartsInstance?.priceOfEachCagePart}">
				<li class="fieldcontain">
					<span id="priceOfEachCagePart-label" class="property-label"><g:message code="corderCageParts.priceOfEachCagePart.label" default="Price Of Each Cage Part" /></span>
					
						<span class="property-value" aria-labelledby="priceOfEachCagePart-label"><g:fieldValue bean="${corderCagePartsInstance}" field="priceOfEachCagePart"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${corderCagePartsInstance?.costOfCagePart}">
				<li class="fieldcontain">
					<span id="costOfCagePart-label" class="property-label"><g:message code="corderCageParts.costOfCagePart.label" default="Cost Of Cage Part" /></span>
					
						<span class="property-value" aria-labelledby="costOfCagePart-label"><g:fieldValue bean="${corderCagePartsInstance}" field="costOfCagePart"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${corderCagePartsInstance?.cageCost}">
				<li class="fieldcontain">
					<span id="cageCost-label" class="property-label"><g:message code="corderCageParts.cageCost.label" default="Cage Cost" /></span>
					
						<span class="property-value" aria-labelledby="cageCost-label"><g:fieldValue bean="${corderCagePartsInstance}" field="cageCost"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${corderCagePartsInstance?.corder}">
				<li class="fieldcontain">
					<span id="corder-label" class="property-label"><g:message code="corderCageParts.corder.label" default="Corder" /></span>
					
						<span class="property-value" aria-labelledby="corder-label"><g:link controller="corder" action="show" id="${corderCagePartsInstance?.corder?.id}">${corderCagePartsInstance?.corder?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${corderCagePartsInstance?.id}" />
					<sec:ifAllGranted roles="ROLE_ADMIN"><g:link class="edit" action="edit" id="${corderCagePartsInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link></sec:ifAllGranted>
					<sec:ifAllGranted roles="ROLE_ADMIN"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></sec:ifAllGranted>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
