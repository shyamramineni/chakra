
<%@ page import="com.chakra.production.ProductionReporting" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'productionReporting.label', default: 'ProductionReporting')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-productionReporting" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-productionReporting" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="alert alert-success" role="status">${flash.message}</div>
			</g:if>
			<%--<ol class="property-list productionReporting">
			
				<g:if test="${productionReportingInstance?.createdBy}">
				<li class="fieldcontain">
					<span id="createdBy-label" class="property-label"><g:message code="productionReporting.createdBy.label" default="Created By" /></span>
					
						<span class="property-value" aria-labelledby="createdBy-label"><g:fieldValue bean="${productionReportingInstance}" field="createdBy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${productionReportingInstance?.createdDate}">
				<li class="fieldcontain">
					<span id="createdDate-label" class="property-label"><g:message code="productionReporting.createdDate.label" default="Created Date" /></span>
					
						<span class="property-value" aria-labelledby="createdDate-label"><g:formatDate date="${productionReportingInstance?.createdDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${productionReportingInstance?.editedDate}">
				<li class="fieldcontain">
					<span id="editedDate-label" class="property-label"><g:message code="productionReporting.editedDate.label" default="Edited Date" /></span>
					
						<span class="property-value" aria-labelledby="editedDate-label"><g:formatDate date="${productionReportingInstance?.editedDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${productionReportingInstance?.lastEditedBy}">
				<li class="fieldcontain">
					<span id="lastEditedBy-label" class="property-label"><g:message code="productionReporting.lastEditedBy.label" default="Last Edited By" /></span>
					
						<span class="property-value" aria-labelledby="lastEditedBy-label"><g:fieldValue bean="${productionReportingInstance}" field="lastEditedBy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${productionReportingInstance?.machine}">
				<li class="fieldcontain">
					<span id="machine-label" class="property-label"><g:message code="productionReporting.machine.label" default="Machine" /></span>
					
						<span class="property-value" aria-labelledby="machine-label"><g:link controller="machine" action="show" id="${productionReportingInstance?.machine?.id}">${productionReportingInstance?.machine?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${productionReportingInstance?.sheetSpecifcation}">
				<li class="fieldcontain">
					<span id="sheetSpecifcation-label" class="property-label"><g:message code="productionReporting.sheetSpecifcation.label" default="Sheet Specifcation" /></span>
					
						<span class="property-value" aria-labelledby="sheetSpecifcation-label"><g:link controller="sheetSpecification" action="show" id="${productionReportingInstance?.sheetSpecifcation?.id}">${productionReportingInstance?.sheetSpecifcation?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${productionReportingInstance?.stockManufacturedTime}">
				<li class="fieldcontain">
					<span id="stockManufacturedTime-label" class="property-label"><g:message code="productionReporting.stockManufacturedTime.label" default="Stock Manufactured Time" /></span>
					
						<span class="property-value" aria-labelledby="stockManufacturedTime-label"><g:formatDate date="${productionReportingInstance?.stockManufacturedTime}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${productionReportingInstance?.totalQuantity}">
				<li class="fieldcontain">
					<span id="totalQuantity-label" class="property-label"><g:message code="productionReporting.totalQuantity.label" default="Total Quantity" /></span>
					
						<span class="property-value" aria-labelledby="totalQuantity-label"><g:fieldValue bean="${productionReportingInstance}" field="totalQuantity"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${productionReportingInstance?.wireBrand}">
				<li class="fieldcontain">
					<span id="wireBrand-label" class="property-label"><g:message code="productionReporting.wireBrand.label" default="Wire Brand" /></span>
					
						<span class="property-value" aria-labelledby="wireBrand-label"><g:link controller="wireBrand" action="show" id="${productionReportingInstance?.wireBrand?.id}">${productionReportingInstance?.wireBrand?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			--%>
			<br>
			<table class="table table-bordered">
							
				    <tr>
				        <th align="left">Sheet Specification:</th>
				        <td>${productionReportingInstance.sheetSpecifcation}</td>
				    </tr>
				    <tr>
				        <th align="left">Wire Brand:</th>
				        <td>${productionReportingInstance.wireBrand}</td>
				    </tr>
				    <tr>
				        <th align="left">Machine:</th>
				        <td>${productionReportingInstance.machine}</td>
				    </tr>
				    <tr>
				        <th align="left">Total Quantity:</th>
				        <td>${productionReportingInstance.totalQuantity}</td>
				    </tr>
				    <tr>
				        <th align="left">Mending:</th>
				        <td>${productionReportingInstance.mending}</td>
				    </tr>
				    <tr>
				        <th align="left">Stock Manufactured Time:</th>
				        <td>${productionReportingInstance.stockManufacturedTime}</td>
				    </tr>
				    <tr>
				        <th align="left">Created By:</th>
				        <td>${productionReportingInstance.createdBy}</td>
				    </tr>
				    <tr>
				        <th align="left">Created Date:</th>
				        <td>${productionReportingInstance.createdDate}</td>
				    </tr>
				     <tr>
				        <th align="left">Comments:</th>
				        <td>${productionReportingInstance.comments}</td>
				    </tr>
				    				    						
			</table>
			<br>
			
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${productionReportingInstance?.id}" />
					<sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_PRODMANAGER"><g:link class="btn btn-primary" action="edit" id="${productionReportingInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link></sec:ifAnyGranted>
					<%--<sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_PRODMANAGER"><g:link class="btn btn-primary" action="cancel" id="${productionReportingInstance?.id}"><g:message code="default.button.cancel.label" default="Cancel" /></g:link></sec:ifAnyGranted>
					--%><sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_PRODMANAGER"><g:actionSubmit class="btn btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></sec:ifAnyGranted>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
