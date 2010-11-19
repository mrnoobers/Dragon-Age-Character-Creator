<h3>Your Characters</h3>
<cfif !qChars.recordcount>
	Looks like you don't have any characters!  Let's create one below!
<cfelse>
	<cfoutput>
	<ul>
	<cfloop query="qChars">
		<li><a href="?action=edit&id=#qChars.pk_char_id#">#qChars.character_name#</a> ---  <a href="?action=export&id=#qChars.pk_char_id#">Export</a></li>
	</cfloop>
	</ul>
	</cfoutput>
</cfif>
<br/>
<h3>New Character</h3>
<form method="post" action="?action=createNew">
	Character Name: <input type="text" id="charName" name="charName"/> <input type="submit" name="submit" id="submit" value="Create!"/>
</form>
