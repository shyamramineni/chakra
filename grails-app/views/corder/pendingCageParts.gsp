
<%@ page import="com.chakra.order.CorderCageParts" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'orderCageParts.label', default: 'OrderCageParts')}" />
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
			<h2><g:message code="default.pendingCageParts.label" args="[entityName]" default="Pending Cage Parts Report"/></h2>
			<g:if test="${flash.message}">
			<div class="alert alert-error" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
				<thead>
					<tr>
						
						<g:sortableColumn property="cagePartSpecFormula" title="${message(code: 'corderCageParts.cagePartSpecFormula.label', default: 'Cage Part Spec Formula')}" />
					    
					    <th><g:message code="corderCageParts.noOfCageParts.label" default="No Of Cage Parts" /></th>
					
					</tr>
				</thead>
				<tbody>
				
				<g:each in="${orderCagePartsInstanceList}" status="i" var="orderCagePartsInstance">
										
				    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
				 
				       <td>${orderCagePartsInstance[0]}</td>
												    
				       <td><g:link action="corderCageParts" controller="corder" params="["cagePart": orderCagePartsInstance[0].id]">${orderCagePartsInstance[1]}</g:link></td>
			    		
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
