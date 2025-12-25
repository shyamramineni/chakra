
<%@ page import="com.chakra.order.CorderChainLink" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'orderCageParts.label', default: 'OrderWeldSide')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-orderCageParts" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-orderCageParts" class="content scaffold-list" role="main">
			<h2><g:message code="default.pendingCageParts.label" args="[entityName]" default="WeldSideMesh Order Book"/></h2>
			<g:if test="${flash.message}">
			<div class="alert alert-error" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
						<th><g:message code="corderCageParts.noOfCageParts.label" default="Customer" /></th>
						<th><g:message code="corderCageParts.noOfCageParts.label" default="Adress" /></th>
						<th><g:message code="corderCageParts.noOfCageParts.label" default="Mobile Number" /></th>						
						<th><g:message code="corderCageParts.noOfCageParts.label" default="Design" /></th>
						<th><g:message code="corderCageParts.noOfCageParts.label" default="Wire Brand" /></th>
						<th><g:message code="corderCageParts.noOfCageParts.label" default="Length" /></th>
						<th><g:message code="corderCageParts.noOfCageParts.label" default="Height" /></th>
						<th><g:message code="corderCageParts.noOfCageParts.label" default="No Of Pieces" /></th>
						<th><g:message code="corderCageParts.noOfCageParts.label" default="Rate" /></th>
						<th><g:message code="corderCageParts.noOfCageParts.label" default="Square Feets" /></th>
						<th><g:message code="corderCageParts.noOfCageParts.label" default="Amount" /></th>
						<th><g:message code="corderCageParts.noOfCageParts.label" default="Total" /></th>
						<%--<th><g:message code="corderCageParts.noOfCageParts.label" default="Balance" /></th>
						--%><th><g:message code="corderCageParts.noOfCageParts.label" default="Delivery Date" /></th>
					
					</tr>
				</thead>
				<tbody>
				
				<g:each in="${corderInstanceList}" status="i" var="corderInstance">
										
				    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
				 
				       <td>${corderInstance?.customer?.customerName}</td>
				       <td>${corderInstance?.customer?.address}</td>
				       <td>${corderInstance?.customer?.mobileNumber}</td>
				       <td>
				       		<g:each in="${corderInstance.corderWeldSideItems}" var="weldSide">
				       		${weldSide?.sideMesh}<br/>
				       		</g:each>
				       </td>
				       <td>
				       		<g:each in="${corderInstance.corderWeldSideItems}" var="weldSide">
				       		${weldSide?.wireBrand}<br/>
				       		</g:each>
				       </td>
				       <td>
				       		<g:each in="${corderInstance.corderWeldSideItems}" var="weldSide">
				       		${weldSide?.length}<br/>
				       		</g:each>
				       </td>
				       <td>
				       		<g:each in="${corderInstance.corderWeldSideItems}" var="weldSide">
				       		${weldSide?.height}<br/>
				       		</g:each>
				       </td>
				       <td>
				       		<g:each in="${corderInstance.corderWeldSideItems}" var="weldSide">
				       		${weldSide?.noOfPieces}<br/>
				       		</g:each>
				       </td>
				       <td>
				       		<g:each in="${corderInstance.corderWeldSideItems}" var="weldSide">
				       		${weldSide?.pricePerSqFt}<br/>
				       		</g:each>
				       </td>
				       <td>
				       		<g:each in="${corderInstance.corderWeldSideItems}" var="weldSide">
				       		${weldSide?.squareFeets}<br/>
				       		</g:each>
				       </td>
				       <td>
				       		<g:each in="${corderInstance.corderWeldSideItems}" var="weldSide">
				       		${weldSide?.weldSideItemCost}<br/>
				       		</g:each>
				       </td>
				       <td>				       		
				       		${corderInstance?.weldSideCost}				       		
				       </td>
				       <%--<td>				       		
				       		${corderInstance?.balance}				       		
				       </td>
				       --%><td>	
				       		<g:formatDate format="dd-MM-yyyy" date="${corderInstance?.deliveryDate}"/>
				       </td>
				       
					</tr>  
				</g:each>
				</tbody>
			</table>
		</div>
	</body>
</html>
