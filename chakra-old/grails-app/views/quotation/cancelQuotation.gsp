
<html>
    <head>
        <meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quotation.label', default: 'Cancel Quotation')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
		<g:javascript library="jquery" />		
    </head>
    <body>
    	<h2>Cancel Quotation</h2>
		
		<g:form controller="quotation" action="cancelQuotationReason">
							
			<div class="row">
			
				<div class="span6">
					
					<div class="fieldcontain ${hasErrors(bean: quotationInstance, field: 'quotationFailedReason', 'error')} required">
						<label for="quotationFailedReason">
							<g:message code="quotation.quotationFailedReason.label" default="quotationFailedReason" />
							<span class="required-indicator">*</span>
						</label>
						<g:select id="quotationFailedReason" name="quotationFailedReason.id" from="${com.chakra.config.QuotationFailedReason.list()}" optionKey="id" required="" value="" noSelection="${['null':'Select One...']}" class="many-to-one"/>
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: quotationInstance, field: 'quotationFailedComments', 'error')} ">
						<label for="quotationFailedComments">
							<g:message code="quotation.quotationFailedComments.label" default="Quotation Failed Comments" />
		
						</label>
						<g:textArea name="quotationFailedComments" value=""/>
					</div>					
											
				</div>					
				
	   	    </div>
	   	    <g:hiddenField name="quotation.id" value="${quotationInstance?.id}" />	   	      	    
	   	    <div class="buttons">
               	<span class="button"><g:submitButton name="cancelQuotation" class="btn btn-primary" value="Cancel Quotation"/></span>
            </div>
	   	    
		</g:form>		
    
    </body>
</html>

