component
{
	remote array function getDieRoll(required array sidesArray)
	{
		var oRoller = new roller(arguments.sidesArray);		
		return oRoller.rollDice();
	}
}