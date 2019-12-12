/*
  by Ghostrider

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_coords","_hostageConfigs"];
private["_hostage","_building","_result"];

try 
{
	_hostage = [_coords,_hostageConfigs] call blck_fnc_spawnCharacter;
	if (_hostage isEqualTo grpNull) throw 1;
	_hostage remoteExec["GMS_fnc_initHostage", -2, true];
	_hostage setVariable["assetType",1,true];
	_building = [_hostage,_coords,_hostageConfigs select 7] call blck_fnc_placeCharacterInBuilding;
	_result = [_hostage,_building];
	//diag_log format["_fnd_spawnHostage:  _result = %1",_result];
}

catch 
{
	if (_exception isEqualTo 1) then 
	{
		_result = grpNull;
		diag_log format["[blckeagls] <WARNING> createGroup returned grpNull"];
	};
};
_result


