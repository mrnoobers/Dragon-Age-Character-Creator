component accessors="true"
{
	property name="sides" type="numeric" getters="true" setters="true";
	property name="currentValue" type="numeric" getters="true" setters="true";
	
	public any function init(numeric sides=6)
	{
		this.setSides(arguments.sides);
		this.roll();
		return (this);
	}
	public void function roll()
	{
		var i = 0;
		var rollArr = [];
		
		for (i=1;i<=this.getSides();i++)
			rollArr[i] = i;
		
		createobject("java","java.util.Collections").Shuffle(rollArr);
		this.setCurrentValue(rollArr[1]);
	}
}