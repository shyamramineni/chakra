
<%@ page import="com.chakra.stock.Stock" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'stock.label', default: 'Stock')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-stock" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-stock" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			
			<table class="table table-bordered">
							
				    <tr>
				        <th align="left">Stock Id:</th>
				        <td>${stockInstance.stockId}</td>
				    </tr>
				    <tr>
				        <th align="left">Sheet Specification:</th>
				        <td>${stockInstance.sheetSpec}</td>
				    </tr>
				    <tr>
				        <th align="left">Wire Brand:</th>
				        <td>${stockInstance.wireBrand}</td>
				    </tr>
				    <tr>
				        <th align="left">Machine:</th>
				        <td>${stockInstance.machine}</td>
				    </tr>
				    
				    <tr>
				        <th align="left">Stock Manufactured Time:</th>
				        <td>${stockInstance.stockManufacturedTime}</td>
				    </tr>
				    <tr>
				        <th align="left">No Of Manufactured:</th>
				        <td>${stockInstance.noOfManufactured}</td>
				    </tr>
				    <tr>
				        <th align="left">No Of InStock:</th>
				        <td>${stockInstance.noOfInStock}</td>
				    </tr>
				    <tr>
				        <th align="left">Availability Status:</th>
				        <td>${stockInstance.availabilityStatus}</td>
				    </tr>
				     <tr>
				        <th align="left">Comments:</th>
				        <td>${stockInstance.comments}</td>
				    </tr>
				    <tr>
				        <th align="left">Created By:</th>
				        <td>${stockInstance.createdBy?.encodeAsHTML()}</td>
				    </tr>
				    <tr>
				        <th align="left">Last Edited By:</th>
				        <td>${stockInstance.lastEditedBy?.encodeAsHTML()}</td>
				    </tr>
				    				    						
			</table>
			<br>			
			
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${stockInstance?.id}" />
					<g:link class="edit" action="edit" id="${stockInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
