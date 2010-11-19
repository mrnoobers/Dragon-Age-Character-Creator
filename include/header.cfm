<html>
	<head>
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
		<cfif structkeyexists(request,"js")>
			<cfloop array="#request.js#" index="i">
				<script src="<cfoutput>#i#</cfoutput>"></script>
			</cfloop>
		</cfif>
	</head>
	
<body>

