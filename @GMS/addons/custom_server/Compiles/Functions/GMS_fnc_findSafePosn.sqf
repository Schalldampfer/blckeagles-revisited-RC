/*
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
//
if (isNil "blck_locationBlackList") then {blck_locationBlackList = []};
private _blacklistedLocations =  blck_locationBlackList;
/*
diag_log format["_fnc_findSafePosn: blck_locationBlackList = %1", blck_locationBlackList];
diag_log format["_fnc_findSafePosn: _blacklistedLocations = %1",_blacklistedLocations];
private "_pole";
if (blck_modType isEqualTo "Epoch") then {_pole = "PlotPole_EPOCH"};
if (blck_modType isEqualTo "Exile") then {_pole = "Exile_Construction_Flag_Static"};
{
	if (count _x isEqualTo 2) then {
		diag_log format["_value %1 has a count of 2",_x];
		_x pushBack 0;
	};
	_blacklistedLocations pushBack [_x,blck_minDistanceToBases];
} forEach nearestObjects[blck_mapCenter, [_pole], blck_mapRange];

{
	if (count _x isEqualTo 2) then {_x pushBack 0};
	_blacklistedLocations pushBack [_x,blck_minDistanceFromTowns];
} forEach blck_townLocations;
{
	if (count _x isEqualTo 2) then {_x pushBack 0};
	_blacklistedLocations pushBack [_x,blck_MinDistanceFromMission];
} forEach blck_ActiveMissionCoords;
*/
/*
for '_i' from 1 to count blck_recentMissionCoords do {
	private _loc = blck_recentMissionCoords deleteAt 0;
	diag_log format["BIS_fnc_findSafePos:  _loc = %1",_loc];
	
	if (_loc select 1 < diag_tickTime) then 
	{
		diag_log "location still blacklisted";
		if (count (_loc select 0) isEqualTo 2) then {(_loc select 0) pushBack 0};
		blck_recentMissionCoords pushBack _loc;
		_blacklistedLocations pushBack [_loc select 0, 500];
	};
	
};
*/
/*
{
	if (count _x isEqualTo 2) then {_x pushBack 0};
	_blacklistedLocations pushBack [_x,blck_TriggerDistance + 300];
} forEach allPlayers;

private _coords = []; 
*/
private _coords = [blck_mapCenter,0,blck_mapRange,3,0,5,0,_blacklistedLocations] call BIS_fnc_findSafePos;
diag_log format["_fnc_findSafePosn: _coords from first attempt = %1 | _blacklistedLocations = %2",_coords, _blacklistedLocations];
if (_coords isEqualTo []) then 
{
	for "_index" from 1 to 100 do 
	{
		{
			_x set[1, (_x select 1) * 0.8];
			diag_log format["_fnc_findSafePosn: _x downgraded to %1",_x];
		} forEach _blacklistedLocations;
		_coords = [blck_mapCenter,0,blck_mapRange,3,0,5,0,_blacklistedLocations] call BIS_fnc_findSafePos;
		diag_log format["_fnc_findSafePosn: try %1 yielded _coords = %2",_index,_coords];
		if !(_coords isEqualTo []) exitWith {};
		uisleep 1;
	};
};

diag_log format["_fnc_findSafePosn: _coords = %1",_coords];
_coords



