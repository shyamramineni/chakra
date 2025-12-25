<%@ page import="com.chakra.config.CagePartType" %>



<%--<div class="fieldcontain ${hasErrors(bean: cagePartTypeInstance, field: 'cagePartSpecifications', 'error')} ">
	<label for="cagePartSpecifications">
		<g:message code="cagePartType.cagePartSpecifications.label" default="Cage Part Specifications" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${cagePartTypeInstance?.cagePartSpecifications?}" var="c">
    <li><g:link controller="cagePartSpecification" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="cagePartSpecification" action="create" params="['cagePartType.id': cagePartTypeInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'cagePartSpecification.label', default: 'CagePartSpecification')])}</g:link>
</li>
</ul>

</div>

--%><div class="fieldcontain ${hasErrors(bean: cagePartTypeInstance, field: 'cagePartType', 'error')} ">
	<label for="cagePartType">
		<g:message code="cagePartType.cagePartType.label" default="Cage Part Type" />
		
	</label>
	<g:textField name="cagePartType" value="${cagePartTypeInstance?.cagePartType}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cagePartTypeInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="cagePartType.description.label" default="Description" />
		
	</label>
	<g:textArea name="description" value="${cagePartTypeInstance?.description}"/>
</div>

