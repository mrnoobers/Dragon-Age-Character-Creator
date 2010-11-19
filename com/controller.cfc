component 
{
	public any function init(string action="login")
	{
		return this.bind(arguments.action);
	}
	public struct function bind(required string action)
	{
		var outStruct = {};
		switch(arguments.action)
		{
			case "login":
			{
				outStruct.model = "mdlLogin.cfm";
				outStruct.view = "dspLogin.cfm";
				break;
			}
			case "console":
			{
				outStruct.model = "mdlConsole.cfm";
				outStruct.view = "dspConsole.cfm";
				break;
			}
			case "createNew":
			{
				outStruct.model = "mdlCreateNew.cfm";
				outStruct.view = "";
				break;
			}
			case "edit":
			{
				outStruct.model = "mdlEdit.cfm";
				outStruct.view = "dspEdit.cfm";
				break;
			}
			case "export":
			{
				outStruct.model = "mdlExport.cfm";
				outStruct.view = "";
				break;
			}
			default:
			{
				outStruct.model = "mdlLogin.cfm";
				outStruct.view = "dspLogin.cfm";
				break;
			}
		}	
		
		return outStruct;
	}
}