<cfparam name="url.action" default="login">

<cfset pageStruct = new com.controller(url.action)/>



<cfinclude template="model/#pageStruct.model#"/>
<cfinclude template="include/header.cfm"/>
<cfif len(pageStruct.view)>
	<cfinclude template="view/#pageStruct.view#"/>
</cfif>
<cfinclude template="include/footer.cfm"/>
