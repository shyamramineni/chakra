
<%@ page import="com.chakra.quotation.QuotationChainLinkModel" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quotationChainLinkModel.label', default: 'QuotationChainLinkModel')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-quotationChainLinkModel" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-quotationChainLinkModel" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list quotationChainLinkModel">
			
				<g:if test="${quotationChainLinkModelInstance?.chainLinkCost}">
				<li class="fieldcontain">
					<span id="chainLinkCost-label" class="property-label"><g:message code="quotationChainLinkModel.chainLinkCost.label" default="Chain Link Cost" /></span>
					
						<span class="property-value" aria-labelledby="chainLinkCost-label"><g:fieldValue bean="${quotationChainLinkModelInstance}" field="chainLinkCost"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationChainLinkModelInstance?.chainLinkDiscount}">
				<li class="fieldcontain">
					<span id="chainLinkDiscount-label" class="property-label"><g:message code="quotationChainLinkModel.chainLinkDiscount.label" default="Chain Link Discount" /></span>
					
						<span class="property-value" aria-labelledby="chainLinkDiscount-label"><g:fieldValue bean="${quotationChainLinkModelInstance}" field="chainLinkDiscount"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationChainLinkModelInstance?.chainLinkDiscountPercent}">
				<li class="fieldcontain">
					<span id="chainLinkDiscountPercent-label" class="property-label"><g:message code="quotationChainLinkModel.chainLinkDiscountPercent.label" default="Chain Link Discount Percent" /></span>
					
						<span class="property-value" aria-labelledby="chainLinkDiscountPercent-label"><g:fieldValue bean="${quotationChainLinkModelInstance}" field="chainLinkDiscountPercent"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationChainLinkModelInstance?.addValue}">
				<li class="fieldcontain">
					<span id="addValue-label" class="property-label"><g:message code="quotationChainLinkModel.addValue.label" default="Add Value" /></span>
					
						<span class="property-value" aria-labelledby="addValue-label"><g:fieldValue bean="${quotationChainLinkModelInstance}" field="addValue"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationChainLinkModelInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="quotationChainLinkModel.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${quotationChainLinkModelInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationChainLinkModelInstance?.quotationChainLinkItems}">
				<li class="fieldcontain">
					<span id="quotationChainLinkItems-label" class="property-label"><g:message code="quotationChainLinkModel.quotationChainLinkItems.label" default="Quotation Chain Link Items" /></span>
					
						<g:each in="${quotationChainLinkModelInstance.quotationChainLinkItems}" var="q">
						<span class="property-value" aria-labelledby="quotationChainLinkItems-label"><g:link controller="quotationChainLink" action="show" id="${q.id}">${q?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${quotationChainLinkModelInstance?.id}" />
					<g:link class="edit" action="edit" id="${quotationChainLinkModelInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
