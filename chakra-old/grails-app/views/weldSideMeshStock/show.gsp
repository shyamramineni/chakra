
<%@ page import="com.chakra.stock.WeldSideMeshStock" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'weldSideMeshStock.label', default: 'WeldSideMeshStock')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-weldSideMeshStock" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-weldSideMeshStock" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list weldSideMeshStock">
			
				<g:if test="${weldSideMeshStockInstance?.machine}">
				<li class="fieldcontain">
					<span id="machine-label" class="property-label"><g:message code="weldSideMeshStock.machine.label" default="Machine" /></span>
					
						<span class="property-value" aria-labelledby="machine-label"><g:link controller="machine" action="show" id="${weldSideMeshStockInstance?.machine?.id}">${weldSideMeshStockInstance?.machine?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${weldSideMeshStockInstance?.wireBrand}">
				<li class="fieldcontain">
					<span id="wireBrand-label" class="property-label"><g:message code="weldSideMeshStock.wireBrand.label" default="Wire Brand" /></span>
					
						<span class="property-value" aria-labelledby="wireBrand-label"><g:link controller="wireBrand" action="show" id="${weldSideMeshStockInstance?.wireBrand?.id}">${weldSideMeshStockInstance?.wireBrand?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${weldSideMeshStockInstance?.noOfManufactured}">
				<li class="fieldcontain">
					<span id="noOfManufactured-label" class="property-label"><g:message code="weldSideMeshStock.noOfManufactured.label" default="No Of Manufactured" /></span>
					
						<span class="property-value" aria-labelledby="noOfManufactured-label"><g:fieldValue bean="${weldSideMeshStockInstance}" field="noOfManufactured"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${weldSideMeshStockInstance?.noOfInStock}">
				<li class="fieldcontain">
					<span id="noOfInStock-label" class="property-label"><g:message code="weldSideMeshStock.noOfInStock.label" default="No Of In Stock" /></span>
					
						<span class="property-value" aria-labelledby="noOfInStock-label"><g:fieldValue bean="${weldSideMeshStockInstance}" field="noOfInStock"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${weldSideMeshStockInstance?.sideMesh}">
				<li class="fieldcontain">
					<span id="sideMesh-label" class="property-label"><g:message code="weldSideMeshStock.sideMesh.label" default="Side Mesh" /></span>
					
						<span class="property-value" aria-labelledby="sideMesh-label"><g:link controller="sideMesh" action="show" id="${weldSideMeshStockInstance?.sideMesh?.id}">${weldSideMeshStockInstance?.sideMesh?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${weldSideMeshStockInstance?.comments}">
				<li class="fieldcontain">
					<span id="comments-label" class="property-label"><g:message code="weldSideMeshStock.comments.label" default="Comments" /></span>
					
						<span class="property-value" aria-labelledby="comments-label"><g:fieldValue bean="${weldSideMeshStockInstance}" field="comments"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${weldSideMeshStockInstance?.weldSideMeshStockId}">
				<li class="fieldcontain">
					<span id="weldSideMeshStockId-label" class="property-label"><g:message code="weldSideMeshStock.weldSideMeshStockId.label" default="Weld Side Mesh Stock Id" /></span>
					
						<span class="property-value" aria-labelledby="weldSideMeshStockId-label"><g:fieldValue bean="${weldSideMeshStockInstance}" field="weldSideMeshStockId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${weldSideMeshStockInstance?.createdBy}">
				<li class="fieldcontain">
					<span id="createdBy-label" class="property-label"><g:message code="weldSideMeshStock.createdBy.label" default="Created By" /></span>
					
						<span class="property-value" aria-labelledby="createdBy-label"><g:link controller="user" action="show" id="${weldSideMeshStockInstance?.createdBy?.id}">${weldSideMeshStockInstance?.createdBy?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${weldSideMeshStockInstance?.createdDate}">
				<li class="fieldcontain">
					<span id="createdDate-label" class="property-label"><g:message code="weldSideMeshStock.createdDate.label" default="Created Date" /></span>
					
						<span class="property-value" aria-labelledby="createdDate-label"><g:formatDate date="${weldSideMeshStockInstance?.createdDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${weldSideMeshStockInstance?.lastEditedBy}">
				<li class="fieldcontain">
					<span id="lastEditedBy-label" class="property-label"><g:message code="weldSideMeshStock.lastEditedBy.label" default="Last Edited By" /></span>
					
						<span class="property-value" aria-labelledby="lastEditedBy-label"><g:link controller="user" action="show" id="${weldSideMeshStockInstance?.lastEditedBy?.id}">${weldSideMeshStockInstance?.lastEditedBy?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${weldSideMeshStockInstance?.lastEditedDate}">
				<li class="fieldcontain">
					<span id="lastEditedDate-label" class="property-label"><g:message code="weldSideMeshStock.lastEditedDate.label" default="Last Edited Date" /></span>
					
						<span class="property-value" aria-labelledby="lastEditedDate-label"><g:formatDate date="${weldSideMeshStockInstance?.lastEditedDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${weldSideMeshStockInstance?.availabilityStatus}">
				<li class="fieldcontain">
					<span id="availabilityStatus-label" class="property-label"><g:message code="weldSideMeshStock.availabilityStatus.label" default="Availability Status" /></span>
					
						<span class="property-value" aria-labelledby="availabilityStatus-label"><g:formatBoolean boolean="${weldSideMeshStockInstance?.availabilityStatus}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${weldSideMeshStockInstance?.stockManufacturedTime}">
				<li class="fieldcontain">
					<span id="stockManufacturedTime-label" class="property-label"><g:message code="weldSideMeshStock.stockManufacturedTime.label" default="Stock Manufactured Time" /></span>
					
						<span class="property-value" aria-labelledby="stockManufacturedTime-label"><g:formatDate date="${weldSideMeshStockInstance?.stockManufacturedTime}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${weldSideMeshStockInstance?.weldSideMeshStockOrderItems}">
				<li class="fieldcontain">
					<span id="weldSideMeshStockOrderItems-label" class="property-label"><g:message code="weldSideMeshStock.weldSideMeshStockOrderItems.label" default="Weld Side Mesh Stock Order Items" /></span>
					
						<g:each in="${weldSideMeshStockInstance.weldSideMeshStockOrderItems}" var="w">
						<span class="property-value" aria-labelledby="weldSideMeshStockOrderItems-label"><g:link controller="weldSideMeshStockOrder" action="show" id="${w.id}">${w?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${weldSideMeshStockInstance?.id}" />
					<g:link class="edit" action="edit" id="${weldSideMeshStockInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
