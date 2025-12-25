<%@ page import="com.chakra.config.CageDesignSheetSpecFormula" %>



<div class="fieldcontain ${hasErrors(bean: cageDesignSheetSpecFormulaInstance, field: 'sheetSpecification', 'error')} required">
	<label for="sheetSpecification">
		<g:message code="cageDesignSheetSpecFormula.sheetSpecification.label" default="Sheet Specification" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="sheetSpecification" name="sheetSpecification.id" from="${com.chakra.config.SheetSpecification.list()}" optionKey="id" required="" value="${cageDesignSheetSpecFormulaInstance?.sheetSpecification?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cageDesignSheetSpecFormulaInstance, field: 'cageDesign', 'error')} required">
	<label for="cageDesign">
		<g:message code="cageDesignSheetSpecFormula.cageDesign.label" default="Cage Design" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="cageDesign" name="cageDesign.id" from="${com.chakra.config.CageDesign.list()}" optionKey="id" required="" value="${cageDesignSheetSpecFormulaInstance?.cageDesign?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cageDesignSheetSpecFormulaInstance, field: 'formula', 'error')} required">
	<label for="formula">
		<g:message code="cageDesignSheetSpecFormula.formula.label" default="Formula" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="formula" required="" value="${cageDesignSheetSpecFormulaInstance?.formula}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cageDesignSheetSpecFormulaInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="cageDesignSheetSpecFormula.description.label" default="Description" />
		
	</label>
	<g:textArea name="description" value="${cageDesignSheetSpecFormulaInstance?.description}"/>
</div>

