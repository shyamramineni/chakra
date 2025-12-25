
<%@ page import="com.chakra.config.SheetSpecification" %>
<%@ page import="com.chakra.config.WirePrice" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'sheetSpecification.label', default: 'SheetSpecification')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<r:require module="export"/>
	</head>
	<body>
		<a href="#list-sheetSpecification" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-sheetSpecification" class="content scaffold-list" role="main">
			<h1><g:message code="Sheet Price Report" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
						
						<td><g:message code="sheetSpecification.sheetName.label" default="Sheet Id" /></td>
																
						<td><g:message code="sheetSpecification.sheetName.label" default="Sheet Name" /></td>
						
						<td><g:message code="sheetSpecification.sheetName.label" default="Sheet Weight" /></td>
						
						<g:each in="${com.chakra.config.WireBrand.list()}" status="w" var="wireBrandInstance">
						
						<th>${wireBrandInstance}</th>
						
						</g:each>											
						
					</tr>
				</thead>
				<tbody>
				
				<g:each in="${com.chakra.config.SheetSpecification.list()}" status="i" var="sheetSpecificationInstance">
				
				<%
					BigDecimal noOfCrossWires = (sheetSpecificationInstance.length/sheetSpecificationInstance.pitch)+1
					BigDecimal crossWireLength = noOfCrossWires*(sheetSpecificationInstance.width+(2*sheetSpecificationInstance.projection))
					BigDecimal lineWireLength1 = (sheetSpecificationInstance.length+sheetSpecificationInstance.pitch)*sheetSpecificationInstance.noOfLineWires1
					BigDecimal lineWireLength2 = (sheetSpecificationInstance.length+sheetSpecificationInstance.pitch)*sheetSpecificationInstance.noOfLineWires2
			
					BigDecimal crossWireWeight = ((crossWireLength/6588)*(sheetSpecificationInstance.crossWireDiameter*sheetSpecificationInstance.crossWireDiameter))
					BigDecimal lineWireWeight1 = ((lineWireLength1/6588)*(sheetSpecificationInstance.lineWireDiameter1*sheetSpecificationInstance.lineWireDiameter1))
					BigDecimal lineWireWeight2 = ((lineWireLength2/6588)*(sheetSpecificationInstance.lineWireDiameter2*sheetSpecificationInstance.lineWireDiameter2))
											
					
				
				 %>
				
						
				    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
				 
				       <td><g:link action="show" id="${sheetSpecificationInstance.id}">${fieldValue(bean: sheetSpecificationInstance, field: "sheetSpecId")}</g:link></td>
				
					   <td>${sheetSpecificationInstance}</td>
					   
					   <td><g:formatNumber number="${(crossWireWeight+lineWireWeight1+lineWireWeight2)}" type="number" maxFractionDigits="2"/></td>
								    
					   
								    
				<g:each in="${com.chakra.config.WireBrand.list()}" status="w" var="wireBrandInstance">
				
				<% 
					def crossWirePrice = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, sheetSpecificationInstance?.crossWireDiameter)
					def lineWirePrice1 = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, sheetSpecificationInstance?.lineWireDiameter1)
					def lineWirePrice2 = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, sheetSpecificationInstance?.lineWireDiameter2)
				%>
				    <g:if test="${(sheetSpecificationInstance?.lineWireDiameter1 == sheetSpecificationInstance?.crossWireDiameter) && (sheetSpecificationInstance?.lineWireDiameter2 > 0)}">
				 		<td><g:formatNumber number="${(crossWireWeight*crossWirePrice?.price) + (lineWireWeight1*lineWirePrice1?.price) + (lineWireWeight2*lineWirePrice2?.price)}" type="number" maxFractionDigits="2" roundingMode="HALF_UP"/></td>
			        </g:if>
			        <g:if test="${(sheetSpecificationInstance?.lineWireDiameter1 == sheetSpecificationInstance?.crossWireDiameter) && (sheetSpecificationInstance?.lineWireDiameter2 == 0)}">
				 		<td><g:formatNumber number="${(crossWireWeight*crossWirePrice?.price) + (lineWireWeight1*lineWirePrice1?.price)}" type="number" maxFractionDigits="2" roundingMode="HALF_UP"/></td>
			        </g:if>
			        <g:if test="${(sheetSpecificationInstance?.lineWireDiameter2 == sheetSpecificationInstance?.crossWireDiameter) && (sheetSpecificationInstance?.lineWireDiameter1 == 0)}">
				 		<td><g:formatNumber number="${(crossWireWeight*crossWirePrice?.price) + (lineWireWeight2*lineWirePrice2?.price)}" type="number" maxFractionDigits="2" roundingMode="HALF_UP"/></td>
			        </g:if>
			        </g:each>
				
				    </tr>  
				</g:each>
				 						
				</tbody>
			</table>
			<g:link class="btn btn-primary" action="meshPartsPdf" id="${sheetSpecificationInstance?.id}"><g:message code="default.button.print.label" default="Print" /></g:link>
			<div>
		    	<export:formats formats="['csv', 'excel', 'ods', 'pdf', 'rtf', 'xml']"  action="exportSheetPrice" />
			</div>
		</div>
	</body>
</html>
