
<%@ page import="com.chakra.config.CageDesignSheetSpecFormula" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cageDesignSheetSpecFormula.label', default: 'CageDesignSheetSpecFormula')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-cageDesignSheetSpecFormula" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-cageDesignSheetSpecFormula" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<%--<ol class="property-list cageDesignSheetSpecFormula">
			
				<g:if test="${cageDesignSheetSpecFormulaInstance?.sheetSpecification}">
				<li class="fieldcontain">
					<span id="sheetSpecification-label" class="property-label"><g:message code="cageDesignSheetSpecFormula.sheetSpecification.label" default="Sheet Specification" /></span>
					
						<span class="property-value" aria-labelledby="sheetSpecification-label"><g:link controller="sheetSpecification" action="show" id="${cageDesignSheetSpecFormulaInstance?.sheetSpecification?.id}">${cageDesignSheetSpecFormulaInstance?.sheetSpecification?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${cageDesignSheetSpecFormulaInstance?.cageDesign}">
				<li class="fieldcontain">
					<span id="cageDesign-label" class="property-label"><g:message code="cageDesignSheetSpecFormula.cageDesign.label" default="Cage Design" /></span>
					
						<span class="property-value" aria-labelledby="cageDesign-label"><g:link controller="cageDesign" action="show" id="${cageDesignSheetSpecFormulaInstance?.cageDesign?.id}">${cageDesignSheetSpecFormulaInstance?.cageDesign?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${cageDesignSheetSpecFormulaInstance?.formula}">
				<li class="fieldcontain">
					<span id="formula-label" class="property-label"><g:message code="cageDesignSheetSpecFormula.formula.label" default="Formula" /></span>
					
						<span class="property-value" aria-labelledby="formula-label"><g:fieldValue bean="${cageDesignSheetSpecFormulaInstance}" field="formula"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${cageDesignSheetSpecFormulaInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="cageDesignSheetSpecFormula.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${cageDesignSheetSpecFormulaInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
			</ol>	--%>
			<table class="table table-bordered">
							
				    <tr>
				        <th align="left">Cage Design:</th>
				        <td>${cageDesignSheetSpecFormulaInstance.cageDesign}</td>
				    </tr>
				    <tr>
				        <th align="left">SheetSpecification:</th>
				        <td>${cageDesignSheetSpecFormulaInstance.sheetSpecification}</td>
				    </tr>
				    <tr>
				        <th align="left">Formula:</th>
				        <td>${cageDesignSheetSpecFormulaInstance.formula}</td>
				    </tr>
				    <tr>
				        <th align="left">Description:</th>
				        <td>${cageDesignSheetSpecFormulaInstance.description}</td>
				    </tr>
				    				    				    				    						
			</table>
			<br>
			
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${cageDesignSheetSpecFormulaInstance?.id}" />
					<sec:ifAllGranted roles="ROLE_ADMIN"><g:link class="btn btn-primary" action="edit" id="${cageDesignSheetSpecFormulaInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link></sec:ifAllGranted>
					<sec:ifAllGranted roles="ROLE_ADMIN"><g:actionSubmit class="btn btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></sec:ifAllGranted>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
