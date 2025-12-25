
<%@ page import="com.chakra.order.CorderMeshParts" %>
<%@ page import="com.chakra.config.WireBrand" %>

<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'orderMeshParts.label', default: 'OrderMeshParts')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-orderMeshParts" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-orderMeshParts" class="content scaffold-list" role="main">
			<h1><g:message code="default.pendingMeshParts.label" args="[entityName]" default="Pending Mesh Parts Report"/></h1>
			<g:if test="${flash.message}">
			<div class="alert alert-error" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
						
						<g:sortableColumn property="sheetName" title="${message(code: 'sheetSpecification.sheetName.label', default: 'Sheet Id')}" />
																
						<g:sortableColumn property="sheetName" title="${message(code: 'sheetSpecification.sheetName.label', default: 'Sheet Name')}" />
						
						<g:each in="${wireBrandInstanceList}" status="i" var="wireBrandInstance">
										
							<th>${wireBrandInstance}</th>
												
						</g:each>
											
						
						
					</tr>
				</thead>
				<tbody>
				<% int temp = 0 %>
				
				<%  String text = null
					WireBrand wireBrand = null
					
				 %>
				
				<g:each in="${orderMeshPartsInstanceList}" status="i" var="orderMeshPartsInstance">
								
				    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
				 				
						 	
							<%-- <td>${orderMeshPartsInstance[0]}</td> --%>
						 	<td>${orderMeshPartsInstance[1].sheetSpecId}</td>
						 	<td>${orderMeshPartsInstance[1]}</td>
						 	
						 	<g:each in="${wireBrandInstanceList}" status="j" var="wireBrandInstance">
								<% wireBrand = wireBrandInstanceList.get(j)  %>
						 		<td><g:link controller="corder" action="corderAwaitingParts" params="["sheetSpecification": orderMeshPartsInstance[1].id,"wireBrand": wireBrand.id]">${orderMeshPartsInstance[2 + j]}</g:link></td>
							</g:each>
								    
				      <%-- <td><g:link controller="corder" action="corderAwaitingParts" params="["sheetSpecification":orderMeshPartsInstance[0].id,"wireBrand":orderMeshPartsInstance[1].id]">${orderMeshPartsInstance[2]}</g:link></td>--%> 
				       
				    </tr>  
				</g:each>
				</tbody>
			</table>
			<%--<div class="pagination">
				<g:paginate total="${orderMeshPartsInstanceTotal}" />
			</div>
			 --%>
		</div>
	</body>
</html>
