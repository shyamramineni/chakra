
<%@ page import="com.chakra.config.CagePart" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cagePart.label', default: 'CagePart')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-cagePart" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-cagePart" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<%--<ol class="property-list cagePart">
			
				<g:if test="${cagePartInstance?.cagePart}">
				<li class="fieldcontain">
					<span id="cagePart-label" class="property-label"><g:message code="cagePart.cagePart.label" default="Cage Part" /></span>
					
						<span class="property-value" aria-labelledby="cagePart-label"><g:fieldValue bean="${cagePartInstance}" field="cagePart"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${cagePartInstance?.cagePartCode}">
				<li class="fieldcontain">
					<span id="cagePartCode-label" class="property-label"><g:message code="cagePart.cagePartCode.label" default="Cage Part Code" /></span>
					
						<span class="property-value" aria-labelledby="cagePartCode-label"><g:fieldValue bean="${cagePartInstance}" field="cagePartCode"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${cagePartInstance?.image}">
				<li class="fieldcontain">
					<span id="image-label" class="property-label"><g:message code="cagePart.image.label" default="Image" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${cagePartInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="cagePart.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${cagePartInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${cagePartInstance?.parentCagePart}">
				<li class="fieldcontain">
					<span id="parentCagePart-label" class="property-label"><g:message code="cagePart.parentCagePart.label" default="Parent Cage Part" /></span>
					
						<span class="property-value" aria-labelledby="parentCagePart-label"><g:link controller="cagePart" action="show" id="${cagePartInstance?.parentCagePart?.id}">${cagePartInstance?.parentCagePart?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${cagePartInstance?.formula}">
				<li class="fieldcontain">
					<span id="formula-label" class="property-label"><g:message code="cagePart.formula.label" default="Formula" /></span>
					
						<span class="property-value" aria-labelledby="formula-label"><g:fieldValue bean="${cagePartInstance}" field="formula"/></span>
					
				</li>
				</g:if>
			
			</ol> --%>
			
			<table class="table table-bordered">
				<tr>
			        <th align="left">CagePart Code:</th>
			        <td>${cagePartInstance?.cagePartCode}</td>
			    </tr>
			    <tr>
			        <th align="left">CagePart Code:</th>
			        <td>${cagePartInstance?.cagePart}</td>
			    </tr>
			    <tr>
			        <th align="left">CagePart Image:</th>
			        <td><img src="${createLink(action:'showImage', id:cagePartInstance?.id)}" /></td>
			    </tr>
			    <tr>
			        <th align="left">Description:</th>
			        <td>${cagePartInstance?.description}</td>
			    </tr>
			</table>
			
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${cagePartInstance?.id}" />
					<g:link class="btn btn-primary" action="edit" id="${cagePartInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="btn btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
