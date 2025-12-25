<%@ page import="com.chakra.security.User" %>



<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'username', 'error')} required">
	<label for="username">
		<g:message code="user.username.label" default="Username" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="username" required="" value="${userInstance?.username}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required">
	<label for="password">
		<g:message code="user.password.label" default="Password" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="password" required="" value=""/>
</div>

<div class="help-block" class="checkbox ${hasErrors(bean: userInstance, field: 'accountExpired', 'error')} ">

	<label for="accountExpired">
		<g:message code="user.accountExpired.label" default="Account Expired" />
		
	</label>
	<g:checkBox name="accountExpired" value="${userInstance?.accountExpired}" />
</div>

<div class="help-block" class="checkbox ${hasErrors(bean: userInstance, field: 'accountLocked', 'error')} ">

	<label for="accountLocked">
		<g:message code="user.accountLocked.label" default="Account Locked" />
		
	</label>
	<g:checkBox name="accountLocked" value="${userInstance?.accountLocked}" />
</div>

<div class="help-block" class="checkbox ${hasErrors(bean: userInstance, field: 'enabled', 'error')} ">
	<label for="enabled">
		<g:message code="user.enabled.label" default="Enabled" />
		
	</label>
	<g:checkBox name="enabled" value="${userInstance?.enabled}" />
</div>

<div class="help-block" class="checkbox ${hasErrors(bean: userInstance, field: 'passwordExpired', 'error')} ">
	<label for="passwordExpired">
		<g:message code="user.passwordExpired.label" default="Password Expired" />
		
	</label>
	<g:checkBox name="passwordExpired" value="${userInstance?.passwordExpired}" />
</div>

<%--<div
	class="fieldcontain ${hasErrors(bean: enquiryInstance, field: 'cagePartTypeList', 'error')} ">
	<label for="cagePartTypeList"> <g:message
			code="enquiry.cagePartTypeList.label" default="Cage Part Type List" />

	</label>
	<g:select name="cagePartTypeList"
		from="${com.chakra.config.CagePartType.list()}" multiple="multiple"
		optionKey="id" size="5"
		value="${enquiryInstance?.cagePartTypeList*.id}" class="many-to-many" />
</div>

--%>