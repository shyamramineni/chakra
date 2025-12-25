
<%@ page import="com.chakra.production.CagePartReporting" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cagePartReporting.label', default: 'CagePartReporting')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-cagePartReporting" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-cagePartReporting" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<%--<ol class="property-list cagePartReporting">
			
				<g:if test="${cagePartReportingInstance?.cagePart}">
				<li class="fieldcontain">
					<span id="cagePart-label" class="property-label"><g:message code="cagePartReporting.cagePart.label" default="Cage Part" /></span>
					
						<span class="property-value" aria-labelledby="cagePart-label"><g:link controller="cagePart" action="show" id="${cagePartReportingInstance?.cagePart?.id}">${cagePartReportingInstance?.cagePart?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${cagePartReportingInstance?.cageStock}">
				<li class="fieldcontain">
					<span id="cageStock-label" class="property-label"><g:message code="cagePartReporting.cageStock.label" default="Cage Stock" /></span>
					
						<span class="property-value" aria-labelledby="cageStock-label"><g:link controller="cageStock" action="show" id="${cagePartReportingInstance?.cageStock?.id}">${cagePartReportingInstance?.cageStock?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${cagePartReportingInstance?.createdBy}">
				<li class="fieldcontain">
					<span id="createdBy-label" class="property-label"><g:message code="cagePartReporting.createdBy.label" default="Created By" /></span>
					
						<span class="property-value" aria-labelledby="createdBy-label"><g:fieldValue bean="${cagePartReportingInstance}" field="createdBy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${cagePartReportingInstance?.createdDate}">
				<li class="fieldcontain">
					<span id="createdDate-label" class="property-label"><g:message code="cagePartReporting.createdDate.label" default="Created Date" /></span>
					
						<span class="property-value" aria-labelledby="createdDate-label"><g:formatDate date="${cagePartReportingInstance?.createdDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${cagePartReportingInstance?.lastEditedBy}">
				<li class="fieldcontain">
					<span id="lastEditedBy-label" class="property-label"><g:message code="cagePartReporting.lastEditedBy.label" default="Last Edited By" /></span>
					
						<span class="property-value" aria-labelledby="lastEditedBy-label"><g:fieldValue bean="${cagePartReportingInstance}" field="lastEditedBy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${cagePartReportingInstance?.editedDate}">
				<li class="fieldcontain">
					<span id="editedDate-label" class="property-label"><g:message code="cagePartReporting.editedDate.label" default="Edited Date" /></span>
					
						<span class="property-value" aria-labelledby="editedDate-label"><g:formatDate date="${cagePartReportingInstance?.editedDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${cagePartReportingInstance?.comments}">
				<li class="fieldcontain">
					<span id="comments-label" class="property-label"><g:message code="cagePartReporting.comments.label" default="Comments" /></span>
					
						<span class="property-value" aria-labelledby="comments-label"><g:fieldValue bean="${cagePartReportingInstance}" field="comments"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${cagePartReportingInstance?.stockPurchasedTime}">
				<li class="fieldcontain">
					<span id="stockPurchasedTime-label" class="property-label"><g:message code="cagePartReporting.stockPurchasedTime.label" default="Stock Purchased Time" /></span>
					
						<span class="property-value" aria-labelledby="stockPurchasedTime-label"><g:formatDate date="${cagePartReportingInstance?.stockPurchasedTime}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${cagePartReportingInstance?.totalQuantity}">
				<li class="fieldcontain">
					<span id="totalQuantity-label" class="property-label"><g:message code="cagePartReporting.totalQuantity.label" default="Total Quantity" /></span>
					
						<span class="property-value" aria-labelledby="totalQuantity-label"><g:fieldValue bean="${cagePartReportingInstance}" field="totalQuantity"/></span>
					
				</li>
				</g:if>
			
			</ol>--%>
			
			<br>
			<table class="table table-bordered">
							
				    <tr>
				        <th align="left">CagePart Name:</th>
				        <td>${cagePartReportingInstance.cagePart}</td>
				    </tr>
				    <tr>
				        <th align="left">Stock Purchased Date:</th>
				        <td>${cagePartReportingInstance.stockPurchasedTime}</td>
				    </tr>
				    <tr>
				        <th align="left">Total Quantity:</th>
				        <td>${cagePartReportingInstance.totalQuantity}</td>
				    </tr>
				    <tr>
				        <th align="left">Created By:</th>
				        <td>${cagePartReportingInstance.createdBy}</td>
				    </tr>
				    <tr>
				        <th align="left">Created Date:</th>
				        <td>${cagePartReportingInstance.createdDate}</td>
				    </tr>
				     <tr>
				        <th align="left">Comments:</th>
				        <td>${cagePartReportingInstance.comments}</td>
				    </tr>
				    				    						
			</table>
			<br>
			
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${cagePartReportingInstance?.id}" />
					<g:link class="edit" action="edit" id="${cagePartReportingInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
