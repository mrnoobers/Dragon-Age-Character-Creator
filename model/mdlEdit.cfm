
<cfset sConstants = {abilities=request.oUtilities.getAbilities(),Backgrounds=request.oUtilities.getBackgrounds(),Classes=request.oUtilities.getClasses(),focuses=request.oUtilities.getFocuses(),talents=request.oUtilities.getTalents(),talentRanks=request.oUtilities.getTalentRanks(),weapongroups=request.oUtilities.getWeaponGroups()}/>
<cfloop query="sConstants.abilities">
	<cfparam name="form.curr_ability#sConstants.abilities.pk_ability_id#" default=""/>
</cfloop>
<cfset oCharacter = new com.character(url.id)/>

<cfif structkeyexists(form,"submit")>
	<cfset oCharacter.setCharMeta(form.charName,form.charLevel,form.charHP,form.charMP)/>
	<cfloop list="#form.delete_talents#" index="i">
		<cfset oCharacter.deleteTalent(i)/>
	</cfloop>
	<cfset talentList = ListAppend(form.new_talents,form.curr_talents)/>
	<cfloop list="#talentList#" index="i">
		<cfif structkeyexists(form,"talent#i#")>
			<cfset oCharacter.setCharTalent(i,form["talent#i#"])/>
		</cfif>
	</cfloop>	
	<cfif form.characterclass neq form.curr_characterClass>
		<cfset oCharacter.setCharClass(form.characterclass)/>
	</cfif>
	<cfif form.characterBackground neq form.curr_characterBackground>
		<cfset oCharacter.setCharBG(form.characterBackground)/>
	</cfif>
	<cfif len(form.delete_focuses)>
		<cfloop list="#form.delete_focuses#" index="i">
			<cfset oCharacter.deleteFocus(i)/>
		</cfloop>
	</cfif>
	<cfif len(form.delete_wg)>
		<cfloop list="#form.delete_wg#" index="i">
			<cfset oCharacter.deleteWG(i)/>
		</cfloop>
	</cfif>
	<cfif len(form.new_focuses)>
		<cfloop list="#form.new_focuses#" index="i">
			<cfset oCharacter.setCharFocus(i)/>
		</cfloop>
	</cfif>
	<cfif len(form.new_wg)>
		<cfloop list="#form.new_wg#" index="i">
			<cfset oCharacter.setCharWG(i)/>
		</cfloop>
	</cfif>
	<cfloop query="sConstants.abilities">
		<cfif form["curr_ability#sConstants.abilities.pk_ability_id#"] neq form["ability#sConstants.abilities.pk_ability_id#"]>
			<cfset oCharacter.setCharAbil(sConstants.abilities.pk_ability_id,form["ability#sConstants.abilities.pk_ability_id#"])/>
		</cfif>
	</cfloop>
</cfif>

<cfset oCharacter.setData()/>

<cfif !structkeyexists(request,"js")>
	<cfset request.js = []/>
</cfif>

<cfset ArrayAppend(request.js,"js/edit.js")/>
<!---<cfdump var="#sConstants#"/>--->
<!---<cfdump var="#oCharacter#">--->
