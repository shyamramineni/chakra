
<%@ page import="com.chakra.production.WeldSideMeshReporting" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'weldSideMeshReporting.label', default: 'WeldSideMeshReporting')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-weldSideMeshReporting" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-weldSideMeshReporting" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list weldSideMeshReporting">
			
				<g:if test="${weldSideMeshReportingInstance?.machine}">
				<li class="fieldcontain">
					<span id="machine-label" class="property-label"><g:message code="weldSideMeshReporting.machine.label" default="Machine" /></span>
					
						<span class="property-value" aria-labelledby="machine-label"><g:link controller="machine" action="show" id="${weldSideMeshReportingInstance?.machine?.id}">${weldSideMeshReportingInstance?.machine?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${weldSideMeshReportingInstance?.sideMesh}">
				<li class="fieldcontain">
					<span id="sideMesh-label" class="property-label"><g:message code="weldSideMeshReporting.sideMesh.label" default="Side Mesh" /></span>
					
						<span class="property-value" aria-labelledby="sideMesh-label"><g:link controller="sideMesh" action="show" id="${weldSideMeshReportingInstance?.sideMesh?.id}">${weldSideMeshReportingInstance?.sideMesh?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${weldSideMeshReportingInstance?.wireBrand}">
				<li class="fieldcontain">
					<span id="wireBrand-label" class="property-label"><g:message code="weldSideMeshReporting.wireBrand.label" default="Wire Brand" /></span>
					
						<span class="property-value" aria-labelledby="wireBrand-label"><g:link controller="wireBrand" action="show" id="${weldSideMeshReportingInstance?.wireBrand?.id}">${weldSideMeshReportingInstance?.wireBrand?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${weldSideMeshReportingInstance?.weldSideMeshStock}">
				<li class="fieldcontain">
					<span id="weldSideMeshStock-label" class="property-label"><g:message code="weldSideMeshReporting.weldSideMeshStock.label" default="Weld Side Mesh Stock" /></span>
					
						<span class="property-value" aria-labelledby="weldSideMeshStock-label"><g:link controller="weldSideMeshStock" action="show" id="${weldSideMeshReportingInstance?.weldSideMeshStock?.id}">${weldSideMeshReportingInstance?.weldSideMeshStock?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${weldSideMeshReportingInstance?.createdBy}">
				<li class="fieldcontain">
					<span id="createdBy-label" class="property-label"><g:message code="weldSideMeshReporting.createdBy.label" default="Created By" /></span>
					
						<span class="property-value" aria-labelledby="createdBy-label"><g:fieldValue bean="${weldSideMeshReportingInstance}" field="createdBy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${weldSideMeshReportingInstance?.createdDate}">
				<li class="fieldcontain">
					<span id="createdDate-label" class="property-label"><g:message code="weldSideMeshReporting.createdDate.label" default="Created Date" /></span>
					
						<span class="property-value" aria-labelledby="createdDate-label"><g:formatDate date="${weldSideMeshReportingInstance?.createdDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${weldSideMeshReportingInstance?.lastEditedBy}">
				<li class="fieldcontain">
					<span id="lastEditedBy-label" class="property-label"><g:message code="weldSideMeshReporting.lastEditedBy.label" default="Last Edited By" /></span>
					
						<span class="property-value" aria-labelledby="lastEditedBy-label"><g:fieldValue bean="${weldSideMeshReportingInstance}" field="lastEditedBy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${weldSideMeshReportingInstance?.editedDate}">
				<li class="fieldcontain">
					<span id="editedDate-label" class="property-label"><g:message code="weldSideMeshReporting.editedDate.label" default="Edited Date" /></span>
					
						<span class="property-value" aria-labelledby="editedDate-label"><g:formatDate date="${weldSideMeshReportingInstance?.editedDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${weldSideMeshReportingInstance?.comments}">
				<li class="fieldcontain">
					<span id="comments-label" class="property-label"><g:message code="weldSideMeshReporting.comments.label" default="Comments" /></span>
					
						<span class="property-value" aria-labelledby="comments-label"><g:fieldValue bean="${weldSideMeshReportingInstance}" field="comments"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${weldSideMeshReportingInstance?.stockManufacturedTime}">
				<li class="fieldcontain">
					<span id="stockManufacturedTime-label" class="property-label"><g:message code="weldSideMeshReporting.stockManufacturedTime.label" default="Stock Manufactured Time" /></span>
					
						<span class="property-value" aria-labelledby="stockManufacturedTime-label"><g:formatDate date="${weldSideMeshReportingInstance?.stockManufacturedTime}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${weldSideMeshReportingInstance?.totalQuantity}">
				<li class="fieldcontain">
					<span id="totalQuantity-label" class="property-label"><g:message code="weldSideMeshReporting.totalQuantity.label" default="Total Quantity" /></span>
					
						<span class="property-value" aria-labelledby="totalQuantity-label"><g:fieldValue bean="${weldSideMeshReportingInstance}" field="totalQuantity"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${weldSideMeshReportingInstance?.weldSideMeshReportingWireWeightList}">
				<li class="fieldcontain">
					<span id="weldSideMeshReportingWireWeightList-label" class="property-label"><g:message code="weldSideMeshReporting.weldSideMeshReportingWireWeightList.label" default="Weld Side Mesh Reporting Wire Weight List" /></span>
					
						<g:each in="${weldSideMeshReportingInstance.weldSideMeshReportingWireWeightList}" var="w">
						<span class="property-value" aria-labelledby="weldSideMeshReportingWireWeightList-label"><g:link controller="weldSideMeshReportingWireWeight" action="show" id="${w.id}">${w?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${weldSideMeshReportingInstance?.id}" />
					<g:link class="edit" action="edit" id="${weldSideMeshReportingInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
