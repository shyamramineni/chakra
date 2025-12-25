<%@ page import="com.chakra.enquiry.Enquiry" %>
<%@ page import="com.chakra.security.*" %>







<div class="fieldcontain ${hasErrors(bean: enquiryInstance, field: 'assigned', 'error')} required">
	<label for="assigned">
		<g:message code="enquiry.assigned.label" default="Assigned" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="assigned" name="assigned.id" from="${UserRole.findAllByRole(Role.findByAuthority("ROLE_SALES"))}" optionValue="user" required="" value="${enquiryInstance?.assigned?.id}" optionKey="${{it.user?.id}}" class="many-to-one"/>
</div>



