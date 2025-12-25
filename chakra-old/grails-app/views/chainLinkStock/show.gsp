
<%@ page import="com.chakra.stock.ChainLinkStock" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'chainLinkStock.label', default: 'ChainLinkStock')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-chainLinkStock" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-chainLinkStock" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list chainLinkStock">
			
				<g:if test="${chainLinkStockInstance?.machine}">
				<li class="fieldcontain">
					<span id="machine-label" class="property-label"><g:message code="chainLinkStock.machine.label" default="Machine" /></span>
					
						<span class="property-value" aria-labelledby="machine-label"><g:link controller="machine" action="show" id="${chainLinkStockInstance?.machine?.id}">${chainLinkStockInstance?.machine?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${chainLinkStockInstance?.wireBrand}">
				<li class="fieldcontain">
					<span id="wireBrand-label" class="property-label"><g:message code="chainLinkStock.wireBrand.label" default="Wire Brand" /></span>
					
						<span class="property-value" aria-labelledby="wireBrand-label"><g:link controller="wireBrand" action="show" id="${chainLinkStockInstance?.wireBrand?.id}">${chainLinkStockInstance?.wireBrand?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${chainLinkStockInstance?.noOfManufactured}">
				<li class="fieldcontain">
					<span id="noOfManufactured-label" class="property-label"><g:message code="chainLinkStock.noOfManufactured.label" default="No Of Manufactured" /></span>
					
						<span class="property-value" aria-labelledby="noOfManufactured-label"><g:fieldValue bean="${chainLinkStockInstance}" field="noOfManufactured"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${chainLinkStockInstance?.noOfInStock}">
				<li class="fieldcontain">
					<span id="noOfInStock-label" class="property-label"><g:message code="chainLinkStock.noOfInStock.label" default="No Of In Stock" /></span>
					
						<span class="property-value" aria-labelledby="noOfInStock-label"><g:fieldValue bean="${chainLinkStockInstance}" field="noOfInStock"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${chainLinkStockInstance?.linkMesh}">
				<li class="fieldcontain">
					<span id="linkMesh-label" class="property-label"><g:message code="chainLinkStock.linkMesh.label" default="Link Mesh" /></span>
					
						<span class="property-value" aria-labelledby="linkMesh-label"><g:link controller="linkMesh" action="show" id="${chainLinkStockInstance?.linkMesh?.id}">${chainLinkStockInstance?.linkMesh?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${chainLinkStockInstance?.comments}">
				<li class="fieldcontain">
					<span id="comments-label" class="property-label"><g:message code="chainLinkStock.comments.label" default="Comments" /></span>
					
						<span class="property-value" aria-labelledby="comments-label"><g:fieldValue bean="${chainLinkStockInstance}" field="comments"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${chainLinkStockInstance?.chainLinkStockId}">
				<li class="fieldcontain">
					<span id="chainLinkStockId-label" class="property-label"><g:message code="chainLinkStock.chainLinkStockId.label" default="Chain Link Stock Id" /></span>
					
						<span class="property-value" aria-labelledby="chainLinkStockId-label"><g:fieldValue bean="${chainLinkStockInstance}" field="chainLinkStockId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${chainLinkStockInstance?.createdBy}">
				<li class="fieldcontain">
					<span id="createdBy-label" class="property-label"><g:message code="chainLinkStock.createdBy.label" default="Created By" /></span>
					
						<span class="property-value" aria-labelledby="createdBy-label"><g:link controller="user" action="show" id="${chainLinkStockInstance?.createdBy?.id}">${chainLinkStockInstance?.createdBy?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${chainLinkStockInstance?.createdDate}">
				<li class="fieldcontain">
					<span id="createdDate-label" class="property-label"><g:message code="chainLinkStock.createdDate.label" default="Created Date" /></span>
					
						<span class="property-value" aria-labelledby="createdDate-label"><g:formatDate date="${chainLinkStockInstance?.createdDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${chainLinkStockInstance?.lastEditedBy}">
				<li class="fieldcontain">
					<span id="lastEditedBy-label" class="property-label"><g:message code="chainLinkStock.lastEditedBy.label" default="Last Edited By" /></span>
					
						<span class="property-value" aria-labelledby="lastEditedBy-label"><g:link controller="user" action="show" id="${chainLinkStockInstance?.lastEditedBy?.id}">${chainLinkStockInstance?.lastEditedBy?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${chainLinkStockInstance?.lastEditedDate}">
				<li class="fieldcontain">
					<span id="lastEditedDate-label" class="property-label"><g:message code="chainLinkStock.lastEditedDate.label" default="Last Edited Date" /></span>
					
						<span class="property-value" aria-labelledby="lastEditedDate-label"><g:formatDate date="${chainLinkStockInstance?.lastEditedDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${chainLinkStockInstance?.availabilityStatus}">
				<li class="fieldcontain">
					<span id="availabilityStatus-label" class="property-label"><g:message code="chainLinkStock.availabilityStatus.label" default="Availability Status" /></span>
					
						<span class="property-value" aria-labelledby="availabilityStatus-label"><g:formatBoolean boolean="${chainLinkStockInstance?.availabilityStatus}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${chainLinkStockInstance?.chainLinkStockOrderItems}">
				<li class="fieldcontain">
					<span id="chainLinkStockOrderItems-label" class="property-label"><g:message code="chainLinkStock.chainLinkStockOrderItems.label" default="Chain Link Stock Order Items" /></span>
					
						<g:each in="${chainLinkStockInstance.chainLinkStockOrderItems}" var="c">
						<span class="property-value" aria-labelledby="chainLinkStockOrderItems-label"><g:link controller="chainLinkStockOrder" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${chainLinkStockInstance?.stockManufacturedTime}">
				<li class="fieldcontain">
					<span id="stockManufacturedTime-label" class="property-label"><g:message code="chainLinkStock.stockManufacturedTime.label" default="Stock Manufactured Time" /></span>
					
						<span class="property-value" aria-labelledby="stockManufacturedTime-label"><g:formatDate date="${chainLinkStockInstance?.stockManufacturedTime}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${chainLinkStockInstance?.id}" />
					<g:link class="edit" action="edit" id="${chainLinkStockInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
