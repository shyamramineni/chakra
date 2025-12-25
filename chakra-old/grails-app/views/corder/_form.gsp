<%@ page import="com.chakra.order.Corder" %>


<%--<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'createdBy', 'error')} ">
	<label for="createdBy">
		<g:message code="corder.createdBy.label" default="Created By" />
		
	</label>
	<g:select id="createdBy" name="createdBy.id" from="${com.chakra.security.User.list()}" optionKey="id" value="${corderInstance?.createdBy?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'createdDate', 'error')} ">
	<label for="createdDate">
		<g:message code="corder.createdDate.label" default="Created Date" />
		
	</label>
	<g:datePicker name="createdDate" precision="day"  value="${corderInstance?.createdDate}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'lastEditedBy', 'error')} ">
	<label for="lastEditedBy">
		<g:message code="corder.lastEditedBy.label" default="Last Edited By" />
		
	</label>
	<g:select id="lastEditedBy" name="lastEditedBy.id" from="${com.chakra.security.User.list()}" optionKey="id" value="${corderInstance?.lastEditedBy?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'lastEditedDate', 'error')} ">
	<label for="lastEditedDate">
		<g:message code="corder.lastEditedDate.label" default="Last Edited Date" />
		
	</label>
	<g:datePicker name="lastEditedDate" precision="day"  value="${corderInstance?.lastEditedDate}" default="none" noSelection="['': '']" />
</div>



<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'customer', 'error')} required">
	<label for="customer">
		<g:message code="corder.customer.label" default="Customer" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="customer" name="customer.id" from="${com.chakra.customer.Customer.list()}" optionKey="id" required="" value="${corderInstance?.customer?.id}" class="many-to-one"/>
</div>

<g:hiddenField name="quotation.id" value="${corderInstance?.quotation?.id}" />

<g:hiddenField name="quotationModel.id" value="${corderInstance?.quotationModel?.id}" />

<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'quotation', 'error')} required">
	<label for="quotation">
		<g:message code="corder.quotation.label" default="Quotation" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="quotation" name="quotation.id" from="${com.chakra.quotation.Quotation.list()}" optionKey="id" required="" value="${corderInstance?.quotation?.id}" class="many-to-one"/>
</div>



<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'cageLength', 'error')} required">
	<label for="cageLength">
		<g:message code="corder.cageLength.label" default="Cage Length" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="cageLength" required="" value="${fieldValue(bean: corderInstance, field: 'cageLength')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'fulls', 'error')} required">
	<label for="fulls">
		<g:message code="corder.fulls.label" default="Fulls" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="fulls" required="" value="${fieldValue(bean: corderInstance, field: 'fulls')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'halfs', 'error')} required">
	<label for="halfs">
		<g:message code="corder.halfs.label" default="Halfs" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="halfs" required="" value="${fieldValue(bean: corderInstance, field: 'halfs')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'tiers', 'error')} required">
	<label for="tiers">
		<g:message code="corder.tiers.label" default="Tiers" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="tiers" required="" value="${fieldValue(bean: corderInstance, field: 'tiers')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'noOfCuttingsInShed', 'error')} required">
	<label for="noOfCuttingsInShed">
		<g:message code="corder.noOfCuttingsInShed.label" default="No Of Cuttings In Shed" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="noOfCuttingsInShed" required="" value="${fieldValue(bean: corderInstance, field: 'noOfCuttingsInShed')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'noOfSheds', 'error')} required">
	<label for="noOfSheds">
		<g:message code="corder.noOfSheds.label" default="No Of Sheds" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="noOfSheds" required="" value="${fieldValue(bean: corderInstance, field: 'noOfSheds')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'orderId', 'error')} ">
	<label for="orderId">
		<g:message code="corder.orderId.label" default="Order Id" />
		
	</label>
	<g:textField name="orderId" value="${corderInstance?.orderId}"/>
</div>



<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'wireBrand', 'error')} ">
	<label for="wireBrand">
		<g:message code="corder.wireBrand.label" default="Wire Brand" />
		
	</label>
	<g:select id="wireBrand" name="wireBrand.id" from="${com.chakra.config.WireBrand.list()}" optionKey="id" value="${corderInstance?.wireBrand?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'cageDesign', 'error')} required">
	<label for="cageDesign">
		<g:message code="corder.cageDesign.label" default="Cage Design" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="cageDesign" name="cageDesign.id" from="${com.chakra.config.CageDesign.list()}" optionKey="id" required="" value="${corderInstance?.cageDesign?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'singleBox', 'error')} ">
	<label for="singleBox">
		<g:message code="corder.singleBox.label" default="Single Box" />
		
	</label>
	<g:textField type="number" name="singleBox" value="${fieldValue(bean: corderInstance, field: 'singleBox')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'doubleBox', 'error')} ">
	<label for="doubleBox">
		<g:message code="corder.doubleBox.label" default="Double Box" />
		
	</label>
	<g:textField type="number" name="doubleBox" value="${fieldValue(bean: corderInstance, field: 'doubleBox')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'balance', 'error')} required">
	<label for="balance">
		<g:message code="corder.balance.label" default="Balance" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="balance" required="" value="${fieldValue(bean: corderInstance, field: 'balance')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'corderPayments', 'error')} ">
	<label for="corderPayments">
		<g:message code="corder.corderPayments.label" default="Corder Payments" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${corderInstance?.corderPayments?}" var="c">
    <li><g:link controller="corderPayment" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="corderPayment" action="create" params="['corder.id': corderInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'corderPayment.label', default: 'CorderPayment')])}</g:link>
</li>
</ul>

</div>



<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'noOfBirds', 'error')} required">
	<label for="noOfBirds">
		<g:message code="corder.noOfBirds.label" default="No Of Birds" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="noOfBirds" required="" value="${fieldValue(bean: corderInstance, field: 'noOfBirds')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'deliveryDate', 'error')} required">
	<label for="deliveryDate">
		<g:message code="corder.deliveryDate.label" default="Delivery Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="deliveryDate" precision="day"  value="${corderInstance?.deliveryDate}"  />
</div>



<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'orderCageParts', 'error')} ">
	<label for="orderCageParts">
		<g:message code="corder.orderCageParts.label" default="Order Cage Parts" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${corderInstance?.orderCageParts?}" var="o">
    <li><g:link controller="orderCageParts" action="show" id="${o.id}">${o?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="orderCageParts" action="create" params="['corder.id': corderInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'orderCageParts.label', default: 'OrderCageParts')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'orderMeshParts', 'error')} ">
	<label for="orderMeshParts">
		<g:message code="corder.orderMeshParts.label" default="Order Mesh Parts" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${corderInstance?.orderMeshParts?}" var="o">
    <li><g:link controller="orderMeshParts" action="show" id="${o.id}">${o?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="orderMeshParts" action="create" params="['corder.id': corderInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'orderMeshParts.label', default: 'OrderMeshParts')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'paymentDueDate', 'error')} required">
	<label for="paymentDueDate">
		<g:message code="corder.paymentDueDate.label" default="Payment Due Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="paymentDueDate" precision="day"  value="${corderInstance?.paymentDueDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'paymentStatus', 'error')} ">
	<label for="paymentStatus">
		<g:message code="corder.paymentStatus.label" default="Payment Status" />
		
	</label>
	<g:textField name="paymentStatus" value="${corderInstance?.paymentStatus}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'shippingStatus', 'error')} ">
	<label for="shippingStatus">
		<g:message code="corder.shippingStatus.label" default="Shipping Status" />
		
	</label>
	<g:textField name="shippingStatus" value="${corderInstance?.shippingStatus}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="corder.status.label" default="Status" />
		
	</label>
	<g:textField name="status" value="${corderInstance?.status}"/>
</div>



<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'taxation', 'error')} required">
	<label for="taxation">
		<g:message code="corder.taxation.label" default="Taxation" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="taxation" name="taxation.id" from="${com.chakra.config.Taxation.list()}" optionKey="id" required="" value="${corderInstance?.taxation?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'tax', 'error')} required">
	<label for="tax">
		<g:message code="corder.tax.label" default="Tax" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="tax" required="" value="${fieldValue(bean: corderInstance, field: 'tax')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'cost', 'error')} required">
	<label for="cost">
		<g:message code="corder.cost.label" default="Cost" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="cost" required="" value="${fieldValue(bean: corderInstance, field: 'cost')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'costPerBird', 'error')} required">
	<label for="costPerBird">
		<g:message code="corder.costPerBird.label" default="Cost Per Bird" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="costPerBird" required="" value="${fieldValue(bean: corderInstance, field: 'costPerBird')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'meshCost', 'error')} ">
	<label for="meshCost">
		<g:message code="corder.meshCost.label" default="Mesh Cost" />
		
	</label>
	<g:textField type="number" name="meshCost" value="${fieldValue(bean: corderInstance, field: 'meshCost')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'cagePartCost', 'error')} ">
	<label for="cagePartCost">
		<g:message code="corder.cagePartCost.label" default="Cage Part Cost" />
		
	</label>
	<g:textField type="number" name="cagePartCost" value="${fieldValue(bean: corderInstance, field: 'cagePartCost')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'totalCost', 'error')} required">
	<label for="totalCost">
		<g:message code="corder.totalCost.label" default="Total Cost" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="number" name="totalCost" required="" value="${fieldValue(bean: corderInstance, field: 'totalCost')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="corder.comments.label" default="Comments" />
		
	</label>
	<g:textField name="comments" value="${corderInstance?.comments}"/>
</div>



<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'deliveryDate', 'error')} required">
	<label for="deliveryDate">
		<g:message code="corder.deliveryDate.label" default="Delivery Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="deliveryDate" precision="day"  value="${corderInstance?.deliveryDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: corderInstance, field: 'paymentDueDate', 'error')} required">
	<label for="paymentDueDate">
		<g:message code="corder.paymentDueDate.label" default="Payment Due Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="paymentDueDate" precision="day"  value="${corderInstance?.paymentDueDate}"  />
</div>

--%>
<br>
<div id="quotation">

	<table class="table table-bordered">
		<tbody>
			<tr>

				<td><label><b>Customer Name</b></label></td>
				<td><label><b>Cage Length</b></label></td>
				<td><label><b>Fulls</b></label></td>
				<td><label><b>Halfs</b></label></td>
				<td><label><b>Tiers</b></label></td>
				<td><label><b>No Of Cuttings In Shed</b></label></td>
				<td><label><b>No Of Sheds</b></label></td>

			</tr>

			<tr>

				<td valign="top" class="value">
					${corderInstance?.customer?.customerName}
				</td>
				<td valign="top" class="value">
					${corderInstance?.cageLength}
				</td>
				<td valign="top" class="value">
					${corderInstance?.fulls}
				</td>
				<td valign="top" class="value">
					${corderInstance?.halfs}
				</td>
				<td valign="top" class="value">
					${corderInstance?.tiers}
				</td>
				<td valign="top" class="value">
					${corderInstance?.noOfCuttingsInShed}
				</td>
				<td valign="top" class="value">
					${corderInstance?.noOfSheds}
				</td>

			</tr>
		</tbody>
	</table>

</div>

<div>
    <table>
      <tbody>
            <tr>
               <td>
                   <b>Delivery Date:</b>
               </td>
               <td>
                   <g:datePicker name="deliveryDate" precision="day"  value="${corderInstance?.deliveryDate}"  />
               </td>
            </tr>
            <tr>
               <td>
                  <b>Payment Due Date:</b>
               </td>
               <td>
                   <g:datePicker name="paymentDueDate" precision="day"  value="${corderInstance?.paymentDueDate}"  />
               </td>
            </tr>      
      </tbody>
    </table>
</div>

<div id="quotationModel">

	<table class="table table-bordered">
		<tbody>
			<tr>

				<td><label><b>CageDesign</b></label></td>
				<td><label><b>Wire Brand</b></label></td>
				<td><label><b>Single Box</b></label></td>
				<td><label><b>Double Box</b></label></td>
				<td><label><b>Taxation</b></label></td>
				<td><label><b>Cost Per Bird</b></label></td>
				<td><label><b>Cost</b></label></td>
				<td><label><b>Tax</b></label></td>
				<td><label><b>Total Cost</b></label></td>
			
			</tr>

			<tr>
			    <g:hiddenField name="customer.id" value="${corderInstance?.customer?.id}" />
                <g:hiddenField name="quotation.id" value="${corderInstance?.quotation?.id}" />
				<g:hiddenField name='taxation.id' value ='${corderInstance?.taxation?.id}' />
				<g:hiddenField name='wireBrand.id' value='${corderInstance?.wireBrand?.id}' />
				<g:hiddenField name='cageDesign.id' value='${corderInstance?.cageDesign?.id}' />
				<g:hiddenField name='noOfBirds' value='${corderInstance?.noOfBirds}' />
				<g:hiddenField name='singleBox' value='${corderInstance?.singleBox}' />
				<g:hiddenField name='doubleBox' value='${corderInstance?.doubleBox}' />
								
				<td valign="top" class="value">
					${corderInstance?.cageDesign}
				</td>
				<td valign="top" class="value">
					${corderInstance?.wireBrand}
				</td>
				<td valign="top" class="value">
					${corderInstance?.singleBox}
				</td>
				<td valign="top" class="value">
					${corderInstance?.doubleBox}
				</td>
				<td valign="top" class="value">
					${corderInstance?.taxation}
				</td>
				<td valign="top" class="value">
					${corderInstance?.costPerBird}
				</td>
				<td valign="top" class="value">
					${corderInstance?.cost}
				</td>
				<td valign="top" class="value">
					${corderInstance?.tax}
				</td>
				<td valign="top" class="value">
					${corderInstance?.totalCost}
				</td>

			</tr>
		</tbody>
	</table>

</div>



<label><b>MESH PARTS:</b></label>

<div>

	<table class="table table-bordered">
		<tbody>

			<tr>
				<th>Sheet Specification</th>
				<th>Wire Brand</th>
				<%--<th>Wire Price</th>
				--%><th>No Of MeshParts</th>
				<th>Cost Of MeshParts</th>
			</tr>

			<g:each var="meshPart"	in="${corderInstance?.corderMeshParts}" status="i">
				<tr>
					<g:hiddenField name='corderMeshParts[${i}].id'value='${meshPart?.id}' />
					<g:hiddenField name='corderMeshParts[${i}].sheetSpecification.id' value='${meshPart.sheetSpecification?.id}' />
					<g:hiddenField name='corderMeshParts[${i}].wireBrand.id' value='${meshPart?.wireBrand?.id}' />
					<%--<g:hiddenField name='corderMeshParts[${i}].wirePrice' value='${meshPart?.wirePrice}' />
					--%><g:hiddenField name='corderMeshParts[${i}].meshCost' value='${meshPart?.meshCost}' />
					<td valign="top" class="value">
						${meshPart?.sheetSpecification}
					</td>
					<td valign="top" class="value">
						${meshPart?.wireBrand}
					</td>
					<%--<td valign="top" class="value">
						${meshPart?.wirePrice}
					</td>
					--%><td valign="top" class="value">
					    <g:textField id="corderMeshParts[${i}].noOfMeshParts" name="corderMeshParts[${i}].noOfMeshParts" value="${meshPart?.noOfMeshParts}" />
					</td>
					<td valign="top" class="value">
						${meshPart?.meshCost}
					</td>
				</tr>
			</g:each>
			        <tr>
						<th colspan="4">MESH COST</th>
						<td>${corderInstance?.meshCost}</td>
					</tr>
			
		</tbody>
	</table>

</div>

<label><b>CAGE PARTS:</b></label>

<div>

	<table class="table table-bordered">
		<tbody>

			<tr>
				<th>Cage Part Name</th>
				<th>Price Of Each CagePart</th>
				<th>No Of Cage Parts</th>
				<th>Cost Of CagePart</th>
			</tr>

			<g:each var="cagePart"	in="${corderInstance?.corderCageParts}" status="i">
				<tr>
					
					<g:hiddenField name='corderCageParts[${i}].id' value='${cagePart?.id}' />
					<g:hiddenField name='corderCageParts[${i}].cagePartSpecFormula.id' value='${cagePart.cagePartSpecFormula?.id}' />
					<g:hiddenField name='corderCageParts[${i}].noOfCageParts' value='${cagePart?.noOfCageParts}' />
					<g:hiddenField name='corderCageParts[${i}].priceOfEachCagePart' value='${cagePart?.priceOfEachCagePart}' />
					<g:hiddenField name='corderCageParts[${i}].costOfCagePart' value='${cagePart?.costOfCagePart}' />
					<td valign="top" class="value">
						${cagePart?.cagePartSpecFormula}
					</td>
					<td valign="top" class="value">
						${cagePart?.priceOfEachCagePart}
					</td>
					<td valign="top" class="value">
					    <g:textField id="corderCageParts[${i}].noOfCageParts" name="corderCageParts[${i}].noOfCageParts" value="${cagePart?.noOfCageParts}" />
					</td>
					<td valign="top" class="value">
						${cagePart?.costOfCagePart}
					</td>

				</tr>
			</g:each>
			    <tr>
				    <th colspan="3">CAGEPART COST</th>
					<td>${corderInstance?.cagePartCost}</td>
				</tr>

		</tbody>
	</table>

</div>

<label><b>CHAIN LINK:</b></label>

<div>

	<table class="table table-bordered">
		<tbody>

			<tr>
				<th>Design</th>
				<th>Wire Brand</th>
				<th>Length</th>
				<th>Height</th>
				<th>No Of Pieces</th>
				<th>Square Feets</th>
				<th>Price Per SqFt</th>
				<th>chainLink Item Cost</th>
			</tr>

			<g:each var="chainLink"	in="${corderInstance?.corderChainLinkItems}" status="i">
				<tr>
					<g:hiddenField name='corderChainLinkItems[${i}].linkMesh.id'value='${chainLink?.linkMesh?.id}' />
					<g:hiddenField name='corderChainLinkItems[${i}].wireBrand.id' value='${chainLink?.wireBrand?.id}' />
					<g:hiddenField name='corderChainLinkItems[${i}].length' value='${chainLink?.length}' />
					<g:hiddenField name='corderChainLinkItems[${i}].height' value='${chainLink?.height}' />
					<g:hiddenField name='corderChainLinkItems[${i}].noOfPieces' value='${chainLink?.noOfPieces}' />
					<g:hiddenField name='corderChainLinkItems[${i}].squareFeets' value='${chainLink?.squareFeets}' />
					<g:hiddenField name='corderChainLinkItems[${i}].pricePerSqFt' value='${chainLink?.pricePerSqFt}' />
					<g:hiddenField name='corderChainLinkItems[${i}].chainLinkItemCost' value='${chainLink?.chainLinkItemCost}' />
					
					<td valign="top" class="value">
						${chainLink?.linkMesh}
					</td>
					<td valign="top" class="value">
						${chainLink?.wireBrand}
					</td>
					<td valign="top" class="value">
						${chainLink?.length}
					</td>
					<%--<td valign="top" class="value">
					    <g:textField id="corderMeshParts[${i}].noOfMeshParts" name="corderMeshParts[${i}].noOfMeshParts" value="${meshPart?.noOfMeshParts}" />
					</td>
					--%>
					<td valign="top" class="value">
						${chainLink?.height}
					</td>
					<td valign="top" class="value">
						${chainLink?.noOfPieces}
					</td>
					<td valign="top" class="value">
						${chainLink?.squareFeets}
					</td>
					<td valign="top" class="value">
						${chainLink?.pricePerSqFt}
					</td>
					<td valign="top" class="value">
						${chainLink?.chainLinkItemCost}
					</td>
				</tr>
			</g:each>
			        <tr>
						<th colspan="7">CHAIN LINK COST</th>
						<td>${corderInstance?.chainLinkCost}</td>
					</tr>
			
		</tbody>
	</table>

</div>

<label><b>WELD SIDE MESH:</b></label>

<div>

	<table class="table table-bordered">
		<tbody>

			<tr>
				<th>Design</th>
				<th>Wire Brand</th>
				<th>Length</th>
				<th>Height</th>
				<th>No Of Pieces</th>
				<th>Square Feets</th>
				<th>Price Per SqFt</th>
				<th>chainLink Item Cost</th>
			</tr>

			<g:each var="weldSide"	in="${corderInstance?.corderWeldSideItems}" status="i">
				<tr>
					<g:hiddenField name='corderWeldSideItems[${i}].sideMesh.id'value='${weldSide?.sideMesh?.id}' />
					<g:hiddenField name='corderWeldSideItems[${i}].wireBrand.id' value='${weldSide?.wireBrand?.id}' />
					<g:hiddenField name='corderWeldSideItems[${i}].length' value='${weldSide?.length}' />
					<g:hiddenField name='corderWeldSideItems[${i}].height' value='${weldSide?.height}' />
					<g:hiddenField name='corderWeldSideItems[${i}].noOfPieces' value='${weldSide?.noOfPieces}' />
					<g:hiddenField name='corderWeldSideItems[${i}].squareFeets' value='${weldSide?.squareFeets}' />
					<g:hiddenField name='corderWeldSideItems[${i}].pricePerSqFt' value='${weldSide?.pricePerSqFt}' />
					<g:hiddenField name='corderWeldSideItems[${i}].weldSideItemCost' value='${weldSide?.weldSideItemCost}' />
					<td valign="top" class="value">
						${weldSide?.sideMesh}
					</td>
					<td valign="top" class="value">
						${weldSide?.wireBrand}
					</td>
					<td valign="top" class="value">
						${weldSide?.length}
					</td>
					<%--<td valign="top" class="value">
					    <g:textField id="corderMeshParts[${i}].noOfMeshParts" name="corderMeshParts[${i}].noOfMeshParts" value="${meshPart?.noOfMeshParts}" />
					</td>
					--%>
					<td valign="top" class="value">
						${weldSide?.height}
					</td>
					<td valign="top" class="value">
						${weldSide?.noOfPieces}
					</td>
					<td valign="top" class="value">
						${weldSide?.squareFeets}
					</td>
					<td valign="top" class="value">
						${weldSide?.pricePerSqFt}
					</td>
					<td valign="top" class="value">
						${weldSide?.weldSideItemCost}
					</td>
				</tr>
			</g:each>
			        <tr>
						<th colspan="7">WELD SIDE COST</th>
						<td>${corderInstance?.weldSideCost}</td>
					</tr>
			
		</tbody>
	</table>

</div>

<div>
    <table>
      <tbody>
            <tr>
               <td>
                   <b>Comments:</b>
               </td>
               <td>
                   <g:textArea name="comments" value="${corderInstance?.comments}"/>
               </td>
            </tr>
      </tbody>
    </table>
</div>
