
<%@ page import="com.chakra.production.WeldSideMeshReportingWireWeight" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'weldSideMeshReportingWireWeight.label', default: 'WeldSideMeshReportingWireWeight')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-weldSideMeshReportingWireWeight" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-weldSideMeshReportingWireWeight" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list weldSideMeshReportingWireWeight">
			
				<g:if test="${weldSideMeshReportingWireWeightInstance?.weldSideMeshReporting}">
				<li class="fieldcontain">
					<span id="weldSideMeshReporting-label" class="property-label"><g:message code="weldSideMeshReportingWireWeight.weldSideMeshReporting.label" default="Weld Side Mesh Reporting" /></span>
					
						<span class="property-value" aria-labelledby="weldSideMeshReporting-label"><g:link controller="weldSideMeshReporting" action="show" id="${weldSideMeshReportingWireWeightInstance?.weldSideMeshReporting?.id}">${weldSideMeshReportingWireWeightInstance?.weldSideMeshReporting?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${weldSideMeshReportingWireWeightInstance?.wireReceiptReporting}">
				<li class="fieldcontain">
					<span id="wireReceiptReporting-label" class="property-label"><g:message code="weldSideMeshReportingWireWeight.wireReceiptReporting.label" default="Wire Receipt Reporting" /></span>
					
						<span class="property-value" aria-labelledby="wireReceiptReporting-label"><g:link controller="wireReceiptReporting" action="show" id="${weldSideMeshReportingWireWeightInstance?.wireReceiptReporting?.id}">${weldSideMeshReportingWireWeightInstance?.wireReceiptReporting?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${weldSideMeshReportingWireWeightInstance?.diameter}">
				<li class="fieldcontain">
					<span id="diameter-label" class="property-label"><g:message code="weldSideMeshReportingWireWeight.diameter.label" default="Diameter" /></span>
					
						<span class="property-value" aria-labelledby="diameter-label"><g:fieldValue bean="${weldSideMeshReportingWireWeightInstance}" field="diameter"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${weldSideMeshReportingWireWeightInstance?.weight}">
				<li class="fieldcontain">
					<span id="weight-label" class="property-label"><g:message code="weldSideMeshReportingWireWeight.weight.label" default="Weight" /></span>
					
						<span class="property-value" aria-labelledby="weight-label"><g:fieldValue bean="${weldSideMeshReportingWireWeightInstance}" field="weight"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${weldSideMeshReportingWireWeightInstance?.wireBrand}">
				<li class="fieldcontain">
					<span id="wireBrand-label" class="property-label"><g:message code="weldSideMeshReportingWireWeight.wireBrand.label" default="Wire Brand" /></span>
					
						<span class="property-value" aria-labelledby="wireBrand-label"><g:link controller="wireBrand" action="show" id="${weldSideMeshReportingWireWeightInstance?.wireBrand?.id}">${weldSideMeshReportingWireWeightInstance?.wireBrand?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${weldSideMeshReportingWireWeightInstance?.wireConsumptionDate}">
				<li class="fieldcontain">
					<span id="wireConsumptionDate-label" class="property-label"><g:message code="weldSideMeshReportingWireWeight.wireConsumptionDate.label" default="Wire Consumption Date" /></span>
					
						<span class="property-value" aria-labelledby="wireConsumptionDate-label"><g:formatDate date="${weldSideMeshReportingWireWeightInstance?.wireConsumptionDate}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${weldSideMeshReportingWireWeightInstance?.id}" />
					<g:link class="edit" action="edit" id="${weldSideMeshReportingWireWeightInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
