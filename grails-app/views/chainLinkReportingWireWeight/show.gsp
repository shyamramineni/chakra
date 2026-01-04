
<%@ page import="com.chakra.production.ChainLinkReportingWireWeight" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'chainLinkReportingWireWeight.label', default: 'ChainLinkReportingWireWeight')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-chainLinkReportingWireWeight" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-chainLinkReportingWireWeight" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list chainLinkReportingWireWeight">
			
				<g:if test="${chainLinkReportingWireWeightInstance?.chainLinkReporting}">
				<li class="fieldcontain">
					<span id="chainLinkReporting-label" class="property-label"><g:message code="chainLinkReportingWireWeight.chainLinkReporting.label" default="Chain Link Reporting" /></span>
					
						<span class="property-value" aria-labelledby="chainLinkReporting-label"><g:link controller="chainLinkReporting" action="show" id="${chainLinkReportingWireWeightInstance?.chainLinkReporting?.id}">${chainLinkReportingWireWeightInstance?.chainLinkReporting?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${chainLinkReportingWireWeightInstance?.wireReceiptReporting}">
				<li class="fieldcontain">
					<span id="wireReceiptReporting-label" class="property-label"><g:message code="chainLinkReportingWireWeight.wireReceiptReporting.label" default="Wire Receipt Reporting" /></span>
					
						<span class="property-value" aria-labelledby="wireReceiptReporting-label"><g:link controller="wireReceiptReporting" action="show" id="${chainLinkReportingWireWeightInstance?.wireReceiptReporting?.id}">${chainLinkReportingWireWeightInstance?.wireReceiptReporting?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${chainLinkReportingWireWeightInstance?.diameter}">
				<li class="fieldcontain">
					<span id="diameter-label" class="property-label"><g:message code="chainLinkReportingWireWeight.diameter.label" default="Diameter" /></span>
					
						<span class="property-value" aria-labelledby="diameter-label"><g:fieldValue bean="${chainLinkReportingWireWeightInstance}" field="diameter"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${chainLinkReportingWireWeightInstance?.weight}">
				<li class="fieldcontain">
					<span id="weight-label" class="property-label"><g:message code="chainLinkReportingWireWeight.weight.label" default="Weight" /></span>
					
						<span class="property-value" aria-labelledby="weight-label"><g:fieldValue bean="${chainLinkReportingWireWeightInstance}" field="weight"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${chainLinkReportingWireWeightInstance?.wireBrand}">
				<li class="fieldcontain">
					<span id="wireBrand-label" class="property-label"><g:message code="chainLinkReportingWireWeight.wireBrand.label" default="Wire Brand" /></span>
					
						<span class="property-value" aria-labelledby="wireBrand-label"><g:link controller="wireBrand" action="show" id="${chainLinkReportingWireWeightInstance?.wireBrand?.id}">${chainLinkReportingWireWeightInstance?.wireBrand?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${chainLinkReportingWireWeightInstance?.wireConsumptionDate}">
				<li class="fieldcontain">
					<span id="wireConsumptionDate-label" class="property-label"><g:message code="chainLinkReportingWireWeight.wireConsumptionDate.label" default="Wire Consumption Date" /></span>
					
						<span class="property-value" aria-labelledby="wireConsumptionDate-label"><g:formatDate date="${chainLinkReportingWireWeightInstance?.wireConsumptionDate}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${chainLinkReportingWireWeightInstance?.id}" />
					<g:link class="edit" action="edit" id="${chainLinkReportingWireWeightInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
