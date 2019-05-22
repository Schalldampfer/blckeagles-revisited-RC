/*
	GMS_fnc_isClass

	Purpose: determine if a string is a valid className
	Parameters: _item, a string to be interrogated.
	Returns: true if the string is a valid classname.
*/
//#include "GMSCore\init\GMS_defines.hpp" "\addons\GMSCore\init\GMS_defines.hpp"
params["_item"];
private _result = if ([_item] call GMS_fnc_getCfgType isEqualTo "") then {false} else {true};
_result