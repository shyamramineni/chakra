
<%@ page import="com.chakra.config.SideMesh" %>
<%@ page import="com.chakra.config.WirePrice" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'sideMesh.label', default: 'SideMesh Price Report')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-sideMesh" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-sideMesh" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
					
						<%--<g:sortableColumn property="id" title="${message(code: 'sideMesh.sideMeshId.label', default: 'SideMesh Id')}" />
					
						--%><g:sortableColumn property="design" title="${message(code: 'sideMesh.design.label', default: 'Design')}" />
						
						<g:sortableColumn property="wireDiameter" title="${message(code: 'sideMesh.design.label', default: 'Wire Diameter')}" />
					
						<%--<g:sortableColumn property="weight" title="${message(code: 'sideMesh.weight.label', default: 'Weight')}" />
					
						--%><g:each in="${com.chakra.config.WireBrand.list()}" status="w" var="wireBrandInstance">
						
						<th>${wireBrandInstance}</th>
						
						</g:each>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${com.chakra.config.SideMesh.list()}" status="i" var="sideMeshInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<%--<td>${fieldValue(bean: sideMeshInstance, field: "id")}</td>
					
						--%><td>${fieldValue(bean: sideMeshInstance, field: "holeSize")}</td>
						
						<td>${fieldValue(bean: sideMeshInstance, field: "wireDiameter")}</td>
					
						<%--<td>${fieldValue(bean: sideMeshInstance, field: "weight")}</td>
					
						--%><g:each in="${com.chakra.config.WireBrand.list()}" status="w" var="wireBrandInstance">
						
						<% 
							def wirePrice = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance,sideMeshInstance.wireDiameter)
					    %>
						<td><g:formatNumber number="${(sideMeshInstance?.weight * wirePrice?.price)}" type="number" maxFractionDigits="2" roundingMode="HALF_UP"/></td>
												
						</g:each>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			
		</div>
	</body>
</html>
