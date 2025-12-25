
<%@ page import="com.chakra.order.Corder" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'corder.label', default: 'Order')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-corder" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-corder" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="alert alert-success" role="status">${flash.message}</div>
			</g:if>
			<%--<ol class="property-list corder">
			
				<g:if test="${corderInstance?.customer}">
				<li class="fieldcontain">
					<span id="customer-label" class="property-label"><g:message code="corder.customer.label" default="Customer" /></span>
					
						<span class="property-value" aria-labelledby="customer-label"><g:link controller="customer" action="show" id="${corderInstance?.customer?.id}">${corderInstance?.customer?.customerName.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
				
				<g:if test="${corderInstance?.orderId}">
				<li class="fieldcontain">
					<span id="orderId-label" class="property-label"><g:message code="corder.orderId.label" default="Order Id" /></span>
					
						<span class="property-value" aria-labelledby="orderId-label"><g:fieldValue bean="${corderInstance}" field="orderId"/></span>
					
				</li>
				</g:if>
				
				<g:if test="${corderInstance?.createdBy}">
				<li class="fieldcontain">
					<span id="createdBy-label" class="property-label"><g:message code="corder.createdBy.label" default="Created By" /></span>
					
						<span class="property-value" aria-labelledby="createdBy-label"><g:link controller="user" action="show" id="${corderInstance?.createdBy?.id}">${corderInstance?.createdBy?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${corderInstance?.createdDate}">
				<li class="fieldcontain">
					<span id="createdDate-label" class="property-label"><g:message code="corder.createdDate.label" default="Created Date" /></span>
					
						<span class="property-value" aria-labelledby="createdDate-label"><g:formatDate date="${corderInstance?.createdDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${corderInstance?.lastEditedBy}">
				<li class="fieldcontain">
					<span id="lastEditedBy-label" class="property-label"><g:message code="corder.lastEditedBy.label" default="Last Edited By" /></span>
					
						<span class="property-value" aria-labelledby="lastEditedBy-label"><g:link controller="user" action="show" id="${corderInstance?.lastEditedBy?.id}">${corderInstance?.lastEditedBy?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${corderInstance?.lastEditedDate}">
				<li class="fieldcontain">
					<span id="lastEditedDate-label" class="property-label"><g:message code="corder.lastEditedDate.label" default="Last Edited Date" /></span>
					
						<span class="property-value" aria-labelledby="lastEditedDate-label"><g:formatDate date="${corderInstance?.lastEditedDate}" /></span>
					
				</li>
				</g:if>
			
				
				<g:if test="${corderInstance?.quotation}">
				<li class="fieldcontain">
					<span id="quotation-label" class="property-label"><g:message code="corder.quotation.label" default="Quotation" /></span>
					
						<span class="property-value" aria-labelledby="quotation-label"><g:link controller="quotation" action="show" id="${corderInstance?.quotation?.id}">${corderInstance?.quotation?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
				
				<g:if test="${corderInstance?.cageLength}">
				<li class="fieldcontain">
					<span id="cageLength-label" class="property-label"><g:message code="corder.cageLength.label" default="Cage Length" /></span>
					
						<span class="property-value" aria-labelledby="cageLength-label"><g:fieldValue bean="${corderInstance}" field="cageLength"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${corderInstance?.fulls}">
				<li class="fieldcontain">
					<span id="fulls-label" class="property-label"><g:message code="corder.fulls.label" default="Fulls" /></span>
					
						<span class="property-value" aria-labelledby="fulls-label"><g:fieldValue bean="${corderInstance}" field="fulls"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${corderInstance?.halfs}">
				<li class="fieldcontain">
					<span id="halfs-label" class="property-label"><g:message code="corder.halfs.label" default="Halfs" /></span>
					
						<span class="property-value" aria-labelledby="halfs-label"><g:fieldValue bean="${corderInstance}" field="halfs"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${corderInstance?.tiers}">
				<li class="fieldcontain">
					<span id="tiers-label" class="property-label"><g:message code="corder.tiers.label" default="Tiers" /></span>
					
						<span class="property-value" aria-labelledby="tiers-label"><g:fieldValue bean="${corderInstance}" field="tiers"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${corderInstance?.noOfCuttingsInShed}">
				<li class="fieldcontain">
					<span id="noOfCuttingsInShed-label" class="property-label"><g:message code="corder.noOfCuttingsInShed.label" default="No Of Cuttings In Shed" /></span>
					
						<span class="property-value" aria-labelledby="noOfCuttingsInShed-label"><g:fieldValue bean="${corderInstance}" field="noOfCuttingsInShed"/></span>
					
				</li>
				</g:if>
				
				<g:if test="${corderInstance?.noOfSheds}">
				<li class="fieldcontain">
					<span id="noOfSheds-label" class="property-label"><g:message code="corder.noOfSheds.label" default="No Of Sheds" /></span>
					
						<span class="property-value" aria-labelledby="noOfSheds-label"><g:fieldValue bean="${corderInstance}" field="noOfSheds"/></span>
					
				</li>
				</g:if>
				
				<g:if test="${corderInstance?.wireBrand}">
				<li class="fieldcontain">
					<span id="wireBrand-label" class="property-label"><g:message code="corder.wireBrand.label" default="Wire Brand" /></span>
					
						<span class="property-value" aria-labelledby="wireBrand-label"><g:link controller="wireBrand" action="show" id="${corderInstance?.wireBrand?.id}">${corderInstance?.wireBrand?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
				
				<g:if test="${corderInstance?.cageDesign}">
				<li class="fieldcontain">
					<span id="cageDesign-label" class="property-label"><g:message code="corder.cageDesign.label" default="Cage Design" /></span>
					
						<span class="property-value" aria-labelledby="cageDesign-label"><g:link controller="cageDesign" action="show" id="${corderInstance?.cageDesign?.id}">${corderInstance?.cageDesign?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
				
				<g:if test="${corderInstance?.singleBox}">
				<li class="fieldcontain">
					<span id="singleBox-label" class="property-label"><g:message code="corder.singleBox.label" default="Single Box" /></span>
					
						<span class="property-value" aria-labelledby="singleBox-label"><g:fieldValue bean="${corderInstance}" field="singleBox"/></span>
					
				</li>
				</g:if>
				
				<g:if test="${corderInstance?.doubleBox}">
				<li class="fieldcontain">
					<span id="doubleBox-label" class="property-label"><g:message code="corder.doubleBox.label" default="Double Box" /></span>
					
						<span class="property-value" aria-labelledby="doubleBox-label"><g:fieldValue bean="${corderInstance}" field="doubleBox"/></span>
					
				</li>
				</g:if>
				
				<g:if test="${corderInstance?.orderCageParts}">
				<li class="fieldcontain">
					<span id="orderCageParts-label" class="property-label"><g:message code="corder.orderCageParts.label" default="Order Cage Parts" /></span>
					
						<g:each in="${corderInstance.orderCageParts}" var="o">
						<span class="property-value" aria-labelledby="orderCageParts-label"><g:link controller="orderCageParts" action="show" id="${o.id}">${o?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${corderInstance?.orderMeshParts}">
				<li class="fieldcontain">
					<span id="orderMeshParts-label" class="property-label"><g:message code="corder.orderMeshParts.label" default="Order Mesh Parts" /></span>
					
						<g:each in="${corderInstance.orderMeshParts}" var="o">
						<span class="property-value" aria-labelledby="orderMeshParts-label"><g:link controller="orderMeshParts" action="show" id="${o.id}">${o?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
				
				<g:if test="${corderInstance?.meshCost}">
				<li class="fieldcontain">
					<span id="meshCost-label" class="property-label"><g:message code="corder.meshCost.label" default="Mesh Cost" /></span>
					
						<span class="property-value" aria-labelledby="meshCost-label"><g:fieldValue bean="${corderInstance}" field="meshCost"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${corderInstance?.cagePartCost}">
				<li class="fieldcontain">
					<span id="cagePartCost-label" class="property-label"><g:message code="corder.cagePartCost.label" default="Cage Part Cost" /></span>
					
						<span class="property-value" aria-labelledby="cagePartCost-label"><g:fieldValue bean="${corderInstance}" field="cagePartCost"/></span>
					
				</li>
				</g:if>
				
				<g:if test="${corderInstance?.cost}">
				<li class="fieldcontain">
					<span id="cost-label" class="property-label"><g:message code="corder.cost.label" default="Cost" /></span>
					
						<span class="property-value" aria-labelledby="cost-label"><g:fieldValue bean="${corderInstance}" field="cost"/></span>
					
				</li>
				</g:if>
				
				<g:if test="${corderInstance?.noOfBirds}">
				<li class="fieldcontain">
					<span id="noOfBirds-label" class="property-label"><g:message code="corder.noOfBirds.label" default="No Of Birds" /></span>
					
						<span class="property-value" aria-labelledby="noOfBirds-label"><g:fieldValue bean="${corderInstance}" field="noOfBirds"/></span>
					
				</li>
				</g:if>
				
				<g:if test="${corderInstance?.costPerBird}">
				<li class="fieldcontain">
					<span id="costPerBird-label" class="property-label"><g:message code="corder.costPerBird.label" default="Cost Per Bird" /></span>
					
						<span class="property-value" aria-labelledby="costPerBird-label"><g:fieldValue bean="${corderInstance}" field="costPerBird"/></span>
					
				</li>
				</g:if>
				
				<g:if test="${corderInstance?.taxation}">
				<li class="fieldcontain">
					<span id="taxation-label" class="property-label"><g:message code="corder.taxation.label" default="Taxation" /></span>
					
						<span class="property-value" aria-labelledby="taxation-label"><g:link controller="taxation" action="show" id="${corderInstance?.taxation?.id}">${corderInstance?.taxation?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
				
				<g:if test="${corderInstance?.tax}">
				<li class="fieldcontain">
					<span id="tax-label" class="property-label"><g:message code="corder.tax.label" default="Tax" /></span>
					
						<span class="property-value" aria-labelledby="tax-label"><g:fieldValue bean="${corderInstance}" field="tax"/></span>
					
				</li>
				</g:if>
					
				<g:if test="${corderInstance?.totalCost}">
				<li class="fieldcontain">
					<span id="totalCost-label" class="property-label"><g:message code="corder.totalCost.label" default="Total Cost" /></span>
					
						<span class="property-value" aria-labelledby="totalCost-label"><g:fieldValue bean="${corderInstance}" field="totalCost"/></span>
					
				</li>
				</g:if>
				
				<g:if test="${corderInstance?.balance}">
				<li class="fieldcontain">
					<span id="balance-label" class="property-label"><g:message code="corder.balance.label" default="Balance" /></span>
					
						<span class="property-value" aria-labelledby="balance-label"><g:fieldValue bean="${corderInstance}" field="balance"/></span>
					
				</li>
				</g:if>
				
				<g:if test="${corderInstance?.status}">
				<li class="fieldcontain">
					<span id="status-label" class="property-label"><g:message code="corder.status.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="status-label"><g:fieldValue bean="${corderInstance}" field="status"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${corderInstance?.corderPayments}">
				<li class="fieldcontain">
					<span id="corderPayments-label" class="property-label"><g:message code="corder.corderPayments.label" default="Corder Payments" /></span>
					
						<g:each in="${corderInstance.corderPayments}" var="c">
						<span class="property-value" aria-labelledby="corderPayments-label"><g:link controller="corderPayment" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
										
				<g:if test="${corderInstance?.paymentDueDate}">
				<li class="fieldcontain">
					<span id="paymentDueDate-label" class="property-label"><g:message code="corder.paymentDueDate.label" default="Payment Due Date" /></span>
					
						<span class="property-value" aria-labelledby="paymentDueDate-label"><g:formatDate date="${corderInstance?.paymentDueDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${corderInstance?.paymentStatus}">
				<li class="fieldcontain">
					<span id="paymentStatus-label" class="property-label"><g:message code="corder.paymentStatus.label" default="Payment Status" /></span>
					
						<span class="property-value" aria-labelledby="paymentStatus-label"><g:fieldValue bean="${corderInstance}" field="paymentStatus"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${corderInstance?.deliveryDate}">
				<li class="fieldcontain">
					<span id="deliveryDate-label" class="property-label"><g:message code="corder.deliveryDate.label" default="Delivery Date" /></span>
					
						<span class="property-value" aria-labelledby="deliveryDate-label"><g:formatDate date="${corderInstance?.deliveryDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${corderInstance?.shippingStatus}">
				<li class="fieldcontain">
					<span id="shippingStatus-label" class="property-label"><g:message code="corder.shippingStatus.label" default="Shipping Status" /></span>
					
						<span class="property-value" aria-labelledby="shippingStatus-label"><g:fieldValue bean="${corderInstance}" field="shippingStatus"/></span>
					
				</li>
				</g:if>
							
				<g:if test="${corderInstance?.comments}">
				<li class="fieldcontain">
					<span id="comments-label" class="property-label"><g:message code="corder.comments.label" default="Comments" /></span>
					
						<span class="property-value" aria-labelledby="comments-label"><g:fieldValue bean="${corderInstance}" field="comments"/></span>
					
				</li>
				</g:if>
			    <g:if test="${true}">
				<g:link controller="corderPayment" action="create" params="['corder.id': corderInstance?.id, 'customer.id': corderInstance?.customer?.id]">${message(code: 'default.add.label', args: [message(code: 'corderPayment.label', default: 'CorderPayment')])}</g:link>
				</g:if>				
			
			</ol>
			
--%>
<div id="quotation">

	<table class="table table-bordered" >
		<tbody>
			<tr>

				<td><label><b>Customer Name</b></label></td>
				<td><label><b>Order Id</b></label></td>
				<td><label><b>Quotaton</b></label></td>
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
					${corderInstance?.orderId}
				</td>
				<td valign="top" class="value">
					${corderInstance?.quotation}
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
				<td><label><b>Balance</b></label></td>
			
			</tr>

			<tr>
			    								
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
				<td valign="top" class="value">
					${balance}
				</td>

			</tr>
		</tbody>
	</table>

</div>

<div>
    <table class="table table-bordered">
      <tbody>
            <tr>
               <th>
                   Status
               </th>
               <th>
                   Shipping Status
               </th>
               <th>
                   Delivery Date
               </th>
               <th>
                   Payment Status
               </th>
                <th>
                  Payment Due Date
               </th>
            </tr>
            <tr>
               <td>
                   ${corderInstance?.status}
               </td>
               <td>
                   ${corderInstance?.shippingStatus}
               </td>
               <td>
                   ${corderInstance?.deliveryDate}
               </td>   
               <td>
                   <g:formatNumber number="${(corderInstance.balance/corderInstance.totalCost)*100}" type="number" maxFractionDigits="2"/>% DUE
               </td>
               <td>
                   ${corderInstance?.paymentDueDate}              
               </td>
            </tr>      
      </tbody>
    </table>
</div>

<g:if test ="${corderInstance?.isMeshOrder}" >
	<label><b>MESH PARTS:</b></label>
	
	<div>
		
		<table class="table table-bordered">
			<tbody>
	
				<tr>
					<th>Sheet Id</th>
					<th>Sheet Specification</th>
					<th>Wire Brand</th>
					<%--<th>Price of Single Sheet</th>
					--%><th>No Of MeshParts</th>
					<th>Cost Of MeshParts</th>
				</tr>
	
				<g:each var="meshPart"	in="${corderInstance?.corderMeshParts}" status="i">
					<tr>
						<td valign="top" class="value">
							${meshPart?.sheetSpecification?.sheetSpecId}
						</td>
						<td valign="top" class="value">
							${meshPart?.sheetSpecification}
						</td>
						<td valign="top" class="value">
							${meshPart?.wireBrand}
						</td>
						<%--<td valign="top" class="value">
							<g:formatNumber number="${(meshPart.wirePrice)*(meshPart.sheetSpecification.sheetWeight)}" type="number" maxFractionDigits="2" />
						</td>
						--%><td valign="top" class="value">
						    ${meshPart?.noOfMeshParts}
						</td>
						<%--<td valign="top" class="value">
							<g:formatNumber number="${(meshPart.wirePrice)*(meshPart.noOfMeshParts)}" type="number" maxFractionDigits="2" roundingMode="HALF_UP"/>
						</td>
					--%>
						<td valign="top" class="value">
							${meshPart?.meshCost} 
						</td>
					</tr>
				</g:each>
				        <tr>
							<th colspan="4">MESH COST</th>
							<td>${corderInstance?.meshCost}</td>
						</tr>
						<tr>
							<th colspan="4">Mesh Discount&nbsp;@&nbsp;${corderInstance?.meshDiscountPercent}</th>
							<td>
								${corderInstance?.meshDiscount}
							</td>
						</tr>
						<tr>
							<th colspan="4">Total Cost Of Mesh Parts</th>
							<td>
								${corderInstance?.netMeshCost}
							</td>
						</tr>
				
			</tbody>
		</table>
		
	</div>
</g:if>

<g:if test ="${corderInstance?.isCageOrder}" >
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
						<td valign="top" class="value">
							${cagePart?.cagePartSpecFormula}
						</td>
						<td valign="top" class="value">
							${cagePart?.priceOfEachCagePart}
						</td>
						<td valign="top" class="value">
						    ${cagePart?.noOfCageParts}
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
</g:if>

<g:if test ="${corderInstance?.isChainLinkOrder}" >
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
						<%--<g:hiddenField name='corderMeshParts[${i}].id'value='${meshPart?.id}' />
						<g:hiddenField name='corderMeshParts[${i}].sheetSpecification.id' value='${meshPart.sheetSpecification?.id}' />
						<g:hiddenField name='corderMeshParts[${i}].wireBrand.id' value='${meshPart?.wireBrand?.id}' />
						<g:hiddenField name='corderMeshParts[${i}].wirePrice' value='${meshPart?.wirePrice}' />
						<g:hiddenField name='corderMeshParts[${i}].meshCost' value='${meshPart?.meshCost}' />
						--%>
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
						<tr>
							<th colspan="7">ChainLink Discount&nbsp;@&nbsp;${corderInstance?.chainLinkDiscountPercent}</th>
							<td>
								${corderInstance?.chainLinkDiscount}
							</td>
						</tr>
						<tr>
							<th colspan="7">Total Cost Of ChainLink</th>
							<td>
								${corderInstance?.netChainLinkCost}
							</td>
						</tr>
				
			</tbody>
		</table>
	
	</div>
</g:if>

<g:if test ="${corderInstance?.isWeldSideMeshOrder}" >
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
						<%--<g:hiddenField name='corderMeshParts[${i}].id'value='${meshPart?.id}' />
						<g:hiddenField name='corderMeshParts[${i}].sheetSpecification.id' value='${meshPart.sheetSpecification?.id}' />
						<g:hiddenField name='corderMeshParts[${i}].wireBrand.id' value='${meshPart?.wireBrand?.id}' />
						<g:hiddenField name='corderMeshParts[${i}].wirePrice' value='${meshPart?.wirePrice}' />
						<g:hiddenField name='corderMeshParts[${i}].meshCost' value='${meshPart?.meshCost}' />
						--%>
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
						<tr>
							<th colspan="7">WeldSideMesh Discount&nbsp;@&nbsp;${corderInstance?.weldSideDiscountPercent}</th>
							<td>
								${corderInstance?.weldSideDiscount}
							</td>
						</tr>
						<tr>
							<th colspan="7">Total Cost Of WeldSideMesh</th>
							<td>
								${corderInstance?.netWeldSideCost}
							</td>
						</tr>
				
			</tbody>
		</table>
	
	</div>
</g:if>

<label><b>PAYMENT DETAILS:</b></label>

<div>

	<table class="table table-bordered">
		<tbody>

			<tr>
				<th>Customer</th>
				<th>Date</th>
				<th>Payment Amount</th>
			</tr>
	
			
		 <g:each var="payment" in="${corderInstance?.corderPayments}" status="i">	
			<tr>				
					<td valign="top" class="value">
						${payment?.customer?.customerName}
					</td>
					<td valign="top" class="value">
						${payment?.paymentDate}
					</td>
					<td valign="top" class="value">
					    ${payment?.paymentAmount}
					</td>
			</tr>
			</g:each>

		</tbody>
	</table>

</div>
            		
            <g:if test="${true}">
                <sec:ifAllGranted roles="ROLE_ADMIN"><g:link controller="corderPayment" class="btn btn-primary" action="create" params="['corder.id': corderInstance?.id, 'customer.id': corderInstance?.customer?.id]">${message(code: 'default.add.label', args: [message(code: 'corderPayment.label', default: 'CorderPayment')])}</g:link></sec:ifAllGranted>	
            </g:if>
			
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${corderInstance?.id}" />
					<%--<sec:ifAnyGranted roles="ROLE_ADMIN, ROLE_SALES"><g:link class="edit" action="edit" id="${corderInstance?.id}"><g:message code="default.button.editorder.label" default="Edit Order" /></g:link></sec:ifAnyGranted>
					<sec:ifAllGranted roles="ROLE_ADMIN"><g:link class="btn btn-primary" action="editPayment" id="${corderInstance?.id}"><g:message code="default.button.editpayment.label" default="Edit Payment" /></g:link></sec:ifAllGranted>
					--%><sec:ifAllGranted roles="ROLE_ADMIN"><g:actionSubmit class="btn btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></sec:ifAllGranted>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
