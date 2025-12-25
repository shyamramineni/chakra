
<%@ page import="com.chakra.config.SideMesh" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'sideMesh.label', default: 'SideMesh')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-sideMesh" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-sideMesh" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<%--<ol class="property-list sideMesh">
			
				<g:if test="${sideMeshInstance?.holeSize}">
				<li class="fieldcontain">
					<span id="holeSize-label" class="property-label"><g:message code="sideMesh.holeSize.label" default="Hole Size" /></span>
					
						<span class="property-value" aria-labelledby="holeSize-label"><g:fieldValue bean="${sideMeshInstance}" field="holeSize"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sideMeshInstance?.wireDiameter}">
				<li class="fieldcontain">
					<span id="wireDiameter-label" class="property-label"><g:message code="sideMesh.wireDiameter.label" default="Wire Diameter" /></span>
					
						<span class="property-value" aria-labelledby="wireDiameter-label"><g:fieldValue bean="${sideMeshInstance}" field="wireDiameter"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sideMeshInstance?.weight}">
				<li class="fieldcontain">
					<span id="weight-label" class="property-label"><g:message code="sideMesh.weight.label" default="Weight" /></span>
					
						<span class="property-value" aria-labelledby="weight-label"><g:fieldValue bean="${sideMeshInstance}" field="weight"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sideMeshInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="sideMesh.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${sideMeshInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
			</ol>
			--%>
			
			<table class="table table-bordered">
							
				    <tr>
				        <th align="left">Hole Size:</th>
				        <td>${sideMeshInstance.holeSize}</td>
				    </tr>
				    <tr>
				        <th align="left">Wire Diameter:</th>
				        <td>${sideMeshInstance.wireDiameter}</td>
				    </tr>
				    <tr>
				        <th align="left">Weight:</th>
				        <td>${sideMeshInstance.weight}</td>
				    </tr>
				    <tr>
				        <th align="left">Description:</th>
				        <td>${sideMeshInstance.description}</td>
				    </tr>				    
				    				    				    				    						
			</table>
			<br>
			
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${sideMeshInstance?.id}" />
					<g:link class="btn btn-primary" action="edit" id="${sideMeshInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="btn btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
