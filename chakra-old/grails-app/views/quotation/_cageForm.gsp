<%@ page import="com.chakra.quotation.QuotationCagePart" %>



   <g:if test="${quotationInstance.quotationModels!= null}">
                     
                              
                   <div>
                  
                   
                       <table class="table table-bordered">
                           <tbody>    
                                                  	
                                 	<tr>                                    
                                        <th>Cage Part Name</th>
										<th>Price Of Each CagePart</th>
										<th>No Of Cage Parts</th>
										<th>Cost Of CagePart</th>
                                    </tr>     
                                 	                                                     
                                    
                                    <g:each var="quotationCagePart" in="${quotationModelInstance?.quotationCagePartModel.quotationCageParts}" status="i">  
                                     <tr>
                                      
                                      <g:hiddenField name='quotationCageParts[${i}].id' value='${quotationCagePart.id}' />
                                      <g:hiddenField name='quotationCageParts[${i}].cagePartSpecFormula.id' value='${quotationCagePart.cagePartSpecFormula.id}' />
                                      <g:hiddenField name='quotationCageParts[${i}].noOfCageParts.id' value='${quotationCagePart.noOfCageParts}' />
                                      <g:hiddenField name='quotationCageParts[${i}].priceOfEachCagePart.id' value='${quotationCagePart.priceOfEachCagePart}' />                                      
                                      <td valign="top" class="value">
                                      	  ${quotationCagePart.cagePartSpecFormula}                                     		
                                      </td>
                                      <td valign="top" class="value">
                                      	  ${quotationCagePart.priceOfEachCagePart}                                     		
                                      </td>
                                      <td valign="top" class="value">
                                      	  <g:textField id="quotationCageParts[${i}].noOfCageParts" name="quotationCageParts[${i}].noOfCageParts"  value="${quotationCagePart.noOfCageParts}" />
                                      </td>
                                      <td valign="top" class="value">
                                      	 ${quotationCagePart.costOfCagePart}
                                      </td>
                                      
                                     </tr>
                                    </g:each>
                         </tbody>
                       </table>
                   
                   </div>               
	                              
	   </g:if>
	   
	   
	   