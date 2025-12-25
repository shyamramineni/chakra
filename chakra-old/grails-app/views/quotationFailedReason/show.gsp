
<%@ page import="com.chakra.config.QuotationFailedReason" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quotationFailedReason.label', default: 'QuotationFailedReason')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-quotationFailedReason" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-quotationFailedReason" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<%--<ol class="property-list quotationFailedReason">
			
				<g:if test="${quotationFailedReasonInstance?.quotationFailedReason}">
				<li class="fieldcontain">
					<span id="quotationFailedReason-label" class="property-label"><g:message code="quotationFailedReason.quotationFailedReason.label" default="Quotation Failed Reason" /></span>
					
						<span class="property-value" aria-labelledby="quotationFailedReason-label"><g:fieldValue bean="${quotationFailedReasonInstance}" field="quotationFailedReason"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationFailedReasonInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="quotationFailedReason.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${quotationFailedReasonInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
			</ol>
			--%>
			
			<table class="table table-bordered">
							
				    <tr>
				        <th align="left">Quotation Failed Reason:</th>
				        <td>${quotationFailedReasonInstance.quotationFailedReason}</td>
				    </tr>
				    <tr>
				        <th align="left">Description:</th>
				        <td>${quotationFailedReasonInstance.description}</td>
				    </tr>				    
				    				    				    				    						
			</table>
			<br>
			
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${quotationFailedReasonInstance?.id}" />
					<g:link class="edit" action="edit" id="${quotationFailedReasonInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
