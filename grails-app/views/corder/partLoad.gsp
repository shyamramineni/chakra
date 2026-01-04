
<%@ page import="com.chakra.order.Corder" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'corder.label', default: 'Corder')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		
		<div id="list-corder" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="alert alert-error" role="status">${flash.message}</div>
			</g:if>
			
			<g:form controller="corder" action="partBlock">
			
				<g:if test="${corderMeshPartInstanceList?.size()!=0}">
					<table class="table table-bordered table-striped table-condensed">
						<thead>
							<tr>
												
								<th><g:message code="corder.sheetSpecification.label" default="SheetSpecification" /></th>
								<th><g:message code="corder.noOfMeshParts.label" default="No Of MeshParts" /></th>
								<th><g:message code="corder.noOfMeshParts.label" default="No Of InStock" /></th>
								<th><g:message code="corder.meshPart.label" default="No.Of Blocked" /></th>
								<th><g:message code="corder.meshPart.label" default="No.Of Shipped" /></th>
								<th><g:message code="corder.meshPart.label" default="No.Of Parts To Block" /></th>													
							
							</tr>
						</thead>
						<tbody>
										
						<g:each in="${corderMeshPartInstanceList}" status="i" var="corderMeshPartsInstance">
							<tr>
							
								<td>${corderMeshPartsInstance[0]}</td>
								<td>${corderMeshPartsInstance[1]}</td>
								<td>${corderMeshPartsInstance[2]}</td>
								<td>${corderMeshPartsInstance[3]}</td>
								<td>${corderMeshPartsInstance[4]}</td>
								<g:hiddenField name="meshParts[${i}].id" value="${corderMeshPartsInstance[0]?.id}" />
								<td><g:textField name="meshParts[${i}].noOfBlockedParts" value="${noOfBlockedParts}"/></td>
							</tr>
						</g:each>
						</tbody>
					</table>
				</g:if>
				
				<g:if test="${corderCagePartInstanceList?.size()!=0}">
					<table class="table table-bordered table-striped table-condensed">
						<thead>
							<tr>
												
								<th><g:message code="corder.cagePart.label" default="CagePartSpec Formula" /></th>
								<th><g:message code="corder.cagePart.label" default="No Of CageParts" /></th>
								<th><g:message code="corder.cagePart.label" default="No Of InStock" /></th>
								<th><g:message code="corder.cagePart.label" default="No.Of Blocked" /></th>
								<th><g:message code="corder.cagePart.label" default="No.Of Shipped" /></th>
								<th><g:message code="corder.cagePart.label" default="No.Of Parts To Block" /></th>													
							
							</tr>
						</thead>
						<tbody>
										
						<g:each in="${corderCagePartInstanceList}" status="i" var="corderCagePartsInstance">
							<tr>
							
								<td>${corderCagePartsInstance[0]}</td>
								<td>${corderCagePartsInstance[1]}</td>
								<td>${corderCagePartsInstance[2]}</td>
								<td>${corderCagePartsInstance[3]}</td>
								<td>${corderCagePartsInstance[4]}</td>
								<g:hiddenField name="cageParts[${i}].id" value="${corderCagePartsInstance[0]?.id}" />
								<td><g:textField name="cageParts[${i}].noOfBlockedCageParts" value="${noOfBlockedParts}"/></td>
							</tr>
						</g:each>
						</tbody>
					</table>
				</g:if>
				
				<g:if test="${corderChainLinkInstanceList?.size()!=0}">
					<table class="table table-bordered table-striped table-condensed">
						<thead>
							<tr>
												
								<th><g:message code="corder.chainLink.label" default="ChainLink Design" /></th>
								<th><g:message code="corder.chainLink.label" default="No Of SquareFeets" /></th>
								<th><g:message code="corder.chainLink.label" default="InStock Sqfts" /></th>
								<th><g:message code="corder.chainLink.label" default="Blocked Sqfts" /></th>
								<th><g:message code="corder.chainLink.label" default="Shipped Sqfts" /></th>
								<th><g:message code="corder.chainLink.label" default="Sqfts To Block" /></th>													
							
							</tr>
						</thead>
						<tbody>
										
						<g:each in="${corderChainLinkInstanceList}" status="i" var="corderChainLinkItemsInstance">
							<tr>
							
								<td>${corderChainLinkItemsInstance[0]}</td>
								<td>${corderChainLinkItemsInstance[1]}</td>
								<td>${corderChainLinkItemsInstance[2]}</td>
								<td>${corderChainLinkItemsInstance[3]}</td>
								<td>${corderChainLinkItemsInstance[4]}</td>
								<g:hiddenField name="chainLink[${i}].id" value="${corderChainLinkItemsInstance[0]?.id}" />
								<td><g:textField name="chainLink[${i}].blockedChainLinkSqfts" value="${noOfBlockedParts}"/></td>
							</tr>
						</g:each>
						</tbody>
					</table>
				</g:if>
				
				<g:if test="${corderWeldSideInstanceList?.size()!=0}">
					<table class="table table-bordered table-striped table-condensed">
						<thead>
							<tr>
												
								<th><g:message code="corder.weldSide.label" default="WeldSide Design" /></th>
								<th><g:message code="corder.weldSide.label" default="No Of SquareFeets" /></th>
								<th><g:message code="corder.weldSide.label" default="InStock Sqfts" /></th>
								<th><g:message code="corder.weldSide.label" default="Blocked Sqfts" /></th>
								<th><g:message code="corder.weldSide.label" default="Shipped Sqfts" /></th>
								<th><g:message code="corder.weldSide.label" default="Sqfts To Block" /></th>													
							
							</tr>
						</thead>
						<tbody>
										
						<g:each in="${corderWeldSideInstanceList}" status="i" var="corderWeldSideItemsInstance">
							<tr>
							
								<td>${corderWeldSideItemsInstance[0]}</td>
								<td>${corderWeldSideItemsInstance[1]}</td>
								<td>${corderWeldSideItemsInstance[2]}</td>
								<td>${corderWeldSideItemsInstance[3]}</td>
								<td>${corderWeldSideItemsInstance[4]}</td>
								<g:hiddenField name="weldSide[${i}].id" value="${corderWeldSideItemsInstance[0]?.id}" />
								<td><g:textField name="weldSide[${i}].blockedWeldSideSqfts" value="${noOfBlockedParts}"/></td>
							</tr>
						</g:each>
						</tbody>
					</table>
				</g:if>
				
				<g:hiddenField name='corder.id' value='${corderInstance?.id}' />
				<g:hiddenField name="wireBrand.id" value="${wireBrandInstance?.id}" />                
				<div class="buttons">
		    		<span class="button"><g:submitButton name="partBlock" class="btn btn-primary" value="Block"/></span>
		    	</div>
			</g:form>
		</div>
		
	</body>
</html>
