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

#define DMS_missionMarkerRootName "DMS_MissionMarker"
_fn_isDMSMarker = {
	private _m = _this;
	private _r = if ( ([_m,0,(count DMS_missionMarkerRootName) - 1] call BIS_fnc_trimString) isEqualTo DMS_missionMarkerRootName) then {true} else {false};
	_r
};

private _m = [];
{
	if (_x call _fn_isDMSMarker) then {_m pushBack _x};
} forEach allMapMarkers;
diag_log format["_fnc_getAllDMSMarkers: _bem = %1",_m];
_m