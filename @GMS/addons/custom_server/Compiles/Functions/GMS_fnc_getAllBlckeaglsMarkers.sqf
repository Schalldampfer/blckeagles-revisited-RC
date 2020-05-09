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
private _m = [];
{
	if (_x call blck_fnc_isBlackeaglsMarker) then {_m pushBack _x};
} forEach allMapMarkers;
diag_log format["_fnc_getAllBlackeaglsMarkers: _bem = %1",_m];
_m

