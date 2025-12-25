
<%@ page import="com.chakra.config.CagePartSpecification" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cagePartSpecification.label', default: 'CagePartSpecification')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-cagePartSpecification" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-cagePartSpecification" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<%--<ol class="property-list cagePartSpecification">
			
				<g:if test="${cagePartSpecificationInstance?.cagePartSpecFormulaList}">
				<li class="fieldcontain">
					<span id="cagePartSpecFormulaList-label" class="property-label"><g:message code="cagePartSpecification.cagePartSpecFormulaList.label" default="Cage Part Spec Formula List" /></span>
					
						<g:each in="${cagePartSpecificationInstance.cagePartSpecFormulaList}" var="c">
						<span class="property-value" aria-labelledby="cagePartSpecFormulaList-label"><g:link controller="cagePartSpecFormula" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${cagePartSpecificationInstance?.cagePartSpecification}">
				<li class="fieldcontain">
					<span id="cagePartSpecification-label" class="property-label"><g:message code="cagePartSpecification.cagePartSpecification.label" default="Cage Part Specification" /></span>
					
						<span class="property-value" aria-labelledby="cagePartSpecification-label"><g:fieldValue bean="${cagePartSpecificationInstance}" field="cagePartSpecification"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${cagePartSpecificationInstance?.cagePartType}">
				<li class="fieldcontain">
					<span id="cagePartType-label" class="property-label"><g:message code="cagePartSpecification.cagePartType.label" default="Cage Part Type" /></span>
					
						<span class="property-value" aria-labelledby="cagePartType-label"><g:link controller="cagePartType" action="show" id="${cagePartSpecificationInstance?.cagePartType?.id}">${cagePartSpecificationInstance?.cagePartType?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${cagePartSpecificationInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="cagePartSpecification.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${cagePartSpecificationInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
			</ol>
			--%><table class="table table-bordered">
							
				    <tr>
				        <th align="left">CagePart Type:</th>
				        <td><g:link controller="cagePartType" action="show" id="${cagePartSpecificationInstance?.cagePartType?.id}">${cagePartSpecificationInstance?.cagePartType?.encodeAsHTML()}</g:link></td>
				    </tr>
				    <tr>
				        <th align="left">CagePart Specification:</th>
				        <td>${cagePartSpecificationInstance.cagePartSpecification}</td>
				    </tr>
				    <tr>
				        <th align="left">CagePart Specification Formula:</th>
				        <td>
				            <g:each in="${cagePartSpecificationInstance.cagePartSpecFormulaList}" var="c">
				                  <g:link controller="cagePartSpecFormula" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link><br>
				            </g:each>
				        </td>
				    </tr>
				    <tr>
				        <th align="left">Description:</th>
				        <td>${cagePartSpecificationInstance.description}</td>
				    </tr>
				    				    				    				    						
			</table>
			<br>
			
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${cagePartSpecificationInstance?.id}" />
					<sec:ifAllGranted roles="ROLE_ADMIN"><g:link class="btn btn-primary" action="edit" id="${cagePartSpecificationInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link></sec:ifAllGranted>
					<sec:ifAllGranted roles="ROLE_ADMIN"><g:actionSubmit class="btn btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></sec:ifAllGranted>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
