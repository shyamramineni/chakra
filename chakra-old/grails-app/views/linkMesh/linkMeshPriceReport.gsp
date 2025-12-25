
<%@ page import="com.chakra.config.LinkMesh" %>
<%@ page import="com.chakra.config.WirePrice" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'linkMesh.label', default: 'LinkMesh Price Report')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-linkMesh" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-linkMesh" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
					
						<%--<g:sortableColumn property="id" title="${message(code: 'linkMesh.holeSize.label', default: 'Id')}" />
					
						--%>
						<g:sortableColumn property="design" title="${message(code: 'linkMesh.design.label', default: 'Design')}" />
						
						<g:sortableColumn property="wireDiameter" title="${message(code: 'linkMesh.design.label', default: 'Wire Diameter')}" />
					
						<%--<g:sortableColumn property="weight" title="${message(code: 'linkMesh.weight.label', default: 'Weight')}" />
					
						--%><g:each in="${com.chakra.config.WireBrand.list()}" status="w" var="wireBrandInstance">
						
						<th>${wireBrandInstance}</th>
						
						</g:each>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${com.chakra.config.LinkMesh.list()}" status="i" var="linkMeshInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<%--<td>${fieldValue(bean: linkMeshInstance, field: "id")}</td>
					
						--%><td>${fieldValue(bean: linkMeshInstance, field: "holeSize")}</td>
						
						<td>${fieldValue(bean: linkMeshInstance, field: "wireDiameter")}</td>
					
						<%--<td>${fieldValue(bean: linkMeshInstance, field: "weight")}</td>
						
						--%><g:each in="${com.chakra.config.WireBrand.list()}" status="w" var="wireBrandInstance">
						
						<% 
							def wirePrice = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance,linkMeshInstance.wireDiameter)
					    %>
						<td><g:formatNumber number="${(linkMeshInstance?.weight * wirePrice?.price)}" type="number" maxFractionDigits="2" roundingMode="HALF_UP"/></td>
												
						</g:each>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<%--<ul>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
			<div class="pagination">
				<g:paginate total="${linkMeshInstanceTotal}" />
			</div>
		--%></div>
	</body>
</html>
