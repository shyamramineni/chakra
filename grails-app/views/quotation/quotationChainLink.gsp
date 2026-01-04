
<html>
    <head>
        <meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quotation.label', default: 'Quotation ChainLink')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
		<g:javascript library="jquery" />		
    </head>
    
    <body>
    	<h2>Quotation ChainLink</h2>
    	<g:form controller="quotation" action="chainLinkPrices" >
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
	   	    	
	  	    	<g:each in="${(0..4)}"status="i" var="chainLink">
	   	    	<tr>
	   	    	    <td><g:select name="linkMesh[${i}].id" from="${com.chakra.config.LinkMesh.list()}" noSelection="${['null':'Select One...']}" optionKey="id" value="${linkMeshList?.getAt(i)?.id}" /></td>
	   	    	    <td><g:select name="linkMesh[${i}].wireBrand" from="${com.chakra.config.WireBrand.list()}" noSelection="${['null':'Select One...']}" optionKey="id" value="${wireBrandList?.getAt(i)?.id}" /></td>
	   	    	    <td><g:textField type="number" name="linkMesh[${i}].length1" value="${lengthList?.getAt(i)}"/></td>
	   	    		<td><g:textField type="number" name="linkMesh[${i}].height" value="${heightList?.getAt(i)}"/></td>
	   	    		<td><g:textField type="number" name="linkMesh[${i}].noOfPieces" value="${noOfPiecesList?.getAt(i)}"/></td>
	   	    		<td><g:textField type="number" name="linkMesh[${i}].pricePerSqFt" value="${formatNumber(number: ratePerSqftList?.getAt(i), format: '#,##0.00')}"/></td>
	   	    		<td><g:textField type="number" name="linkMesh[${i}].squareFeets" value="${formatNumber(number: squareFeetsList?.getAt(i), format: '#,##0.00')}"/></td>
	   	    		<td><g:textField type="number" name="linkMesh[${i}].chainLinkItemCost" value="${formatNumber(number: chainLinkCostList?.getAt(i), format: '#,##0.00')}"/></td>
	   	    	</tr>
	  	    	</g:each>
	   	    	
	   	    </table>	   	    						 
				  	    
		    <div class="buttons">
	           	<span class="button"><g:submitButton name="submit" class="btn btn-primary" value="Submit"/></span>
	        </div>
	   	</g:form>
	   	
	   	<g:form controller="quotation" action="createChainLink">
		
			<g:hiddenField name="customer.id" value="${customerInstance?.id}" />
			<g:hiddenField name="taxation.id" value="${taxationInstance?.id}" />
			
			<g:each var="linkMesh"	in="${linkMeshList}" status="j">
            	<g:hiddenField name="linkMesh[${j}].id"" value="${linkMesh?.id}" />
		    </g:each>
		    <g:each var="wireBrand"	in="${wireBrandList}" status="j">
            	<g:hiddenField name="linkMesh[${j}].wireBrand" value="${wireBrand?.id}" />
		    </g:each>
		    <g:each var="length" in="${lengthList}" status="j">
            		<g:hiddenField name="linkMesh[${j}].length1" value="${length}" />
		    </g:each>
		    <g:each var="height" in="${heightList}" status="j">
            	<g:hiddenField name="linkMesh[${j}].height" value="${height}" />
		    </g:each>
		    <g:each var="noOfPieces" in="${noOfPiecesList}" status="j">
            	<g:hiddenField name="linkMesh[${j}].noOfPieces" value="${noOfPieces}" />
		    </g:each>
			
			<div class="buttons">
               	<span class="button"><g:submitButton name="createQuotation" class="btn btn-primary" value="Create Quotation"/></span>
            </div>
		</g:form>   
		
	</body>
</html>
