
<html>
    <head>
        <meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quotation.label', default: 'Quotation Planner')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
		<g:javascript library="jquery" />		
    </head>
    <body>
    	<h2>Quotation Cart</h2>
		<g:form controller="cageDesign" action="sheetPrices" name="sheetPrices">
		
			<div class="row">
			
				<div class="span6">
					
					<div class="fieldcontain ${hasErrors(bean: quotationInstance, field: 'customer', 'error')} required">
						<label for="customer">
							<g:message code="quotation.customer.label" default="Customer" />
							<span class="required-indicator">*</span>
						</label>
						<g:select id="customer" name="customer.id" from="${com.chakra.customer.Customer.list()}" optionKey="id" required="" value="${customerInstance?.id}" class="many-to-one"/>
					</div>
										
					<div class="fieldcontain ${hasErrors(bean: wirePriceInstance, field: 'wireBrand', 'error')} required">
						<label for="wireBrand">
							<g:message code="wirePrice.wireBrand.label" default="Wire Brand" />
							<span class="required-indicator">*</span>
						</label>
						<g:select id="wireBrand" name="wireBrand.id" from="${com.chakra.config.WireBrand.list()}" optionKey="id" required="" value="${wireBrandInstance?.id}" class="many-to-one"/>
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: wirePriceInstance, field: 'taxation', 'error')} required">
						<label for="wireBrand">
							<g:message code="wirePrice.wireBrand.label" default="Taxation" />
							<span class="required-indicator">*</span>
						</label>
						<g:select id="taxation" name="taxation.id" from="${com.chakra.config.Taxation.list()}" optionKey="id" required="" value="${taxationInstance?.id}" class="many-to-one"/>
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: cageDesignInstance, field: 'cageDesign', 'error')} required">
						<label for="cageDesign">
							<g:message code="wirePrice.cageDesign.label" default="Cage Design" />
							<span class="required-indicator">*</span>
						</label>
						<g:select id="cageDesign" name="cageDesign.id" from="${com.chakra.config.CageDesign.list()}" optionKey="id" required="" noSelection="${['0':'Select One...']}" value="${cageDesignInstance?.id}" class="many-to-one"/>
					</div>
											
				</div>
					
				
	   	    </div>
	   	    
	   	    <h2>Mesh Parts</h2>
	   	    
	   	    <table>
	   	    	<tr>
	   	    		<th>Sheet Specification</th>
	   	    		<th>Quantity</th>
	   	    		<th>Price</th>
	   	    	</tr>
	   	    	
	   	    	<g:each in="${ (0..7) }"status="i" var="sheet">
		   	    	<tr>
		   	    	    <g:if test="${sheetSpecFormulaList != null}">
		   	    			<td><g:select name="cageDesignSheetSpecFormula[${i}].id" id="cageDesignSheetSpecFormula[${i}]" optionKey="id" from="${cageDesignSheetSpecFormulaList_1}" value="${sheetSpecFormulaList?.getAt(i)?.id}"></g:select></td>
		   	    			<td><g:textField type="number" name="sheetQuantity" id="sheetQuantity" value="${sheetQuantityList?.getAt(i)}"/></td>
		   	    			<td><g:textField type="number" name="sheetPrice" id="sheetPrice" value="${formatNumber(number: sheetPriceList?.getAt(i), format: '#,##0.00')}"/></td>
		   	    		</g:if>
		   	    		<g:if test="${sheetSpecFormulaList == null}">
		   	    			<td><g:select name="cageDesignSheetSpecFormula" id="cageDesignSheetSpecFormula[]" from="[]" value=""></g:select></td>
		   	    			<td><g:textField type="number" name="sheetQuantity" id="sheetQuantity" value=""/></td>
		   	    			<td><g:textField type="number" name="sheetPrice" id="sheetPrice" value=""/></td>
		   	    		</g:if>
		   	    	</tr>
	   	    	</g:each>
	   	    	
	   	    </table>
	   	    <br>
	   	    
	   	    <h2>Cage Parts</h2>
	   	    	   	    			
			<table>						 
				<tr>
					<th>Cage Part Type</th>
					<th>Cage Part Specification</th>
					<th>Cage Part</th>
					<th>Quantity</th>
					<th>Price</th>
				</tr>
				<g:each in="${0..15}" status="i" var="cagePartTypeInstance">
				<tr>
					<g:if test ="${cagePartTypeList_1 != null}"> 
					<td>
						<g:select optionKey="id" optionValue="cagePartType" name="cagePartType" id="cagePartType[${i}].id" from="${cagePartTypeList_1}" value="${cagePartTypeList_2?.getAt(i)?.id}"/>
					</td>
					</g:if>
					
					<g:if test ="${cagePartTypeList_1 == null}"> 
					<td>
						<g:select optionKey="id" optionValue="cagePartType" name="cagePartType" id="cagePartType[${i}].id" noSelection="${['null':'Select One...']}" from="${com.chakra.config.CagePartType.list()}" value=""/>
					</td>
					</g:if>
					
					<g:if test ="${cagePartSpecificationList_1 != null}">
					<td>
						<g:select optionKey="id" name="cagePartSpecification" id="cagePartSpecification[${i}]" from="${cagePartSpecificationList_2}" value="${cagePartSpecificationList_1?.getAt(i)?.id}"></g:select>
					</td>
					</g:if>
					
					<g:if test ="${cagePartSpecificationList_1 == null}">
					<td>
						<g:select name="cagePartSpecification" id="cagePartSpecification[${i}]" from="[]" noSelection="${['null':'Select One...']}" value=""></g:select>
					</td>
					</g:if>
					
					<g:if test ="${cagePartSpecFormulaList_1 != null}">
					<td>
						<g:select optionKey="id" name="cagePartSpecFormula" id="cagePartSpecFormula[${i}]" from="${cagePartSpecFormulaList_2}"  value="${cagePartSpecFormulaList_1?.getAt(i)?.id}"></g:select>
					</td>
					</g:if>
					
					<g:if test ="${cagePartSpecFormulaList_1 == null}">
					<td>
						<g:select name="cagePartSpecFormula" id="cagePartSpecFormula[${i}]" from="[]" noSelection="${['null':'Select One...']}" value=""></g:select>
					</td>
					</g:if>
					
					<td>
						<g:textField type="number" name="cageQuantity" id="cageQuantity" value="${cageQuantityList?.getAt(i)}"/>
					</td>
					
					<td>
						<g:textField type="number" name="price" id="price" value="${cagePartPriceList?.getAt(i)}"/>
					</td>
				</tr>
				</g:each>				   
			</table>						 
			<br>  	    
	   	    <div class="buttons">
               	<span class="button"><g:submitButton name="createQuotation" class="btn btn-primary" value="Submit"/></span>
            </div>
	   	    
		</g:form>
		<br>
		<g:form controller="quotation" action="quotationCart">
		
			<g:hiddenField name="customer.id" value="${customerInstance?.id}" />
			<g:hiddenField name="wireBrand.id" value="${wireBrandInstance?.id}" />
			<g:hiddenField name="cageDesign.id" value="${cageDesignInstance?.id}" />
			<g:hiddenField name="taxation.id" value="${taxationInstance?.id}" />
			
			<g:each var="sheetSpecFormula"	in="${sheetSpecFormulaList}" status="j">
            	
		    	<g:hiddenField name="meshList" value="${sheetSpecFormula?.id}" />
		    	
		    </g:each>
			<g:each var="cagePartSpecForm"	in="${cagePartSpecFormulaList_1}" status="j">
            	
		    	<g:hiddenField name="cageParSpecFormulaList" value="${cagePartSpecForm?.id}" />
		    		
		    </g:each>
		    <g:each var="cageQuantity"	in="${cageQuantityList}" status="j">
            	
		    	<g:hiddenField name="cageQuantityList" value="${cageQuantity}" />
		    		
		    </g:each>
		    <g:each var="quantity"	in="${sheetQuantityList}" status="j">
            	
		    	<g:hiddenField name="meshQuantityList" value="${quantity}" />
		    		
		    </g:each>
		    <g:each var="meshPrice"	in="${sheetPriceList}" status="j">
            	
		    	<g:hiddenField name="meshPriceList" value="${meshPrice}" />
		    		
		    </g:each>
		    <g:each var="cagePrice"	in="${cagePartPriceList}" status="j">
            	
		    	<g:hiddenField name="cagePartPriceList" value="${cagePrice}" />
		    		
		    </g:each>		
			<div class="buttons">
               	<span class="button"><g:submitButton name="createQuotation" class="btn btn-primary" value="Create Quotation"/></span>
            </div>
		</g:form>
				
		<script type="text/javascript">
		
		 $(document).ready(function() {
		 //alert("doc loaded")
		 		
		      $("#cageDesign").change(function() {
			      //alert("cagedesign")
			      var fieldchanged = $(this).attr('id');
			      var fieldvalue = $(this).val();
					if(fieldvalue === ''){
						return;
					}
					//alert(fieldchanged+' '+fieldvalue);
					var cageDesign = "cageDesign="+fieldvalue;
		      $.ajax({
		            url: "${request.contextPath}/cageDesign/sheetSpecifications",
		              data: "id=" + this.value,
		              cache: false,
		             success: function(html) {
		             //alert(html);
		              $('select[id*="cageDesignSheetSpecFormula[]"]').html(html);
		              }
		            });
		         });


		      $("#cagePartType\\.id").change(function() {
		        	//alert(this.value);
		           
		            $.ajax({
		                url: "${request.contextPath}/cagePartType/ajaxGetCagePartType",
		                data: "id=" + this.value,
		                dataType: 'html',
		                cache: false,
		                success: function(result) {
		                	//alert(result);
		                    $("#cargoSourceCell").html(result);
		                    
		                }
		            });
		        });
		        
		        
		        $('select[name*="cagePartType"]').change(function() {
		        	var fieldchanged = $(this).attr('id');
		        	//alert(fieldchanged);
					var index = fieldchanged.substring(13,14);
					//alert(index);
					var id = $(this).val();
					//alert("id "+id);
		           
		            $.ajax({
		                url: "${request.contextPath}/cagePartType/ajaxGetCagePartType",
		                data: "id=" + id,
		                dataType: 'html',
		                cache: false,
		                success: function(result) {
		                	//alert(result);
		                    $("#cagePartSpecification\\["+index+"\\]").html(result);
		                    
		                }
		            });
		        });

		        $('select[name*="cagePartSpecification"]').change(function() {
		        	var fieldchanged = $(this).attr('id');
		        	//alert(fieldchanged);
					var index = fieldchanged.substring(22,23);
					//alert(index);
					var id = $(this).val();
					//alert("id "+id);
		           
		            $.ajax({
		                url: "${request.contextPath}/cagePartType/ajaxGetCagePartSpec",
		                data: "id=" + id,
		                dataType: 'html',
		                cache: false,
		                success: function(result) {
		                	//alert(result);
		                    $("#cagePartSpecFormula\\["+index+"\\]").html(result);
		                    
		                }
		            });
		        });

		        //$('select[name*="sheetSpecification"]').change(function() {
		        	//var fieldvalue = $(this).val();
		        	//$("#sheetSpecification option[value=fieldvalue]").remove();
					//alert("sheet")
					//var fieldchanged = $(this).attr('id');
					//alert(fieldchanged);
					//var index = fieldchanged.substring(22,23);
		        	//alert(index);
		        	//$('#sheetSpecification option:eq(' + index + ')').remove();
		        	//index.remove();

		        	
		//        });

		        //$("input[type='text']").change(function() {
					//var fieldchanged = $(this).attr('id');
					//alert("fieldchanged");
					//var fieldvalue = $(this).val();
					//$("#getSheetPrices").submit();				
					
				//});		        
		       // $("#sheetSpecification[] option[value='true']").remove();				
		  
		});

			//onchange of quantity
			//check if value is number
			//if its number make ajax to get price for that shet,quantity,wirebrand
		    //get the index of quantity
		    // update correponsding index price.s
		       
         </script>
    
    </body>
</html>

