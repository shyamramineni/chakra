
<%@ page import="com.chakra.quotation.Quotation" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quotation.label', default: 'Quotation Model')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-quotation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-quotation" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list quotation">
			
				<%--<g:if test="${quotationInstance?.quotationId}">
				<li class="fieldcontain">
					<span id="quotationId-label" class="property-label"><g:message code="quotation.quotationId.label" default="Quotation Id" /></span>
					
						<span class="property-value" aria-labelledby="quotationId-label"><g:fieldValue bean="${quotationInstance}" field="quotationId"/></span>
					
				</li>
				</g:if>
				
				<g:if test="${quotationInstance?.customer}">
				<li class="fieldcontain">
					<span id="customer-label" class="property-label"><g:message code="quotation.customer.label" default="Customer" /></span>
					
						<span class="property-value" aria-labelledby="customer-label"><g:link controller="customer" action="show" id="${quotationInstance?.customer?.id}">${quotationInstance?.customer?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
				
				<g:if test="${quotationInstance?.cageLength}">
				<li class="fieldcontain">
					<span id="cageLength-label" class="property-label"><g:message code="quotation.cageLength.label" default="Cage Length" /></span>
					
						<span class="property-value" aria-labelledby="cageLength-label"><g:fieldValue bean="${quotationInstance}" field="cageLength"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationInstance?.fulls}">
				<li class="fieldcontain">
					<span id="fulls-label" class="property-label"><g:message code="quotation.fulls.label" default="Fulls" /></span>
					
						<span class="property-value" aria-labelledby="fulls-label"><g:fieldValue bean="${quotationInstance}" field="fulls"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationInstance?.halfs}">
				<li class="fieldcontain">
					<span id="halfs-label" class="property-label"><g:message code="quotation.halfs.label" default="Halfs" /></span>
					
						<span class="property-value" aria-labelledby="halfs-label"><g:fieldValue bean="${quotationInstance}" field="halfs"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationInstance?.tiers}">
				<li class="fieldcontain">
					<span id="tiers-label" class="property-label"><g:message code="quotation.tiers.label" default="Tiers" /></span>
					
						<span class="property-value" aria-labelledby="tiers-label"><g:fieldValue bean="${quotationInstance}" field="tiers"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationInstance?.noOfCuttingsInShed}">
				<li class="fieldcontain">
					<span id="noOfCuttingsInShed-label" class="property-label"><g:message code="quotation.noOfCuttingsInShed.label" default="No Of Cuttings In Shed" /></span>
					
						<span class="property-value" aria-labelledby="noOfCuttingsInShed-label"><g:fieldValue bean="${quotationInstance}" field="noOfCuttingsInShed"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationInstance?.noOfSheds}">
				<li class="fieldcontain">
					<span id="noOfSheds-label" class="property-label"><g:message code="quotation.noOfSheds.label" default="No Of Sheds" /></span>
					
						<span class="property-value" aria-labelledby="noOfSheds-label"><g:fieldValue bean="${quotationInstance}" field="noOfSheds"/></span>
					
				</li>
				</g:if>
				
				<g:if test="${quotationInstance?.status}">
				<li class="fieldcontain">
					<span id="status-label" class="property-label"><g:message code="quotation.status.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="status-label"><g:fieldValue bean="${quotationInstance}" field="status"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationInstance?.comments}">
				<li class="fieldcontain">
					<span id="comments-label" class="property-label"><g:message code="quotation.comments.label" default="Comments" /></span>
					
						<span class="property-value" aria-labelledby="comments-label"><g:fieldValue bean="${quotationInstance}" field="comments"/></span>
					
				</li>
				</g:if>
									
				<g:if test="${quotationInstance?.createdBy}">
				<li class="fieldcontain">
					<span id="createdBy-label" class="property-label"><g:message code="quotation.createdBy.label" default="Created By" /></span>
					
						<span class="property-value" aria-labelledby="createdBy-label"><g:link controller="user" action="show" id="${quotationInstance?.createdBy?.id}">${quotationInstance?.createdBy?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationInstance?.createdDate}">
				<li class="fieldcontain">
					<span id="createdDate-label" class="property-label"><g:message code="quotation.createdDate.label" default="Created Date" /></span>
					
						<span class="property-value" aria-labelledby="createdDate-label"><g:formatDate date="${quotationInstance?.createdDate}" format="dd-MM-yyyy" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationInstance?.lastEditedBy}">
				<li class="fieldcontain">
					<span id="lastEditedBy-label" class="property-label"><g:message code="quotation.lastEditedBy.label" default="Last Edited By" /></span>
					
						<span class="property-value" aria-labelledby="lastEditedBy-label"><g:link controller="user" action="show" id="${quotationInstance?.lastEditedBy?.id}">${quotationInstance?.lastEditedBy?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${quotationInstance?.lastEditedDate}">
				<li class="fieldcontain">
					<span id="lastEditedDate-label" class="property-label"><g:message code="quotation.lastEditedDate.label" default="Last Edited Date" /></span>
					
						<span class="property-value" aria-labelledby="lastEditedDate-label"><g:formatDate date="${quotationInstance?.lastEditedDate}" format="dd-MM-yyyy" /></span>
					
				</li>
				</g:if>
				--%>
				<table class="table table-bordered">
							
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
			
				<br>
				<table class="table table-bordered">
				
				<tr>
				<th>Cage Design</th>
				<th>No.Of Birds</th>
				<th>Cost</th>
				<th>Tax</th>
				<th>Total Cost</th>
				<%--<th>Action</th>
				--%></tr>
					
				<g:if test="${quotationInstance?.quotationModels}">
				<li class="fieldcontain">
					<span id="quotationModels-label" class="property-label"><g:message code="quotation.quotationModels.label" default="QUOTATION MODELS:" /></span>
					 
						<%--<g:each in="${quotationInstance.quotationModels}" var="q">
						--%><tr>
							 <td>${quotationModelInstance.cageDesign}</td>
						     <td>${quotationModelInstance.noOfBirds}</td>
						     <td>${quotationModelInstance.cost}</td>
						     <td>${quotationModelInstance.tax}</td>
						     <td>${quotationModelInstance.totalCost}</td>
						     <%--<td><g:link class="quotationModelEdit" action="quotationModelEdit" id="${quotationModelInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link></td>
						 --%></tr>    
						<%--</g:each>
						
				--%></li>
				</g:if>
				</table>
				
				<g:if test="${quotationInstance?.isMeshQuotation}">
				<table class="table table-bordered">
				<tr>
				<th>Cage Design</th>
				<th>Wire Brand</th>
				<th>Single Box</th>
				<th>Double Box</th>
				<th>Cost Per Bird</th>
				<th>Total No. Of Birds</th>
				<th>Mesh Cost:</th>
				<%--<th>Action</th>
				--%></tr>
				
				<li class="fieldcontain">
					<span id="quotationModels-label" class="property-label"><g:message code="quotationModels.cageParts.label" default="MESH MODEL:" /></span>
					
						<%--<g:each in="${quotationInstance?.quotationModels.quotationMeshModel}" var="m">
						<span class="property-value" aria-labelledby="quotationModels-label"><g:link controller="quotationModels" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></span>
						--%>
						   <tr>
							 <td>${quotationModelInstance?.quotationMeshModel?.cageDesign}</td>
							 <td>${quotationModelInstance?.quotationMeshModel?.wireBrand}</td>
							 <td>${quotationModelInstance?.quotationMeshModel?.singleBox}</td>
							 <td>${quotationModelInstance?.quotationMeshModel?.doubleBox}</td>
							 <td>${quotationModelInstance?.quotationMeshModel?.costPerBird}</td>
							 <td>${quotationModelInstance?.quotationMeshModel?.noOfBirds}</td>
							 <td>${quotationModelInstance?.quotationMeshModel?.meshCost}</td>
						   </tr>		
						<%--</g:each>
					
				--%></li>
				
				</table>
				</g:if>
				
				<g:if test="${quotationInstance?.isCageQuotation}">
				<table class="table table-bordered">
				<tr>
				<th>Cage Design</th>
				<th>Cost Per Bird</th>
				<th>No. Of Birds</th>
				<th>CagePart Cost</th>
				</tr>
				
				<li class="fieldcontain">
					<span id="quotationModels-label" class="property-label"><g:message code="quotationModels.cageParts.label" default="CAGEPART MODEL:" /></span>
					
						<%--<g:each in="${quotationInstance?.quotationModels.quotationCagePartModel}" var="m">
						  --%><tr>
							 <td>${quotationModelInstance?.quotationCagePartModel?.cageDesign}</td>
							 <td>${quotationModelInstance?.quotationCagePartModel?.costPerBird}</td>
							 <td>${quotationModelInstance?.quotationCagePartModel?.noOfBirds}</td>
							 <td>${quotationModelInstance?.quotationCagePartModel?.cagePartCost}</td>
						   </tr>		
						<%--</g:each>
					
				--%></li>
				
				</table>
				</g:if>
			
			    <g:if test="${quotationModelInstance?.quotationMeshModel?.quotationMeshParts?.size() > 0}">
			    <table class="table table-bordered">
				<tr>

					<th>Sheet Id</th>
					<th>Sheet Specification</th>
					<th>Wire Brand</th>
					<%--<th>Price of Single Sheet</th>
					--%><th>No Of Mesh Parts</th>
					<th>Cost Of Mesh Parts</th>
				</tr>
				
					<li class="fieldcontain">
					   <span id="quotationModels-label" class="property-label"><g:message code="quotationModels.meshParts.label" default="MESH PARTS:" /></span>
						<g:each
							in="${quotationModelInstance?.quotationMeshModel?.quotationMeshParts}"
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
									<g:formatNumber number="${(p?.wirePrice)*(p?.sheetSpecification?.sheetWeight)}" type="number" maxFractionDigits="2" />
								</td>
								--%><td>
									${(p?.noOfMeshParts)}
								</td>
								<td>
									${p?.meshCost}
								</td>
							</tr>
						</g:each>
					<tr>
						<th colspan="4">Total Mesh Cost</th>
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
						<th colspan="4">Total Cost Of Mesh Parts</th>
						<td>
							${quotationModelInstance?.quotationMeshModel?.netMeshCost}
						</td>
					</tr>
					

					</li>
				
			</table>
			</g:if>

			<g:if test="${quotationModelInstance?.quotationCagePartModel?.quotationCageParts?.size() > 0}">
			<table class="table table-bordered">
				<tr>
				
				<th>Cage Part Name</th>
				<th>No Of Cage Parts</th>
				<th>Price Of Each CagePart</th>
				<th>Cost Of CagePart</th>
				
				</tr>
			 
			 	<li class="fieldcontain">
			 		<span id="quotationModels-label" class="property-label"><g:message code="quotationModels.cageParts.label" default="CAGE PARTS:" /></span>
			 		
			 			<g:each in="${quotationModelInstance?.quotationCagePartModel?.quotationCageParts}" var="c">
			 			<tr>
			 				 <td>${c.cagePartSpecFormula}</td>
							 <td>${c.noOfCageParts}</td>
							 <td>${c.priceOfEachCagePart}</td>
							 <td>${c.costOfCagePart}</td>
						  </tr>	
                  		</g:each>
                  		  <tr>
						     <th  colspan="3">Total Cost Of  Cage Parts</th>
						     <td>${quotationModelInstance?.quotationCagePartModel.cagePartCost}</td>
						  </tr>
						  
					
				</li>
			  
			</table>
			</g:if>	
			
			<g:if test="${quotationModelInstance?.quotationChainLinkModel?.quotationChainLinkItems?.size() > 0}">
			<table class="table table-bordered">
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
			 
			 	<li class="fieldcontain">
			 		<span id="quotationModels-label" class="property-label"><g:message code="quotationModels.cageParts.label" default="CHAIN LINK:" /></span>
			 		
			 <g:each in="${quotationModelInstance?.quotationChainLinkModel?.quotationChainLinkItems}" var="chainLink">
			 		<tr>			
			 			<td valign="top" class="value">
							${chainLink?.linkMesh}
						</td>
						<td valign="top" class="value">
							${chainLink?.wireBrand}
						</td>
						<td valign="top" class="value">
							${chainLink?.length}
						</td>
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
					<%--<tr>
						<td colspan="9"><sec:ifAnyGranted roles="ROLE_ADMIN, ROLE_SALES"><g:link class="editChainLink" action="editChainLinkModel" params="["quotation":quotationInstance.id,"quotationModel":quotationModelInstance.id]"><g:message code="quotationModels.cageParts.label" default="Edit ChainLink" /></g:link></sec:ifAnyGranted></td>
					</tr>
					
				--%></li>
			  
			</table>
			</g:if>
			
			<g:if test="${quotationModelInstance?.quotationWeldSideModel?.quotationWeldSideItems?.size() > 0}">
			<table class="table table-bordered">
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
			 
			 	<li class="fieldcontain">
			 		<span id="quotationModels-label" class="property-label"><g:message code="quotationModels.cageParts.label" default="WELD SIDE MESH:" /></span>
			 		
			 <g:each in="${quotationModelInstance?.quotationWeldSideModel?.quotationWeldSideItems}" var="weldSide">
			 		<tr>			
			 			<td valign="top" class="value">
							${weldSide?.sideMesh}
						</td>
						<td valign="top" class="value">
							${weldSide?.wireBrand}
						</td>
						<td valign="top" class="value">
							${weldSide?.length}
						</td>
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
						<th colspan="7">WELDSIDE MESH COST</th>
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
					<%--<tr>
						<td colspan="9"><sec:ifAnyGranted roles="ROLE_ADMIN, ROLE_SALES"><g:link class="editWeldSide" action="editWeldSideModel" params="["quotation":quotationInstance.id,"quotationModel":quotationModelInstance.id]"><g:message code="quotationModels.weldSide.label" default="Edit WeldSideMesh" /></g:link></sec:ifAnyGranted></td>
					</tr>
					
					
				--%></li>
			  
			</table>
			</g:if>
				
			</ol>	
			
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${quotationInstance?.id}" />
					<g:hiddenField name="modelid" value="${quotationModelInstance?.id}" />
					
					<%--<sec:ifAnyGranted roles="ROLE_ADMIN, ROLE_SALES"><g:link class="btn btn-primary" action="quotation" id="${quotationInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link></sec:ifAnyGranted>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />--%>
					<sec:ifAnyGranted roles="ROLE_ADMIN, ROLE_SALES"><g:link class="btn btn-primary" action="quotationPdf" id="${quotationInstance?.id}" params="["quotation":quotationInstance.id,"quotationModel":quotationModelInstance.id]"><g:message code="default.button.print.label" default="Print" /></g:link></sec:ifAnyGranted>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
