<%@ page import="com.chakra.config.CageDesign" %>


<div class="fieldcontain ${hasErrors(bean: cageDesignInstance, field: 'designType', 'error')} required">
	<label for="designType">
		<g:message code="cageDesign.designType.label" default="Cage Design Type" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="designType" from="${cageDesignInstance?.constraints?.designType?.inList}" required="" value="${cageDesignInstance?.designType}" valueMessagePrefix="cageDesign.designType"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cageDesignInstance, field: 'cageDesign', 'error')} required">
	<label for="cageDesign">
		<g:message code="cageDesign.cageDesign.label" default="Cage Design" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="cageDesign" required="" value="${cageDesignInstance?.cageDesign}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cageDesignInstance, field: 'sheetLength', 'error')} required">
	<label for="sheetLength">
		<g:message code="cageDesign.sheetLength.label" default="Sheet Length" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="sheetLength" required="" value="${fieldValue(bean: cageDesignInstance, field: 'sheetLength')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cageDesignInstance, field: 'noOfBirdsPerCageSingleBox', 'error')} required">
	<label for="noOfBirdsPerCageSingleBox">
		<g:message code="cageDesign.noOfBirdsPerCageSingleBox.label" default="NoOfBirds/Cage Single Box" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="noOfBirdsPerCageSingleBox" required="" value="${fieldValue(bean: cageDesignInstance, field: 'noOfBirdsPerCageSingleBox')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cageDesignInstance, field: 'noOfBirdsPerCageDoubleBox', 'error')} required">
	<label for="noOfBirdsPerCageDoubleBox">
		<g:message code="cageDesign.noOfBirdsPerCageDoubleBox.label" default="No Of Birds/Cage Double Box" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="noOfBirdsPerCageDoubleBox" required="" value="${fieldValue(bean: cageDesignInstance, field: 'noOfBirdsPerCageDoubleBox')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cageDesignInstance, field: 'noOfPartitionsPerSheetLength', 'error')} required">
	<label for="noOfPartitionsPerSheetLength">
		<g:message code="cageDesign.noOfPartitionsPerSheetLength.label" default="No Of Partitions/Sheet Length" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="noOfPartitionsPerSheetLength" required="" value="${fieldValue(bean: cageDesignInstance, field: 'noOfPartitionsPerSheetLength')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cageDesignInstance, field: 'noOfSingleBottomsPerSheet', 'error')} required">
	<label for="noOfSingleBottomsPerSheet">
		<g:message code="cageDesign.noOfSingleBottomsPerSheet.label" default="No Of Single Bottoms/Sheet" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="noOfSingleBottomsPerSheet" required="" value="${fieldValue(bean: cageDesignInstance, field: 'noOfSingleBottomsPerSheet')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cageDesignInstance, field: 'bottomDepth', 'error')} required">
	<label for="bottomDepth">
		<g:message code="cageDesign.bottomDepth.label" default="Bottom Depth" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="bottomDepth" required="" value="${fieldValue(bean: cageDesignInstance, field: 'bottomDepth')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cageDesignInstance, field: 'cageFront', 'error')} required">
	<label for="cageFront">
		<g:message code="cageDesign.cageFront.label" default="Cage Front" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="cageFront" required="" value="${fieldValue(bean: cageDesignInstance, field: 'cageFront')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cageDesignInstance, field: 'cageHeight', 'error')} required">
	<label for="cageHeight">
		<g:message code="cageDesign.cageHeight.label" default="Cage Height" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="cageHeight" required="" value="${fieldValue(bean: cageDesignInstance, field: 'cageHeight')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cageDesignInstance, field: 'topDepth', 'error')} required">
	<label for="topDepth">
		<g:message code="cageDesign.topDepth.label" default="Top Depth" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="topDepth" required="" value="${fieldValue(bean: cageDesignInstance, field: 'topDepth')}"/>
</div>

<div class="form-horizontal fieldcontain ${hasErrors(bean: cageDesignInstance, field: 'doubleBottomCentreIncluded', 'error')} ">
	<label for="doubleBottomCentreIncluded">
		<g:message code="cageDesign.doubleBottomCentreIncluded.label" default="Double Bottom Centre Included" />
		
	</label>
	<%--<label class="checkbox">
    Check me out <input type="checkbox"> 
  </label>
	--%><g:checkBox name="doubleBottomCentreIncluded" value="${cageDesignInstance?.doubleBottomCentreIncluded}" />
</div>

<div class="form-horizontal fieldcontain ${hasErrors(bean: cageDesignInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="cageDesign.description.label" default="Description" />
		
	</label>
	<g:textArea name="description" value="${cageDesignInstance?.description}"/>
</div>

<%--<div class="fieldcontain ${hasErrors(bean: cageDesignInstance, field: 'cageDesignSheetSpecFormula', 'error')} ">
	<label for="cageDesignSheetSpecFormula">
		<g:message code="cageDesign.cageDesignSheetSpecFormula.label" default="Cage Design Sheet Spec Formula" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${cageDesignInstance?.cageDesignSheetSpecFormula?}" var="c">
    <li><g:link controller="cageDesignSheetSpecFormula" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="cageDesignSheetSpecFormula" action="create" params="['cageDesign.id': cageDesignInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'cageDesignSheetSpecFormula.label', default: 'CageDesignSheetSpecFormula')])}</g:link>
</li>
</ul>

</div>

--%>

