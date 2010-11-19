<cfcomponent  output="false">

	<cffunction name="init" access="public" returntype="any">	
		<cfreturn this/>	
	</cffunction>
	<cffunction access="public" returntype="numeric" name="checkLogin">
		<cfargument name="inusername" required="true" type="string">
		<Cfargument name="inpassword" required="true" type="string">
		
		<cfset var qLogin = ""/>
		
		<cfquery name="qLogin" datasource="dragonage">
			select pk_user_id FROM users 
			WHERE username = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.inusername#"/>
			AND password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.inpassword#"/>
		</cfquery>
		
		<cfif qLogin.recordcount>
			<cfreturn qLogin.pk_user_id/>
		<cfelse>
			<cfreturn 0/>
		</cfif>
	</cffunction>	
	
	<cffunction access="public" returntype="query" name="getCharacters">
		
		<cfset var qChars = ""/>
		
		<cfquery name="qChars" datasource="dragonage">
			SELECT pk_char_id,character_name
			FROM characters
			WHERE fk_user_id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#session.userid#"/>
		</cfquery>
		
		<cfreturn qChars/>
	</cffunction>
	
	<cffunction access="public" name="createCharacter">
		<cfargument name="inName" required="true" type="string">
		<cfset var qCreate = ""/>
		
		<cfquery name="qCreate" datasource="dragonage">
			INSERT INTO characters (character_name,fk_user_id)
			VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.inName#">,
			<cfqueryparam cfsqltype="cf_sql_numeric" value="#session.userid#"/>)			
		</cfquery>
		
	</cffunction>
	
	<cffunction name="getAbilities" access="public" returntype="Query">
		<cfset var qData = ""/>
		
		<cfquery name="qData" datasource="dragonage">
			SELECT pk_ability_id,ability_name,shorthand
			FROM abilities
		</cfquery>
		
		<cfreturn qData/>
	</cffunction>
	
	<cffunction name="getBackgrounds" access="public" returntype="Query">
		<cfset var qData = ""/>
		
		<cfquery name="qData" datasource="dragonage">
			SELECT pk_bg_id,bg_name
			FROM backgrounds
		</cfquery>
		
		<cfreturn qData/>
	</cffunction>
	
	<cffunction name="getClasses" access="public" returntype="Query">
		<cfset var qData = ""/>
		
		<cfquery name="qData" datasource="dragonage">
			SELECT pk_class_id,class_name
			FROM classes
		</cfquery>
		
		<cfreturn qData/>
	</cffunction>
	
	<cffunction name="getFocuses" access="public" returntype="Query">
		<cfset var qData = ""/>
		
		<cfquery name="qData" datasource="dragonage">
			SELECT a.ability_name,pk_focus_id,focus_name,fk_ability_id
			FROM focuses f
			INNER JOIN abilities a on a.pk_ability_id = f.fk_ability_id
			order by a.ability_name
		</cfquery>
		
		<cfreturn qData/>
	</cffunction>
	
	<cffunction name="getTalents" access="public" returntype="Query">
		<cfset var qData = ""/>
		
		<cfquery name="qData" datasource="dragonage">
			SELECT pk_talent_id,talent_name
			FROM talents
		</cfquery>
		
		<cfreturn qData/>
	</cffunction>
	
	<cffunction name="getTalentRanks" access="public" returntype="Query">
		<cfset var qData = ""/>
		
		<cfquery name="qData" datasource="dragonage">
			SELECT pk_rank_id,rank
			FROM talent_ranks
		</cfquery>
		
		<cfreturn qData/>
	</cffunction>
	
	<cffunction name="getWeaponGroups" access="public" returntype="Query">
		<cfset var qData = ""/>
		
		<cfquery name="qData" datasource="dragonage">
			SELECT pk_weapongroup_id,group_name
			FROM weapon_groups
		</cfquery>
		
		<cfreturn qData/>
	</cffunction>
</cfcomponent>