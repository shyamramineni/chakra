
<%@ page import="com.chakra.config.CagePartSpecFormula" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cagePartSpecFormula.label', default: 'CagePartSpecFormula')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-cagePartSpecFormula" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-cagePartSpecFormula" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<%--<ol class="property-list cagePartSpecFormula">
			
				<g:if test="${cagePartSpecFormulaInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="cagePartSpecFormula.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${cagePartSpecFormulaInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${cagePartSpecFormulaInstance?.cagePart}">
				<li class="fieldcontain">
					<span id="cagePart-label" class="property-label"><g:message code="cagePartSpecFormula.cagePart.label" default="Cage Part" /></span>
					
						<span class="property-value" aria-labelledby="cagePart-label"><g:link controller="cagePart" action="show" id="${cagePartSpecFormulaInstance?.cagePart?.id}">${cagePartSpecFormulaInstance?.cagePart?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${cagePartSpecFormulaInstance?.cagePartSpecification}">
				<li class="fieldcontain">
					<span id="cagePartSpecification-label" class="property-label"><g:message code="cagePartSpecFormula.cagePartSpecification.label" default="Cage Part Specification" /></span>
					
						<span class="property-value" aria-labelledby="cagePartSpecification-label"><g:link controller="cagePartSpecification" action="show" id="${cagePartSpecFormulaInstance?.cagePartSpecification?.id}">${cagePartSpecFormulaInstance?.cagePartSpecification?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${cagePartSpecFormulaInstance?.formula}">
				<li class="fieldcontain">
					<span id="formula-label" class="property-label"><g:message code="cagePartSpecFormula.formula.label" default="Formula" /></span>
					
						<span class="property-value" aria-labelledby="formula-label"><g:fieldValue bean="${cagePartSpecFormulaInstance}" field="formula"/></span>
					
				</li>
				</g:if>
			
			</ol>--%>
			<table class="table table-bordered">
				<tr>
			        <th align="left">Cage Part:</th>
			        <td>${cagePartSpecFormulaInstance?.cagePart}</td>
			    </tr>
			    <tr>
			        <th align="left">CagePart Specification:</th>
			        <td>${cagePartSpecFormulaInstance?.cagePartSpecification}</td>
			    </tr>
			    <tr>
			        <th align="left">Formula:</th>
			        <td>${cagePartSpecFormulaInstance?.formula}</td>
			    </tr>		
				<tr>
			        <th align="left">Description:</th>
			        <td>${cagePartSpecFormulaInstance?.description}</td>
			    </tr>
			</table>
			<br>	    
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${cagePartSpecFormulaInstance?.id}" />
					<g:link class="btn btn-primary" action="edit" id="${cagePartSpecFormulaInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="btn btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
