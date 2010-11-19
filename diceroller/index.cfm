<cfscript>
	oRoller = new com.roller([6,6,6]);
	resultsArr = oRoller.rollDice();
</cfscript>
<cfset doubles = false/>
<cfset total = 0/>
<cfloop from="1" to="#arraylen(resultsArr)#" index="i">
	<cfset check = resultsArr[i].value/>
	<cfloop from="1" to="#arraylen(resultsArr)#" index="j">
		<cfif i eq j>
			<cfcontinue/>
		</cfif>
		<cfif resultsArr[j].value eq check>
			<cfset doubles = true/>
		</cfif>
	</cfloop>
	<cfset total += resultsArr[i].value/>
</cfloop>
<cfoutput>
<cfif doubles>
	<strong>STUNT POINTS: #resultsArr[1].value#</strong><br/>
</cfif>
Total = <strong>#total#</strong><br/>
<Br/>
<strong>Dragon Die:</strong> #resultsArr[1].value#<br/>
Die 2: #resultsArr[2].value#<br/>
Die 3: #resultsArr[3].value#<br/>
<form>
<input type="submit" value="ROLL!"/>
</form>
</cfoutput>