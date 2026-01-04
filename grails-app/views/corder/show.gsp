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
		</div>
	</body>
</html>
