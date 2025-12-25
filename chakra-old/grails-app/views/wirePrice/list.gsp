
<%@ page import="com.chakra.config.WirePrice" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'wirePrice.label', default: 'WirePrice')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-wirePrice" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-wirePrice" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
					
						<th><g:message code="wirePrice.wireBrand.label" default="Wire Brand" /></th>
					
						<g:sortableColumn property="wireDiameter" title="${message(code: 'wirePrice.wireDiameter.label', default: 'Wire Diameter')}" />
											
						<g:sortableColumn property="price" title="${message(code: 'wirePrice.price.label', default: 'WirePrice')}" />
						
						<g:sortableColumn property="wastage" title="${message(code: 'wirePrice.wastage.label', default: 'Wastage')}(%)" />
						
						<g:sortableColumn property="price" title="${message(code: 'wirePrice.price.label', default: 'Conversion')}" />
												
						<g:sortableColumn property="price" title="${message(code: 'wirePrice.price.label', default: 'Freight')}" />
						
						<g:sortableColumn property="price" title="${message(code: 'wirePrice.price.label', default: 'Trending')}" />
						
						<g:sortableColumn property="price" title="${message(code: 'wirePrice.price.label', default: 'Price')}" />
						
						<g:sortableColumn property="price" title="${message(code: 'wirePrice.price.label', default: 'SheetSpec Disc')}" />
						
						<g:sortableColumn property="description" title="${message(code: 'wirePrice.description.label', default: 'ChainLink Disc.')}" />
					
						<g:sortableColumn property="wirePrice" title="${message(code: 'wirePrice.wirePrice.label', default: 'Weld Side Mesh Disc.')}" />
											
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${wirePriceInstanceList}" status="i" var="wirePriceInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${wirePriceInstance.id}">${fieldValue(bean: wirePriceInstance, field: "wireBrand")}</g:link></td>
					
						<td>${fieldValue(bean: wirePriceInstance, field: "wireDiameter")}</td>
					
						<td>${fieldValue(bean: wirePriceInstance, field: "wirePrice")}</td>
						
						<td>${fieldValue(bean: wirePriceInstance, field: "wastage")}</td>
						
						<td>${fieldValue(bean: wirePriceInstance, field: "conversion")}</td>
											
						<td>${fieldValue(bean: wirePriceInstance, field: "freightHandlingPerMetricTon")}</td>
						
						<td>${fieldValue(bean: wirePriceInstance, field: "wirePriceTrending")}</td>
						
						<td>${fieldValue(bean: wirePriceInstance, field: "price")}</td>
						
						<td>${fieldValue(bean: wirePriceInstance, field: "sheetSpecDiscount")}</td>
						
						<td>${fieldValue(bean: wirePriceInstance, field: "chainLinkDiscount")}</td>
						
						<td>${fieldValue(bean: wirePriceInstance, field: "weldSideMeshDiscount")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<ul>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
			<div class="pagination">
				<g:paginate total="${wirePriceInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
