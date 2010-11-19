<cfparam name="form.username" default="">
<cfparam name="form.password" default="">

<cfif len(form.username) && len(form.password)>	
	<cfset userID = request.oUtilities.checkLogin(form.username,form.password)/>
	<cfif userID>
		<cfset session.userID = userID/>
		<cflocation url="?action=console" addtoken="false"/>
		<cfabort>
	</cfif>
</cfif>

