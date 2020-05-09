/*
	for ghostridergaming
	By Ghostrider [GRG]
	Copyright 2016
	checks the status of each entry in 
/*
	By Ghostrider [GRG]
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

#ifdef blck_debugMode
if (blck_debugLevel >= 2) then {
	diag_log format["_fnc_spawnPendingMissions:: count blck_pendingMissions = %1", count blck_pendingMissions];
};
#endif

if (blck_missionsRunning >= blck_maxSpawnedMissions) exitWith {

	#ifdef blck_debugMode
	if (blck_debugLevel > 2) then {
		diag_log "_fnc_spawnPendingMissions:: --- >> Maximum number of missions is running; function exited without attempting to find a new mission to spawn";
	};
	#endif
};

private["_coords","_compiledMission","_search","_readyToSpawnQue","_missionToSpawn","_allowReinforcements"];
_readyToSpawnQue = [];
{ 	
	if ( (diag_tickTime > (_x select 5)) && ((_x select 5) > 0) ) then 
	{
		_readyToSpawnQue pushback _x;
	};
} forEach blck_pendingMissions;

if (count _readyToSpawnQue > 0) then
{
	_missionToSpawn = selectRandom _readyToSpawnQue;
	diag_log format["_fnc_spawnPendingMIssions: blc markers = %1",[] call blck_fnc_getAllBlackeaglsMarkers];

	_coords = [] call blck_fnc_FindSafePosn;
	
	_compiledMission = selectRandom (_missionToSpawn select 0);
	// 	_mission = [_compiledMissionsList,format["%1%2",_marker,_i],_difficulty,_tMin,_tMax,_waitTime,[0,0,0]];
	_missionMarker = _missionToSpawn select 1;
	_missionDifficulty = _missionToSpawn select 2;
	[_coords,_missionMarker,_missionDifficulty] spawn _compiledMission;
};

true
