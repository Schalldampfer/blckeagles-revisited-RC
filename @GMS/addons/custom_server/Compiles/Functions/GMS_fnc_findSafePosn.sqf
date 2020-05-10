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

_fn_buildBlacklistedLocationsList = {
	params["_minToBases","_minToPlayers","_minToMissions","_minToTowns","_minToRecentMissionLocation"];
	private _blacklistedLocations = +blck_locationBlackList;

	for '_i' from 1 to (count blck_recentMissionCoords) do {
		private _loc = blck_recentMissionCoords deleteAt 0;
		//diag_log format["_fnc_findSafePosn: Evaluation reccent mission location %1",_x];
		if (_loc select 1 < diag_tickTime) then 
		{
			blck_recentMissionCoords pushBack _loc;
			_blacklistedLocations pushBack [_loc select 0, _minToRecentMissionLocation];
		};
	};	

	{
		//diag_log format["_fnc_findSafePosn: adding activeMissioncoords, element %1 2 = %1",_x,_forEachIndex];
		_blacklistedLocations pushBack [_x,_minToMissions];
	} forEach blck_ActiveMissionCoords;	

	private "_bases";
	if (blck_modType isEqualTo "Epoch") then {_bases = nearestObjects[blck_mapCenter, ["PlotPole_EPOCH"], blck_mapRange + 25000]};
	if (blck_modType isEqualTo "Exile") then {_bases = nearestObjects[blck_mapCenter, ["Exile_Construction_Flag_Static"], blck_mapRange + 25000]};

	{
		//diag_log format["_fnc_findSafePosn: adding base location at %1",_x];
		_blacklistedLocations pushBack [getPosATL _x,_minToBases];
	} forEach _bases;	

	// Town positions are already in the blacklist
	//{
		//_blacklistedLocations pushBack [locationPosition _x,_minToTowns];
	//} forEach blck_townLocations;	

	{
		//diag_log format["_fnc_findSafePosn: adding player %1 at %2",_x, getPosATL _x];
		_blacklistedLocations pushBack [getPosATL _x,_minToPlayers];
	} forEach allPlayers;	

	if (blck_minDistanceFromDMS > 0) then 
	{
		_blacklistedLocations append ([] call blck_fnc_getAllDMSMarkers);
	};

	_blacklistedLocations
};

private _minDistToBases = blck_minDistanceToBases;
private _minDistToPlayers = blck_minDistanceToPlayer;
private _minDistToTowns = blck_minDistanceFromTowns;
private _mindistToMissions = blck_MinDistanceFromMission;
private _minToRecentMissionLocation = 200;

private _blacklistedLocations = [_minDistToBases,_minDistToPlayers,_minDistToTowns,_mindistToMissions,_minToRecentMissionLocation] call _fn_buildBlacklistedLocationsList;

private _coords = [blck_mapCenter,0,blck_mapRange,3,0,5,0,_blacklistedLocations] call BIS_fnc_findSafePos;

diag_log format["_fnc_findSafePosn: _coords from first attempt = %1 | _blacklistedLocations = %2",_coords, _blacklistedLocations];
if (_coords isEqualTo []) then 
{
	for "_index" from 1 to 100 do 
	{
		{
			_x set[1, (_x select 1) * 0.8];
			//diag_log format["_fnc_findSafePosn: _x downgraded to %1",_x];
		} forEach _blacklistedLocations;
		_coords = [blck_mapCenter,0,blck_mapRange,3,0,5,0,_blacklistedLocations] call BIS_fnc_findSafePos;
		//diag_log format["_fnc_findSafePosn: try %1 yielded _coords = %2 on try #%3",_index,_coords,_i];
		if !(_coords isEqualTo []) exitWith {};
		uisleep 1;
	};
};

_coords



