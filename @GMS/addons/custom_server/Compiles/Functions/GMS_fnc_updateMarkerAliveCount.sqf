/*
	by Ghostrider [GRG] 
	Copyright 2016
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";
params["_mainMarker","_labelMarker","_rootText","_missionAI"];
//private _p = ["_mainMarker","_labelMarker","_rootText","_missionAI"];
/*
{
	diag_log format["_fnc_updateMarkerAliveCount:  %1 = %2", _p select _foreachindex, _x];
}forEach _this;
*/
private _mToUpdate = if (_labelMarker isEqualTo "") then {_mainMarker} else {_labelMarker};	
diag_log format["_fnc_updateMarerAliveCounts: _marker = %1 | _rootText = %2 | alive AI = %3",_mToUpdate,_rootText,{alive _x} count _missionAI];
_mToUpdate setMarkerText format["%1 / %2 AI Alive",_rootText,{alive _x} count _missionAI];
diag_log format["_fnc_updateMarerAliveCounts: _mToUpdate = %1 | markerText = %2",_mToUpdate,markerText _mToUpdate];
