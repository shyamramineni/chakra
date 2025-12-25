
<%@ page import="com.chakra.config.Taxation" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'taxation.label', default: 'Taxation')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-taxation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-taxation" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<%--<ol class="property-list taxation">
			
				<g:if test="${taxationInstance?.taxation}">
				<li class="fieldcontain">
					<span id="taxation-label" class="property-label"><g:message code="taxation.taxation.label" default="Taxation" /></span>
					
						<span class="property-value" aria-labelledby="taxation-label"><g:fieldValue bean="${taxationInstance}" field="taxation"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${taxationInstance?.percent}">
				<li class="fieldcontain">
					<span id="percent-label" class="property-label"><g:message code="taxation.percent.label" default="Percent" /></span>
					
						<span class="property-value" aria-labelledby="percent-label"><g:fieldValue bean="${taxationInstance}" field="percent"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${taxationInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="taxation.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${taxationInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
			</ol>--%>
			<table class="table table-bordered">
							
				    <tr>
				        <th align="left">Taxation:</th>
				        <td>${taxationInstance.taxation}</td>
				    </tr>
				    <tr>
				        <th align="left">Percent:</th>
				        <td>${taxationInstance.percent}</td>
				    </tr>
				    <tr>
				        <th align="left">Description:</th>
				        <td>${taxationInstance.description}</td>
				    </tr>
				    				    				    				    						
			</table>
			<br>
			
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${taxationInstance?.id}" />
					<sec:ifAllGranted roles="ROLE_ADMIN"><g:link class="btn btn-primary" action="edit" id="${taxationInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link></sec:ifAllGranted>
					<sec:ifAllGranted roles="ROLE_ADMIN"><g:actionSubmit class="btn btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></sec:ifAllGranted>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
