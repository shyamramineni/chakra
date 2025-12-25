
<%@ page import="com.chakra.registry.Registry" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'registry.label', default: 'Registry')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-registry" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-registry" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<%--<ol class="property-list registry">
			
				<g:if test="${registryInstance?.entryName}">
				<li class="fieldcontain">
					<span id="entryName-label" class="property-label"><g:message code="registry.entryName.label" default="Entry Name" /></span>
					
						<span class="property-value" aria-labelledby="entryName-label"><g:fieldValue bean="${registryInstance}" field="entryName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${registryInstance?.entryValue}">
				<li class="fieldcontain">
					<span id="entryValue-label" class="property-label"><g:message code="registry.entryValue.label" default="Entry Value" /></span>
					
						<span class="property-value" aria-labelledby="entryValue-label"><g:fieldValue bean="${registryInstance}" field="entryValue"/></span>
					
				</li>
				</g:if>
			
			</ol>
			--%>
			<table class="table table-bordered">
				<tr>
			        <th align="left">Entry Name:</th>
			        <td>${registryInstance.entryName}</td>
			    </tr>
			    <tr>
			        <th align="left">Entry Value:</th>
			        <td>${registryInstance.entryValue}</td>
			    </tr>
			</table>
							    
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${registryInstance?.id}" />
					<g:link class="edit" action="edit" id="${registryInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
