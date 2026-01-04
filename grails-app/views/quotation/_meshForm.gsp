<%@ page import="com.chakra.quotation.QuotationMeshPart" %>



   <g:if test="${quotationInstance.quotationModels!= null}">
                     
                              
                   <div>
                  
                   
                       <table class="table table-bordered">
                           <tbody>    
                                                  	
                                 	<tr>                                    
                                       <th>Sheet Specification</th>  
		                               <th>Wire Brand</th>
                                       <th>No Of MeshParts</th>
                                    </tr>     
                                 	                                                     
                                    
                                    <g:each var="quotationMeshPart" in="${quotationModelInstance?.quotationMeshModel?.quotationMeshParts}" status="i">  
                                    <tr>
                                      
                                      <g:hiddenField name='quotationMeshParts[${i}].id' value='${quotationMeshPart.id}' />
                                      <g:hiddenField name='quotationMeshParts[${i}].sheetSpecification.id' value='${quotationMeshPart.sheetSpecification.id}' />
                                      <g:hiddenField name='quotationMeshParts[${i}].wireBrand.id' value='${quotationMeshPart.wireBrand.id}' />
                                      <td valign="top" class="value">
                                      	  ${quotationMeshPart.sheetSpecification}                                     		
                                      </td>
                                      <td valign="top" class="value">
                                      	 ${quotationMeshPart.wireBrand}
                                      </td>
                                      <td valign="top" class="value">
                                      	  <g:textField id="quotationMeshParts[${i}].noOfMeshParts" name="quotationMeshParts[${i}].noOfMeshParts"  value="${quotationMeshPart.noOfMeshParts}" />
                                      </td>
                                    
                                    </tr>
                                    </g:each>
                                    <%--<tr>
                                    	<td><g:select name="sheetSpecFormula" id="sheetSpecFormula[${i}]" from="${sheetSpecFormulaList}" value="${sheetSpecFormulaList?.getAt(i)}"></g:select></td>
                                    	<td></td>
                                    	<td><g:textField id="quotationMeshParts[${i}].noOfMeshParts" name="quotationMeshParts[${i}].noOfMeshParts"  value="${quotationMeshPart?.noOfMeshParts}" /></td>
                                    </tr>
                                                
                           --%></tbody>
                       </table>
                       
                       <div>
					   		<label for="comments">
								<g:message code="quotation.comments.label" default="Add Value" />
							</label>
							<g:textField type="number" name="addValue" value=""/>
							<g:textArea name="description" value=""/>							
						</div>
                   
                   </div>               
	                              
	   </g:if>
	   
	   
	   
