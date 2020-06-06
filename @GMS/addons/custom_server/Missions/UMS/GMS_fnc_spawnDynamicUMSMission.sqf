/*
	Dynamic Underwater Mission Spawner
	By Ghostrider GRG
	Copyright 2016
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

#define isScubaMission true
#define delayTime 1
private ["_abort","_crates","_aiGroup","_objects","_mines","_blck_AllMissionAI","_blck_localMissionMarker",
		"_AI_Vehicles","_timeOut","_aiDifficultyLevel","_missionPatrolVehicles","_missionGroups","_loadCratesTiming","_spawnCratesTiming","_assetSpawned",
		"_blck_AllMissionAI","_delayTime","_wait","_missionStartTime","_playerInRange","_missionTimedOut","_temp","_patrolVehicles","_vehToSpawn","_marker","_vehicleCrewCount",
		"_defaultMissionLocations"];
		
params["_coords","_mission",["_allowReinforcements",false]];

_markerClass = _mission;
_aiDifficultyLevel = _difficulty;  // _difficulty is defined in the mission description file. see \addons\custom_server\Missions\UMS\dynamicMissions\default.sqf for an example

diag_log format["[blckeagls Dynamic UMS] dynamicUMSspawner (34):: Initializing mission: _cords %1 : _markerClass %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_markerClass,_aiDifficultyLevel,_markerMissionName];


if (isNil "_assetKilledMsg")			 then {_assetKilledMsg = ""};
if (isNil "_markerColor") 				then {_markerColor = "ColorBlack"};
if (isNil "_markerType") 				then {_markerType = ["mil_box",[]]};
if (isNil "_markerSize") 				then {_markerSize = []};
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
if (isNil "_paraSkill")					then {_paraSkill = _aiDifficultyLevel};
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
if (isNil "_isScubaMission") then {_isScubaMission = false};
if (isNil "_missionLootBoxes") then {_missionLootBoxes = []};

_objects = [];
_mines = [];
_crates = [];
_aiGroup = [];
_missionAIVehicles = [];
_blck_AllMissionAI = [];
_AI_Vehicles = [];
_blck_localMissionMarker = [_markerClass,_coords,"","",_markerColor,_markerType];
_delayTime = 1;
_groupPatrolRadius = 50;

if (blck_labelMapMarkers select 0) then
{
	_blck_localMissionMarker set [2, _markerMissionName];
};
if !(blck_preciseMapMarkers) then
{
	_blck_localMissionMarker set [1,[_coords,75] call blck_fnc_randomPosition];
};
_blck_localMissionMarker set [3,blck_labelMapMarkers select 1];  // Use an arrow labeled with the mission name?
[["start",_startMsg,_markerMissionName]] call blck_fnc_messageplayers;
_marker = [_blck_localMissionMarker] call blck_fnc_spawnMarker;

////////
//  All parameters are defined, let's wait until a player is nearby or the mission has timed out
////////

_missionStartTime = diag_tickTime;
_playerInRange = false;
_missionTimedOut = false;

_wait = true;

while {_wait} do
{
	if ([_coords, blck_TriggerDistance, false] call blck_fnc_playerInRange) exitWith {_playerInRange = true;};
	if ([_missionStartTime,blck_MissionTimeout] call blck_fnc_timedOut) exitWith {_missionTimedOut = true;};
	uiSleep 5;

};

if (_missionTimedOut) exitWith
{
	//  Deal with the case in which the mission timed out.
	blck_priorDynamicUMS_Missions pushback [_coords,diag_tickTime]; 
	blck_UMS_ActiveDynamicMissions = blck_UMS_ActiveDynamicMissions - [_coords];
	blck_dynamicUMS_MissionsRuning = blck_dynamicUMS_MissionsRuning - 1;		
	diag_log format["_fnc_dynamicUMSSpawner (187): mission timed out"];
	[_mines,_objects,_crates, _blck_AllMissionAI,_endMsg,_blck_localMissionMarker,_coords,_markerClass,  1] call blck_fnc_endMission;
};

////////
// Spawn the mission objects, loot chest, and AI
////////

if (blck_SmokeAtMissions select 0) then  // spawn a fire and smoke near the crate
{
	_temp = [_coords,blck_SmokeAtMissions select 1] call blck_fnc_smokeAtCrates;
	if (typeName _temp isEqualTo "ARRAY") then 
	{
		_objects append _temp;
	};
};

uiSleep delayTime;
if (_useMines) then
{
	_mines = [_coords] call blck_fnc_spawnMines;
	//uiSleep _delayTime;;
};
uiSleep delayTime;
_temp = [];
//diag_log format["_dynamicUMSspawner"" _missionLandscape = %1 | _missionLandscapeMode = %2",_missionLandscape, _missionLandscapeMode];
if (_missionLandscapeMode isEqualTo "random") then
{
	_temp = [_coords,_missionLandscape, 3, 15, 2] call blck_fnc_spawnRandomLandscape;
};
if (_missionLandscapeMode isEqualTo "precise") then
{
	//params["_center","_objects"];
	_temp = [_coords, _missionLandscape] call blck_fnc_spawnCompositionObjects;
	//uiSleep 1;
};
//diag_log format["_fnc_dynamicUMSspawner: _temp = %1, typeName _temp = %2",_temp, typeName _temp];
if (typeName _temp isEqualTo "ARRAY") then
{
	_objects append _temp;
};

uiSleep delayTime;;

_temp = [_coords,_missionLootVehicles] call blck_fnc_spawnMissionLootVehicles;
//uisleep 1;
_crates append _temp;

uiSleep _delayTime;

private _abort = false;
private _temp = [[],[],false];
diag_log format["_fnc_dynamicUMSspawner: spawning infantry using data in _missionGroups with _missionGroups = %1",_missionGroups];
// Require that the server admin define the location of any infantry patrols given that missions will be off-shore. 
// AI could be spawned on a platform or floating structure.
if (count _missionGroups > 0) then
{
	if (isNil "_noAIGroups") then {_noAIGroups = 1};
	diag_log format["_fnc_dynamicUMSSpawner: _noAIGroups = %1",_noAIGroups];
	// _temp = [_coords, _minNoAI,_maxNoAI,_noAIGroups,_missionGroups,_aiDifficultyLevel,_uniforms,_headGear,_vests,_backpacks,_weaponList,_sideArms] call blck_fnc_spawnMissionAI;
	_temp = [_coords, _minNoAI,_maxNoAI,_noAIGroups,_missionGroups,_aiDifficultyLevel,_uniforms,_headGear,_vests,_backpacks,_weaponList,_sideArms] call blck_fnc_spawnMissionAI;
	_blck_AllMissionAI append (_temp select 0);
};

private "_temp";
if (count _scubaGroupParameters > 0) then
{
	//diag_log format["_fnc_dynamicUMSspawner: spawning scuba groups with _scubaGroupParameters = %1",_scubaGroupParameters];
	// params["_coords",["_minNoAI",3],["_maxNoAI",6],"_missionGroups",["_aiDifficultyLevel","red"],["_uniforms",blck_SkinList],["_headGear",blck_BanditHeadgear],["_vests",blck_vests],["_backpacks",[]],["_weapons",[]],["_sideArms",blck_Pistols],["_isScubaGroup",false]];
	_temp = [_coords, _minNoAI,_maxNoAI,count _scubaGroupParameters,_scubaGroupParameters,_aiDifficultyLevel,blck_UMS_uniforms,blck_UMS_headgear,blck_UMS_vests,[],blck_UMS_weapons,[],isScubaMission] call blck_fnc_spawnMissionAI;
	_blck_AllMissionAI append (_temp select 0);
};

uiSleep _delayTime;

_temp = [[],[],false];
_abort = false;
private["_patrolVehicles","_vehToSpawn"];
_vehToSpawn = 0;

// Spawn any surface patrols
if (blck_useVehiclePatrols &&  count _vehiclePatrolParameters > 0) then
{
	// params["_coords","_noVehiclePatrols","_aiDifficultyLevel","_missionPatrolVehicles",["_useRelativePos",true],["_uniforms",blck_SkinList], ["_headGear",blck_headgear],["_vests",blck_vests],["_backpacks",blck_backpacks],["_weaponList",[]],["_sideArms",blck_Pistols], ["_isScubaGroup",false]];
	_temp = [_coords,_vehToSpawn,_aiDifficultyLevel,_vehiclePatrolParameters,true,_uniforms,_headGear,_vests,_backpacks,_weaponList,_sideArms,false,_vehicleCrewCount /*,blck_UMS_weapons,blck_UMS_vests,isScubaMission*/ ] call blck_fnc_spawnMissionVehiclePatrols;
	_missionAIVehicles append (_temp select 0);
	_blck_AllMissionAI append (_temp select 1);
};
// Spawn any submarine patrols
if (blck_useVehiclePatrols &&  count _submarinePatrolParameters > 0) then
{
	// params["_coords","_noVehiclePatrols","_aiDifficultyLevel","_missionPatrolVehicles",["_useRelativePos",true],["_uniforms",blck_SkinList], ["_headGear",blck_headgear],["_vests",blck_vests],["_backpacks",blck_backpacks],["_weaponList",[]],["_sideArms",blck_Pistols], ["_isScubaGroup",false]];
	_temp = [_coords,_vehToSpawn,_aiDifficultyLevel,_submarinePatrolParameters,true,blck_UMS_uniforms,blck_UMS_headgear,blck_UMS_vests,[],blck_UMS_weapons,[],isScubaMission] call blck_fnc_spawnMissionVehiclePatrols;
	_missionAIVehicles append  (_temp select 0);
	_blck_AllMissionAI append (_temp select 1);
};

uiSleep delayTime;

_noChoppers = [_noChoppers] call blck_fnc_getNumberFromRange;
_noPara = [_noPara] call blck_fnc_getNumberFromRange;

if (_noChoppers > 0) then
{
	for "_i" from 1 to (_noChoppers) do
	{
		if (random(1) < _chanceHeliPatrol) then
		{
			//_temp = [_coords,_missionHelis,spawnHeli,_aiDifficultyLevel,_chancePara,_noPara,_uniforms,_headGear,_vests,_backpacks,_weaponList,_sideArms] call blck_fnc_spawnMissionReinforcements;
			_temp = [_coords,_aiDifficultyLevel,_missionHelis] call blck_fnc_spawnMissionHeli;
			blck_monitoredVehicles pushBack (_temp select 0);
			_blck_AllMissionAI append (_temp select 1);
		};
	};
};

//////////////////////////
// Spawn Crates and Emplaced Weapons Last to try to force them to correct positions relative to spawned buildinga or other objects.

uiSleep 15;
private["_noEmplacedToSpawn"];
_noEmplacedToSpawn = [_noEmplacedWeapons] call blck_fnc_getNumberFromRange;
//diag_log format["_dynamicUMSspawner:: _noEmplacedToSpawn = %1",_vehToSpawn];
if (blck_useStatic && ((_noEmplacedToSpawn > 0)) || count _missionEmplacedWeapons > 0) then
{
	_temp = [_coords,_missionEmplacedWeapons,true,_noEmplacedToSpawn,_aiDifficultyLevel,_uniforms,_headGear,_vests,_backpacks,_weaponList,_sideArms] call blck_fnc_spawnEmplacedWeaponArray;
	_objects append (_temp select 0);
	_blck_AllMissionAI append (_temp select 1);
};

uiSleep _delayTime;
if (isNil "blck_UMS_crates") then {blck_UMS_crates = blck_crateTypes};
if (blck_UMS_crates isEqualTo []) then {blck_UMS_crates = blck_crateTypes};
if (_spawnCratesTiming isEqualTo "atMissionSpawnGround") then
{
	if (count _missionLootBoxes > 0) then
	{
		_crates = [_coords,_missionLootBoxes,_loadCratesTiming, _spawnCratesTiming, "start", _aiDifficultyLevel] call blck_fnc_spawnMissionCrates;
	}
	else
	{
		_crates = [_coords,[[selectRandom blck_crateTypes,[0,0,0],_crateLoot,_lootCounts]], _loadCratesTiming, _spawnCratesTiming, "start", _aiDifficultyLevel] call blck_fnc_spawnMissionCrates;
	};

	if (blck_cleanUpLootChests) then
	{
		_objects append _crates;
	};
};

if (blck_cleanUpLootChests) then
{
	_objects append _crates;
};
if (_noPara > 0 && (random(1) < _chancePara) && _paraTriggerDistance == 0) then
{
	private _paratroops = [_coords,_noPara,_aiDifficultyLevel,blck_UMS_uniforms,blck_UMS_headgear,blck_UMS_vests,[],blck_UMS_weapons,[],isScubaMission] call blck_fnc_spawnParaUnits;
	if !(isNull _paratroops) then 
	{
		_blck_AllMissionAI append (units _paratroops);
	};
	if (random(1) < _chanceLoot) then
	{
		private _extraCrates = [_coords,[[selectRandom blck_crateTypes,[0,0,0],_paraLoot,_paraLootCounts]], "atMissionSpawn","atMissionStartAir", "start", _aiDifficultyLevel] call blck_fnc_spawnMissionCrates;
		if (blck_cleanUpLootChests) then
		{
			_objects append _extraCrates;
		};		
	};
};

// Trigger for mission end
private["_missionComplete","_endIfPlayerNear","_endIfAIKilled"];
_missionComplete = -1;
_startTime = diag_tickTime;
if (blck_showCountAliveAI) then
{
	if !(_marker isEqualTo "") then
	{
		[_marker,_markerMissionName,_blck_AllMissionAI] call blck_fnc_updateMarkerAliveCount;
		blck_missionMarkers pushBack [_marker,_markerMissionName,_blck_AllMissionAI];
	};
};
switch (_endCondition) do
{
	case "playerNear": {_endIfPlayerNear = true;_endIfAIKilled = false;};
	case "allUnitsKilled": {_endIfPlayerNear = false;_endIfAIKilled = true;};
	case "allKilledOrPlayerNear": {_endIfPlayerNear = true;_endIfAIKilled = true;};
};

private["_locations"];
_locations = [_coords];
{
	_locations pushback (getPos _x);
	_x setVariable["crateSpawnPos", (getPos _x)];
} forEach _crates;

if (blck_showCountAliveAI) then
{
	if !(_marker isEqualTo "") then
	{
		[_marker,_markerMissionName,_blck_AllMissionAI] call blck_fnc_updateMarkerAliveCount;
		blck_missionMarkers pushBack [_marker,_markerMissionName,_blck_AllMissionAI];
	};
};

private _spawnPara = if (random(1) < _chancePara) then {true} else {false};
_missionComplete = -1;
while {_missionComplete isEqualTo -1} do
{
	if ((_endIfPlayerNear) && [_locations,10,true] call blck_fnc_playerInRangeArray) exitWith {};
	if ((_endIfAIKilled) &&  ({alive _x} count _blck_AllMissionAI) < 1) exitWith {};

	if (_spawnCratesTiming isEqualTo "atMissionSpawn") then
	{
		{
			if ({[_x] call blck_fnc_crateMoved} count _crates > 0) exitWith
			{
				_missionComplete = 1;
				_crateStolen = true;
			};
		}forEach _crates;
	};
	if (_spawnPara) then
	{
		
		if ([_coords,_paraTriggerDistance,true] call blck_fnc_playerInRange) then
		{
			_spawnPara = false; // The player gets one try to spawn these.
			if (random(1) < _chancePara) then  //  
			{
				// blck_UMS_uniforms,blck_UMS_headgear,blck_UMS_vests,[],blck_UMS_weapons,[],isScubaMission] call blck_fnc_spawnParaUnits;] call blck_fnc_spawnParaUnits;
				private _paratroops = [_coords,_noPara,_aiDifficultyLevel,blck_UMS_uniforms,blck_UMS_headgear,blck_UMS_vests,[],blck_UMS_weapons,[],isScubaMission] call blck_fnc_spawnParaUnits;
				if !(isNull _paratroops) then 
				{
					_blck_AllMissionAI append (units _paratroops);
				};
				if (random(1) < _chanceLoot) then
				{
					private _extraCrates = [_coords,[[selectRandom blck_crateTypes,[0,0,0],_paraLoot,_paraLootCounts]], "atMissionSpawn","atMissionStartAir", "start", _aiDifficultyLevel] call blck_fnc_spawnMissionCrates;
					if (blck_cleanUpLootChests) then
					{
						_objects append _extraCrates;
					};		
				};	
			};
		};	
	};
	//diag_log format["dynamicUMSspawner:: (483) missionCompleteLoop - > players near = %1 and ai alive = %2 and crates stolen = %3",[_coords,20] call blck_fnc_playerInRange, {alive _x} count _blck_AllMissionAI, _crateStolen];
	uiSleep 4;
};
if (_crateStolen) exitWith
{
	//diag_log format["dynamicUMSspawner:: (542) Crate Stolen Callening _fnc_endMission - > players near = %1 and ai alive = %2 and crates stolen = %3",[_locations,10,true] call blck_fnc_playerInRangeArray, {alive _x} count _blck_AllMissionAI, _crateStolen];
	[_mines,_objects,_crates, _blck_AllMissionAI,"Crate Removed from Mission Site Before Mission Completion: Mission Aborted",_blck_localMissionMarker,_coords,_mission,2,isScubaMission] call blck_fnc_endMission;
};

if (_spawnCratesTiming in ["atMissionEndGround","atMissionEndAir"]) then
{
	if (count _missionLootBoxes > 0) then
	{
		_crates = [_coords,_missionLootBoxes,_loadCratesTiming,_spawnCratesTiming, "end", _aiDifficultyLevel] call blck_fnc_spawnMissionCrates;
	}
	else
	{
		_crates = [_coords,[[selectRandom blck_crateTypes,[0,0,0],_crateLoot,_lootCounts]], _loadCratesTiming,_spawnCratesTiming, "end", _aiDifficultyLevel] call blck_fnc_spawnMissionCrates;
	};
	
	if (blck_cleanUpLootChests) then
	{
		_objects append _crates;
	};
};

if (_spawnCratesTiming isEqualTo "atMissionSpawnGround" && _loadCratesTiming isEqualTo "atMissionCompletion") then
{
	{
		[_x] call blck_fnc_loadMissionCrate;
	} forEach _crates;
};

private["_result"];
// Force passing the mission name for informational purposes.
_blck_localMissionMarker set [2, _markerMissionName];
if (blck_showCountAliveAI) then
{
	//_marker setMarkerText format["%1: All AI Dead",_markerMissionName];
	{
		if ((_x select 1) isEqualTo _markerMissionName) exitWith{blck_missionMarkers deleteAt _forEachIndex};
	}forEach blck_missionMarkers;
};
// params["_mines","_objects","_crates","_blck_AllMissionAI","_endMsg","_blck_localMissionMarker","_coords","_mission",["_endCondition",0],["_vehicles",[]],["_isScubaMission",false]];
_result = [_mines,_objects,_crates,_blck_AllMissionAI,_endMsg,_blck_localMissionMarker,_coords,_mission,0,_missionAIVehicles,isScubaMission] call blck_fnc_endMission;

blck_missionsRun = blck_missionsRun + 1;
diag_log format["[blckeagls] dynamicUMSspawner:: Total Dyanamic Land and UMS Run = %1", blck_missionsRun];
