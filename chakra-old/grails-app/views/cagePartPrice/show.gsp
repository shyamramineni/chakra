
<%@ page import="com.chakra.config.CagePartPrice" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cagePartPrice.label', default: 'CagePartPrice')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-cagePartPrice" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-cagePartPrice" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<%--<ol class="property-list cagePartPrice">
			
				<g:if test="${cagePartPriceInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="cagePartPrice.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${cagePartPriceInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${cagePartPriceInstance?.cagePart}">
				<li class="fieldcontain">
					<span id="cagePart-label" class="property-label"><g:message code="cagePartPrice.cagePart.label" default="Cage Part" /></span>
					
						<span class="property-value" aria-labelledby="cagePart-label"><g:link controller="cagePart" action="show" id="${cagePartPriceInstance?.cagePart?.id}">${cagePartPriceInstance?.cagePart?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${cagePartPriceInstance?.endDate}">
				<li class="fieldcontain">
					<span id="endDate-label" class="property-label"><g:message code="cagePartPrice.endDate.label" default="End Date" /></span>
					
						<span class="property-value" aria-labelledby="endDate-label"><g:formatDate date="${cagePartPriceInstance?.endDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${cagePartPriceInstance?.price}">
				<li class="fieldcontain">
					<span id="price-label" class="property-label"><g:message code="cagePartPrice.price.label" default="Price" /></span>
					
						<span class="property-value" aria-labelledby="price-label"><g:fieldValue bean="${cagePartPriceInstance}" field="price"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${cagePartPriceInstance?.startDate}">
				<li class="fieldcontain">
					<span id="startDate-label" class="property-label"><g:message code="cagePartPrice.startDate.label" default="Start Date" /></span>
					
						<span class="property-value" aria-labelledby="startDate-label"><g:formatDate date="${cagePartPriceInstance?.startDate}" /></span>
					
				</li>
				</g:if>
			
			</ol>--%>
			
			<table class="table table-bordered">
				<tr>
			        <th align="left">CagePart:</th>
			        <td>${cagePartPriceInstance?.cagePart}</td>
			    </tr>
			    <tr>
			        <th align="left">CagePart Price:</th>
			        <td>${cagePartPriceInstance?.price}</td>
			    </tr>
			    <tr>
			        <th align="left">Start Date:</th>
			        <td>${cagePartPriceInstance?.startDate}</td>
			    </tr>
			    <tr>
			        <th align="left">End Date:</th>
			        <td>${cagePartPriceInstance?.endDate}</td>
			    </tr>
			    <tr>
			        <th align="left">Description:</th>
			        <td>${cagePartPriceInstance?.description}</td>
			    </tr>
			</table>
			
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${cagePartPriceInstance?.id}" />
					<g:link class="edit" action="edit" id="${cagePartPriceInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
