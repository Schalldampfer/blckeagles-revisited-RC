/*

	Perform all functions necessary to initialize a mission.
	[_mrkr,_difficulty,_m] call blck_fnc_initializeMission;
*/

#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_missionCategoryDescriptors","_missionParameters"];

 _missionCategoryDescriptors params [
		//"_marker",
		"_difficulty",
		"_noMissions",  // Max no missions of this category
		"_noActive",  // Number active 
		//"_timesSpawned", // times spawned, useful for keeping unique markers 
		"_tMin", // Used to calculate waittime in the future
		"_tMax", // as above
		"_waitTime",  // time at which a mission should be spawned
		"_missionsData"  // 
	];


{
	 diag_log format["fnc_initializeMission: _missionCategoryDescriptors:%1 = %2",_x,_missionCategoryDescriptors select _forEachIndex];
} forEach [
	//"_marker",
	"_difficulty",
	"_noMissions",  // Max no missions of this category
	"_noActive",  // Number active 
	//"_timesSpawned", // times spawned, useful for keeping unique markers 
	"_tMin", // Used to calculate waittime in the future
	"_tMax", // as above
	"_waitTime",  // time at which a mission should be spawned
	"_missionsData"  // 
	];

if (_noActive > _noMissions) exitWith {if (blck_debugOn) then {}};

_missionParameters params[
	//"_markerClass",				// 0  ?? "Scouts"; ignored from build 186 on.
	"_defaultMissionLocations",	// 1	
	"_crateLoot", 				// 2
	"_lootCounts", 				// 3
	"_startMsg", // 2
	"_endMsg", // 3
	"_markerMissionName", //   "Scouts";
	"_markerType", // "mil_triangle"
	"_markerColor", // ColorBlue
	"_markerSize",  //[200,200] for ELLIPSE and rectangle markers only
	"_markerBrush",  // "GRID", for ELLIPSE and rectangle markers only
	//"_markerLabel",		// ignored from build 186 on
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

/*
 {
	 diag_log format["fnc_initializeMission: _missionParameters:%1 = %2",_x,_missionParameters select _forEachIndex];
 } forEach [
	//"_markerClass",				// 0  Ignored from build 186 on
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
	//"_markerLabel",		
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
private "_coords";
if !(_defaultMissionLocations isEqualTo []) then 
{
	_coords = selectRandom _defaultMissionLocations;
} else {
	if (_isScubaMission) then 
	{
		_coords = [] call blck_fnc_findShoreLocation;
	} else {
		_coords =  [] call blck_fnc_FindSafePosn;
	};
};
_defaultMissionLocations pushBack _coords;

diag_log format["_fnc_initializeMission(160): _defaultMissionLocations = %3 | _markerMissionName = %1 | _coords = %2",_markerMissionName,_coords,_defaultMissionLocations];
blck_ActiveMissionCoords pushback _coords; 
blck_missionsRunning = blck_missionsRunning + 1;

blck_missionsRun = blck_missionsRun + 1;
diag_log format["_initializeMission (164): Total Dyanamic Land and UMS Run = %1 | total Dynamic and UMS Missions Running = %2", blck_missionsRun,blck_missionsRunning];

private _markers = [];

/*
	Handle map markers 
*/
private _markerName = format["%1-%2",_markerMissionName,blck_missionsRun];
diag_log format["_initializeMission: _markerName = %1",_markerName];
private "_missionMarkerPosition";
if (blck_labelMapMarkers select 0) then
{
	_missionMarkerPosition = _coords;
};
if !(blck_preciseMapMarkers) then
{
	_missionMarkerPosition = [_coords,75] call blck_fnc_randomPosition;
};
/*
 params[
	"_markerName",  // the name used when creating the marker. Must be unique.
	"_markerPos",
	"_markerLabel",
	"_markerColor",
	"_markerType",	// Use either the name of the icon or "ELLIPSE" or "RECTANGLE" where non-icon markers are used
	["_markerSize",[0,0]],
	["_markerBrush","GRID"]
 ];
*/
private _markers = [_markerName,_coords,_markerMissionName,_markerColor,_markerType,_markerSize,_markerBrush] call blck_fnc_createMarker;
diag_log format["_fnc_createmarker: _markers = %1",_markers];
_markers params["_mainMarker",["_labelMarker",""]];
/*
	Send a message to players.
*/
[["start",_startMsg,_markerMissionName]] call blck_fnc_messageplayers;
//_missionCategoryDescriptors set [3,_timesSpawned + 1];
private _missionTimeoutAt = diag_tickTime + blck_MissionTimeout;
private _triggered = 0;
private _spawnPara = if (random(1) < _chancePara) then {true} else {false};
private _assetSpawned = objNull;
private _playerInRange = false;
private _missionTimedOut = false;
private _wait = true;
private _objects = [];
private _mines = [];
private _crates = [];
private _aiGroup = [];
private _missionAIVehicles = [];
private _blck_AllMissionAI = [];
private _AI_Vehicles = [];
private _asset = objNull;

private _missionData = [_coords,_mines,_objects,_crates, _blck_AllMissionAI,_asset,_mainMarker,_labelMarker];
diag_log format["_fnc_initializeMission(201): _coords = %1 | _markerName = %2 | _marker = %3 | _markers = %4",_coords,_markerName,_mainMarker,_labelMarker];									//  0						1					2			3		4			5				6		7
blck_activeMissionsList pushBack [_missionCategoryDescriptors,_missionTimeoutAt,_triggered,_spawnPara,_missionData,_missionParameters];