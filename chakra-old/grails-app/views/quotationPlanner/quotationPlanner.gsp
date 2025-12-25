
<html>
    <head>
        <meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quotation.label', default: 'Quotation Planner')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
		<g:javascript library="jquery" />
		
    </head>
    <body>
    	<h2>Quotation Planner</h2>
		
		<g:form action="quotationPlanner" name="quotationPlanner">
		
			<div class="row">
			
				  <div class="span6">
				
					<div class="fieldcontain ${hasErrors(bean: quotationInstance, field: 'cageLength', 'error')} required">
						<label for="cageLength">
							<g:message code="quotation.cageLength.label" default="Cage Length" />
							<span class="required-indicator">*</span>
						</label>
						<g:textField type="number" name="cageLength" value="${(cageLength != null) ? cageLength : 300}"/>
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: quotationInstance, field: 'fulls', 'error')} required">
						<label for="fulls">
							<g:message code="quotation.fulls.label" default="Fulls" />
							<span class="required-indicator">*</span>
						</label>
						<g:textField type="number" name="fulls" required="" value="${(fulls != null) ? fulls : 3}"/>
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: quotationInstance, field: 'halfs', 'error')} required">
						<label for="halfs">
							<g:message code="quotation.halfs.label" default="Halfs" />
							<span class="required-indicator">*</span>
						</label>
						<g:textField type="number" name="halfs" required="" value="${(halfs != null) ? halfs : 0}"/>
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: quotationInstance, field: 'tiers', 'error')} required">
						<label for="tiers">
							<g:message code="quotation.tiers.label" default="Tiers" />
							<span class="required-indicator">*</span>
						</label>
						<g:textField type="number" name="tiers" required="" value="${(tiers != null) ? tiers : 3}"/>
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: quotationInstance, field: 'noOfCuttingsInShed', 'error')} required">
						<label for="noOfCuttingsInShed">
							<g:message code="quotation.noOfCuttingsInShed.label" default="No Of Cuttings In Shed" />
							<span class="required-indicator">*</span>
						</label>
						<g:textField type="number" name="noOfCuttingsInShed" required="" value="${(noOfCuttingsInShed != null) ? noOfCuttingsInShed : 0}"/>
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: quotationInstance, field: 'noOfSheds', 'error')} required">
						<label for="noOfSheds">
							<g:message code="quotation.noOfSheds.label" default="No Of Sheds" />
							<span class="required-indicator">*</span>
						</label>
						<g:textField type="number" name="noOfSheds" required="" value="${(noOfSheds != null) ? noOfSheds : 1}"/>
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: wirePriceInstance, field: 'wireBrand', 'error')} required">
						<label for="wireBrand">
							<g:message code="wirePrice.wireBrand.label" default="Wire Brand" />
							<span class="required-indicator">*</span>
						</label>
						<g:select id="wireBrand" name="wireBrand.id" from="${com.chakra.config.WireBrand.list()}" optionKey="id" noSelection="${["":'Select One...']}" required="" value="${wireBrand?.id}" class="many-to-one"/>
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: taxationInstance, field: 'taxation', 'error')} required">
						<label for="taxation">
							<g:message code="wirePrice.wireBrand.label" default="Taxation" />
							<span class="required-indicator">*</span>
						</label>
						<g:select id="taxation" name="taxation.id" from="${com.chakra.config.Taxation.list()}" optionKey="id" noSelection="${["":'Select One...']}" required="" value="${taxation?.id}" class="many-to-one"/>
					</div>
								
				</div>
					
				<div class="span6">
					<g:each in="${com.chakra.config.CagePartType.list()}" status="i" var="cagePartTypeInstance">
					
					    <div class="fieldcontain ${cagePartTypeInstance} ">
							<label for="cagePartType">
								${cagePartTypeInstance}
							</label>
							<g:select name="cagePartSpecification" from="${com.chakra.config.CagePartSpecification.findAllByCagePartType(cagePartTypeInstance)}" noSelection="${['null':'Select One...']}" optionKey="id" value="${cagePartSpecList?.getAt(i)}" />
						</div>
												 
					</g:each>
				</div>
	   		</div>
		</g:form>
				
		<%--<g:if test="${cageDesignInstance.size() > 0}">
			--%><table class="table table-bordered">
					
					<tr>
						<th>Cage Design</th>
						<th>Wire Brand</th>
						<th>No.Of Birds</th>
						<th>Cost Per Bird</th>
						<th>Cost</th>
						<th>Tax</th>
						<th>Total Cost</th>
						<th>Quotation</th>
					</tr>			
					<g:each in="${cageDesignInstance}" var="cageDesign" status="i">
				   		<tr>
							<td>${cageDesign.cageDesign}</td>
							<td>${wireBrand}</td>
							<td><g:formatNumber number="${noOfBirds.get(i)}" type="number" maxFractionDigits="0" /></td>
							<td><g:formatNumber number="${costPerBird.get(i)}" type="number" maxFractionDigits="2" /></td>
							<td><g:formatNumber number="${cost.get(i)}" type="number" maxFractionDigits="2" roundingMode="HALF_UP" /></td>
							<td><g:formatNumber number="${tax.get(i)}" type="number" maxFractionDigits="2" roundingMode="HALF_UP" /></td>
							<td><g:formatNumber number="${totalCost.get(i)}" type="number" maxFractionDigits="2" roundingMode="HALF_UP" /></td>
							<td>
                            	<g:form controller="quotationPlanner" action="createQuotation">
                            	    <g:hiddenField name="cageDesign" value="${cageDesign?.id}" />
                            	    <g:hiddenField name="wireBrand" value="${wireBrand?.id}" />
                            	    <g:hiddenField name="taxation" value="${taxation?.id}" />
                            	    <g:hiddenField name="cageLength" value="${cageLength}" />
                                	<g:hiddenField name="fulls" value="${fulls}" />
                                	<g:hiddenField name="halfs" value="${halfs}" />
                                	<g:hiddenField name="tiers" value="${tiers}" />
                                	<g:hiddenField name="noOfCuttingsInShed" value="${noOfCuttingsInShed}" />
                                	<g:hiddenField name="noOfSheds" value="${noOfSheds}" />
                            	     <g:each var="cagePartSpec"	in="${cagePartSpecList}" status="j">
                            	    	<g:if test="${cagePartSpec != ''}">
		    								<g:hiddenField name="cagePartSpecList" value="${cagePartSpec}" />
		    							</g:if>	
		    						</g:each>
                            	    <%--<g:hiddenField name="cageLength" value="${cageLength}" />
                                	<g:hiddenField name="fulls" value="${fulls}" />
                                	<g:hiddenField name="halfs" value="${halfs}" />
                                	<g:hiddenField name="tiers" value="${tiers}" />
                                	<g:hiddenField name="noOfCuttingsInShed" value="${noOfCuttingsInShed}" />
                                	<g:hiddenField name="noOfSheds" value="${noOfSheds}" />
                                	<g:hiddenField name="noOfBirds" value="${noOfBirds.get(i)}" />
                                	<g:hiddenField name="cost" value="${cost.get(i)}" />
                                	<g:hiddenField name="tax" value="${tax.get(i)}" />
                                	<g:hiddenField name="totalCost" value="${totalCost.get(i)}" />
                                	<g:hiddenField name="meshCost" value="${meshCost.get(i)}" />
                                	<g:hiddenField name="meshDiscount" value="${meshDiscount.get(i)}" />
                                	<g:hiddenField name="meshDiscountPercent" value="${meshDiscountPercent.get(i)}" />
                                	<g:hiddenField name="netMeshCost" value="${netMeshCost.get(i)}" />
                                	<g:hiddenField name="cagePartsTotalCost" value="${cagePartsTotalCost.get(i)}" />
                                	--%>
                                	<div class="buttons">
                                    	<span class="button"><g:submitButton name="createQuotation" class="btn btn-primary" value="Create"/></span>
                                    </div>
                                </g:form>

                            </td>
						</tr>    
					</g:each>
					
			</table>
	
    
    <script type="text/javascript">

		$(document).ready(function() {

			//$("#quotationPlanner").submit();	
			//alert("document loaded");
			$(':input').change(function() {
				
				var fieldchanged = $(this).attr('id');
				//alert("fieldchanged");
				var fieldvalue = $(this).val();
				$("#quotationPlanner").submit();				
				
			});			
	
		});

	</script>
    
    </body>
</html>

