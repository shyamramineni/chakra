
<html>
    <head>
        <meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quotation.label', default: 'Quotation ChainLink')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
		<g:javascript library="jquery" />		
    </head>
    <body>
    	<h2>Quotation WeldSideMesh</h2>
    	<g:form controller="quotation" action="weldSidePrices" >
	    	<div class="row">
				
					<div class="span6">
						
						<div class="fieldcontain ${hasErrors(bean: quotationInstance, field: 'customer', 'error')} required">
							<label for="customer">
								<g:message code="quotation.customer.label" default="Customer" />
								<span class="required-indicator">*</span>
							</label>
							<g:select id="customer" name="customer.id" from="${com.chakra.customer.Customer.list()}" optionKey="id" value="${customerInstance?.id}" class="many-to-one"/>
						</div>
											
						<div class="fieldcontain ${hasErrors(bean: wirePriceInstance, field: 'taxation', 'error')} required">
							<label for="wireBrand">
								<g:message code="wirePrice.wireBrand.label" default="Taxation" />
								<span class="required-indicator">*</span>
							</label>
							<g:select id="taxation" name="taxation.id" from="${com.chakra.config.Taxation.list()}" optionKey="id" required="" value="${taxationInstance?.id}" class="many-to-one"/>
						</div>
																						
					</div>						
					
	 		</div>
		   	       	    
	   	    <table>
	   	    	<tr>
	   	    		<th>Design</th>
	   	    		<th>Wire Brand</th>
	   	    		<th>Length</th>
	   	    		<th>Height</th>
	   	    		<th>No. of Pieces</th>
	   	    		<th>Rate Per Sft</th>
	   	    		<th>Square Feets</th>
	   	    		<th>ChainLink Item Cost</th>
	   	    	</tr>
	   	    	
	  	    	<g:each in="${(0..4)}"status="i" var="sideMesh">
	   	    	<tr>
	   	    	    <td><g:select name="sideMesh[${i}].id" from="${com.chakra.config.SideMesh.list()}" noSelection="${['null':'Select One...']}" optionKey="id" value="${sideMeshList?.getAt(i)?.id}" /></td>
	   	    	    <td><g:select name="sideMesh[${i}].wireBrand" from="${com.chakra.config.WireBrand.list()}" noSelection="${['null':'Select One...']}" optionKey="id" value="${wireBrandList?.getAt(i)?.id}" /></td>
	   	    	    <td><g:textField type="number" name="sideMesh[${i}].length1" value="${lengthList?.getAt(i)}"/></td>
	   	    		<td><g:textField type="number" name="sideMesh[${i}].height" value="${heightList?.getAt(i)}"/></td>
	   	    		<td><g:textField type="number" name="sideMesh[${i}].noOfPieces" value="${noOfPiecesList?.getAt(i)}"/></td>
	   	    		<td><g:textField type="number" name="sideMesh[${i}].pricePerSqFt" value="${formatNumber(number: ratePerSqftList?.getAt(i), format: '#,##0.00')}"/></td>
	   	    		<td><g:textField type="number" name="sideMesh[${i}].squareFeets" value="${formatNumber(number: squareFeetsList?.getAt(i), format: '#,##0.00')}"/></td>
	   	    		<td><g:textField type="number" name="sideMesh[${i}].weldSideItemCost" value="${formatNumber(number: weldSideCostList?.getAt(i), format: '#,##0.00')}"/></td>
	   	    	</tr>
	  	    	</g:each>
	   	    	
	   	    </table>	   	    						 
				  	    
		    <div class="buttons">
	           	<span class="button"><g:submitButton name="submit" class="btn btn-primary" value="Submit"/></span>
	        </div>
	   	</g:form>
	   	
	   	<g:form controller="quotation" action="createWeldSide">
		
			<g:hiddenField name="customer.id" value="${customerInstance?.id}" />
			<g:hiddenField name="taxation.id" value="${taxationInstance?.id}" />
			
			<g:each var="sideMesh"	in="${sideMeshList}" status="j">
            	<g:hiddenField name="sideMesh[${j}].id" value="${sideMesh?.id}" />
		    </g:each>
		    <g:each var="wireBrand"	in="${wireBrandList}" status="j">
            	<g:hiddenField name="sideMesh[${j}].wireBrand" value="${wireBrand?.id}" />
		    </g:each>
		    <g:each var="length" in="${lengthList}" status="j">
            		<g:hiddenField name="sideMesh[${j}].length1" value="${length}" />
		    </g:each>
		    <g:each var="height" in="${heightList}" status="j">
            	<g:hiddenField name="sideMesh[${j}].height" value="${height}" />
		    </g:each>
		    <g:each var="noOfPieces" in="${noOfPiecesList}" status="j">
            	<g:hiddenField name="sideMesh[${j}].noOfPieces" value="${noOfPieces}" />
		    </g:each>
			
			<div class="buttons">
               	<span class="button"><g:submitButton name="createQuotation" class="btn btn-primary" value="Create Quotation"/></span>
            </div>
		</g:form>   
		
	</body>
</html>
