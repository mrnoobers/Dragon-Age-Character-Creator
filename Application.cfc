<cfcomponent output="false">

	<cfset this.name = "DragonAgeCC">
	<cfset this.sessionManagement = true/>
	<cfset this.sessionTimeout = createTimespan(0,2,0,0)/>
	
	
	<cffunction name="onApplicationStart" output="true">	
		
	</cffunction>
	<!---------------------------------------------------------------------------------------->
	<cffunction name="onRequestStart" output="false">
		
		<cfset request.oUtilities = createObject("component","com.utilities").init()/>
		<cfif !structkeyexists(session,"userID")>
			<cfset url.action = "login"/>
		</cfif>
	</cffunction>
	<!---------------------------------------------------------------------------------------->
	<cffunction name="onError">
		<cfargument name="Exception" required=true/>
		<cfargument name="EventName" type="String" required=true/>

		<cfthrow object="#arguments.exception#">
	</cffunction>

	<!---------------------------------------------------------------------------------------->

</cfcomponent>