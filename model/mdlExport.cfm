<cfset oCharacter = new com.character(url.id)/>
<cfset oCharacter.setData()/>

<!---<cfdump var="#oCharacter#">--->
<cfdocument margintop="1" format="PDF">
<cfoutput>
<cfdocumentitem type="header"><center><img src="http://www.dragonagetools.com/images/sheet_header.png"/></center></cfdocumentitem>
<style>
	table {
		font-family: Verdana, Geneva, Arial, Helvetica, sans-serif;
	}
	td.focuslist {
		padding-left:30px;
		font-size: 12px;
	}
	td.heading {
		font-size:18px;
		font-weight: bolder;
	}
</style>
<table width="100%">
<tr><td colspan="3" class="heading">Character Information</td></tr>
<tr><td width="10%"><strong>Name:</strong></td><td>#oCharacter.getMetaData().character_name#</td></tr>
<tr><td><strong>Level:</strong></td><td>#oCharacter.getMetaData().level#</td></tr>
<tr><td><strong>Class:</strong></td><td>#oCharacter.getClass().class_name#</td></tr>
<tr><td><strong>HP:</strong></td><td>#oCharacter.getMetaData().hp#</td></tr>
<tr><td><strong>Mana:</strong></td><td>#oCharacter.getMetaData().mp#</td></tr>
<tr><td><strong>Background:</strong></td><td>#oCharacter.getBackground().bg_name#</td></tr>
<tr><td colspan="3">&nbsp;</td></tr>
<tr><td colspan="3" class="heading">Abilities</td></tr>
<tr><td colspan="2">
<cfset theQuery = oCharacter.getAbilities()/>
<table border="1">
<cfloop query="theQuery">
	<tr><td width="5%">#theQuery.ability_name#</td><td>#theQuery.value#</td></tr>
	<cfset focusQuery = oCharacter.getFocuses()/> 
	<cfquery name="focusQuery" dbtype="query">
		SELECT * from focusQuery
		WHERE fk_ability_id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#theQuery.fk_ability_id#"/> 
	</cfquery>
		<tr>		
		<td colspan="2" class="focuslist">
			<cfset focuslist = ""/>
			<cfloop query="focusQuery">
				<cfset focuslist = ListAppend(focusList,focusQuery.focus_name)/>
			</cfloop>
			&nbsp;#focuslist#
		</td>
		</tr>
</cfloop>
</table>
</td><td width="75%" valign="top">
	<table border="1">
	<tr><td colspan="2" class="heading">Talents</td></tr>
	<cfset theQuery = oCharacter.getTalents()/>
	<cfloop query="theQuery">
		<tr><td>#theQuery.talent_name#</td><td>#theQuery.rank#</td></tr>
	</cfloop>
	<tr><td colspan="2" class="heading">Weapon Groups</td></tr>
	<cfset theQuery = oCharacter.getWeaponGroups()/>
	<cfloop query="theQuery">
		<tr><td colspan="2">#theQuery.group_name#</td></tr>
	</cfloop>
	<tr><td colspan="2" class="heading">Spells</td></tr>
	<cfset theQuery = oCharacter.getSpells()/>
	<cfloop query="theQuery">
		<tr><td colspan="2">#theQuery.spell_name#</td></tr>
	</cfloop>
	</table>
</td></tr>
</table>
<cfdocumentitem type="footer">DragonAgeTools.com</cfdocumentitem>	
</cfoutput>
</cfdocument>
