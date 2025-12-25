
<%@ page import="com.chakra.config.CagePartPrice" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cagePartPrice.label', default: 'CagePart Price')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<r:require module="export"/>
	</head>
	<body>
		<a href="#list-cagePartPrice" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-cagePartPrice" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table  class="table table-bordered">
				<thead>
					<tr>
						<th><g:message code="cagePartPrice.cagePartId.label" default="Cage Part Code" /></th>
								
						<th><g:message code="cagePartPrice.cagePart.label" default="Cage Part" /></th>
						
						<th><g:message code="cagePartPrice.price.label" default="Price" /></th>
						
						<th><g:message code="cagePartPrice.pricePerUnit.label" default="Unit" /></th>
						
					</tr>
				</thead>
				<tbody>
				<g:each in="${com.chakra.config.CagePartPrice.list()}" status="i" var="cagePartPriceInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
                        <td><g:link action="show" id="${cagePartPriceInstance.id}">${cagePartPriceInstance?.cagePart?.cagePartCode}</g:link></td> 						
					
						<td>${cagePartPriceInstance.cagePart}</td>
						
						<td>${cagePartPriceInstance.price}</td>
						
						<td></td>
											
					</tr>
				</g:each>
				</tbody>
			</table>
			<g:link class="btn btn-primary" action="cagePartsPdf" id="${cagePartPriceInstance?.id}"><g:message code="default.button.print.label" default="Print" /></g:link>
			<div>
		    	<export:formats formats="['csv', 'excel', 'ods', 'pdf', 'rtf', 'xml']"  action="exportCagePartPrice" />
			</div>
		</div>
	</body>
</html>
