
<%@ page import="com.chakra.production.ProductionReportingWireWeight" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'productionReportingWireWeight.label', default: 'ProductionReportingWireWeight')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-productionReportingWireWeight" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-productionReportingWireWeight" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list productionReportingWireWeight">
			
				<g:if test="${productionReportingWireWeightInstance?.diameter}">
				<li class="fieldcontain">
					<span id="diameter-label" class="property-label"><g:message code="productionReportingWireWeight.diameter.label" default="Diameter" /></span>
					
						<span class="property-value" aria-labelledby="diameter-label"><g:fieldValue bean="${productionReportingWireWeightInstance}" field="diameter"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${productionReportingWireWeightInstance?.productionReporting}">
				<li class="fieldcontain">
					<span id="productionReporting-label" class="property-label"><g:message code="productionReportingWireWeight.productionReporting.label" default="Production Reporting" /></span>
					
						<span class="property-value" aria-labelledby="productionReporting-label"><g:link controller="productionReporting" action="show" id="${productionReportingWireWeightInstance?.productionReporting?.id}">${productionReportingWireWeightInstance?.productionReporting?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${productionReportingWireWeightInstance?.weight}">
				<li class="fieldcontain">
					<span id="weight-label" class="property-label"><g:message code="productionReportingWireWeight.weight.label" default="Weight" /></span>
					
						<span class="property-value" aria-labelledby="weight-label"><g:fieldValue bean="${productionReportingWireWeightInstance}" field="weight"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${productionReportingWireWeightInstance?.wireBrand}">
				<li class="fieldcontain">
					<span id="wireBrand-label" class="property-label"><g:message code="productionReportingWireWeight.wireBrand.label" default="Wire Brand" /></span>
					
						<span class="property-value" aria-labelledby="wireBrand-label"><g:link controller="wireBrand" action="show" id="${productionReportingWireWeightInstance?.wireBrand?.id}">${productionReportingWireWeightInstance?.wireBrand?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${productionReportingWireWeightInstance?.wireConsumptionDate}">
				<li class="fieldcontain">
					<span id="wireConsumptionDate-label" class="property-label"><g:message code="productionReportingWireWeight.wireConsumptionDate.label" default="Wire Consumption Date" /></span>
					
						<span class="property-value" aria-labelledby="wireConsumptionDate-label"><g:formatDate date="${productionReportingWireWeightInstance?.wireConsumptionDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${productionReportingWireWeightInstance?.wireReceiptReporting}">
				<li class="fieldcontain">
					<span id="wireReceiptReporting-label" class="property-label"><g:message code="productionReportingWireWeight.wireReceiptReporting.label" default="Wire Receipt Reporting" /></span>
					
						<span class="property-value" aria-labelledby="wireReceiptReporting-label"><g:link controller="wireReceiptReporting" action="show" id="${productionReportingWireWeightInstance?.wireReceiptReporting?.id}">${productionReportingWireWeightInstance?.wireReceiptReporting?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${productionReportingWireWeightInstance?.id}" />
					<g:link class="edit" action="edit" id="${productionReportingWireWeightInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
