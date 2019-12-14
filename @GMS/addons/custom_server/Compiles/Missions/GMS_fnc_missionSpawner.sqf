/*
	Dynamic Mission Spawner (over-ground missions)
	By Ghostrider GRG
	Copyright 2016
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/

#include "\q\addons\custom_server\Configs\blck_defines.hpp";
#define delayTime 1
private ["_abort","_crates","_aiGroup","_objects","_groupPatrolRadius","_missionLandscape","_mines","_blck_AllMissionAI","_blck_localMissionMarker","_assetKilledMsg","_enemyLeaderConfig",
		"_AI_Vehicles","_timeOut","_aiDifficultyLevel","_missionPatrolVehicles","_missionGroups","_loadCratesTiming","_spawnCratesTiming","_assetSpawned","_hostageConfig",
		"_chanceHeliPatrol","_noPara","_chanceLoot","_heliCrew","_loadCratesTiming","_useMines","_blck_AllMissionAI","_delayTime","_groupPatrolRadius",
		"_wait","_missionStartTime","_playerInRange","_missionTimedOut","_temp","_patrolVehicles","_vehToSpawn","_noChoppers","_chancePara","_marker","_vehicleCrewCount","_defaultMissionLocations"];
		
params[["_coords",[0,0,0]],["_markerClass","blue"],["_aiDifficultyLevel","Red"]];

if (isNil "_assetKilledMsg")			 then {_assetKilledMsg = ""};
if (isNil "_markerColor") 				then {_markerColor = "ColorBlack"};
if (isNil "_markerType") 				then {_markerType = ["mil_box",[]]};
if (isNil "_markerSize") 				then {_markerSize = []};
//if (isNil "_timeOut") then {_timeOut = -1;};
if (isNil "_endCondition") 				then {_endCondition = blck_missionEndCondition};  // Options are "allUnitsKilled", "playerNear", "allKilledOrPlayerNear"};
if (isNil "_spawnCratesTiming")	 		then {_spawnCratesTiming = blck_spawnCratesTiming}; // Choices: "atMissionSpawnGround","atMissionStartAir","atMissionEndGround","atMissionEndAir". 
if (isNil "_loadCratesTiming") 			then {_loadCratesTiming = blck_loadCratesTiming}; // valid choices are "atMissionCompletion" and "atMissionSpawn"; 
if (isNil "_missionPatrolVehicles") 	then {_missionPatrolVehicles = []};
if (isNil "_missionGroups") 			then {_missionGroups = []};
if (isNil "_hostageConfig") 			then {_hostageConfig = []};
if (isNil "_enemyLeaderConfig") 		then {_enemyLeaderConfig = []};
if (isNil "_useMines") 					then {_useMines = blck_useMines;};
if (isNil "_weaponList") 				then {_weaponList = [_aiDifficultyLevel] call blck_fnc_selectAILoadout};
if (isNil "_sideArms") 					then {_sideArms = [_aiDifficultyLevel] call blck_fnc_selectAISidearms};
if (isNil "_uniforms") 					then {_uniforms = [_aiDifficultyLevel] call blck_fnc_selectAIUniforms};
if (isNil "_headGear") 					then {_headGear = [_aiDifficultyLevel] call blck_fnc_selectAIHeadgear};
if (isNil "_vests") 					then {_vests = [_aiDifficultyLevel] call blck_fnc_selectAIVests};
if (isNil "_backpacks") 				then {_backpacks = [_aiDifficultyLevel] call blck_fnc_selectAIBackpacks};
if (isNil "_chanceHeliPatrol") 			then {_chanceHeliPatrol = [_aiDifficultyLevel] call blck_fnc_selectChanceHeliPatrol};
if (isNil "_noChoppers") 				then {_noChoppers = [_aiDifficultyLevel] call blck_fnc_selectNumberAirPatrols};
if (isNil "_chancePara") 				then {_chancePara = [_aiDifficultyLevel] call blck_fnc_selectChanceParatroops};
if (isNil "_missionHelis") 				then {_missionHelis = [_aiDifficultyLevel] call blck_fnc_selectMissionHelis};
if (isNil "_noPara") 					then {_noPara = [_aiDifficultyLevel] call blck_fnc_selectNumberParatroops};
if (isNil "_chanceLoot") 				then {_chanceLoot = 1.0}; //0.5}; 
if (isNil "_paraTriggerDistance") 		then {_paraTriggerDistance = 400;};
if (isNil "_paraLoot") 					then {_paraLoot = blck_BoxLoot_Green};  //  Add diffiiculty based settings
if (isNil "_paraLootCounts") 			then {_paraLootCounts = blck_lootCountsRed}; // Add difficulty based settings
if (isNil "_missionLootVehicles") 		then {_missionLootVehicles = []};
if (isNil "_garrisonedBuilding_ATLsystem") then {_garrisonedBuilding_ATLsystem = []};
if (isNil "_garrisonedBuildings_BuildingPosnSystem") then {_garrisonedBuildings_BuildingPosnSystem = []};
if (isNil "_vehicleCrewCount") then {_vehicleCrewCount = [_aiDifficultyLevel] call GMS_fnc_selectVehicleCrewCount};
if (isNil "_defaultMissionLocations") then {_defaultMissionLocations = []};
if (isNil "_submarinePatrolParameters") then {_submarinePatrolParameters = []};
if (isNil "_airpatrols") then {_airpatrols = []};
if (isNil "_scubagroupparameters") then {_scubagroupparameters = []};
if (isNil "_markerMissionName") then {
	diag_log format["_fnc_missionSpawner: _markerMissionName not defined, using default value"];
	_markerMissionName = "Default Mission Name";
};
if (isNil "_noLootCrates") then {_noLootCrates = 1};
if (isNil "_lootCrates") then {_lootCrates = blck_crateTypes};
if (isNil "_lootCratePositions") then {_lootCratePositions = []};
if (isNil "_markerSize") then {_markerSize = [200,200]};
if (isNil "_markerBrush") then {_markerBrush = "GRID"};
if (isNil "_isScubaMission") then {_isScubaMission = false};
private "_temp";
if (typeName _markerType isEqualTo "ARRAY" && !(typeName _markerType isEqualTo "STRING")) then 
{ 
	_markerSize = _markerType select 1;
	_markerType = _markerType select 0;	
};

	/*
	private _maxNooMissions = 0;
	private _noActiveMissions = 0;
	private _timesspawned = 0;
	 private _missionCategoryDescriptors = [
		"_markerClass",
		"_aiDifficultyLevel",
		"_noMissions",  // Max no missions of this category
		"_noActive",  // Number active 
		"_timesSpawned", // times spawned, useful for keeping unique markers 
		"_tMin", // Used to calculate waittime in the future
		"_tMax", // as above
		"_waitTime",  // time at which a mission should be spawned
		"_missionsData"  // 
	];
	*/
	private _paraSkill = _aiDifficultyLevel;

	private _table = [
		//_markerClass,  //  duplicate really, not used, ignore going foward as of build 186
		_defaultMissionLocations,		
		_crateLoot, // 0
		_lootCounts, // 1
		_startMsg, // 2
		_endMsg, // 3
		_markerMissionName, // Name used for setMarkerText and also for the root name for all markers
		_markerType, 
		_markerColor, 
		_markerSize,
		_markerBrush,
		//_markerLabel,		// Never Used, ignore going forward as of Build 186
		_missionLandscapeMode, 	
		_garrisonedBuildings_BuildingPosnSystem, 
		_garrisonedBuilding_ATLsystem,
		_missionLandscape,
		_missionLootBoxes,
		_missionLootVehicles,
		_missionPatrolVehicles,
		_submarinePatrolParameters,
		_airPatrols,
		_noVehiclePatrols, 
		_vehicleCrewCount,
		_missionEmplacedWeapons,
		_noEmplacedWeapons, 
		_missionLootVehicles,
		_useMines, 
		_minNoAI, 
		_maxNoAI, 
		_noAIGroups, 		
		_missionGroups,
		_scubaGroupParameters,		
		_hostageConfig,
		_enemyLeaderConfig,
		_uniforms, 
		_headgear, 
		_vests, 
		_backpacks, 
		_weaponList,
		_sideArms, 
		_chanceHeliPatrol, 
		_noChoppers, 
		_missionHelis, 
		_chancePara, 
		_noPara, 
		_paraTriggerDistance,
		_paraSkill,
		_chanceLoot, 
		_paraLoot, 
		_paraLootCounts,
		_spawnCratesTiming, 
		_loadCratesTiming, 
		_endCondition,
		_isScubaMission 										
	];
	// params["_missionCategoryDescriptors","_missionParameters","_marker"];
	//[_missionCategoryDescriptors,_table,_markerClass] call blck_fnc_initializeMission;
	_table
