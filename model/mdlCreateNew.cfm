<cfparam name="form.charname" default="">

<cfif len(form.charname)>
	<cfset request.oUtilities.createCharacter(form.charName)/>	
</cfif>
<cflocation addtoken="false" url="?action=console"/>

