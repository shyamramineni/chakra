
<%@ page import="com.chakra.production.ChainLinkReporting" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'chainLinkReporting.label', default: 'ChainLinkReporting')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-chainLinkReporting" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-chainLinkReporting" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list chainLinkReporting">
			
				<g:if test="${chainLinkReportingInstance?.machine}">
				<li class="fieldcontain">
					<span id="machine-label" class="property-label"><g:message code="chainLinkReporting.machine.label" default="Machine" /></span>
					
						<span class="property-value" aria-labelledby="machine-label"><g:link controller="machine" action="show" id="${chainLinkReportingInstance?.machine?.id}">${chainLinkReportingInstance?.machine?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${chainLinkReportingInstance?.linkMesh}">
				<li class="fieldcontain">
					<span id="linkMesh-label" class="property-label"><g:message code="chainLinkReporting.linkMesh.label" default="Link Mesh" /></span>
					
						<span class="property-value" aria-labelledby="linkMesh-label"><g:link controller="linkMesh" action="show" id="${chainLinkReportingInstance?.linkMesh?.id}">${chainLinkReportingInstance?.linkMesh?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${chainLinkReportingInstance?.wireBrand}">
				<li class="fieldcontain">
					<span id="wireBrand-label" class="property-label"><g:message code="chainLinkReporting.wireBrand.label" default="Wire Brand" /></span>
					
						<span class="property-value" aria-labelledby="wireBrand-label"><g:link controller="wireBrand" action="show" id="${chainLinkReportingInstance?.wireBrand?.id}">${chainLinkReportingInstance?.wireBrand?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${chainLinkReportingInstance?.chainLinkStock}">
				<li class="fieldcontain">
					<span id="chainLinkStock-label" class="property-label"><g:message code="chainLinkReporting.chainLinkStock.label" default="Chain Link Stock" /></span>
					
						<span class="property-value" aria-labelledby="chainLinkStock-label"><g:link controller="chainLinkStock" action="show" id="${chainLinkReportingInstance?.chainLinkStock?.id}">${chainLinkReportingInstance?.chainLinkStock?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${chainLinkReportingInstance?.createdBy}">
				<li class="fieldcontain">
					<span id="createdBy-label" class="property-label"><g:message code="chainLinkReporting.createdBy.label" default="Created By" /></span>
					
						<span class="property-value" aria-labelledby="createdBy-label"><g:fieldValue bean="${chainLinkReportingInstance}" field="createdBy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${chainLinkReportingInstance?.createdDate}">
				<li class="fieldcontain">
					<span id="createdDate-label" class="property-label"><g:message code="chainLinkReporting.createdDate.label" default="Created Date" /></span>
					
						<span class="property-value" aria-labelledby="createdDate-label"><g:formatDate date="${chainLinkReportingInstance?.createdDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${chainLinkReportingInstance?.lastEditedBy}">
				<li class="fieldcontain">
					<span id="lastEditedBy-label" class="property-label"><g:message code="chainLinkReporting.lastEditedBy.label" default="Last Edited By" /></span>
					
						<span class="property-value" aria-labelledby="lastEditedBy-label"><g:fieldValue bean="${chainLinkReportingInstance}" field="lastEditedBy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${chainLinkReportingInstance?.editedDate}">
				<li class="fieldcontain">
					<span id="editedDate-label" class="property-label"><g:message code="chainLinkReporting.editedDate.label" default="Edited Date" /></span>
					
						<span class="property-value" aria-labelledby="editedDate-label"><g:formatDate date="${chainLinkReportingInstance?.editedDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${chainLinkReportingInstance?.comments}">
				<li class="fieldcontain">
					<span id="comments-label" class="property-label"><g:message code="chainLinkReporting.comments.label" default="Comments" /></span>
					
						<span class="property-value" aria-labelledby="comments-label"><g:fieldValue bean="${chainLinkReportingInstance}" field="comments"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${chainLinkReportingInstance?.chainLinkReportingWireWeightList}">
				<li class="fieldcontain">
					<span id="chainLinkReportingWireWeightList-label" class="property-label"><g:message code="chainLinkReporting.chainLinkReportingWireWeightList.label" default="Chain Link Reporting Wire Weight List" /></span>
					
						<g:each in="${chainLinkReportingInstance.chainLinkReportingWireWeightList}" var="c">
						<span class="property-value" aria-labelledby="chainLinkReportingWireWeightList-label"><g:link controller="chainLinkReportingWireWeight" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${chainLinkReportingInstance?.stockManufacturedTime}">
				<li class="fieldcontain">
					<span id="stockManufacturedTime-label" class="property-label"><g:message code="chainLinkReporting.stockManufacturedTime.label" default="Stock Manufactured Time" /></span>
					
						<span class="property-value" aria-labelledby="stockManufacturedTime-label"><g:formatDate date="${chainLinkReportingInstance?.stockManufacturedTime}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${chainLinkReportingInstance?.totalQuantity}">
				<li class="fieldcontain">
					<span id="totalQuantity-label" class="property-label"><g:message code="chainLinkReporting.totalQuantity.label" default="Total Quantity" /></span>
					
						<span class="property-value" aria-labelledby="totalQuantity-label"><g:fieldValue bean="${chainLinkReportingInstance}" field="totalQuantity"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${chainLinkReportingInstance?.id}" />
					<g:link class="edit" action="edit" id="${chainLinkReportingInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
