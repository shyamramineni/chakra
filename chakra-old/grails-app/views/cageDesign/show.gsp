
<%@ page import="com.chakra.config.CageDesign" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cageDesign.label', default: 'CageDesign')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-cageDesign" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-cageDesign" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="alert alert-success" role="status">${flash.message}</div>
			</g:if>
			<%--<ol class="property-list cageDesign">
			
				<g:if test="${cageDesignInstance?.cageDesign}">
				<li class="fieldcontain">
					<span id="cageDesign-label" class="property-label"><g:message code="cageDesign.cageDesign.label" default="Cage Design" /></span>
					
						<span class="property-value" aria-labelledby="cageDesign-label"><g:fieldValue bean="${cageDesignInstance}" field="cageDesign"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${cageDesignInstance?.sheetLength}">
				<li class="fieldcontain">
					<span id="sheetLength-label" class="property-label"><g:message code="cageDesign.sheetLength.label" default="Sheet Length" /></span>
					
						<span class="property-value" aria-labelledby="sheetLength-label"><g:fieldValue bean="${cageDesignInstance}" field="sheetLength"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${cageDesignInstance?.noOfBirdsPerCageSingleBox}">
				<li class="fieldcontain">
					<span id="noOfBirdsPerCageSingleBox-label" class="property-label"><g:message code="cageDesign.noOfBirdsPerCageSingleBox.label" default="No Of Birds Per Cage Single Box" /></span>
					
						<span class="property-value" aria-labelledby="noOfBirdsPerCageSingleBox-label"><g:fieldValue bean="${cageDesignInstance}" field="noOfBirdsPerCageSingleBox"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${cageDesignInstance?.noOfBirdsPerCageDoubleBox}">
				<li class="fieldcontain">
					<span id="noOfBirdsPerCageDoubleBox-label" class="property-label"><g:message code="cageDesign.noOfBirdsPerCageDoubleBox.label" default="No Of Birds Per Cage Double Box" /></span>
					
						<span class="property-value" aria-labelledby="noOfBirdsPerCageDoubleBox-label"><g:fieldValue bean="${cageDesignInstance}" field="noOfBirdsPerCageDoubleBox"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${cageDesignInstance?.noOfPartitionsPerSheetLength}">
				<li class="fieldcontain">
					<span id="noOfPartitionsPerSheetLength-label" class="property-label"><g:message code="cageDesign.noOfPartitionsPerSheetLength.label" default="No Of Partitions Per Sheet Length" /></span>
					
						<span class="property-value" aria-labelledby="noOfPartitionsPerSheetLength-label"><g:fieldValue bean="${cageDesignInstance}" field="noOfPartitionsPerSheetLength"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${cageDesignInstance?.noOfSingleBottomsPerSheet}">
				<li class="fieldcontain">
					<span id="noOfSingleBottomsPerSheet-label" class="property-label"><g:message code="cageDesign.noOfSingleBottomsPerSheet.label" default="No Of Single Bottoms Per Sheet" /></span>
					
						<span class="property-value" aria-labelledby="noOfSingleBottomsPerSheet-label"><g:fieldValue bean="${cageDesignInstance}" field="noOfSingleBottomsPerSheet"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${cageDesignInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="cageDesign.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${cageDesignInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${cageDesignInstance?.bottomDepth}">
				<li class="fieldcontain">
					<span id="bottomDepth-label" class="property-label"><g:message code="cageDesign.bottomDepth.label" default="Bottom Depth" /></span>
					
						<span class="property-value" aria-labelledby="bottomDepth-label"><g:fieldValue bean="${cageDesignInstance}" field="bottomDepth"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${cageDesignInstance?.cageDesignSheetSpecFormula}">
				<li class="fieldcontain">
					<span id="cageDesignSheetSpecFormula-label" class="property-label"><g:message code="cageDesign.cageDesignSheetSpecFormula.label" default="Cage Design Sheet Spec Formula" /></span>
					
						<g:each in="${cageDesignInstance.cageDesignSheetSpecFormula}" var="c">
						<span class="property-value" aria-labelledby="cageDesignSheetSpecFormula-label"><g:link controller="cageDesignSheetSpecFormula" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${cageDesignInstance?.cageFront}">
				<li class="fieldcontain">
					<span id="cageFront-label" class="property-label"><g:message code="cageDesign.cageFront.label" default="Cage Front" /></span>
					
						<span class="property-value" aria-labelledby="cageFront-label"><g:fieldValue bean="${cageDesignInstance}" field="cageFront"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${cageDesignInstance?.cageHeight}">
				<li class="fieldcontain">
					<span id="cageHeight-label" class="property-label"><g:message code="cageDesign.cageHeight.label" default="Cage Height" /></span>
					
						<span class="property-value" aria-labelledby="cageHeight-label"><g:fieldValue bean="${cageDesignInstance}" field="cageHeight"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${cageDesignInstance?.doubleBottomCentreIncluded}">
				<li class="fieldcontain">
					<span id="doubleBottomCentreIncluded-label" class="property-label"><g:message code="cageDesign.doubleBottomCentreIncluded.label" default="Double Bottom Centre Included" /></span>
					
						<span class="property-value" aria-labelledby="doubleBottomCentreIncluded-label"><g:formatBoolean boolean="${cageDesignInstance?.doubleBottomCentreIncluded}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${cageDesignInstance?.topDepth}">
				<li class="fieldcontain">
					<span id="topDepth-label" class="property-label"><g:message code="cageDesign.topDepth.label" default="Top Depth" /></span>
					
						<span class="property-value" aria-labelledby="topDepth-label"><g:fieldValue bean="${cageDesignInstance}" field="topDepth"/></span>
					
				</li>
				</g:if>
			
			</ol>
			
			
			--%><table class="table table-bordered">
							
				    <tr>
				        <th align="left">Cage Design:</th>
				        <td>${cageDesignInstance.cageDesign}</td>
				    </tr>
				    <tr>
				        <th align="left">Sheet Length:</th>
				        <td>${cageDesignInstance.sheetLength}</td>
				    </tr>
				    <tr>
				        <th align="left">No Of Birds Per Cage SingleBox:</th>
				        <td>${cageDesignInstance.noOfBirdsPerCageSingleBox}</td>
				    </tr>
				    <tr>
				        <th align="left">No Of Birds Per Cage DoubleBox:</th>
				        <td>${cageDesignInstance.noOfBirdsPerCageDoubleBox}</td>
				    </tr>
				    
				    <tr>
				        <th align="left">No Of Partitions Per SheetLength:</th>
				        <td>${cageDesignInstance.noOfPartitionsPerSheetLength}</td>
				    </tr>
				    <tr>
				        <th align="left">No Of Single Bottoms Per Sheet:</th>
				        <td>${cageDesignInstance.noOfSingleBottomsPerSheet}</td>
				    </tr>
				    <tr>
				        <th align="left">Bottom Depth:</th>
				        <td>${cageDesignInstance.bottomDepth}</td>
				    </tr>
				    <tr>
				        <th align="left">Top Depth:</th>
				        <td>${cageDesignInstance.topDepth}</td>
				    </tr>
				    <tr>
				        <th align="left">Cage Height:</th>
				        <td>${cageDesignInstance.cageHeight}</td>
				    </tr>
				    <tr>
				        <th align="left">Cage Front:</th>
				        <td>${cageDesignInstance.cageFront}</td>
				    </tr>
				    <tr>
				        <th align="left">Double Bottom Centre Included:</th>
				        <td>${cageDesignInstance.doubleBottomCentreIncluded}</td>
				    </tr>
				    <tr>
				        <th align="left">Formula:</th>
				        <td>
				            <g:each in="${cageDesignInstance.cageDesignSheetSpecFormula}" var="c">
						    
						    		${c.sheetSpecification}--${c.formula}<br>
						    	
						    </g:each>
				        </td>
				    </tr>
				    <tr>
				        <th align="left">Description:</th>
				        <td>${cageDesignInstance.description}</td>
				    </tr>
				    				    						
			</table>
			<br>			
			
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${cageDesignInstance?.id}" />
					<sec:ifAnyGranted roles="ROLE_ADMIN"><g:link class="btn btn-primary" action="edit" id="${cageDesignInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link></sec:ifAnyGranted>
					<sec:ifAnyGranted roles="ROLE_ADMIN"><g:actionSubmit class="btn btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></sec:ifAnyGranted>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
