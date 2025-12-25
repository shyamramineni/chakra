<html>
    <head>
        <meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quotation.label', default: 'Quotation Planner')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
		<g:javascript library="jquery" />
		
    </head>
    <body>
    	<h2>Create Quotation</h2>
    	    			
		<g:form controller="quotation" action="saveQuotation">
		
		<table class="table table-bordered">
							
				    <tr>
				        <th align="left">Customer:</th>
				        <td>
				        	<g:select id="customer" name="customer.id" from="${com.chakra.customer.Customer.list()}" optionKey="id" required="" value="${quotationInstance?.customer?.id}" class="many-to-one"/>
				        </td>
				    </tr>
				    <tr>
				        <th align="left">Cage Length:</th>
				        <td>${quotationInstance.cageLength}</td>
				    </tr>
				    <tr>
				        <th align="left">Fulls:</th>
				        <td>${quotationInstance.fulls}</td>
				    </tr>
				    <tr>
				        <th align="left">Halfs:</th>
				        <td>${quotationInstance.halfs}</td>
				    </tr>
				    <tr>
				        <th align="left">Tiers:</th>
				        <td>${quotationInstance.tiers}</td>
				    </tr>
				    <tr>
				        <th align="left">No Of Cuttings In Shed:</th>
				        <td>${quotationInstance.noOfCuttingsInShed}</td>
				    </tr>
				    <tr>
				        <th align="left">No Of Sheds:</th>
				        <td>${quotationInstance.noOfSheds}</td>
				    </tr>			    
						
			</table>
		
		<br>
		
		<li class="fieldcontain">
			<span id="quotationModels-label" class="property-label"><g:message code="quotation.quotationModels.label" default="QUOTATION MODEL:" /></span>
		
				<table class="table table-bordered">
						
						<tr>
							<th>Cage Design</th>
							<th>Wire Brand</th>
							<th>No.Of Birds</th>
							<th>Cost</th>
							<th>Tax</th>
							<th>Total Cost</th>
						</tr>										
							 
						<tr>
							<td>${cageDesign}</td>
							<td>${wireBrand}</td>
							<td><g:formatNumber number="${noOfBirds}" type="number" maxFractionDigits="0" /></td>
							<td><g:formatNumber number="${cost}" type="number" maxFractionDigits="2" roundingMode="HALF_UP" /></td>
							<td><g:formatNumber number="${tax}" type="number" maxFractionDigits="2" roundingMode="HALF_UP" /></td>
							<td><g:formatNumber number="${totalCost}" type="number" maxFractionDigits="2" roundingMode="HALF_UP" /></td>
						</tr>			
						
				</table>							
    	</li>
    	
    	
		    <g:hiddenField name="cageDesign" value="${cageDesign.id}" />
		    <g:hiddenField name="wireBrand" value="${wireBrand.id}" />
		    <g:each var="cagePartSpec"	in="${cagePartSpecList}" status="j">
		    	<g:hiddenField name="cagePartSpecList" value="${cagePartSpec}" />
		    </g:each>
		    <g:hiddenField name="taxation" value="${taxation.id}" />
		    <g:hiddenField name="cageLength" value="${quotationInstance.cageLength}" />
		    <g:hiddenField name="fulls" value="${quotationInstance.fulls}" />
		    <g:hiddenField name="halfs" value="${quotationInstance.halfs}" />
		    <g:hiddenField name="tiers" value="${quotationInstance.tiers}" />
		    <g:hiddenField name="noOfCuttingsInShed" value="${quotationInstance.noOfCuttingsInShed}" />
		    <g:hiddenField name="noOfSheds" value="${quotationInstance.noOfSheds}" />
		    <g:hiddenField name="noOfBirds" value="${noOfBirds}" />
		    <g:hiddenField name="cost" value="${cost}" />
		    <g:hiddenField name="tax" value="${tax}" />
		    <g:hiddenField name="totalCost" value="${totalCost}" />
		                      	
		    <div class="buttons">
		    	<span class="button"><g:submitButton name="createQuotation" class="btn btn-primary" value="Save"/></span>
		    </div>
        </g:form>    	
    </body>
</html>