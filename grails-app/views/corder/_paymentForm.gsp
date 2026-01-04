<%@ page import="com.chakra.order.CorderPayment" %>

 <div>
                  
                   
                       <table class="table table-bordered">
                           <tbody>    
                                                  	
                                 	<tr>                                    
                                       <th>Order Id</th>  
		                               <th>Customer</th>
                                       <th>Payment Date</th>
                                       <th>Payment Amount</th>
                                       <th>Comments</th>
                                    </tr>     
                                 	                                                     
                                    
                                 <g:each var="corderPayment" in="${corderInstance?.corderPayments}" status="i">  
                                    <tr>
                                                                             
                                      <g:hiddenField name='corderPayments[${i}].id' value='${corderPayment.id}' />
                                      <%--<g:hiddenField name='corderPayments[${i}].corder' value='${corderPayment.corder}' />
                                      <g:hiddenField name='corderPayments[${i}].paymentDate' value='${corderPayment.paymentDate}' />
                                      --%><g:hiddenField name='corderPayments[${i}].paymentAmount.id' value='${corderPayment.paymentAmount}' />
                                      <%--<g:hiddenField name='corderPayments[${i}].comments' value='${corderPayment.comments}' />
                                      --%><td valign="top" class="value">
                                      	  ${corderPayment.corder.orderId}                                     		
                                      </td>
                                      <td valign="top" class="value">
                                      	  ${corderPayment.customer.customerName}                                     		
                                      </td>
                                      <td valign="top" class="value">
                                      	 ${corderPayment.paymentDate}
                                      </td>
                                      <td valign="top" class="value">
                                      	  <g:textField id="corderPayments[${i}].paymentAmount" name="corderPayments[${i}].paymentAmount"  value="${corderPayment.paymentAmount}" />
                                      </td>
                                     <td valign="top" class="value">
                                      	 ${corderPayment.comments}
                                      </td>
                                    </tr>
                                 </g:each>
                                        
                           </tbody>
                       </table>
                   
                   </div>
