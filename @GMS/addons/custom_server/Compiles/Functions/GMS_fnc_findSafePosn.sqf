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

if (isNil "blck_locationBlackList") then {blck_locationBlackList = []};
private _blacklistedLocations =  blck_locationBlackList;

//diag_log format["_fnc_findsafeposn: count blck_recentMissionCoords = %1 | blck_recentMissionCoords = %2", count blck_recentMissionCoords, blck_recentMissionCoords];

for '_i' from 1 to count blck_recentMissionCoords do {
	private _loc = blck_recentMissionCoords deleteAt 0;
	//diag_log format["BIS_fnc_findSafePos:  _loc = %1",_loc];
	if (_loc select 1 < diag_tickTime) then 
	{
		//diag_log "location still blacklisted";
		blck_recentMissionCoords pushBack _loc;
		_blacklistedLocations pushBack [_loc select 0, 300];
	};
};

//diag_log format["_fnc_findsafeposn: count blck_ActiveMissionCoords = %1 || blck_ActiveMissionCoords = %2 ",count blck_ActiveMissionCoords,blck_ActiveMissionCoords];
// Check coordinates of active missions so we dont spawn 2 right on top of each other 
{
	//diag_log format["_fnc_findSafePosn: search activeMissioncoords, _x = %1",_x];
	_blacklistedLocations pushBack [_x,blck_MinDistanceFromMission];
} forEach blck_ActiveMissionCoords;

// Check for bases every time this function is called so that we account for any new bases started during that server uptime period.
private _bases = [];
if (blck_modType isEqualTo "Epoch") then {_bases = nearestObjects[blck_mapCenter, ["PlotPole_EPOCH"], blck_mapRange + 25000]};
if (blck_modType isEqualTo "Exile") then {_bases = nearestObjects[blck_mapCenter, ["Exile_Construction_Flag_Static"], blck_mapRange + 25000]};


//diag_log format["_fnc_findSafePosn: count _bases = %1 | _bases = %2", count _bases, _bases];
{
	_blacklistedLocations pushBack [getPosATL _x,blck_minDistanceToBases];
} forEach _bases;

//diag_log format["_fnc_findSafePosn: count blck_townLocations = %1",count blck_townLocations];
{
	_blacklistedLocations pushBack [locationPosition _x,blck_minDistanceFromTowns];
} forEach blck_townLocations;

//diag_log format["_fnc_findSafePosn: count allPlayers = %1",count allPlayers];
{
	_blacklistedLocations pushBack [getPosATL _x,blck_minDistanceToPlayer];
} forEach allPlayers;

private _coords = [blck_mapCenter,0,blck_mapRange,3,0,5,0,_blacklistedLocations] call BIS_fnc_findSafePos;

//diag_log format["_fnc_findSafePosn: _coords from first attempt = %1 | _blacklistedLocations = %2",_coords, _blacklistedLocations];
if (_coords isEqualTo []) then 
{
	for "_index" from 1 to 100 do 
	{
		{
			_x set[1, (_x select 1) * 0.8];
			//diag_log format["_fnc_findSafePosn: _x downgraded to %1",_x];
		} forEach _blacklistedLocations;
		_coords = [blck_mapCenter,0,blck_mapRange,3,0,5,0,_blacklistedLocations] call BIS_fnc_findSafePos;
		//diag_log format["_fnc_findSafePosn: try %1 yielded _coords = %2",_index,_coords];
		if !(_coords isEqualTo []) exitWith {};
		uisleep 1;
	};
};

//diag_log format["_fnc_findSafePosn: _coords = %1",_coords];
_coords



