
<%@ page import="com.chakra.quotation.Quotation" %>
<html>
    <head>
        <meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quotation.label', default: 'Quotation Models')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
		<g:javascript library="jquery" />
    </head>
    <body>
    	<a href="#add-quotationmodel" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
        	<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
	
	
		
        <div id="#add-quotationmodel" class="content scaffold-create" role="main">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="alert alert-error">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${quotationInstance}">
            <div class="errors">
                <g:renderErrors bean="${quotationInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="update" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <g:hiddenField name="id" value="${quotationInstance?.id}" />
                            <g:hiddenField name="customer.id" value="${quotationInstance?.customer?.id}" />
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="cageLength"><g:message code="quotation.cageLength.label" default="Customer Name" /></label>
                                </td>
                                <td valign="top" class="value">
                                    ${quotationInstance?.customer?.customerName}
                                </td>
                            </tr>
                            
                            <tr class="prop">
                            <td valign="top" class="name"><g:message code="quotation.cageLength.label" default="Cage Length" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: quotationInstance, field: "cageLength")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="quotation.fulls.label" default="Fulls" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: quotationInstance, field: "fulls")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="quotation.halfs.label" default="Halfs" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: quotationInstance, field: "halfs")}</td>
                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="quotation.tiers.label" default="Tiers" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: quotationInstance, field: "tiers")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="quotation.noOfCuttingsInShed.label" default="No Of Cuttings In Shed" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: quotationInstance, field: "noOfCuttingsInShed")}</td>
                            
                        </tr>
                                           
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="quotation.noOfSheds.label" default="No Of Sheds" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: quotationInstance, field: "noOfSheds")}</td>
                            
                        </tr><%--
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="quotation.taxation.label" default="Taxation" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: quotationInstance, field: "taxation")}</td>
                            
                        </tr>--%>                        
                      
                         <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="quotation.tiers.label" default="Status" /></label>
                                </td>
                                
                                <td valign="top" class="value"><b>${fieldValue(bean: quotationInstance, field: "status")}</b></td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                
               <%--<div class="buttons">
                    <span class="btn-primary"><g:submitButton class="btn-primary" name="update" class="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
           	  </div>
           --%></g:form>
            <g:if test="${quotationInstance.quotationModels!= null}">
                 
                 
            <label><b>QUOTATION MODELS:</b></label>
                      
                               
            <div id="quotationModels">
                   
                    
                        <table class="table table-bordered">
                            <tbody>    
                                                         
                                                      
                                  <g:each var="quotationModel" in="${quotationInstance.quotationModels}" status="i">
                                  
                                  	<g:if test="${i  == 0 }">
                                  	 <tr>
                                     
                                        <td>
                                          <label id="cageDesign"><b>Cage Design</b></label>
                                        </td>  
		                                <td>
                                          <label id="noOfBirds"><b>No.Of Birds</b></label>
                                        </td>
                                        <td>
                                          <label id="cost"><b>Cost</b></label>
                                        </td>
                                        <td>
                                          <label id="tax"><b>Tax</b></label>
                                        </td>
                                        <td>
                                          <label id="totalCost"><b>Total Cost</b></label>
                                        </td>
                                        <td>
                                          <label id="view"><b>Quotation Model</b></label>
                                        </td>
                                        <td>
                                          <label id="confirm"><b>Confirm</b></label>
                                        </td>
                                          
                                    </tr>     
                                  	
                                  	</g:if>
                                                                
                                    <tr>
                                    
                                      <td valign="top" class="value">
                                      	   ${quotationModel?.cageDesign?.cageDesign}
                                      </td>
                                                         
                                      <%--<td valign="top" class="value">
                                      		${quotationModel.wireBrand}
                                      </td>
                                      --%><td valign="top" class="value">
                                      	  <%--${quotationModel.singleBox}--%>                                     		
                                          <g:formatNumber number="${quotationModel.noOfBirds}" type="number" maxFractionDigits="0" />
                                      </td>
                                      <td valign="top" class="value">
                                      	 <g:formatNumber number="${quotationModel.cost}" type="number" maxFractionDigits="2" roundingMode="HALF_UP"/>
                                          
                                      </td>
                                      <td valign="top" class="value">
                                      	  <g:formatNumber number="${quotationModel.tax}" type="number" maxFractionDigits="2" roundingMode="HALF_UP" />
                                      </td>
                                      <td valign="top" class="value">
                                      	  <g:formatNumber number="${quotationModel.totalCost}" type="number" maxFractionDigits="2" roundingMode="HALF_UP" />
                                          
                                      </td>
                                      <td>
                                          <g:link action="quotationModelShow" params="["quotation":quotationInstance.id,"quotationModel":quotationModel.id]" >View</g:link>
                                      </td>
                                      <td>
                                          <g:form controller="corder" action="create">
                                             <g:hiddenField name="quotation.id" value="${quotationInstance?.id}" />
                                             <g:hiddenField name="quotationModel.id" value="${quotationModel.id}" />
                                             
                                             <g:if test="${quotationInstance?.status != "REALIZED"}">
                                             <div class="buttons">
                                                  <span class="button"><g:submitButton name="confirmOrder" class="btn btn-primary" value="Confirm Order" /></span>
                                             </div>
                                             </g:if>     
                                          </g:form>
                                      </td>
                                    
                                    </tr>
                                                                          
                                  </g:each>
                                      
                           </tbody>
                       </table>
                    
                    </div>               
	                              
	              </g:if>  
	                  
	                   
	                    
                         <label><b>NEW QUOTATION MODEL:</b></label>             
                           
                           <g:form action="addQuotationModel">  
                             <table class="table table-bordered">
                                 
				                 <thead>
				                    <tr>
				                        <td>
	                                      	<label for="cageDesign">
												<g:message code="quotationModels.cageDesign.label" default="Cage Design" />
												<span class="required-indicator">*</span>
											</label>
	                                     </td>
	                                     <td valign="top" class="value">
	                                          <g:select name="designType" from="${com.chakra.config.CageDesign.constraints.designType.inList}" noSelection="${['null':'Select One...']}" optionKey="" value=""  />
	                                     </td>
	                                     
	                                     <td valign="top" class="value">
	                                          <g:select name="cageDesign.id" from="[]" noSelection="${['null':'Select One...']}" optionKey="id" value=""  />
	                                     </td>
	                                     
	                                     <td>
	                                      	<label for="taxation">
												<g:message code="quotationModels.taxation.label" default="Taxation" />
												<span class="required-indicator">*</span>
											</label>
	                                     </td>
	                                     <td valign="top" class="value">
	                                          <g:select name="taxation.id" from="${com.chakra.config.Taxation.list()}" optionKey="id" value=""  />
	                                     </td>
	                                     
				                    </tr>
				                </thead>
				                
				                <thead>     
									<tr>
									     <td>
				                             <g:checkBox name="meshOrder" value="${false}" />
				                          </td>
										<th colspan="4" align="left">MESH PART:</th>
									</tr>
								</thead>
                                   
                                 <tbody>    
                                      
                                     <g:hiddenField name="quotation.id" value="${quotationInstance?.id}" />                                                                      
                                     <tr><%--
	                                      <td>
				                             <g:checkBox name="meshOrder" value="${false}" />
				                          </td> 
	                                      
	                                      --%><td>
	                                      	<label for="wireBrand">
												<g:message code="quotationModels.wireBrand.label" default="Wire Brand" />
											</label>
	                                      </td>                   
	                                      <td valign="top" class="value">
	                                          <g:select name="wireBrand.id" from="${com.chakra.config.WireBrand.list()}" noSelection="${['null':'Select One...']}" optionKey="id" value=""  />
	                                      </td>
                                     </tr>
                                     
                                <thead>
										<tr>
										    <td>
				                                 <g:checkBox name="cagePartOrder" value="${false}" />
				                            </td>
											<th colspan="4" align="left">CAGE PARTS:</th>
											
										</tr>
										
								</thead>
									
									 <g:each in="${com.chakra.config.CagePartType.list()}" status="i" var="cagePartTypeInstance">
									 
									   <tr>
									      <td colspan="2">
									   	      ${cagePartTypeInstance}
									   	  </td>
									   	   	
	                                       <td id="cagePartSpecification[${i}]" valign="top" class="value">
	                                          <g:select name="cagePartSpecification" from="${com.chakra.config.CagePartSpecification.findAllByCagePartType(cagePartTypeInstance)}" noSelection="${['null':'Select One...']}" optionKey="id" value=""  />  
	                                      </td>
                                     </tr>	
									 
									 
									 </g:each>
								                       
                                <thead>
										<tr>
										    <td>
				                                 <g:checkBox name="chainLinkOrder" value="${false}" />
				                            </td>
											<th colspan="4" align="left">CHAIN LINK:</th>
											
										</tr>
										
										<tr>
							   	    		<th>Design</th>
							   	    		<th>Wire Brand</th>
							   	    		<th>Length</th>
							   	    		<th>Height</th>
							   	    		<th>No. of Pieces</th>
							   	    		<%--<th>Rate Per Sft</th>
							   	    		<th>Square Feets</th>
							   	    		<th>ChainLink Item Cost</th>
							   	    	--%></tr>
							   	    	
							  	    	<g:each in="${(0..4)}"status="i" var="chainLink">
							   	    	<tr>
							   	    	    <td><g:select name="linkMesh[${i}].id" from="${com.chakra.config.LinkMesh.list()}" noSelection="${['null':'Select One...']}" optionKey="id" value="${linkMeshList?.getAt(i)?.id}" /></td>
							   	    	    <td><g:select name="linkMesh[${i}].wireBrand" from="${com.chakra.config.WireBrand.list()}" noSelection="${['null':'Select One...']}" optionKey="id" value="${wireBrandList?.getAt(i)?.id}" /></td>
							   	    	    <td><g:textField type="number" name="linkMesh[${i}].length1" value="${lengthList?.getAt(i)}"/></td>
							   	    		<td><g:textField type="number" name="linkMesh[${i}].height" value="${heightList?.getAt(i)}"/></td>
							   	    		<td><g:textField type="number" name="linkMesh[${i}].noOfPieces" value="${noOfPiecesList?.getAt(i)}"/></td>
							   	    		<%--<td><g:textField type="number" name="linkMesh[${i}].pricePerSqFt" value="${formatNumber(number: ratePerSqftList?.getAt(i), format: '#,##0.00')}"/></td>
							   	    		<td><g:textField type="number" name="linkMesh[${i}].squareFeets" value="${formatNumber(number: squareFeetsList?.getAt(i), format: '#,##0.00')}"/></td>
							   	    		<td><g:textField type="number" name="linkMesh[${i}].chainLinkItemCost" value="${formatNumber(number: chainLinkCostList?.getAt(i), format: '#,##0.00')}"/></td>
							   	    	--%></tr>
							  	    	</g:each>
										
								</thead>
								
								<thead>
										<tr>
										    <td>
				                                 <g:checkBox name="weldSideMeshOrder" value="${false}" />
				                            </td>
											<th colspan="4" align="left">WELD SIDE MESH:</th>
											
										</tr>
										
										<tr>
							   	    		<th>Design</th>
							   	    		<th>Wire Brand</th>
							   	    		<th>Length</th>
							   	    		<th>Height</th>
							   	    		<th>No. of Pieces</th>
							   	    		<%--<th>Rate Per Sft</th>
							   	    		<th>Square Feets</th>
							   	    		<th>ChainLink Item Cost</th>
							   	    	--%></tr>
							   	    	
							  	    	<g:each in="${(0..4)}"status="i" var="sideMesh">
							   	    	<tr>
							   	    	    <td><g:select name="sideMesh[${i}].id" from="${com.chakra.config.SideMesh.list()}" noSelection="${['null':'Select One...']}" optionKey="id" value="${sideMeshList?.getAt(i)?.id}" /></td>
							   	    	    <td><g:select name="sideMesh[${i}].wireBrand" from="${com.chakra.config.WireBrand.list()}" noSelection="${['null':'Select One...']}" optionKey="id" value="${wireBrandList?.getAt(i)?.id}" /></td>
							   	    	    <td><g:textField type="number" name="sideMesh[${i}].length1" value="${lengthList?.getAt(i)}"/></td>
							   	    		<td><g:textField type="number" name="sideMesh[${i}].height" value="${heightList?.getAt(i)}"/></td>
							   	    		<td><g:textField type="number" name="sideMesh[${i}].noOfPieces" value="${noOfPiecesList?.getAt(i)}"/></td>
							   	    		<%--<td><g:textField type="number" name="sideMesh[${i}].pricePerSqFt" value="${formatNumber(number: ratePerSqftList?.getAt(i), format: '#,##0.00')}"/></td>
							   	    		<td><g:textField type="number" name="sideMesh[${i}].squareFeets" value="${formatNumber(number: squareFeetsList?.getAt(i), format: '#,##0.00')}"/></td>
							   	    		<td><g:textField type="number" name="sideMesh[${i}].weldSideItemCost" value="${formatNumber(number: weldSideCostList?.getAt(i), format: '#,##0.00')}"/></td>
							   	    	--%></tr>
							  	    	</g:each>
										
								</thead>
								      
                                </tbody>
                             
                             </table>
                             
                             <g:if test="${(quotationInstance?.status == "NEW") || (quotationInstance?.status =="PENDING")}"> 
	                             <div class="buttons">
	                                  <g:submitButton class="btn btn-primary" name="addQuotationModel" class="btn btn-primary" value="Add Model" />
	                             </div>
                             </g:if>
                             
                            </g:form>                          
	                                   
                       
                
         
       </div>
       
       <script type="text/javascript">
		
		 $(document).ready(function() {
		 	//alert("doc loaded")
			$("#addQuotationModel").attr("disabled", "disabled");

		 	////var checkboxes = $("input[type='checkbox']"),
		    //submitButt = $("input[type='submit']");

			//checkboxes.click(function() {
		   // 	submitButt.attr("disabled", !checkboxes.is(":checked"));
			//});
			var checkboxes = $("input[type='checkbox']");
			checkboxes.click(function() {
				$("#addQuotationModel").attr("disabled", !checkboxes.is(":checked"));
			});	

			$("#designType").change(function() {
				//alert("design")
				$.ajax({
		            url: "${request.contextPath}/cageDesign/ajaxGetCageDesign",
		              data: "id=" + this.value,
		              cache: false,
		             success: function(html) {
		             //alert(html);
		              $('select[name*="cageDesign.id"]').html(html);
		              }
		            });
		         });
			
	     });
		 			
      </script>       
    
    </body>
</html>  
	
