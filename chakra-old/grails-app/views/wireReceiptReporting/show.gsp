
<%@ page import="com.chakra.rawmaterial.WireReceiptReporting" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'wireReceiptReporting.label', default: 'WireReceiptReporting')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-wireReceiptReporting" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-wireReceiptReporting" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="alert alert-success" role="status">${flash.message}</div>
			</g:if>
			<%--<ol class="property-list wireReceiptReporting">
			
				<g:if test="${wireReceiptReportingInstance?.wireBrand}">
				<li class="fieldcontain">
					<span id="wireBrand-label" class="property-label"><g:message code="wireReceiptReporting.wireBrand.label" default="Wire Brand" /></span>
					
						<span class="property-value" aria-labelledby="wireBrand-label"><g:link controller="wireBrand" action="show" id="${wireReceiptReportingInstance?.wireBrand?.id}">${wireReceiptReportingInstance?.wireBrand?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${wireReceiptReportingInstance?.wireDiameter}">
				<li class="fieldcontain">
					<span id="wireDiameter-label" class="property-label"><g:message code="wireReceiptReporting.wireDiameter.label" default="Wire Diameter" /></span>
					
						<span class="property-value" aria-labelledby="wireDiameter-label"><g:fieldValue bean="${wireReceiptReportingInstance}" field="wireDiameter"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${wireReceiptReportingInstance?.weightPurchased}">
				<li class="fieldcontain">
					<span id="weightPurchased-label" class="property-label"><g:message code="wireReceiptReporting.weightPurchased.label" default="Weight Purchased" /></span>
					
						<span class="property-value" aria-labelledby="weightPurchased-label"><g:fieldValue bean="${wireReceiptReportingInstance}" field="weightPurchased"/></span>
					
				</li>
				</g:if>
				
				<g:if test="${wireReceiptReportingInstance?.weightInStock}">
				<li class="fieldcontain">
					<span id="weightInStock-label" class="property-label"><g:message code="wireReceiptReporting.weightInStock.label" default="Weight In Stock" /></span>
					
						<span class="property-value" aria-labelledby="weightInStock-label"><g:fieldValue bean="${wireReceiptReportingInstance}" field="weightInStock"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${wireReceiptReportingInstance?.createdBy}">
				<li class="fieldcontain">
					<span id="createdBy-label" class="property-label"><g:message code="wireReceiptReporting.createdBy.label" default="Created By" /></span>
					
						<span class="property-value" aria-labelledby="createdBy-label"><g:fieldValue bean="${wireReceiptReportingInstance}" field="createdBy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${wireReceiptReportingInstance?.createdDate}">
				<li class="fieldcontain">
					<span id="createdDate-label" class="property-label"><g:message code="wireReceiptReporting.createdDate.label" default="Created Date" /></span>
					
						<span class="property-value" aria-labelledby="createdDate-label"><g:formatDate date="${wireReceiptReportingInstance?.createdDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${wireReceiptReportingInstance?.lastEditedBy}">
				<li class="fieldcontain">
					<span id="lastEditedBy-label" class="property-label"><g:message code="wireReceiptReporting.lastEditedBy.label" default="Last Edited By" /></span>
					
						<span class="property-value" aria-labelledby="lastEditedBy-label"><g:fieldValue bean="${wireReceiptReportingInstance}" field="lastEditedBy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${wireReceiptReportingInstance?.editedDate}">
				<li class="fieldcontain">
					<span id="editedDate-label" class="property-label"><g:message code="wireReceiptReporting.editedDate.label" default="Edited Date" /></span>
					
						<span class="property-value" aria-labelledby="editedDate-label"><g:formatDate date="${wireReceiptReportingInstance?.editedDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${wireReceiptReportingInstance?.availabilityStatus}">
				<li class="fieldcontain">
					<span id="availabilityStatus-label" class="property-label"><g:message code="wireReceiptReporting.availabilityStatus.label" default="Availability Status" /></span>
					
						<span class="property-value" aria-labelledby="availabilityStatus-label"><g:formatBoolean boolean="${wireReceiptReportingInstance?.availabilityStatus}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${wireReceiptReportingInstance?.productionReportingWireWeightList}">
				<li class="fieldcontain">
					<span id="productionReportingWireWeightList-label" class="property-label"><g:message code="wireReceiptReporting.productionReportingWireWeightList.label" default="Production Reporting Wire Weight List" /></span>
					
						<g:each in="${wireReceiptReportingInstance.productionReportingWireWeightList}" var="p">
						<span class="property-value" aria-labelledby="productionReportingWireWeightList-label"><g:link controller="productionReportingWireWeight" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${wireReceiptReportingInstance?.purchaseDate}">
				<li class="fieldcontain">
					<span id="purchaseDate-label" class="property-label"><g:message code="wireReceiptReporting.purchaseDate.label" default="Purchase Date" /></span>
					
						<span class="property-value" aria-labelledby="purchaseDate-label"><g:formatDate date="${wireReceiptReportingInstance?.purchaseDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${wireReceiptReportingInstance?.weightInStock}">
				<li class="fieldcontain">
					<span id="weightInStock-label" class="property-label"><g:message code="wireReceiptReporting.weightInStock.label" default="Weight In Stock" /></span>
					
						<span class="property-value" aria-labelledby="weightInStock-label"><g:fieldValue bean="${wireReceiptReportingInstance}" field="weightInStock"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${wireReceiptReportingInstance?.weightPurchased}">
				<li class="fieldcontain">
					<span id="weightPurchased-label" class="property-label"><g:message code="wireReceiptReporting.weightPurchased.label" default="Weight Purchased" /></span>
					
						<span class="property-value" aria-labelledby="weightPurchased-label"><g:fieldValue bean="${wireReceiptReportingInstance}" field="weightPurchased"/></span>
					
				</li>
				</g:if>
			
			</ol>
			--%>
			<br>
			<table class="table table-bordered">
							
				    <tr>
				        <th align="left">WireBrand:</th>
				        <td>${wireReceiptReportingInstance.wireBrand}</td>
				    </tr>
				    <tr>
				        <th align="left">Wire Diameter:</th>
				        <td>${wireReceiptReportingInstance.wireDiameter}</td>
				    </tr>
				    <tr>
				        <th align="left">Weight Purchased:</th>
				        <td>${wireReceiptReportingInstance.weightPurchased}</td>
				    </tr>
				    <tr>
				        <th align="left">Weight In Stock:</th>
				        <td>${wireReceiptReportingInstance.weightInStock}</td>
				    </tr>
				    <tr>
				        <th align="left">Purchase Date:</th>
				        <td>${wireReceiptReportingInstance.purchaseDate}</td>
				    </tr>
				    <tr>
				        <th align="left">Availability Status:</th>
				        <td>${wireReceiptReportingInstance.availabilityStatus}</td>
				    </tr>
				    <tr>
				        <th align="left">Created By:</th>
				        <td>${wireReceiptReportingInstance.createdBy}</td>
				    </tr>
				    <tr>
				        <th align="left">Created Date:</th>
				        <td>${wireReceiptReportingInstance.createdDate}</td>
				    </tr>
				    <tr>
				        <th align="left">Comments:</th>
				        <td>${wireReceiptReportingInstance.comments}</td>
				    </tr>
				    				    						
			</table>
			<br>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${wireReceiptReportingInstance?.id}" />
					<sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_PRODMANAGER"><g:link class="btn btn-primary" action="edit" id="${wireReceiptReportingInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link></sec:ifAnyGranted>
					<sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_PRODMANAGER"><g:actionSubmit class="btn btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></sec:ifAnyGranted>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
