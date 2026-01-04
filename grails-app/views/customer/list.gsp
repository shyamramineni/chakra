
<%@ page import="com.chakra.customer.Customer"%>
<!doctype html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName"
	value="${message(code: 'customer.label', default: 'Customer')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
	<%--<a href="#list-customer" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		--%>
	<div class="nav" role="navigation">
		<%--
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				--%>

		<li><g:link class="create" action="create">
				<g:message code="default.new.label" args="[entityName]" />
			</g:link></li>
		<%--<li><g:link action="search">Search</g:link></li>
			
		--%>
	</div>
	<%--<ul>
		<li>
				<g:link class="create" action="create">
					<g:message code="default.new.label" args="[entityName]" />
				</g:link>
			</li>
	</ul>
	--%><div id="list-customer" class="content scaffold-list" role="main">
		<h2>
			<g:message code="default.list.label" args="[entityName]" />
		</h2>
		<g:if test="${flash.message}">
			<div class="message" role="status">
				${flash.message}
			</div>
		</g:if>

		<table class="table table-bordered table-striped table-condensed">
			<thead>
				<tr>
						<th><g:message code="customer.customerId.label" default="Customer Id" /></th>
						
						<th><g:message code="customer.companyName.label" default="Company Name" /></th>
											
						<th><g:message code="customer.customerName.label" default="Customer Name" /></th>
						
						<th><g:message code="customer.mobileNumber.label" default="Mobile Number" /></th>
												
						<%--<th><g:message code="customer.email.label" default="Email" /></th>
											
						--%><th><g:message code="customer.address.label" default="Address" />
						
						<%--<th><g:message code="customer.fax.label" default= "Fax" /></th>
						
						--%><th><g:message code="customer.fax.label" default= "Action" /></th>
					
				</tr>
			</thead>
				<tr>
				      <g:form action="list" >	
				          
					    <td><g:textField class="span2" id="customerId" name="customerId" value="" /></td></td>
					    						
						<td><g:textField class="span2" id="companyName" name="companyName" value="" /></td>

						<td><g:textField class="span2" id="customerName" name="customerName" value="" /></td>

						<td><g:textField class="span2" id="mobileNumber" name="mobileNumber" value="" /></td>
		
						<td><g:textField class="span2" id="address" name="address" value="" /></td>
															
						<td><g:submitButton name="search" class="btn btn-primary" value="${message(code: 'default.button.search.label', default: 'Search')}" /></td>
						
					  </g:form>	
					</tr>
				<%--
				<tr>
					<g:form action="list">
						<form class="well form-inline">
							<td><g:textField class="span2" id="customerId" name="customerId" placeholder="SEARCH" value="" /></td>
						</form>
						<td><g:textField class="span2" id="companyName" name="companyName" value="" /></td>

						<td><g:textField class="span2" id="customerName" name="customerName" value="" /></td>

						<td><g:textField class="span2" id="mobileNumber" name="mobileNumber" value="" /></td>

						<td><g:textField id="email" name="email"  value="" /></td>

						<td><g:textField class="span2" id="address" name="address" value="" /></td>

						<td><g:textField id="fax" name="fax"  value="" /></td>
						<td><g:submitButton name="search" class="btn-primary" value="${message(code: 'default.button.search.label', default: 'Search')}" />
							</td>
					</g:form>
				</tr>
					
				--%><tbody>
				<g:each in="${customerInstanceList}" status="i"
					var="customerInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

						<td><g:link action="show" id="${customerInstance.id}">
								${fieldValue(bean: customerInstance, field: "customerId")}
							</g:link></td>

						<td>
							${fieldValue(bean: customerInstance, field: "companyName")}
						</td>

						<td>
							${fieldValue(bean: customerInstance, field: "customerName")}
						</td>

						<td>
							${fieldValue(bean: customerInstance, field: "mobileNumber")}
						</td>

						<%--<td>${fieldValue(bean: customerInstance, field: "email")}</td>--%>

						<td>
							${fieldValue(bean: customerInstance, field: "address")}
						</td>

						<%--<td>${fieldValue(bean: customerInstance, field: "fax")}</td>
						
						--%>
						<td>
							
								<g:link action="create" controller="enquiry" params="['customer.id': customerInstance?.id]">Create Enquiry</g:link>
							<br> 
							<%--
								<g:link action="create" controller="quotation"	params="['customer.id': customerInstance?.id]">Create Quotation</g:link>
							
						--%></td>

					</tr>
				</g:each>
			</tbody>

		</table>
		<%--<ul>
			<li><g:link action="search">Search Customer</g:link></li>
		</ul>
		--%>
		<ul>
			<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
		</ul>
		<div class="pagination">
			<g:paginate total="${customerInstanceTotal}" />
		</div>
	</div>
</body>
</html>
