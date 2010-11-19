<cfoutput>
<script>
	var talentRanks =[];
	<cfloop query="sConstants.talentRanks">
		talentRanks.push("#sConstants.talentRanks.pk_rank_id#-#sConstants.talentRanks.rank#")
	</cfloop>
</script>
<form method="post">
<input type="hidden" id="charID" name="charID" value="#oCharacter.getID()#"/>
<input type="hidden" id="curr_characterClass" name="curr_characterClass" value="#oCharacter.getClass().fk_class_id#"/>
<input type="hidden" id="curr_characterBG" name="curr_characterBackground" value="#oCharacter.getBackground().fk_bg_id#"/>
<cfset theQuery = oCharacter.getAbilities()/>
<cfloop query="theQuery">
	<input type="hidden" name="curr_ability#theQuery.fk_ability_id#" id="curr_ability#theQuery.fk_ability_id#" value="#theQuery.value#"/>
</cfloop>
<strong>Character Name: </strong><input type="text" id="charName" name="charName" value="#oCharacter.getMetaData().character_name#"/><br/>
<strong>Level: </strong> <input type="text" id="charLevel" name="charLevel" value="#oCharacter.getMetaData().level#" size="2" maxlength="2"/><br/>
<strong>Character Class:</strong> 
<select name="characterClass">
	<cfset theQuery = sConstants.classes/>	
	<cfset theClass = oCharacter.getClass()/>
	<cfif !theClass.recordcount>
		<option value="" selected="selected">You need to select a class!</option>
	</cfif>
	<cfloop query="theQuery">
		<option value="#theQuery.pk_class_id#" <cfif theClass.fk_class_id eq theQuery.pk_class_id>selected="selected"</cfif>>#theQuery.class_name#</option>
	</cfloop>
</select><br/>
<strong>HP: </strong> <input type="text" id="charHP" name="charHP" value="#oCharacter.getMetaData().hp#" size="3" maxlength="3"/><br/>
<strong>Mana: </strong> <input type="text" id="charMP" name="charMP" value="#oCharacter.getMetaData().mp#" size="3" maxlength="3"/><br/>
<strong>Character Background:</strong> 
<select name="characterBackground">
	<cfset theQuery = sConstants.backgrounds/>	
	<cfset theBG = oCharacter.getBackground()/>
	<cfif !theBG.recordcount>
		<option value="" selected="selected">You need to select a background!</option>
	</cfif>
	<cfloop query="theQuery">
		<option value="#theQuery.pk_bg_id#" <cfif theBG.fk_bg_id eq theQuery.pk_bg_id>selected="selected"</cfif>>#theQuery.bg_name#</option>
	</cfloop>
</select><br/>
<h3>Abilities</h3>
<cfset theQuery = oCharacter.getAbilities()/>
<cfset x = oCharacter.getFocuses()/>
<input type="hidden" id="curr_focuses" name="curr_focuses" value="#ValueList(x.fk_focus_id)#"/>
<input type="hidden" id="new_focuses" name="new_focuses" value=""/>
<input type="hidden" id="delete_focuses" name="delete_focuses" value=""/>
<cfif x.recordcount>
	<cfquery name="focusQuery" dbtype="query">
		SELECT pk_focus_id,fk_ability_id,focus_name
		FROM sConstants.focuses
		WHERE pk_focus_id IN (<cfqueryparam cfsqltype="cf_sql_numeric" value="#ValueList(x.fk_focus_id)#" list="true"/>)		
	</cfquery>
<cfelse>
	<cfset focusQuery = querynew("pk_focus_id,fk_ability_id,focus_name")/>
</cfif>
<cfloop query="sConstants.abilities">
	<cfquery name="qAbil" dbtype="query">
		SELECT * from thequery
		WHERE fk_ability_id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#sConstants.abilities.pk_ability_id#"/>
	</cfquery>
	#sConstants.abilities.ability_name#: <input value="#qAbil.value#" type="text" name="ability#sConstants.abilities.pk_ability_id#" size="2" maxlength="2"/><br/>
	<cfquery name="focusHolder" dbtype="query">
		SELECT * from focusquery
		WHERE fk_ability_id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#sConstants.abilities.pk_ability_id#"/>
	</cfquery>		
	Focuses: <div id="focusSpan#sConstants.abilities.pk_ability_id#"><cfloop query="focusHolder"><span class="focusDelete" focusid="#focusHolder.pk_focus_id#">#focusHolder.focus_name#</span> </cfloop></div>
</cfloop>

<cfset current = ""/>
<label>Add a new focus:</label>
<select name="focusList" id="focusList">
	<option value="" selected="selected">Select a focus</option>
	<cfset current = sConstants.focuses.fk_ability_id/>
	<optgroup label="#sConstants.focuses.ability_name#" id="#sConstants.focuses.fk_ability_id#">
	<cfloop query="sConstants.focuses">
		
		<cfif sConstants.focuses.fk_ability_id neq current>
			<cfset current = sConstants.focuses.fk_ability_id/>
			</optgroup><optgroup label="#sConstants.focuses.ability_name#" id="#sConstants.focuses.fk_ability_id#">
		</cfif>
		<option value="#sConstants.focuses.pk_focus_id#">#sConstants.focuses.focus_name#</option>
	</cfloop>
</optgroup></select> <input type="button" id="focusBut" name="focusBut" value="Add"/>
<h3>Talents</h3>

<cfset talents = oCharacter.getTalents()/>
<cfset currentTalents = ""/>
<cfloop query="talents">
	<cfset currentTalents = ListAppend(currentTalents,"#talents.fk_talent_id#")/>
</cfloop>
<input type="hidden" id="curr_talents" name="curr_talents" value="#currentTalents#"/>
<input type="hidden" id="new_talents" name="new_talents" value=""/>
<input type="hidden" id="delete_talents" name="delete_talents" value=""/>
<table id="talentTable">
<cfloop query="talents">
	<tr><td class="talentName">#talents.talent_name#</td><td>
		<select name="talent#talents.fk_talent_id#">
			<cfloop query="sConstants.talentRanks">
				<option value="#sConstants.talentRanks.pk_rank_id#" <cfif talents.fk_rank_id eq sConstants.talentRanks.pk_rank_id>selected="selected"</cfif>>#sConstants.talentRanks.rank#</option>
			</cfloop>
		</select>
	</td>
	<td class="talentDelete" talentID="#talents.fk_talent_id#">
		Remove
	</td>
	</tr>
</cfloop>
</table>
<label>Add a new Talent:</label>
<select name="talentList" id="talentList">
	<cfloop query="sConstants.talents">
		<option value="#sConstants.talents.pk_talent_id#">#sConstants.talents.talent_name#</option>
	</cfloop>
</select>	<input type="button" id="talentBut" name="talentBut" value="Add"/>

<h3>Weapon Groups</h3>

<cfset wgs = oCharacter.getWeaponGroups()/>
<cfset currentWGs = ""/>
<cfloop query="wgs">
	<cfset currentWGs = ListAppend(currentWGs,wgs.fk_weapongroup_id)/>
</cfloop>
<input type="hidden" id="curr_wg" name="curr_wg" value="#currentWGs#"/>
<input type="hidden" id="new_wg" name="new_wg" value=""/>
<input type="hidden" id="delete_wg" name="delete_wg" value=""/>
<table id="wgTable">
<cfloop query="wgs">
	<tr><td class="wgName">#wgs.group_name#</td><td class="wgDelete" wgID="#wgs.fk_weapongroup_id#">Remove</td></tr>
</cfloop>
</table>
<label>Add a new Weapon Group:</label>
<select name="wgList" id="wgList">
	<cfloop query="sConstants.weapongroups">
		<option value="#sConstants.weapongroups.pk_weapongroup_id#">#sConstants.weapongroups.group_name#</option>
	</cfloop>
</select>	<input type="button" id="wgBut" name="wgBut" value="Add"/>
<br/><br/>

<input type="submit" value="Edit" id="submit" name="submit"/>
</form>

<a href="?action=console">Back To Main</a>
</cfoutput>