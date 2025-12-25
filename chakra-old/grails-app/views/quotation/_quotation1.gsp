<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="com.chakra.customer.Customer" %>



<html>
	<head>
		<meta name="layout" content="main" />
		<g:set var="entityName" value="${message(code: 'customer.label', default: 'Quotation')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
		<style type="text/css">
			
			table {
				
				border-collapse: collapse;
				width:100%;
				border-color: #000;
			}
			
			
			body {
				font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
				font-size: 9px;
				line-height: 10px;
				color: #333;
			}
			
		</style>
		<link rel="stylesheet" href="/chakrap/static/css/main.css"	type="text/css"/>
		<!-- <link href="/Chakra/static/bundle-bundle_bootstrap_head.css" type="text/css" rel="stylesheet" media="screen, projection" /> -->
		
	</head>
	<body><%--
		<a href="#show-customer" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			
		</div>--%>
		<div class="container">
			<div class="row">
	  			<div class="span12">
	  				<div id="grailsLogo" align="center" role="banner">
						<rendering:inlineJpeg bytes="${imageBytes}" />
					</div>	
				</div>
			</div>
  			
		
			<div id="show-customer" class="content scaffold-show" role="main">
				<h3><g:message code="default.show.label" args="[entityName]" /></h3>
				<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
				</g:if>
				
				<table border="1">
				
				<tr>
				        <th align="left">Customer:</th>
				        <td>${quotationInstance.customer}--${quotationInstance.customer.companyName}</td>
				    </tr>
				    <tr>
				        <th align="left">Quotation Id:</th>
				        <td>${quotationInstance.quotationId}</td>
				    </tr>
				    <tr>
				        <th align="left">Cage Length:</th>
				        <td>${quotationInstance.cageLength}</td>
				    </tr>
				    <tr>
				        <th align="left">Fulls:</th>
				        <td>${quotationInstance.fulls}</td>
				    </tr>
				    <tr>
				        <th align="left">Halfs:</th>
				        <td>${quotationInstance.halfs}</td>
				    </tr>
				    <tr>
				        <th align="left">Tiers:</th>
				        <td>${quotationInstance.tiers}</td>
				    </tr>
				    <tr>
				        <th align="left">No Of Cuttings In Shed:</th>
				        <td>${quotationInstance.noOfCuttingsInShed}</td>
				    </tr>
				    <tr>
				        <th align="left">No Of Sheds:</th>
				        <td>${quotationInstance.noOfSheds}</td>
				    </tr>
				    <tr>
				        <th align="left">Status:</th>
				        <td>${quotationInstance.status}</td>
				    </tr>
				    <tr>
				        <th align="left">Created By:</th>
				        <td>${quotationInstance.createdBy}</td>
				    </tr>
				    <tr>
				        <th align="left">Created Date:</th>
				        <td>${quotationInstance.createdDate}</td>
				    </tr>
				    <tr>
				        <th align="left">Comments:</th>
				        <td>${quotationInstance.comments}</td>
				    </tr>
						
			    </table>
			
				<br></br>
				
				QUOTATION MODELS:
				<table border="1">
				
				<tr>
					<th>Cage Design</th>
					<th>No.Of Birds</th>
					<th>Cost</th>
					<th>Tax</th>
					<th>Total Cost</th>
				</tr>
					
				<g:if test="${quotationInstance?.quotationModels}">
				
					
					 
						<g:each in="${quotationInstance.quotationModels}" var="q">
						<tr>
							 <td>${q?.cageDesign}</td>
						     <td>${q?.noOfBirds}</td>
						     <td>${q?.cost}</td>
						     <td>${q?.tax}</td>
						     <td>${q?.totalCost}</td>
						</tr>    
						</g:each>
						
				
				</g:if>
				</table>
				<br></br>
				<br></br>
				
				MESH MODEL:
				<table border="1">
				<tr>
				<th>Cage Design</th>
				<th>Wire Brand</th>
				<th>Single Box</th>
				<th>Double Box</th>
				<th>Cost Per Bird</th>
				<th>Total No. Of Birds</th>
				<th>Mesh Cost:</th>
				</tr>
				<g:if test="${quotationInstance?.quotationModels?.quotationMeshModel}">
				
					
					
						<g:each in="${quotationInstance?.quotationModels.quotationMeshModel}" var="m">
						   <tr>
							 <td>${m?.cageDesign}</td>
							 <td>${m?.wireBrand}</td>
							 <td>${m?.singleBox}</td>
							 <td>${m?.doubleBox}</td>
							 <td>${m?.costPerBird}</td>
							 <td>${m?.noOfBirds}</td>
							 <td>${m?.meshCost}</td>
						   </tr>		
						</g:each>
					
				
				</g:if>
				</table>
				
				<br></br>
				<br></br>
				CAGEPART MODEL:
				<table border="1">
				<tr>
				<th>Cage Design</th>
				<th>Cost Per Bird</th>
				<th>No. Of Birds</th>
				<th>CagePart Cost</th>
				</tr>
				<g:if test="${quotationInstance?.quotationModels?.quotationCagePartModel}">
				
					
					
						<g:each in="${quotationInstance?.quotationModels.quotationCagePartModel}" var="m">
						  <tr>
							 <td>${m?.cageDesign}</td>
							 <td>${m?.costPerBird}</td>
							 <td>${m?.noOfBirds}</td>
							 <td>${m?.cagePartCost}</td>
						   </tr>		
						</g:each>
					
				
				</g:if>
				</table>
            <br></br>
            <br></br> 
			MESH PARTS:
			<table border="1">
				<tr>
					<th>Sheet Id</th>
					<th>Sheet Specification</th>
					<th>Wire Brand</th>
					<%--<th>Price of Single Sheet</th>
					--%><th>No Of Mesh Parts</th>
					<th>Cost Of Mesh Parts</th>
				</tr>
				<g:if test="${quotationModelInstance?.quotationMeshModel?.quotationMeshParts}">
					
						<g:each
							in="${quotationModelInstance?.quotationMeshModel.quotationMeshParts}"
							var="p">
							
							<tr>
								<td>
									${p?.sheetSpecification?.sheetSpecId}
								</td>
								<td>
									${p?.sheetSpecification}
								</td>
								<td>
									${p?.wireBrand}
								</td>
								<%--<td>
									<g:formatNumber number="${(p.wirePrice)*(p.sheetSpecification.sheetWeight)}" type="number" maxFractionDigits="2" />
								</td>
								--%><td>
									${p?.noOfMeshParts}
								</td>
								<td>
									${p?.meshCost}
								</td>
							</tr>
						</g:each>
					<tr>
						<th colspan="4">Mesh Cost</th>
						<td>
							${quotationModelInstance?.quotationMeshModel?.meshCost}
						</td>
					</tr>
					<tr>
						<th colspan="4">Mesh Discount&nbsp;@&nbsp;${quotationModelInstance?.quotationMeshModel?.meshDiscountPercent}</th>
						<td>
							${quotationModelInstance?.quotationMeshModel?.meshDiscount}
						</td>
					</tr>
					<tr>
						<th colspan="4">Mesh Cost</th>
						<td>
							${quotationModelInstance?.quotationMeshModel?.netMeshCost}
						</td>
					</tr>
					
					
				</g:if>
			</table>
              
            <br></br>
            <br></br>  
			CAGE PARTS:
			<table border="1">
				<tr>
				
				<th>Cage Part Name</th>
				<th>No Of Cage Parts</th>
				<th>Price Of Each CagePart</th>
				<th>Cost Of CagePart</th>
				
				</tr>
				 <g:if test="${quotationModelInstance?.quotationCagePartModel?.quotationCageParts}">
				 	
			 		<g:each in="${quotationModelInstance?.quotationCagePartModel?.quotationCageParts}" var="c">
			 			<tr>
			 				 <td>${c?.cagePartSpecFormula}</td>
							 <td>${c?.noOfCageParts}</td>
							 <td>${c?.priceOfEachCagePart}</td>
							 <td>${c?.costOfCagePart}</td>
					    </tr>	
                  	</g:each>
                  		<tr>
						     <th  colspan="3">Cage Parts Cost</th>
						     <td>${quotationModelInstance?.quotationCagePartModel?.cagePartCost}</td>
						</tr>	  
					
				  </g:if>
			</table>
			
			<br></br>
			<br></br>  
			LINK MESH:
			<table border="1">
				<tr>
				
					<th>Design</th>
					<th>Wire Brand</th>
					<th>Length</th>
					<th>Height</th>
					<th>No Of Pieces</th>
					<th>Square Feets</th>
					<th>Price Per SqFt</th>
					<th>WeldSide Item Cost</th>
				
				</tr>
				 <g:if test="${quotationModelInstance?.quotationChainLinkModel?.quotationChainLinkItems}">
				 	
			 		<g:each in="${quotationModelInstance?.quotationChainLinkModel?.quotationChainLinkItems}" var="linkMesh">
			 			<tr>
			 				 <td>${linkMesh?.linkMesh}</td>
							 <td>${linkMesh?.wireBrand}</td>
							 <td>${linkMesh?.length}</td>
							 <td>${linkMesh?.height}</td>
							 <td>${linkMesh?.noOfPieces}</td>
							 <td>${linkMesh?.squareFeets}</td>
							 <td>${linkMesh?.pricePerSqFt}</td>
							 <td>${linkMesh?.chainLinkItemCost}</td>
					    </tr>	
                  	</g:each>
                  		<tr>
						     <th  colspan="7">ChainLink Cost</th>
						     <td>${quotationModelInstance?.quotationChainLinkModel?.chainLinkCost}</td>
						</tr>
						<tr>
						<th colspan="7">ChainLink Discount&nbsp;@&nbsp;${quotationModelInstance?.quotationChainLinkModel?.chainLinkDiscountPercent}</th>
						<td>
							${quotationModelInstance?.quotationChainLinkModel?.chainLinkDiscount}
						</td>
					</tr>
					<tr>
						<th colspan="7">Total Cost Of ChainLink</th>
						<td>
							${quotationModelInstance?.quotationChainLinkModel?.netChainLinkCost}
						</td>
					</tr>	  
					
				  </g:if>
			</table>
			
			<br></br>
			<br></br>  
			WELD SIDE MESH:
			<table border="1">
				<tr>
				
					<th>Design</th>
					<th>Wire Brand</th>
					<th>Length</th>
					<th>Height</th>
					<th>No Of Pieces</th>
					<th>Square Feets</th>
					<th>Price Per SqFt</th>
					<th>WeldSide Item Cost</th>
				
				</tr>
				 <g:if test="${quotationModelInstance?.quotationWeldSideModel?.quotationWeldSideItems}">
				 	
			 		<g:each in="${quotationModelInstance?.quotationWeldSideModel?.quotationWeldSideItems}" var="sideMesh">
			 			<tr>
			 				 <td>${sideMesh?.sideMesh}</td>
							 <td>${sideMesh?.wireBrand}</td>
							 <td>${sideMesh?.length}</td>
							 <td>${sideMesh?.height}</td>
							 <td>${sideMesh?.noOfPieces}</td>
							 <td>${sideMesh?.squareFeets}</td>
							 <td>${sideMesh?.pricePerSqFt}</td>
							 <td>${sideMesh?.weldSideItemCost}</td>
					    </tr>	
                  	</g:each>
                  		<tr>
						     <th  colspan="7">WeldSideMesh Cost</th>
						     <td>${quotationModelInstance?.quotationWeldSideModel?.weldSideCost}</td>
						</tr>
						<tr>
						<th colspan="7">WeldSideMesh Discount&nbsp;@&nbsp;${quotationModelInstance?.quotationWeldSideModel?.weldSideDiscountPercent}</th>
						<td>
							${quotationModelInstance?.quotationWeldSideModel?.weldSideDiscount}
						</td>
					</tr>
					<tr>
						<th colspan="7">Total Cost Of WeldSideMesh</th>
						<td>
							${quotationModelInstance?.quotationWeldSideModel?.netWeldSideCost}
						</td>
					</tr>	  
					
				  </g:if>
			</table>
							
			</div>
	  </div>	
	</body>
</html>
			