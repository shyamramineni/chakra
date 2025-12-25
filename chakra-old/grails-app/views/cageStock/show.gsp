
<%@ page import="com.chakra.stock.CageStock" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cageStock.label', default: 'CageStock')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-cageStock" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-cageStock" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<%--<ol class="property-list cageStock">
			
				<g:if test="${cageStockInstance?.noOfPurchased}">
				<li class="fieldcontain">
					<span id="noOfPurchased-label" class="property-label"><g:message code="cageStock.noOfPurchased.label" default="No Of Purchased" /></span>
					
						<span class="property-value" aria-labelledby="noOfPurchased-label"><g:fieldValue bean="${cageStockInstance}" field="noOfPurchased"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${cageStockInstance?.noOfInStock}">
				<li class="fieldcontain">
					<span id="noOfInStock-label" class="property-label"><g:message code="cageStock.noOfInStock.label" default="No Of In Stock" /></span>
					
						<span class="property-value" aria-labelledby="noOfInStock-label"><g:fieldValue bean="${cageStockInstance}" field="noOfInStock"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${cageStockInstance?.cagePartSpecFormula}">
				<li class="fieldcontain">
					<span id="cagePartSpecFormula-label" class="property-label"><g:message code="cageStock.cagePartSpecFormula.label" default="Cage Part Spec Formula" /></span>
					
						<span class="property-value" aria-labelledby="cagePartSpecFormula-label"><g:link controller="cagePartSpecFormula" action="show" id="${cageStockInstance?.cagePartSpecFormula?.id}">${cageStockInstance?.cagePartSpecFormula?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${cageStockInstance?.comments}">
				<li class="fieldcontain">
					<span id="comments-label" class="property-label"><g:message code="cageStock.comments.label" default="Comments" /></span>
					
						<span class="property-value" aria-labelledby="comments-label"><g:fieldValue bean="${cageStockInstance}" field="comments"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${cageStockInstance?.cageStockId}">
				<li class="fieldcontain">
					<span id="cageStockId-label" class="property-label"><g:message code="cageStock.cageStockId.label" default="Cage Stock Id" /></span>
					
						<span class="property-value" aria-labelledby="cageStockId-label"><g:fieldValue bean="${cageStockInstance}" field="cageStockId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${cageStockInstance?.createdBy}">
				<li class="fieldcontain">
					<span id="createdBy-label" class="property-label"><g:message code="cageStock.createdBy.label" default="Created By" /></span>
					
						<span class="property-value" aria-labelledby="createdBy-label"><g:link controller="user" action="show" id="${cageStockInstance?.createdBy?.id}">${cageStockInstance?.createdBy?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${cageStockInstance?.createdDate}">
				<li class="fieldcontain">
					<span id="createdDate-label" class="property-label"><g:message code="cageStock.createdDate.label" default="Created Date" /></span>
					
						<span class="property-value" aria-labelledby="createdDate-label"><g:formatDate date="${cageStockInstance?.createdDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${cageStockInstance?.lastEditedBy}">
				<li class="fieldcontain">
					<span id="lastEditedBy-label" class="property-label"><g:message code="cageStock.lastEditedBy.label" default="Last Edited By" /></span>
					
						<span class="property-value" aria-labelledby="lastEditedBy-label"><g:link controller="user" action="show" id="${cageStockInstance?.lastEditedBy?.id}">${cageStockInstance?.lastEditedBy?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${cageStockInstance?.lastEditedDate}">
				<li class="fieldcontain">
					<span id="lastEditedDate-label" class="property-label"><g:message code="cageStock.lastEditedDate.label" default="Last Edited Date" /></span>
					
						<span class="property-value" aria-labelledby="lastEditedDate-label"><g:formatDate date="${cageStockInstance?.lastEditedDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${cageStockInstance?.availabilityStatus}">
				<li class="fieldcontain">
					<span id="availabilityStatus-label" class="property-label"><g:message code="cageStock.availabilityStatus.label" default="Availability Status" /></span>
					
						<span class="property-value" aria-labelledby="availabilityStatus-label"><g:formatBoolean boolean="${cageStockInstance?.availabilityStatus}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${cageStockInstance?.cageStockOrderItems}">
				<li class="fieldcontain">
					<span id="cageStockOrderItems-label" class="property-label"><g:message code="cageStock.cageStockOrderItems.label" default="Cage Stock Order Items" /></span>
					
						<g:each in="${cageStockInstance.cageStockOrderItems}" var="c">
						<span class="property-value" aria-labelledby="cageStockOrderItems-label"><g:link controller="cageStockOrder" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${cageStockInstance?.purchasedTime}">
				<li class="fieldcontain">
					<span id="purchasedTime-label" class="property-label"><g:message code="cageStock.purchasedTime.label" default="Purchased Time" /></span>
					
						<span class="property-value" aria-labelledby="purchasedTime-label"><g:formatDate date="${cageStockInstance?.purchasedTime}" /></span>
					
				</li>
				</g:if>
			
			</ol>--%>
			
			<table class="table table-bordered">
							
				    <tr>
				        <th align="left">CageStock Id:</th>
				        <td>${cageStockInstance?.cageStockId}</td>
				    </tr>
				    <tr>
				        <th align="left">Cage Part:</th>
				        <td>${cageStockInstance?.cagePart}</td>
				    </tr>
				    <tr>
				        <th align="left">No Of Purchased:</th>
				        <td>${cageStockInstance?.noOfPurchased}</td>
				    </tr>
				    <tr>
				        <th align="left">No Of InStock:</th>
				        <td>${cageStockInstance?.noOfInStock}</td>
				    </tr>
				    <tr>
				        <th align="left">Purchased Time:</th>
				        <td>${cagePartTypeInstance?.purchasedTime}</td>
				    </tr>
				    <tr>
				        <th align="left">Availability Status:</th>
				        <td>${cagePartTypeInstance?.availabilityStatus}</td>
				    </tr>
				    <tr>
				        <th align="left">Description:</th>
				        <td>${cagePartTypeInstance?.description}</td>
				    </tr>
				    				    				    				    						
			</table>
			<br>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${cageStockInstance?.id}" />
					<g:link class="btn btn-primary" action="edit" id="${cageStockInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="btn btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
