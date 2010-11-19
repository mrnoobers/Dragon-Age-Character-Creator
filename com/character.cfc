<cfcomponent output="false" accessors="true">
	<cfproperty name="id" type="numeric" getter="true" setter="true">
	<cfproperty name="metaData" type="query" getter="true" setter="true">
	<cfproperty name="background" type="query" getter="true" setter="true">
	<cfproperty name="abilities" type="query" getter="true" setter="true">
	<cfproperty name="class" type="query" getter="true" setter="true">
	<cfproperty name="focuses" type="query" getter="true" setter="true">
	<cfproperty name="talents" type="query" getter="true" setter="true">
	<cfproperty name="weaponGroups" type="query" getter="true" setter="true">
	<cfproperty name="spells" type="query" getter="true" setter="true">
	
	<cffunction access="public" returntype="Any" name="init">
		<cfargument name="inID" type="numeric" required="true">
		
		<cfset this.setID(arguments.inID)/>
		
		<cfreturn this/>
	</cffunction>
	
	<cffunction access="public" name="setData">
		<cfset this.setMetaData(this.getCharMeta())/>
		<cfset this.setBackground(this.getCharBG())/>
		<cfset this.setAbilities(this.getCharAbil())/>
		<cfset this.setClass(this.getCharClass())/>
		<cfset this.setFocuses(this.getCharFocus())/>
		<cfset this.setTalents(this.getCharTalent())/>
		<cfset this.setWeaponGroups(this.getCharWG())/>
		<cfset this.setSpells(this.getCharSpells())/>
	</cffunction>
	<cffunction access="public" returntype="query" name="getCharSpells">
		<cfset var qSpells = ""/>
		
		<cfquery name="qSpells" datasource="dragonage">
			SELECT fk_spell_id,s.spell_name
			FROM char_spell_xref cpx
			INNER JOIN spells s on s.pk_spell_id = cpx.fk_spell_id
			WHERE fk_char_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.getId()#"/>
		</cfquery>
		
		<cfreturn qSpells/>
	</cffunction>
	<cffunction access="public" returntype="query" name="getCharBG">
		
		<cfset var qBG = ""/>
		
		<cfquery name="qBG" datasource="dragonage">
			SELECT fk_bg_id,bg.bg_name
			FROM char_bg_xref cbx
			INNER JOIN backgrounds bg on bg.pk_bg_id = cbx.fk_bg_id
			WHERE fk_char_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.getId()#"/>
		</cfquery>
		
		<cfreturn qBG/>
	</cffunction>
	
	<cffunction access="public" returntype="query" name="getCharAbil">
		
		<cfset var qAbil = ""/>
		
		<cfquery name="qAbil" datasource="dragonage">
			SELECT fk_ability_id,value,a.ability_name,a.shorthand
			FROM char_ability_xref cax
			INNER JOIN abilities a on a.pk_ability_id = cax.fk_ability_id
			WHERE fk_char_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.getId()#"/>
		</cfquery>
		
		<cfreturn qAbil/>
	</cffunction>
	
	<cffunction access="public" returntype="query" name="getCharClass">
		
		<cfset var qClass = ""/>
		
		<cfquery name="qClass" datasource="dragonage">
			SELECT fk_class_id,c.class_name
			FROM char_class_xref ccx
			INNER JOIN classes c on c.pk_class_id = ccx.fk_class_id
			WHERE fk_char_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.getId()#"/>
		</cfquery>
		
		<cfreturn qClass/>
	</cffunction>
	
	<cffunction access="public" returntype="query" name="getCharFocus">
		
		<cfset var qFocus = ""/>
		
		<cfquery name="qFocus" datasource="dragonage">
			SELECT fk_focus_id, f.focus_name,f.fk_ability_id
			FROM char_focus_xref cfx
			INNER JOIN focuses f on f.pk_focus_id = cfx.fk_focus_id
			WHERE fk_char_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.getId()#"/>
		</cfquery>
		
		<cfreturn qFocus/>
	</cffunction>
	
	<cffunction access="public" returntype="query" name="getCharTalent">
		
		<cfset var qTalent = ""/>
		
		<cfquery name="qTalent" datasource="dragonage">
			SELECT talent_name,fk_talent_id,fk_rank_id,tr.rank
			FROM char_talent_xref ctx
			INNER JOIN talents t on t.pk_talent_id = ctx.fk_talent_id
			INNER JOIN talent_ranks tr on tr.pk_rank_id = ctx.fk_rank_id
			WHERE fk_char_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.getId()#"/>
		</cfquery>
		
		<cfreturn qTalent/>
	</cffunction>
	
	<cffunction access="public" returntype="query" name="getCharWG">
		
		<cfset var qWG = ""/>
		
		<cfquery name="qWG" datasource="dragonage">
			SELECT fk_weapongroup_id,wg.group_name
			FROM char_weapongroup_xref cwx
			INNER JOIN weapon_groups wg on wg.pk_weapongroup_id = cwx.fk_weapongroup_id
			WHERE fk_char_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.getId()#"/>
		</cfquery>
		
		<cfreturn qWG/>
	</cffunction>
	
	<cffunction name="getCharMeta" returntype="Query" access="public">
		<cfset var qChar = ""/>
		
		<cfquery name="qChar" datasource="dragonage">
			SELECT character_name,level,hp,mp
			FROM characters
			WHERE pk_char_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.getId()#"/>
		</cfquery>
		
		<cfreturn qChar/>
	</cffunction>
	
	<cffunction name="setCharClass" access="public">
		<cfargument name="inID" required="true" type="numeric">
		
		<cfset var qUpdate = ""/>
		<cfset var qCheck = ""/>
		<cfset var qInsert = ""/>
		
		<cfquery name="qCheck" datasource="dragonage">
			SELECT 1 from char_class_xref
			WHERE fk_char_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.getId()#"/>
		</cfquery>
		
		<cfif qCheck.recordcount>
			<cfquery name="qUpdate" datasource="dragonage">
				UPDATE char_class_xref
				SET fk_class_id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.inID#"/>
				WHERE fk_char_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.getId()#"/>
			</cfquery>
		<cfelse>
			<cfquery name="qInsert" datasource="dragonage">
				INSERT INTO char_class_xref (fk_class_id,fk_char_id)
				VALUES(<cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.inID#"/>,<cfqueryparam cfsqltype="cf_sql_varchar" value="#this.getId()#"/>)
			</cfquery>
		</cfif>
		
	</cffunction>
	
	<cffunction name="setCharBG" access="public">
		<cfargument name="inID" required="true" type="numeric">
		
		<cfset var qUpdate = ""/>
		<cfset var qCheck = ""/>
		<cfset var qInsert = ""/>
		
		<cfquery name="qCheck" datasource="dragonage">
			SELECT 1 from char_bg_xref
			WHERE fk_char_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.getId()#"/>
		</cfquery>
		
		<cfif qCheck.recordcount>
			<cfquery name="qUpdate" datasource="dragonage">
				UPDATE char_bg_xref
				SET fk_bg_id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.inID#"/>
				WHERE fk_char_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.getId()#"/>
			</cfquery>
		<cfelse>
			<cfquery name="qInsert" datasource="dragonage">
				INSERT INTO char_bg_xref (fk_bg_id,fk_char_id)
				VALUES(<cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.inID#"/>,<cfqueryparam cfsqltype="cf_sql_varchar" value="#this.getId()#"/>)
			</cfquery>
		</cfif>
		
	</cffunction>
	
	<cffunction name="setCharAbil" access="public">
		<cfargument name="inID" required="true" type="numeric">
		<cfargument name="inValue" required="true" type="numeric">
		
		<cfset var qUpdate = ""/>
		<cfset var qCheck = ""/>
		<cfset var qInsert = ""/>
		
		<cfquery name="qCheck" datasource="dragonage">
			SELECT 1 from char_ability_xref
			WHERE fk_char_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.getId()#"/>
			AND fk_ability_id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.inID#"/>
		</cfquery>
		
		<cfif qCheck.recordcount>
			<cfquery name="qUpdate" datasource="dragonage">
				UPDATE char_ability_xref
				SET value = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.inValue#"/>
				WHERE fk_char_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.getId()#"/>
				AND fk_ability_id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.inID#"/>
			</cfquery>
		<cfelse>
			<cfquery name="qInsert" datasource="dragonage">
				INSERT INTO char_ability_xref (fk_ability_id,value,fk_char_id)
				VALUES(<cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.inID#"/>,<cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.inValue#"/>,<cfqueryparam cfsqltype="cf_sql_varchar" value="#this.getId()#"/>)
			</cfquery>
		</cfif>
		
	</cffunction>
	
	<cffunction name="setCharFocus" access="public">
		<cfargument name="inID" required="true" type="numeric">
		
		<cfset var qInsert = "">
		
		<cfquery name="qInsert" datasource="dragonage">
			INSERT INTO char_focus_xref (fk_focus_id,fk_char_id)
			VALUES(<cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.inID#"/>,<cfqueryparam cfsqltype="cf_sql_varchar" value="#this.getId()#"/>)
		</cfquery>
		
	</cffunction>
	
	<cffunction name="setCharWG" access="public">
		<cfargument name="inID" required="true" type="numeric">
		
		<cfset var qInsert = "">
		
		<cfquery name="qInsert" datasource="dragonage">
			INSERT INTO char_weapongroup_xref (fk_weapongroup_id,fk_char_id)
			VALUES(<cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.inID#"/>,<cfqueryparam cfsqltype="cf_sql_varchar" value="#this.getId()#"/>)
		</cfquery>
		
	</cffunction>
	
	<cffunction name="setCharMeta" access="public">
		<cfargument name="charName" required="true" type="string">
		<cfargument name="charLevel" required="true" type="numeric">
		<cfargument name="charHP" required="true" type="numeric">
		<cfargument name="charMP" required="true" type="numeric">
		
		<cfset var qUpdate = ""/>
		
		<cfquery name="qUpdate" datasource="dragonage">
			UPDATE characters
			SET character_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.charName#"/>,
			level = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.charlevel#"/>,
			hp = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.charHP#"/>,
			mp = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.charMP#"/>
			WHERE pk_char_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.getId()#"/>
		</cfquery>
	</cffunction>
	
	<cffunction name="setCharTalent" access="public">
		<cfargument name="talentID" required="true" type="numeric">
		<cfargument name="rankID" required="true" type="numeric">
		
		<cfset var qCheck = ""/>
		<cfset var qData = ""/>
		
		<cfquery name="qCheck" datasource="dragonage">
			SELECT 1 from char_talent_xref
			WHERE fk_talent_id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.talentID#">
			AND fk_char_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.getId()#"/>
		</cfquery>
		
		<cfif qCheck.recordcount>
			<cfquery name="qData" datasource="dragonage">
				UPDATE char_talent_xref
				SET fk_rank_id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.rankID#">
				WHERE fk_talent_id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.talentID#">
				AND fk_char_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.getId()#"/>
			</cfquery>
		<cfelse>
			<cfquery name="qData" datasource="dragonage">
				INSERT INTO char_talent_xref (fk_char_id,fk_talent_id,fk_rank_id)
				VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#this.getId()#"/>,
				<cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.talentID#">,
				<cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.rankID#">)
			</cfquery>
		</cfif>
	</cffunction>
	
	<cffunction name="deleteFocus" access="public">
		<cfargument name="inID" type="numeric" required="true">
		
		<cfset qData = ""/>
		
		<cfquery name="qData" datasource="dragonage">
			DELETE FROM char_focus_xref
			WHERE fk_char_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.getId()#"/>
			AND fk_focus_id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.inID#"/>
		</cfquery>
		
	</cffunction>
	
	<cffunction name="deleteWG" access="public">
		<cfargument name="inID" type="numeric" required="true">
		
		<cfset qData = ""/>
		
		<cfquery name="qData" datasource="dragonage">
			DELETE FROM char_weapongroup_xref
			WHERE fk_char_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.getId()#"/>
			AND fk_weapongroup_id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.inID#"/>
		</cfquery>
		
	</cffunction>
	
	<cffunction name="deleteTalent" access="public">
		<cfargument name="inID" type="numeric" required="true">
		
		<cfset qData = ""/>
		
		<cfquery name="qData" datasource="dragonage">
			DELETE FROM char_talent_xref
			WHERE fk_char_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.getId()#"/>
			AND fk_talent_id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.inID#"/>
		</cfquery>
		
	</cffunction>
</cfcomponent>