
<%@ page import="com.chakra.config.CagePartType" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cagePartType.label', default: 'CagePartType')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-cagePartType" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-cagePartType" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<%--<ol class="property-list cagePartType">
			
				<g:if test="${cagePartTypeInstance?.cagePartSpecifications}">
				<li class="fieldcontain">
					<span id="cagePartSpecifications-label" class="property-label"><g:message code="cagePartType.cagePartSpecifications.label" default="Cage Part Specifications" /></span>
					
						<g:each in="${cagePartTypeInstance.cagePartSpecifications}" var="c">
						<span class="property-value" aria-labelledby="cagePartSpecifications-label"><g:link controller="cagePartSpecification" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${cagePartTypeInstance?.cagePartType}">
				<li class="fieldcontain">
					<span id="cagePartType-label" class="property-label"><g:message code="cagePartType.cagePartType.label" default="Cage Part Type" /></span>
					
						<span class="property-value" aria-labelledby="cagePartType-label"><g:fieldValue bean="${cagePartTypeInstance}" field="cagePartType"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${cagePartTypeInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="cagePartType.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${cagePartTypeInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
			</ol>--%>
			<table class="table table-bordered">
							
				    <tr>
				        <th align="left">CagePartType:</th>
				        <td>${cagePartTypeInstance.cagePartType}</td>
				    </tr>
				    <tr>
				        <th align="left">CagePart Specifications:</th>
				        <td>
				            <g:each in="${cagePartTypeInstance.cagePartSpecifications}" var="c">
				                  ${c.cagePartSpecification}
				            </g:each>
				        </td>
				    </tr>
				    <tr>
				        <th align="left">Description:</th>
				        <td>${cagePartTypeInstance.description}</td>
				    </tr>
				    				    				    				    						
			</table>
			<br>
						
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${cagePartTypeInstance?.id}" />
					<sec:ifAllGranted roles="ROLE_ADMIN"><g:link class="btn btn-primary" action="edit" id="${cagePartTypeInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link></sec:ifAllGranted>
					<sec:ifAllGranted roles="ROLE_ADMIN"><g:actionSubmit class="btn btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></sec:ifAllGranted>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
