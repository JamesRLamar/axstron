<cfcomponent name="_Clu" output="false" extends="_Tron">

<cfscript>
	public struct function GetStruct() {
			
		var ViewStruct = {};

		ViewStruct[1]["Section"] = "foo";
		ViewStruct[1]["View"] = "bar";
		
		return ViewStruct;
	}
</cfscript>
</cfcomponent>