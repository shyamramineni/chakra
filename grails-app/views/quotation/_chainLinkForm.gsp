<div>
                      
	<table class="table table-bordered">
		<tbody>    
        	<tr>                                    
            	<th>Design</th>
				<th>WireBrand</th>
				<th>Length</th>
				<th>Height</th>
				<th>No.of Pieces</th>
            </tr>     
  	        <g:each var="quotationChainLink" in="${quotationModelInstance?.quotationChainLinkModel.quotationChainLinkItems}" status="i">  
    		<tr>
		        <g:hiddenField name='quotationChainLink[${i}].id' value='${quotationChainLink.id}' />
		        <g:hiddenField name='quotationChainLink[${i}].linkMesh' value='${quotationChainLink.linkMesh.id}' />
		        <g:hiddenField name='quotationChainLink[${i}].wireBrand' value='${quotationChainLink.wireBrand.id}' />
		        <%--<g:hiddenField name='quotationChainLink[${i}].length' value='${quotationChainLink.length}' />
		        <g:hiddenField name='quotationChainLink[${i}].height' value='${quotationChainLink.height}' />
		        <g:hiddenField name='quotationChainLink[${i}].noOfPieces' value='${quotationChainLink.noOfPieces}' />                                      
		        --%><td valign="top" class="value">
		        	  ${quotationChainLink.linkMesh}                                     		
		        </td>
		        <td valign="top" class="value">
		        	  ${quotationChainLink.wireBrand}                                     		
		        </td>
		        <td valign="top" class="value">
		        	  <g:textField id="quotationChainLink[${i}].length" name="quotationChainLink[${i}].length"  value="${quotationChainLink.length}" />
		        </td>
		        <td valign="top" class="value">
		        	  <g:textField id="quotationChainLink[${i}].height" name="quotationChainLink[${i}].height"  value="${quotationChainLink.height}" />
		        </td>
		        <td valign="top" class="value">
		        	  <g:textField id="quotationChainLink[${i}].noOfPieces" name="quotationChainLink[${i}].noOfPieces"  value="${quotationChainLink.noOfPieces}" />
		        </td>       
       		</tr>
      		</g:each>
  		</tbody>
	</table>
                   
</div>
