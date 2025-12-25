
<%@ page import="com.chakra.config.WirePrice" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'wirePrice.label', default: 'WirePrice')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-wirePrice" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-wirePrice" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<%--<ol class="property-list wirePrice">
			
				<g:if test="${wirePriceInstance?.wireBrand}">
				<li class="fieldcontain">
					<span id="wireBrand-label" class="property-label"><g:message code="wirePrice.wireBrand.label" default="Wire Brand" /></span>
					
						<span class="property-value" aria-labelledby="wireBrand-label"><g:link controller="wireBrand" action="show" id="${wirePriceInstance?.wireBrand?.id}">${wirePriceInstance?.wireBrand?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${wirePriceInstance?.wireDiameter}">
				<li class="fieldcontain">
					<span id="wireDiameter-label" class="property-label"><g:message code="wirePrice.wireDiameter.label" default="Wire Diameter" /></span>
					
						<span class="property-value" aria-labelledby="wireDiameter-label"><g:fieldValue bean="${wirePriceInstance}" field="wireDiameter"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${wirePriceInstance?.price}">
				<li class="fieldcontain">
					<span id="price-label" class="property-label"><g:message code="wirePrice.price.label" default="Price" /></span>
					
						<span class="property-value" aria-labelledby="price-label"><g:fieldValue bean="${wirePriceInstance}" field="price"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${wirePriceInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="wirePrice.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${wirePriceInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${wirePriceInstance?.wirePrice}">
				<li class="fieldcontain">
					<span id="wirePrice-label" class="property-label"><g:message code="wirePrice.wirePrice.label" default="Wire Price" /></span>
					
						<span class="property-value" aria-labelledby="wirePrice-label"><g:fieldValue bean="${wirePriceInstance}" field="wirePrice"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${wirePriceInstance?.wastage}">
				<li class="fieldcontain">
					<span id="wastage-label" class="property-label"><g:message code="wirePrice.wastage.label" default="Wastage" /></span>
					
						<span class="property-value" aria-labelledby="wastage-label"><g:fieldValue bean="${wirePriceInstance}" field="wastage"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${wirePriceInstance?.conversion}">
				<li class="fieldcontain">
					<span id="conversion-label" class="property-label"><g:message code="wirePrice.conversion.label" default="Conversion" /></span>
					
						<span class="property-value" aria-labelledby="conversion-label"><g:fieldValue bean="${wirePriceInstance}" field="conversion"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${wirePriceInstance?.endDate}">
				<li class="fieldcontain">
					<span id="endDate-label" class="property-label"><g:message code="wirePrice.endDate.label" default="End Date" /></span>
					
						<span class="property-value" aria-labelledby="endDate-label"><g:formatDate date="${wirePriceInstance?.endDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${wirePriceInstance?.freightHandlingPerMetricTon}">
				<li class="fieldcontain">
					<span id="freightHandlingPerMetricTon-label" class="property-label"><g:message code="wirePrice.freightHandlingPerMetricTon.label" default="Freight Handling Per Metric Ton" /></span>
					
						<span class="property-value" aria-labelledby="freightHandlingPerMetricTon-label"><g:fieldValue bean="${wirePriceInstance}" field="freightHandlingPerMetricTon"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${wirePriceInstance?.startDate}">
				<li class="fieldcontain">
					<span id="startDate-label" class="property-label"><g:message code="wirePrice.startDate.label" default="Start Date" /></span>
					
						<span class="property-value" aria-labelledby="startDate-label"><g:formatDate date="${wirePriceInstance?.startDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${wirePriceInstance?.wirePriceTrending}">
				<li class="fieldcontain">
					<span id="wirePriceTrending-label" class="property-label"><g:message code="wirePrice.wirePriceTrending.label" default="Wire Price Trending" /></span>
					
						<span class="property-value" aria-labelledby="wirePriceTrending-label"><g:fieldValue bean="${wirePriceInstance}" field="wirePriceTrending"/></span>
					
				</li>
				</g:if>
			
			</ol>
			--%>
			<table class="table table-bordered">
							
				    <tr>
				        <th align="left">Wire Brand:</th>
				        <td>${wirePriceInstance.wireBrand}</td>
				    </tr>
				    <tr>
				        <th align="left">Wire Diameter:</th>
				        <td>${wirePriceInstance.wireDiameter}</td>
				    </tr>
				    <tr>
				        <th align="left">Wire Price:</th>
				        <td>${wirePriceInstance.wirePrice}</td>
				    </tr>
				    <tr>
				        <th align="left">Wastage:</th>
				        <td>${wirePriceInstance.wastage}</td>
				    </tr>
				    <tr>
				        <th align="left">Conversion:</th>
				        <td>${wirePriceInstance.conversion}</td>
				    </tr>
				    <tr>
				        <th align="left">Freight:</th>
				        <td>${wirePriceInstance.freightHandlingPerMetricTon}</td>
				    </tr>
				    <tr>
				        <th align="left">Trending:</th>
				        <td>${wirePriceInstance.wirePriceTrending}</td>
				    </tr>
				    <tr>
				        <th align="left">Start Date:</th>
				        <td>${wirePriceInstance.startDate}</td>
				    </tr>
				    <tr>
				        <th align="left">End Date:</th>
				        <td>${wirePriceInstance.endDate}</td>
				    </tr>
				    <tr>
				        <th align="left">Price:</th>
				        <td>${wirePriceInstance.price}</td>
				    </tr>
				    <tr>
				        <th align="left">SheetSpec Disc.:</th>
				        <td>${wirePriceInstance.sheetSpecDiscount}</td>
				    </tr>
				    <tr>
				        <th align="left">ChainLink Disc.:</th>
				        <td>${wirePriceInstance.chainLinkDiscount}</td>
				    </tr>
				    <tr>
				        <th align="left">Weld Side Mesh Disc.:</th>
				        <td>${wirePriceInstance.weldSideMeshDiscount}</td>
				    </tr>
				    <tr>
				        <th align="left">Description:</th>
				        <td>${wirePriceInstance.description}</td>
				    </tr>
				    				    				    				    						
			</table>
			<br>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${wirePriceInstance?.id}" />
					<g:link class="btn btn-primary" action="edit" id="${wirePriceInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="btn btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
