/*
	By Ghostrider [GRG]
	Copyright 2016
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

private _m = _this;
private _r = if ( ([_m,0,(count blck_missionMarkerRootName) - 1] call BIS_fnc_trimString) isEqualTo blck_missionMarkerRootName) then {true} else {false};
_r