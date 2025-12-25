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
  	        <g:each var="quotationWeldSide" in="${quotationModelInstance?.quotationWeldSideModel?.quotationWeldSideItems}" status="i">  
    		<tr>
		        <g:hiddenField name='quotationWeldSide[${i}].id' value='${quotationWeldSide.id}' />
		        <g:hiddenField name='quotationWeldSide[${i}].sideMesh' value='${quotationWeldSide.sideMesh.id}' />
		        <g:hiddenField name='quotationWeldSide[${i}].wireBrand' value='${quotationWeldSide.wireBrand.id}' />
		        <td valign="top" class="value">
		        	  ${quotationWeldSide.sideMesh}                                     		
		        </td>
		        <td valign="top" class="value">
		        	  ${quotationWeldSide.wireBrand}                                     		
		        </td>
		        <td valign="top" class="value">
		        	  <g:textField id="quotationWeldSide[${i}].length" name="quotationWeldSide[${i}].length"  value="${quotationWeldSide.length}" />
		        </td>
		        <td valign="top" class="value">
		        	  <g:textField id="quotationWeldSide[${i}].height" name="quotationWeldSide[${i}].height"  value="${quotationWeldSide.height}" />
		        </td>
		        <td valign="top" class="value">
		        	  <g:textField id="quotationWeldSide[${i}].noOfPieces" name="quotationWeldSide[${i}].noOfPieces"  value="${quotationWeldSide.noOfPieces}" />
		        </td>       
       		</tr>
      		</g:each>
  		</tbody>
	</table>
                   
</div>