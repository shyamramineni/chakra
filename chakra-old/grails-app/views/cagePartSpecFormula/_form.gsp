<%@ page import="com.chakra.config.CagePartSpecFormula" %>



<div class="fieldcontain ${hasErrors(bean: cagePartSpecFormulaInstance, field: 'cagePartSpecification', 'error')} required">
	<label for="cagePartSpecification">
		<g:message code="cagePartSpecFormula.cagePartSpecification.label" default="Cage Part Specification" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="cagePartSpecification" name="cagePartSpecification.id" from="${com.chakra.config.CagePartSpecification.list()}" optionKey="id" required="" value="${cagePartSpecFormulaInstance?.cagePartSpecification?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cagePartSpecFormulaInstance, field: 'cagePart', 'error')} required">
	<label for="cagePart">
		<g:message code="cagePartSpecFormula.cagePart.label" default="Cage Part" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="cagePart" name="cagePart.id" from="${com.chakra.config.CagePart.list()}" optionKey="id" required="" value="${cagePartSpecFormulaInstance?.cagePart?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cagePartSpecFormulaInstance, field: 'formula', 'error')} ">
	<label for="formula">
		<g:message code="cagePartSpecFormula.formula.label" default="Formula" />
		
	</label>
	<g:textField name="formula" value="${cagePartSpecFormulaInstance?.formula}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cagePartSpecFormulaInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="cagePartSpecFormula.description.label" default="Description" />
		
	</label>
	<g:textArea name="description" value="${cagePartSpecFormulaInstance?.description}"/>
</div>