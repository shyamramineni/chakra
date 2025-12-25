
<%@ page import="com.chakra.quotation.QuotationWeldSideModel" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quotationWeldSideModel.label', default: 'QuotationWeldSideModel')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-quotationWeldSideModel" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-quotationWeldSideModel" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list quotationWeldSideModel">
			
				<g:if test="${quotationWeldSideModelInstance?.weldSideCost}">
				<li class="fieldcontain">
					<span id="weldSideCost-label" class="property-label"><g:message code="quotationWeldSideModel.weldSideCost.label" default="Weld Side Cost" /></span>
					
						<span class="property-value" aria-labelledby="weldSideCost-label"><g:fieldValue bean="${quotationWeldSideModelInstance}" field="weldSideCost"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationWeldSideModelInstance?.weldSideDiscount}">
				<li class="fieldcontain">
					<span id="weldSideDiscount-label" class="property-label"><g:message code="quotationWeldSideModel.weldSideDiscount.label" default="Weld Side Discount" /></span>
					
						<span class="property-value" aria-labelledby="weldSideDiscount-label"><g:fieldValue bean="${quotationWeldSideModelInstance}" field="weldSideDiscount"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationWeldSideModelInstance?.weldSideDiscountPercent}">
				<li class="fieldcontain">
					<span id="weldSideDiscountPercent-label" class="property-label"><g:message code="quotationWeldSideModel.weldSideDiscountPercent.label" default="Weld Side Discount Percent" /></span>
					
						<span class="property-value" aria-labelledby="weldSideDiscountPercent-label"><g:fieldValue bean="${quotationWeldSideModelInstance}" field="weldSideDiscountPercent"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationWeldSideModelInstance?.netWeldSideCost}">
				<li class="fieldcontain">
					<span id="netWeldSideCost-label" class="property-label"><g:message code="quotationWeldSideModel.netWeldSideCost.label" default="Net Weld Side Cost" /></span>
					
						<span class="property-value" aria-labelledby="netWeldSideCost-label"><g:fieldValue bean="${quotationWeldSideModelInstance}" field="netWeldSideCost"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationWeldSideModelInstance?.quotationWeldSideItems}">
				<li class="fieldcontain">
					<span id="quotationWeldSideItems-label" class="property-label"><g:message code="quotationWeldSideModel.quotationWeldSideItems.label" default="Quotation Weld Side Items" /></span>
					
						<g:each in="${quotationWeldSideModelInstance.quotationWeldSideItems}" var="q">
						<span class="property-value" aria-labelledby="quotationWeldSideItems-label"><g:link controller="quotationWeldSide" action="show" id="${q.id}">${q?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${quotationWeldSideModelInstance?.id}" />
					<g:link class="edit" action="edit" id="${quotationWeldSideModelInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
