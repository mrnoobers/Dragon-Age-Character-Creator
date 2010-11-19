/**
*@accessors true
*/
component 
{
	property name="dice" type="array" getters="true" setters="true";
	
	public any function init(required array sidesArray)
	{
		var i = 0;
		var diceArr = [];
		for (i=1;i<=arraylen(arguments.sidesArray);i++)
			ArrayAppend(diceArr,new die(sidesArray[i]));
		this.setDice(diceArr);
		return (this);
	}
	public array function rollDice()
	{
		var outArr = [];
		var theStruct = {};
		var inter  = this.getDice().iterator();
		var a = "";
		
		while (inter.hasNext())
		{
			a = inter.Next();
			a.roll();
			theStruct = {sides=a.getSides(),value=a.getCurrentValue()};
			arrayAppend(outArr,theStruct);
		}
		
		return outArr;		
	}
}