
<%@ page import="com.chakra.config.SheetSpecification" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'sheetSpecification.label', default: 'SheetSpecification')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-sheetSpecification" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-sheetSpecification" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			
			<%--<ol class="property-list sheetSpecification">
			
				<g:if test="${sheetSpecificationInstance?.sheetName}">
				<li class="fieldcontain">
					<span id="sheetName-label" class="property-label"><g:message code="sheetSpecification.sheetName.label" default="Sheet Name" /></span>
					
						<span class="property-value" aria-labelledby="sheetName-label"><g:fieldValue bean="${sheetSpecificationInstance}" field="sheetName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sheetSpecificationInstance?.projection}">
				<li class="fieldcontain">
					<span id="projection-label" class="property-label"><g:message code="sheetSpecification.projection.label" default="Projection" /></span>
					
						<span class="property-value" aria-labelledby="projection-label"><g:fieldValue bean="${sheetSpecificationInstance}" field="projection"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sheetSpecificationInstance?.width}">
				<li class="fieldcontain">
					<span id="width-label" class="property-label"><g:message code="sheetSpecification.width.label" default="Width" /></span>
					
						<span class="property-value" aria-labelledby="width-label"><g:fieldValue bean="${sheetSpecificationInstance}" field="width"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sheetSpecificationInstance?.length}">
				<li class="fieldcontain">
					<span id="length-label" class="property-label"><g:message code="sheetSpecification.length.label" default="Length" /></span>
					
						<span class="property-value" aria-labelledby="length-label"><g:fieldValue bean="${sheetSpecificationInstance}" field="length"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sheetSpecificationInstance?.pitch}">
				<li class="fieldcontain">
					<span id="pitch-label" class="property-label"><g:message code="sheetSpecification.pitch.label" default="Pitch" /></span>
					
						<span class="property-value" aria-labelledby="pitch-label"><g:fieldValue bean="${sheetSpecificationInstance}" field="pitch"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sheetSpecificationInstance?.crossWireDiameter}">
				<li class="fieldcontain">
					<span id="crossWireDiameter-label" class="property-label"><g:message code="sheetSpecification.crossWireDiameter.label" default="Cross Wire Diameter" /></span>
					
						<span class="property-value" aria-labelledby="crossWireDiameter-label"><g:fieldValue bean="${sheetSpecificationInstance}" field="crossWireDiameter"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sheetSpecificationInstance?.lineWireDiameter1}">
				<li class="fieldcontain">
					<span id="lineWireDiameter1-label" class="property-label"><g:message code="sheetSpecification.lineWireDiameter1.label" default="Line Wire Diameter1" /></span>
					
						<span class="property-value" aria-labelledby="lineWireDiameter1-label"><g:fieldValue bean="${sheetSpecificationInstance}" field="lineWireDiameter1"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sheetSpecificationInstance?.lineWireDiameter2}">
				<li class="fieldcontain">
					<span id="lineWireDiameter2-label" class="property-label"><g:message code="sheetSpecification.lineWireDiameter2.label" default="Line Wire Diameter2" /></span>
					
						<span class="property-value" aria-labelledby="lineWireDiameter2-label"><g:fieldValue bean="${sheetSpecificationInstance}" field="lineWireDiameter2"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sheetSpecificationInstance?.noOfLineWires1}">
				<li class="fieldcontain">
					<span id="noOfLineWires1-label" class="property-label"><g:message code="sheetSpecification.noOfLineWires1.label" default="No Of Line Wires1" /></span>
					
						<span class="property-value" aria-labelledby="noOfLineWires1-label"><g:fieldValue bean="${sheetSpecificationInstance}" field="noOfLineWires1"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sheetSpecificationInstance?.noOfLineWires2}">
				<li class="fieldcontain">
					<span id="noOfLineWires2-label" class="property-label"><g:message code="sheetSpecification.noOfLineWires2.label" default="No Of Line Wires2" /></span>
					
						<span class="property-value" aria-labelledby="noOfLineWires2-label"><g:fieldValue bean="${sheetSpecificationInstance}" field="noOfLineWires2"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sheetSpecificationInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="sheetSpecification.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${sheetSpecificationInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sheetSpecificationInstance?.textual}">
				<li class="fieldcontain">
					<span id="textual-label" class="property-label"><g:message code="sheetSpecification.textual.label" default="Textual" /></span>
					
						<span class="property-value" aria-labelledby="textual-label"><g:fieldValue bean="${sheetSpecificationInstance}" field="textual"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sheetSpecificationInstance?.factoryPitch}">
				<li class="fieldcontain">
					<span id="factoryPitch-label" class="property-label"><g:message code="sheetSpecification.factoryPitch.label" default="Factory Pitch" /></span>
					
						<span class="property-value" aria-labelledby="factoryPitch-label"><g:fieldValue bean="${sheetSpecificationInstance}" field="factoryPitch"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sheetSpecificationInstance?.sheetWeight}">
				<li class="fieldcontain">
					<span id="sheetWeight-label" class="property-label"><g:message code="sheetSpecification.sheetWeight.label" default="Sheet Weight" /></span>
					
						<span class="property-value" aria-labelledby="sheetWeight-label"><g:fieldValue bean="${sheetSpecificationInstance}" field="sheetWeight"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sheetSpecificationInstance?.noOfCrossWires}">
				<li class="fieldcontain">
					<span id="noOfCrossWires-label" class="property-label"><g:message code="sheetSpecification.noOfCrossWires.label" default="No Of Cross Wires" /></span>
					
						<span class="property-value" aria-labelledby="noOfCrossWires-label"><g:fieldValue bean="${sheetSpecificationInstance}" field="noOfCrossWires"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sheetSpecificationInstance?.sheetSpecId}">
				<li class="fieldcontain">
					<span id="sheetSpecId-label" class="property-label"><g:message code="sheetSpecification.sheetSpecId.label" default="Sheet Spec Id" /></span>
					
						<span class="property-value" aria-labelledby="sheetSpecId-label"><g:fieldValue bean="${sheetSpecificationInstance}" field="sheetSpecId"/></span>
					
				</li>
				</g:if>
			
			</ol>	--%>
			<table class="table table-bordered">
							
				    <tr>
				        <th align="left">Sheet Spec Id:</th>
				        <td>${sheetSpecificationInstance.sheetSpecId}</td>
				    </tr>
				    <tr>
				        <th align="left">Sheet Name:</th>
				        <td>${sheetSpecificationInstance.sheetName}</td>
				    </tr>
				    <tr>
				        <th align="left">Projection:</th>
				        <td>${sheetSpecificationInstance.projection}</td>
				    </tr>
				    <tr>
				        <th align="left">Width:</th>
				        <td>${sheetSpecificationInstance.width}</td>
				    </tr>
				    
				    <tr>
				        <th align="left">Length:</th>
				        <td>${sheetSpecificationInstance.length}</td>
				    </tr>
				    <tr>
				        <th align="left">Pitch:</th>
				        <td>${sheetSpecificationInstance.pitch}</td>
				    </tr>
				    <tr>
				        <th align="left">CrossWire Diameter:</th>
				        <td>${sheetSpecificationInstance.crossWireDiameter}</td>
				    </tr>
				    <tr>
				        <th align="left">LineWire Diameter1:</th>
				        <td>${sheetSpecificationInstance.lineWireDiameter1}</td>
				    </tr>
				    <tr>
				        <th align="left">LineWire Diameter2:</th>
				        <td>${sheetSpecificationInstance.lineWireDiameter2}</td>
				    </tr>
				    <tr>
				        <th align="left">No Of LineWires1:</th>
				        <td>${sheetSpecificationInstance.noOfLineWires1}</td>
				    </tr>
				    <tr>
				        <th align="left">No Of LineWires2:</th>
				        <td>${sheetSpecificationInstance.noOfLineWires2}</td>
				    </tr>
				    <tr>
				        <th align="left">No Of CrossWires:</th>
				        <td>${sheetSpecificationInstance.noOfCrossWires}</td>
				    </tr>
				    <tr>
				        <th align="left">Sheet Weight1:</th>
				        <td>${sheetSpecificationInstance.sheetWeight}</td>
				    </tr>
				    <tr>
				        <th align="left">Textual:</th>
				        <td>${sheetSpecificationInstance.textual}</td>
				    </tr>
				    <tr>
				        <th align="left">Factory Pitch:</th>
				        <td>${sheetSpecificationInstance.factoryPitch}</td>
				    </tr>
				     <tr>
				        <th align="left">Description:</th>
				        <td>${sheetSpecificationInstance.description}</td>
				    </tr>
				    				    						
			</table>
			<br>
			<ul>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${sheetSpecificationInstance?.id}" />
					<sec:ifAnyGranted roles="ROLE_ADMIN"><g:link class="btn btn-primary" action="edit" id="${sheetSpecificationInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link></sec:ifAnyGranted>
					<sec:ifAnyGranted roles="ROLE_ADMIN"><g:actionSubmit class="btn btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></sec:ifAnyGranted>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
