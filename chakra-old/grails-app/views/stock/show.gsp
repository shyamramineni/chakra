
<%@ page import="com.chakra.stock.Stock" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'stock.label', default: 'Stock')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-stock" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-stock" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<%--<ol class="property-list stock">
			
				<g:if test="${stockInstance?.sheetSpec}">
				<li class="fieldcontain">
					<span id="sheetSpec-label" class="property-label"><g:message code="stock.sheetSpec.label" default="Sheet Spec" /></span>
					
						<span class="property-value" aria-labelledby="sheetSpec-label">${stockInstance?.sheetSpec?.encodeAsHTML()}</span>
					
				</li>
				</g:if>
				
				<g:if test="${stockInstance?.noOfManufactured}">
				<li class="fieldcontain">
					<span id="noOfManufactured-label" class="property-label"><g:message code="stock.noOfManufactured.label" default="No Of Manufactured" /></span>
					
						<span class="property-value" aria-labelledby="noOfManufactured-label"><g:fieldValue bean="${stockInstance}" field="noOfManufactured"/></span>
					
				</li>
				</g:if>
				
				<g:if test="${stockInstance?.noOfInStock}">
				<li class="fieldcontain">
					<span id="noOfInStock-label" class="property-label"><g:message code="stock.noOfInStock.label" default="No Of In Stock" /></span>
					
						<span class="property-value" aria-labelledby="noOfInStock-label"><g:fieldValue bean="${stockInstance}" field="noOfInStock"/></span>
					
				</li>
				</g:if>
				
				<g:if test="${stockInstance?.stockManufacturedTime}">
				<li class="fieldcontain">
					<span id="stockManufacturedTime-label" class="property-label"><g:message code="stock.stockManufacturedTime.label" default="Stock Manufactured Time" /></span>
					
						<span class="property-value" aria-labelledby="stockManufacturedTime-label"><g:formatDate date="${stockInstance?.stockManufacturedTime}" /></span>
					
				</li>
				</g:if>
				
				<g:if test="${stockInstance?.availabilityStatus}">
				<li class="fieldcontain">
					<span id="availabilityStatus-label" class="property-label"><g:message code="stock.availabilityStatus.label" default="Availability Status" /></span>
					
						<span class="property-value" aria-labelledby="availabilityStatus-label"><g:formatBoolean boolean="${stockInstance?.availabilityStatus}" /></span>
					
				</li>
				</g:if>
				
				<g:if test="${stockInstance?.machine}">
				<li class="fieldcontain">
					<span id="machine-label" class="property-label"><g:message code="stock.machine.label" default="Machine" /></span>
					
						<span class="property-value" aria-labelledby="machine-label">${stockInstance?.machine?.encodeAsHTML()}</span>
					
				</li>
				</g:if>
				
				<g:if test="${stockInstance?.wireBrand}">
				<li class="fieldcontain">
					<span id="wireBrand-label" class="property-label"><g:message code="stock.wireBrand.label" default="Wire Brand" /></span>
					
						<span class="property-value" aria-labelledby="wireBrand-label">${stockInstance?.wireBrand?.encodeAsHTML()}</span>
					
				</li>
				</g:if>
				
				<g:if test="${stockInstance?.stockId}">
				<li class="fieldcontain">
					<span id="stockId-label" class="property-label"><g:message code="stock.stockId.label" default="Stock Id" /></span>
					
						<span class="property-value" aria-labelledby="stockId-label"><g:fieldValue bean="${stockInstance}" field="stockId"/></span>
					
				</li>
				</g:if>
			
				
			
				<g:if test="${stockInstance?.stockOrderItems}">
				<li class="fieldcontain">
					<span id="stockOrderItems-label" class="property-label"><g:message code="stock.stockOrderItems.label" default="Stock Order Items" /></span>
					
						<g:each in="${stockInstance.stockOrderItems}" var="s">
						<span class="property-value" aria-labelledby="stockOrderItems-label"><g:link controller="stockOrder" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${stockInstance?.createdBy}">
				<li class="fieldcontain">
					<span id="createdBy-label" class="property-label"><g:message code="stock.createdBy.label" default="Created By" /></span>
					
						<span class="property-value" aria-labelledby="createdBy-label"><g:link controller="user" action="show" id="${stockInstance?.createdBy?.id}">${stockInstance?.createdBy?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${stockInstance?.createdDate}">
				<li class="fieldcontain">
					<span id="createdDate-label" class="property-label"><g:message code="stock.createdDate.label" default="Created Date" /></span>
					
						<span class="property-value" aria-labelledby="createdDate-label"><g:formatDate date="${stockInstance?.createdDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${stockInstance?.lastEditedBy}">
				<li class="fieldcontain">
					<span id="lastEditedBy-label" class="property-label"><g:message code="stock.lastEditedBy.label" default="Last Edited By" /></span>
					
						<span class="property-value" aria-labelledby="lastEditedBy-label"><g:link controller="user" action="show" id="${stockInstance?.lastEditedBy?.id}">${stockInstance?.lastEditedBy?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${stockInstance?.lastEditedDate}">
				<li class="fieldcontain">
					<span id="lastEditedDate-label" class="property-label"><g:message code="stock.lastEditedDate.label" default="Last Edited Date" /></span>
					
						<span class="property-value" aria-labelledby="lastEditedDate-label"><g:formatDate date="${stockInstance?.lastEditedDate}" /></span>
					
				</li>
				</g:if>
			
				
			
			</ol>--%>
			
			<table class="table table-bordered">
							
				    <tr>
				        <th align="left">Stock Id:</th>
				        <td>${stockInstance.stockId}</td>
				    </tr>
				    <tr>
				        <th align="left">Sheet Specification:</th>
				        <td>${stockInstance.sheetSpec}</td>
				    </tr>
				    <tr>
				        <th align="left">Wire Brand:</th>
				        <td>${stockInstance.wireBrand}</td>
				    </tr>
				    <tr>
				        <th align="left">Machine:</th>
				        <td>${stockInstance.machine}</td>
				    </tr>
				    
				    <tr>
				        <th align="left">Stock Manufactured Time:</th>
				        <td>${stockInstance.stockManufacturedTime}</td>
				    </tr>
				    <tr>
				        <th align="left">No Of Manufactured:</th>
				        <td>${stockInstance.noOfManufactured}</td>
				    </tr>
				    <tr>
				        <th align="left">No Of InStock:</th>
				        <td>${stockInstance.noOfInStock}</td>
				    </tr>
				    <tr>
				        <th align="left">Mending:</th>
				        <td>${stockInstance.mending}</td>
				    </tr>
				    <tr>
				        <th align="left">Availability Status:</th>
				        <td>${stockInstance.availabilityStatus}</td>
				    </tr>
				     <tr>
				        <th align="left">Comments:</th>
				        <td>${stockInstance.comments}</td>
				    </tr>
				    				    						
			</table>
			<br>			
			
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${stockInstance?.id}" />
					<sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_PRODMANAGER"><g:link class="edit" action="edit" id="${stockInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link></sec:ifAnyGranted>
					<sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_PRODMANAGER"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></sec:ifAnyGranted>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
