<%@ page import="com.chakra.config.CageDesign" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cageDesign.label', default: 'CageDesign')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#create-cageDesign" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="create-cageDesign" class="content scaffold-create" role="main">
			<h1><g:message code="default.create.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="alert alert-error" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${cageDesignInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${cageDesignInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form action="createCustomCageDesign" >
				
				<div class="fieldcontain ${hasErrors(bean: cageDesignInstance, field: 'designType', 'error')} required">
					<label for="designType">
						<g:message code="cageDesign.designType.label" default="Cage Design Type" />
						<span class="required-indicator">*</span>
					</label>
					<g:textField name="designType" required="" value="${cageDesignInstance?.designType}" valueMessagePrefix="cageDesign.designType"/>
				</div>
				
				<div class="fieldcontain ${hasErrors(bean: cageDesignInstance, field: 'cageDesign', 'error')} required">
					<label for="cageDesign">
						<g:message code="cageDesign.cageDesign.label" default="Cage Design" />
						<span class="required-indicator">*</span>
					</label>
					<g:textField name="cageDesignName" required="" value="${cageDesignInstance?.cageDesign}"/>
				</div>
				
				<div class="fieldcontain ${hasErrors(bean: cageDesignInstance, field: 'sheetLength', 'error')} required">
					<label for="sheetLength">
						<g:message code="cageDesign.sheetLength.label" default="Sheet Length" />
						<span class="required-indicator">*</span>
					</label>
					<g:textField type="number" name="sheetLength" required="" value="${cageDesignInstance?.sheetLength}"/>
				</div>
				
				<div class="fieldcontain ${hasErrors(bean: cageDesignInstance, field: 'noOfBirdsPerCageSingleBox', 'error')} required">
					<label for="noOfBirdsPerCageSingleBox">
						<g:message code="cageDesign.noOfBirdsPerCageSingleBox.label" default="NoOfBirds/Cage Single Box" />
						<span class="required-indicator">*</span>
					</label>
					<g:textField type="number" name="noOfBirdsPerCageSingleBox" required="" value="${cageDesignInstance?.noOfBirdsPerCageSingleBox}"/>
				</div>
				
				<div class="fieldcontain ${hasErrors(bean: cageDesignInstance, field: 'noOfBirdsPerCageDoubleBox', 'error')} required">
					<label for="noOfBirdsPerCageDoubleBox">
						<g:message code="cageDesign.noOfBirdsPerCageDoubleBox.label" default="No Of Birds/Cage Double Box" />
						<span class="required-indicator">*</span>
					</label>
					<g:textField type="number" name="noOfBirdsPerCageDoubleBox" required="" value="${cageDesignInstance?.noOfBirdsPerCageDoubleBox}"/>
				</div>
				
				<div class="fieldcontain ${hasErrors(bean: cageDesignInstance, field: 'noOfPartitionsPerSheetLength', 'error')} required">
					<label for="noOfPartitionsPerSheetLength">
						<g:message code="cageDesign.noOfPartitionsPerSheetLength.label" default="No Of Partitions/Sheet Length" />
						<span class="required-indicator">*</span>
					</label>
					<g:textField type="number" name="noOfPartitionsPerSheetLength" required="" value="${cageDesignInstance?.noOfPartitionsPerSheetLength}"/>
				</div>
				
				<div class="fieldcontain ${hasErrors(bean: cageDesignInstance, field: 'noOfSingleBottomsPerSheet', 'error')} required">
					<label for="noOfSingleBottomsPerSheet">
						<g:message code="cageDesign.noOfSingleBottomsPerSheet.label" default="No Of Single Bottoms/Sheet" />
						<span class="required-indicator">*</span>
					</label>
					<g:textField type="number" name="noOfSingleBottomsPerSheet" required="" value="${cageDesignInstance?.noOfSingleBottomsPerSheet}"/>
				</div>
				
				<div class="fieldcontain ${hasErrors(bean: cageDesignInstance, field: 'bottomDepth', 'error')} required">
					<label for="bottomDepth">
						<g:message code="cageDesign.bottomDepth.label" default="Bottom Depth" />
						<span class="required-indicator">*</span>
					</label>
					<g:textField type="number" name="bottomDepth" required="" value="${cageDesignInstance?.bottomDepth}"/>
				</div>
				
				<div class="fieldcontain ${hasErrors(bean: cageDesignInstance, field: 'cageFront', 'error')} required">
					<label for="cageFront">
						<g:message code="cageDesign.cageFront.label" default="Cage Front" />
						<span class="required-indicator">*</span>
					</label>
					<g:textField type="number" name="cageFront" required="" value="${cageDesignInstance?.cageFront}"/>
				</div>
				
				<div class="fieldcontain ${hasErrors(bean: cageDesignInstance, field: 'cageHeight', 'error')} required">
					<label for="cageHeight">
						<g:message code="cageDesign.cageHeight.label" default="Cage Height" />
						<span class="required-indicator">*</span>
					</label>
					<g:textField type="number" name="cageHeight" required="" value="${cageDesignInstance?.cageHeight}"/>
				</div>
				
				<div class="fieldcontain ${hasErrors(bean: cageDesignInstance, field: 'topDepth', 'error')} required">
					<label for="topDepth">
						<g:message code="cageDesign.topDepth.label" default="Top Depth" />
						<span class="required-indicator">*</span>
					</label>
					<g:textField type="number" name="topDepth" required="" value="${cageDesignInstance?.topDepth}"/>
				</div>
				
				<div class="form-horizontal fieldcontain ${hasErrors(bean: cageDesignInstance, field: 'doubleBottomCentreIncluded', 'error')} ">
					<label for="doubleBottomCentreIncluded">
						<g:message code="cageDesign.doubleBottomCentreIncluded.label" default="Double Bottom Centre Included" />
						
					</label>
					<g:checkBox name="doubleBottomCentreIncluded" value="${cageDesignInstance?.doubleBottomCentreIncluded}" />
				</div>
				
				<div class="form-horizontal fieldcontain ${hasErrors(bean: cageDesignInstance, field: 'isCustom', 'error')} ">
					<label for="isCustom">
						<g:message code="cageDesign.isCustom.label" default="Is Custom" />
						
					</label>
					<g:checkBox name="isCustom" value="${cageDesignInstance?.isCustom}" />
				</div>
				
				<div class="form-horizontal fieldcontain ${hasErrors(bean: cageDesignInstance, field: 'description', 'error')} ">
					<label for="description">
						<g:message code="cageDesign.description.label" default="Description" />
						
					</label>
					<g:textArea name="description" value="${cageDesignInstance?.description}"/>
				</div>
				
				<fieldset class="buttons">
					<g:hiddenField name='cageDesign' value='${cageDesignInstance?.id}' />
					<sec:ifAnyGranted roles="ROLE_ADMIN"><g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" /></sec:ifAnyGranted>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
