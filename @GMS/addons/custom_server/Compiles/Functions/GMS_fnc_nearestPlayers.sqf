
/*
	blck_fnc_nearestPlayers
	for ghostridergaming
	By Ghostrider [GRG]
	Copyright 2016
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params[["_coords",[]],"_range"];
if (_coords isEqualTo []) then 
{
	_coords = [0,0,0];
	diag_log format["[blckeagls] No value passed to blck_fnc_nearestPlayers for _coords - default of [0,0,0] used"];
};
private["_return","_playerClassNames"];
if (blck_modType isEqualTo "Epoch") then {_playerClassNames = ["Epoch_Female_F","Epoch_Male_F"]};
if (blck_modType isEqualTo "Exile") then {_playerClassNames = ["Exile_Unit_Player"]};
//diag_log format["_fnc_nearestPlayers: _coords %1 | _playerClassNames %2 | _range %3",_coords,_playerClassNames,_range];
_return = nearestObjects[_coords,_playerClassNames,_range];
_return
