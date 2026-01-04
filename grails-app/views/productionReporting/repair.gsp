
<html>
    <head>
        <meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quotation.label', default: 'Sheet Repair')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
		<g:javascript library="jquery" />		
    </head>
    <body>
    	<g:if test="${flash.message}">
			<div class="alert alert-error" role="status">${flash.message}</div>
		</g:if>
    	<h2>Sheet Repair</h2>
		<g:form controller="productionReporting" action="sheetRepair" >
		
			<div class="row">
			
				<div class="span6">
					
					<div class="fieldcontain ${hasErrors(bean: productionReportingInstance, field: 'repair', 'error')} required">
						<label for="Mending">
							<g:message code="productionReporting.mending.label" default="No. of Sheets" />
							<span class="required-indicator">*</span>
						</label>
						<g:textField type="number" name="noOfSheets" required="" value=""/>
					</div>
				</div>					
				
	   	    </div>
	   		<g:hiddenField name="productionReporting.id" value="${productionReportingInstance?.id}" />
			<div class="buttons">
               	<span class="button"><g:submitButton name="repair" class="btn btn-primary" value="Submit"/></span>
            </div>
		</g:form>
		   
    </body>
</html>
