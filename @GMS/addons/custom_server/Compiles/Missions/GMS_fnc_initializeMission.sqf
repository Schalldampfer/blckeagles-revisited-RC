/*

	Perform all functions necessary to initialize a mission.
	[_mrkr,_difficulty,_m] call blck_fnc_initializeMission;
*/

#include "\q\addons\custom_server\Configs\blck_defines.hpp";


private ["_coords","_coordArray","_return"];


params["_missionCategoryDescriptors","_missionParameters"];

 _missionCategoryDescriptors params [
		"_difficulty",
		"_noMissions",  // Max no missions of this category
		"_noActive",  // Number active 
		"_tMin", // Used to calculate waittime in the future
		"_tMax", // as above
		"_waitTime",  // time at which a mission should be spawned
		"_missionsData"  // 
	];

/*
{
	 diag_log format["fnc_initializeMission: _missionCategoryDescriptors:%1 = %2",_x,_missionCategoryDescriptors select _forEachIndex];
} forEach [
	"_difficulty",
	"_noMissions",  // Max no missions of this category
	"_noActive",  // Number active 
	"_tMin", // Used to calculate waittime in the future
	"_tMax", // as above
	"_waitTime",  // time at which a mission should be spawned
	"_missionsData"  // 
	];
*/

if (_noActive > _noMissions) exitWith {if (blck_debugOn) then {}};

_missionParameters params[
	"_defaultMissionLocations",			// 1	
	"_crateLoot", 						// 2
	"_lootCounts", 						// 3
	"_startMsg", 						// 4
	"_endMsg", 							// 5
	"_markerMissionName", 				// 6   "Scouts";
	"_markerType", 						// 7 "mil_triangle"
	"_markerColor", 					// 8 ColorBlue
	"_markerSize",  					// 9 [200,200] for ELLIPSE and rectangle markers only
	"_markerBrush",  					// 10 "GRID", for ELLIPSE and rectangle markers only
	"_missionLandscapeMode", 			// 11 
	"_garrisonedBuildings_BuildingPosnSystem", 
	"_garrisonedBuilding_ATLsystem",	// 13
	"_missionLandscape",				// 14
	"_missionLootBoxes",				// 15
	"_missionLootVehicles",				// 16
	"_missionPatrolVehicles",			// 17
	"_submarinePatrolParameters",		// 18
	"_airPatrols",						// 19
	"_noVehiclePatrols", 				// 20
	"_vehicleCrewCount",				// 21
	"_missionEmplacedWeapons",			// 22
	"_noEmplacedWeapons", 				// 23
	"_missionLootVehicles",				// 24
	"_useMines", 						// 25
	"_minNoAI", 						// 26
	"_maxNoAI", 
	"_noAIGroups", 		
	"_missionGroups",
	"_scubaGroupParameters",		
	"_hostageConfig",
	"_enemyLeaderConfig",
	"_uniforms", 
	"_headgear", 
	"_vests", 
	"_backpacks", 
	"_weaponList",
	"_sideArms", 
	"_chanceHeliPatrol", 
	"_noChoppers", 
	"_missionHelis", 
	"_chancePara", 
	"_noPara", 
	"_paraTriggerDistance",
	"_paraSkill",
	"_chanceLoot", 
	"_paraLoot", 
	"_paraLootCounts",
	"_spawnCratesTiming", 
	"_loadCratesTiming", 
	"_endCondition",
	"_isScubaMission"
];

/*
 {
	 diag_log format["fnc_initializeMission: _missionParameters:%1 = %2",_x,_missionParameters select _forEachIndex];
 } forEach [
	"_defaultMissionLocations",	// 1	
	"_crateLoot", 				// 2
	"_lootCounts", 				// 3
	"_startMsg", // 2
	"_endMsg", // 3
	"_markerMissionName", 
	"_markerType", 
	"_markerColor", 
	"_markerSize",
	"_markerBrush",	
	"_missionLandscapeMode", 	
	"_garrisonedBuildings_BuildingPosnSystem", 
	"_garrisonedBuilding_ATLsystem",
	"_missionLandscape",
	"_missionLootBoxes",
	"_missionLootVehicles",
	"_missionPatrolVehicles",
	"_submarinePatrolParameters",
	"_airPatrols",
	"_noVehiclePatrols", 
	"_vehicleCrewCount",
	"_missionEmplacedWeapons",
	"_noEmplacedWeapons", 
	"_missionLootVehicles",
	"_useMines", 
	"_minNoAI", 
	"_maxNoAI", 
	"_noAIGroups", 		
	"_missionGroups",
	"_scubaGroupParameters",		
	"_hostageConfig",
	"_enemyLeaderConfig",
	"_uniforms", 
	"_headgear", 
	"_vests", 
	"_backpacks", 
	"_weaponList",
	"_sideArms", 
	"_chanceHeliPatrol", 
	"_noChoppers", 
	"_missionHelis", 
	"_chancePara", 
	"_noPara", 
	"_paraTriggerDistance",
	"_paraSkill",
	"_chanceLoot", 
	"_paraLoot", 
	"_paraLootCounts",
	"_spawnCratesTiming", 
	"_loadCratesTiming", 
	"_endCondition",
	"_isScubaMission"
];
*/
//diag_log format["_fnc_initializeMission: _isScubaMission = %1",_isScubaMission];
_coordsArray = [];
if !(_defaultMissionLocations isEqualTo []) then 
{
	_coords = selectRandom _defaultMissionLocations;
} else {
	if (_isScubaMission) then 
	{
		_coords = [] call blck_fnc_findShoreLocation;
	} else {
		_coords =  [] call blck_fnc_findSafePosn;

	};
};
//diag_log format["_fnc_initializeMission: _coords = %1",_coords];
//uiSleep 1;
if (_coords isEqualTo []) exitWith 
{
	//diag_log format['_fnc_initializeMission: no safe location found, defering initialization'];
	false;
};

//diag_log format["_fnc_initializeMission(160): _defaultMissionLocations = %3 | _markerMissionName = %1 | _coords = %2",_markerMissionName,_coords,_defaultMissionLocations];
blck_ActiveMissionCoords pushback _coords; 
blck_missionsRunning = blck_missionsRunning + 1;

blck_missionsRun = blck_missionsRun + 1;
//diag_log format["_initializeMission (164): Total Dyanamic Land and UMS Run = %1 | total Dynamic and UMS Missions Running = %2", blck_missionsRun,blck_missionsRunning];

private _markers = [];

/*
	Handle map markers 
*/
private _markerName = format["%1:%2",_markerMissionName,blck_missionsRun];
//diag_log format["_initializeMission: _markerName = %1",_markerName];
private "_missionMarkerPosition";
if (blck_labelMapMarkers select 0) then
{
	_missionMarkerPosition = _coords;
};
if !(blck_preciseMapMarkers) then
{
	_missionMarkerPosition = [_coords,75] call blck_fnc_randomPosition;
};

private _markers = [_markerName,_coords,_markerMissionName,_markerColor,_markerType,_markerSize,_markerBrush] call blck_fnc_createMarker;
_markers params["_mainMarker",["_labelMarker",""]];

/*
	Send a message to players.
*/
[["start",_startMsg,_markerMissionName]] call blck_fnc_messageplayers;
 
private _missionTimeoutAt = diag_tickTime + blck_MissionTimeout;
private _triggered = 0;
private _spawnPara = if (random(1) < _chancePara) then {true} else {false};
private _objects = [];
private _mines = [];
private _crates = [];
private _missionAIVehicles = [];
private _blck_AllMissionAI = [];
private _AI_Vehicles = [];
private _assetSpawned = objNull;

private _missionData = [_coords,_mines,_objects,_crates, _blck_AllMissionAI,_assetSpawned,_missionAIVehicles,_mainMarker,_labelMarker];
blck_activeMissionsList pushBack [_missionCategoryDescriptors,_missionTimeoutAt,_triggered,_spawnPara,_missionData,_missionParameters];

true