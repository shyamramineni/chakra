<%@ page import="com.chakra.config.CagePartSpecification" %>



<%--<div class="fieldcontain ${hasErrors(bean: cagePartSpecificationInstance, field: 'cagePartSpecFormulaList', 'error')} ">
	<label for="cagePartSpecFormulaList">
		<g:message code="cagePartSpecification.cagePartSpecFormulaList.label" default="Cage Part Spec Formula List" />
		
	</label>
	<g:select name="cagePartSpecFormulaList" from="${com.chakra.config.CagePartSpecFormula.list()}" multiple="multiple" optionKey="id" size="5" value="${cagePartSpecificationInstance?.cagePartSpecFormulaList*.id}" class="many-to-many"/>
</div>

--%><div class="fieldcontain ${hasErrors(bean: cagePartSpecificationInstance, field: 'cagePartType', 'error')} required">
	<label for="cagePartType">
		<g:message code="cagePartSpecification.cagePartType.label" default="Cage Part Type" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="cagePartType" name="cagePartType.id" from="${com.chakra.config.CagePartType.list()}" optionKey="id" required="" value="${cagePartSpecificationInstance?.cagePartType?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cagePartSpecificationInstance, field: 'cagePartSpecification', 'error')} ">
	<label for="cagePartSpecification">
		<g:message code="cagePartSpecification.cagePartSpecification.label" default="Cage Part Specification" />
		
	</label>
	<g:textField name="cagePartSpecification" value="${cagePartSpecificationInstance?.cagePartSpecification}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cagePartSpecificationInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="cagePartSpecification.description.label" default="Description" />
		
	</label>
	<g:textArea name="description" value="${cagePartSpecificationInstance?.description}"/>
</div>

