
<%@ page import="com.chakra.quotation.Quotation" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quotation.label', default: 'Quotation')}" />
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
			<%--<ol class="property-list quotation">
			
				<g:if test="${quotationInstance?.customer}">
				<li class="fieldcontain">
					<span id="customer-label" class="property-label"><g:message code="quotation.customer.label" default="Customer" /></span>
					
						<span class="property-value" aria-labelledby="customer-label"><g:link controller="customer" action="show" id="${quotationInstance?.customer?.id}">${quotationInstance?.customer?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
				
				<g:if test="${quotationInstance?.quotationId}">
				<li class="fieldcontain">
					<span id="quotationId-label" class="property-label"><g:message code="quotation.quotationId.label" default="Quotation Id" /></span>
					
						<span class="property-value" aria-labelledby="quotationId-label"><g:fieldValue bean="${quotationInstance}" field="quotationId"/></span>
					
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
						
				<g:if test="${quotationInstance?.quotationModels}">
				<li class="fieldcontain">
					<span id="quotationModels-label" class="property-label"><g:message code="quotation.quotationModels.label" default="Quotation Models" /></span>
					
						<g:each in="${quotationInstance.quotationModels}" var="q">
						<span class="property-value" aria-labelledby="quotationModels-label"><g:link controller="quotationModels" action="show" id="${q.id}">${q?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
									
			</ol>
			
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
				        <td><b>${quotationInstance.status}</b></td>
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
				    <g:if test="${quotationInstance?.status == 'FAILED'}">
				    <tr>
				        <th align="left">Quotation Failed Reason:</th>
				        <td>${quotationInstance?.quotationFailedReason}</td>
				    </tr>
				    <tr>
				        <th align="left">Quotation Failed Comments:</th>
				        <td>${quotationInstance?.quotationFailedComments}</td>
				    </tr>
				    </g:if>
						
			</table>
			<br>	
			<g:if test="${quotationInstance?.quotationModels.size() > 0}">
			<table class="table table-bordered">
				
				<tr>
				<th>Cage Design</th>
				<th>No.Of Birds</th>
				<th>Cost</th>
				<th>Tax</th>
				<th>Total Cost</th>
				<th>View Model</th>
				</tr>
								
				<li class="fieldcontain">
					<span id="quotationModels-label" class="property-label"><g:message code="quotation.quotationModels.label" default="QUOTATION MODELS:" /></span>
					 
						<g:each in="${quotationInstance.quotationModels}" var="q">
						  <tr>
							 <td>${q.cageDesign}</td>
						     <td>${q.noOfBirds}</td>
						     <td>${q.cost}</td>
						     <td>${q.tax}</td>
						     <td>${q.totalCost}</td>
						     <td><g:link action="quotationModelShow" params="["quotation":quotationInstance.id,"quotationModel":q?.id]" >View</g:link></td>
						  </tr>    
						</g:each>
						
				</li>
			</table>
			</g:if>
			
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${quotationInstance?.id}" />
					<%--<sec:ifAnyGranted roles="ROLE_ADMIN, ROLE_SALES"><g:link class="btn btn-primary" action="edit" id="${quotationInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link></sec:ifAnyGranted>
					<sec:ifAnyGranted roles="ROLE_ADMIN, ROLE_SALES"><g:link class="btn btn-primary" action="view" params="["quotation":quotationInstance?.id,"quotationModel":quotationModel?.id]" >View</g:link></sec:ifAnyGranted>--%>
					<sec:ifAllGranted roles="ROLE_ADMIN"><g:actionSubmit class="btn btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></sec:ifAllGranted>
					<g:if test="${quotationInstance.status == "EXPIRED"}">
					<sec:ifAnyGranted roles="ROLE_ADMIN"><g:link class="btn btn-primary" action="reValidate" id="${quotationInstance?.id}"><g:message code="default.button.revalidate.label" default="ReValidate" /></g:link></sec:ifAnyGranted>
					</g:if>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
