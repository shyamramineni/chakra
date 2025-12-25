
<%@ page import="com.chakra.config.Machine" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'machine.label', default: 'Machine')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-machine" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-machine" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<%--<ol class="property-list machine">
			
				<g:if test="${machineInstance?.machineName}">
				<li class="fieldcontain">
					<span id="machineName-label" class="property-label"><g:message code="machine.machineName.label" default="Machine Name" /></span>
					
						<span class="property-value" aria-labelledby="machineName-label"><g:fieldValue bean="${machineInstance}" field="machineName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${machineInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="machine.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${machineInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
			</ol>--%>
			<table class="table table-bordered">
							
				    <tr>
				        <th align="left">Machine Name:</th>
				        <td>${machineInstance.machineName}</td>
				    </tr>
				    <tr>
				        <th align="left">Description:</th>
				        <td>${machineInstance.description}</td>
				    </tr>
				    				    				    				    						
			</table>
			<br>
			
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${machineInstance?.id}" />
					<sec:ifAllGranted roles="ROLE_ADMIN"><g:link class="btn btn-primary" action="edit" id="${machineInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link></sec:ifAllGranted>
					<sec:ifAllGranted roles="ROLE_ADMIN"><g:actionSubmit class="btn btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></sec:ifAllGranted>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
