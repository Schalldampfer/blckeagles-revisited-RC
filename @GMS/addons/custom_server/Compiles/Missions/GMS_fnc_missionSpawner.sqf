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
private ["_abort","_crates","_aiGroup","_objects","_groupPatrolRadius","_missionLandscape","_mines","_blck_AllMissionAI","_assetKilledMsg","_enemyLeaderConfig",
		"_AI_Vehicles","_timeOut","_aiDifficultyLevel","_missionPatrolVehicles","_missionGroups","_loadCratesTiming","_spawnCratesTiming","_assetSpawned","_hostageConfig",
		"_chanceHeliPatrol","_noPara","_chanceLoot","_heliCrew","_loadCratesTiming","_useMines","_blck_AllMissionAI","_delayTime","_groupPatrolRadius",
		"_wait","_missionStartTime","_playerInRange","_missionTimedOut","_temp","_patrolVehicles","_vehToSpawn","_noChoppers","_chancePara","_paraSkill","_marker","_vehicleCrewCount",
		"_defaultMissionLocations","_garrisonedbuildings_buildingposnsystem","_garrisonedBuilding_ATLsystem", "_isScubaMission","_markerlabel","_missionLootBoxes"];
		
params["_coords","_markerName","_aiDifficultyLevel"];
if (isNil "_markerLabel") then {_markerLabel = _markerMissionName};
[_markerName,  "active",_coords] call blck_fnc_updateMissionQue;

diag_log format["[blckeagls] missionSpawner (17):: Initializing mission: _cords %1 : _markerName %2 :  _aiDifficultyLevel %3",_coords,_markerName,_aiDifficultyLevel,_markerLabel];

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
if (isNil "_airpatrols") then {_airpatrols = []};
if (isNil "_submarinePatrolParameters") then {_submarinePatrolParameters = []};

if (isNil "_scubagroupparameters") then {_scubagroupparameters = []};
if (isNil "_markerMissionName") then {
	diag_log format["_fnc_missionSpawner: _markerMissionName not defined, using default value"];
	_markerMissionName = "Default Mission Name";
};
switch (_markerColor) do {
		case "ColorBlue":{ _markerMissionName = "[Easy] " + _markerMissionName; };
		case "ColorRed":{ _markerMissionName = "[Medium] " + _markerMissionName; };
		case "ColorGreen":{ _markerMissionName = "[Hard] " + _markerMissionName; };
		case "ColorOrange":{ _markerMissionName = "[Extreme] " + _markerMissionName; };
		default {};
};
if (isNil "_noLootCrates") then {_noLootCrates = 1};
if (isNil "_lootCrates") then {_lootCrates = blck_crateTypes};
if (isNil "_lootCratePositions") then {_lootCratePositions = []};

if (isNil "_isScubaMission") then {_isScubaMission = false};
if (isNil "_missionLootBoxes") then {_missionLootBoxes = []};
private "_temp";

// If the mission is to be spawned at pre-defined coordinates then select one from the array that defines them 
// otherwise use the _coords that were passed to the script in _this
if (isNil "_defaultMissionLocations") then {_defaultMissionLocations = []};
if !(_defaultMissionLocations isEqualTo []) then 
{
	_coords = selectRandom _defaultMissionLocations;
};

blck_ActiveMissionCoords pushback _coords; 
blck_missionsRunning = blck_missionsRunning + 1;
//diag_log format["_fnc_missionSpawner:  count blck_ActiveMissionCoords = %1 | blck_ActiveMissionCoords = %2",count blck_ActiveMissionCoords,blck_ActiveMissionCoords];

_objects = [];
_mines = [];
_crates = [];
_aiGroup = [];
_missionAIVehicles = [];
_blck_AllMissionAI = [];
_AI_Vehicles = [];

#define delayTime 1
#define useRelativePos true

#ifdef blck_debugMode
diag_log "_missionSpawner:  All variables initialized";
#endif
private _markerPos = _coords;
 
if !(blck_preciseMapMarkers) then
{
	private _markerPos = [_coords,75] call blck_fnc_randomPosition;
	//diag_log format["_fnc_missionSpawner (110): _markerPos = %1",_markerPos];
} ;

[["start",_startMsg,_markerMissionName]] call blck_fnc_messageplayers;


_markerType params["_type",["_size",[250,250]],["_brush","GRID"]];
_markers = [_markerName,_markerPos,_markerMissionName,_markerColor,_type,_size,_brush] call blck_fnc_createMissionMarkers;


#ifdef blck_debugMode
if (blck_debugLevel > 0) then {diag_log "missionSpawner:: (145) message players and spawn a mission marker";};
if (blck_debugLevel > 0) then {diag_log format["missionSpawner:: (146) _markers = %1",_markers];};
if (blck_debugLevel > 0) then {diag_log "missionSpawner:: (147) waiting for player to trigger the mission";};
#endif
////////
//  All parameters are defined, lets wait until a player is nearby or the mission has timed out
////////

_missionStartTime = diag_tickTime;
_playerInRange = false;
_missionTimedOut = false;
_wait = true;

#ifdef blck_debugMode
if (blck_debugLevel > 0) then {
	diag_log "missionSpawner:: (90) starting mission trigger loop"};
	diag_log format["missionSpawner (163) blck_MissionTimeout = %1", blck_MissionTimeout];
#endif

while {_wait} do
{
	//#ifdef blck_debugMode
	if (blck_debugLevel > 2) exitWith {_playerInRange = true;diag_log "_fnc_missionSpawner (168): player trigger loop triggered by scripting";};
	//#endif

	if ([_coords, blck_TriggerDistance, false] call blck_fnc_playerInRange) exitWith {_playerInRange = true;};
	if ([_missionStartTime,blck_MissionTimeout] call blck_fnc_timedOut) exitWith {_missionTimedOut = true;};
	uiSleep 5;

	#ifdef blck_debugMode
	if (blck_debugLevel > 3) then
	{
		diag_log format["missionSpawner:: Trigger Loop - blck_debugLevel = %1 and _coords = %2",blck_debugLevel, _coords];
		diag_log format["missionSpawner:: Trigger Loop - players in range = %1",{isPlayer _x && _x distance2D _coords < blck_TriggerDistance} count allPlayers];
		diag_log format["missionSpawner:: Trigger Loop - blck_MissionTimeout = %4 | _missionStartTime = %1 | time = %2 | timeout = %3",_missionStartTime, diag_tickTime, [_missionStartTime,blck_MissionTimeout] call blck_fnc_timedOut,blck_MissionTimeout];
	};
	#endif
};

if (_missionTimedOut) exitWith
{
	
	
	diag_log format["_fnc_missionSpawner (187): mission timed out: _markerName %1 | _markerLabel %2 | time %3",_markerName,_markerLabel,diag_tickTime];

	[_coords,_mines,_objects,_crates, _blck_AllMissionAI,_endMsg,_markers,_markerPos,_markerName,_markerMissionName,  1] call blck_fnc_endMission;
};

////////////////////////////////////////////////
// Spawn the mission objects, loot chest, and AI
///////////////////////////////////////////////
#ifdef blck_debugMode
if (blck_debugLevel > 0) then
{		
	diag_log format["[blckeagls] missionSpawner:: (200) --  >>  Mission tripped: _cords %1 : _markerName %2 :  _aiDifficultyLevel %3 _markerLabel %4",_coords,_markerName,_aiDifficultyLevel,_markerMissionName];
};
#endif

if (blck_SmokeAtMissions select 0) then  // spawn a fire and smoke near the crate
{
	_temp = [_coords,blck_SmokeAtMissions select 1] call blck_fnc_smokeAtCrates;
	if (typeName _temp isEqualTo "ARRAY") then 
	{
		_objects append _temp;
	};
};

uiSleep  delayTime;
if (_useMines) then
{
	_mines = [_coords] call blck_fnc_spawnMines;

};
uiSleep  delayTime;
_temp = [];

if (_missionLandscapeMode isEqualTo "random") then
{
	_temp = [_coords,_missionLandscape, 3, 15, 2] call blck_fnc_spawnRandomLandscape;
} else {
	
	_temp = [_coords, _missionLandscape] call blck_fnc_spawnCompositionObjects;
};
if (typeName _temp isEqualTo "ARRAY") then
{
	_objects append _temp;
};

#ifdef blck_debugMode
if (blck_debugLevel > 0) then
{
	diag_log format["[blckeagls] missionSpawner:: (219) Landscape spawned: _cords %1 : _markerName %2 :  _aiDifficultyLevel %3 _markerLabel %4",_coords,_markerName,_aiDifficultyLevel,_markerLabel];
};
#endif

uiSleep  delayTime;

_abort = false;
_temp = [];

_temp = [_coords, _minNoAI,_maxNoAI,_noAIGroups,_missionGroups,_aiDifficultyLevel,_uniforms,_headGear,_vests,_backpacks,_weaponList,_sideArms] call blck_fnc_spawnMissionAI;

_abort = _temp select 1;

if !(_abort) then 
{
	_blck_AllMissionAI append (_temp select 0);
};
//diag_log format["[blckeagls] missionSpawner:: (236) missionAI spawned: _markerName %1 : _markerLabel %2 : count _blck_AllMissionAI = %3",_markerName,_markerLabel, count _blck_AllMissionAI];
if !(_scubaGroupParameters isEqualTo []) then
{
	#define isScubaMission true
	private _temp = [_coords, _minNoAI,_maxNoAI,count _scubaGroupParameters,_scubaGroupParameters,_aiDifficultyLevel,blck_UMS_uniforms,blck_UMS_headgear,blck_UMS_vests,[],blck_UMS_weapons,[],_isScubaMission] call blck_fnc_spawnMissionAI;

	uiSleep 2;
	_abort = _temp select 1;

	if !(_abort) then 
	{
		_blck_AllMissionAI append (_temp select 0);
	};
};



_assetSpawned = objNull;
if !(_hostageConfig isEqualTo []) then
{
	_temp = [_coords,_hostageConfig] call blck_fnc_spawnHostage;
	_assetSpawned = _temp select 0;
	_objects pushBack (_temp select 1);
	_blck_AllMissionAI pushBack _assetSpawned;
};

if !(_enemyLeaderConfig isEqualTo []) then
{
	_temp = [_coords,_enemyLeaderConfig] call blck_fnc_spawnLeader;
	_assetSpawned = _temp select 0;
	_objects pushBack (_temp select 1);	
	_blck_AllMissionAI pushBack _assetSpawned;
};

uiSleep  delayTime;
_temp = [[],[],false];
_abort = false;

//  Deal with helicopter patrols
_temp = [];
_noChoppers = [_noChoppers] call blck_fnc_getNumberFromRange;
if (_noChoppers > 0) then
{
	for "_i" from 1 to (_noChoppers) do
	{
		if (random(1) < _chanceHeliPatrol) then
		{
			_temp = [_coords,_aiDifficultyLevel,_missionHelis,_uniforms,_headGear,_vests,_backpacks,_weaponList, _sideArms,"none"] call blck_fnc_spawnMissionHeli;

			if (typeName _temp isEqualTo "ARRAY") then
			{
				_abort = _temp select 2;
				if !(_abort) then
				{
					blck_monitoredVehicles pushBack (_temp select 0);
					_blck_AllMissionAI append (_temp select 1);
				};
			};
		};
	};
};



uisleep 3;
if !(_garrisonedBuilding_ATLsystem isEqualTo []) then
{
	_temp = [_coords, _garrisonedBuilding_ATLsystem, _aiDifficultyLevel,_uniforms,_headGear,_vests,_backpacks,_weaponList,_sideArms] call blck_fnc_garrisonBuilding_ATLsystem;
	_objects append (_temp select 1);
	blck_monitoredVehicles append (_temp select 2);
	_blck_AllMissionAI append (units (_temp select 0));
};




uiSleep 3;
if !(_garrisonedBuildings_BuildingPosnSystem isEqualTo []) then
{
	_temp = [_coords, _garrisonedBuildings_BuildingPosnSystem, _aiDifficultyLevel,_uniforms,_headGear,_vests,_backpacks,_weaponList,_sideArms] call blck_fnc_garrisonBuilding_RelPosSystem;
	_objects append (_temp select 1);
	blck_monitoredVehicles append (_temp select 2);
	_blck_AllMissionAI append (units (_temp select 0));
};



uiSleep 15;
private["_noEmplacedToSpawn"];
_noEmplacedToSpawn = [_noEmplacedWeapons] call blck_fnc_getNumberFromRange;
if (blck_useStatic && (_noEmplacedToSpawn > 0)) then
{
	_temp = [_coords,_missionEmplacedWeapons,useRelativePos,_noEmplacedToSpawn,_aiDifficultyLevel,_uniforms,_headGear,_vests,_backpacks,_weaponList,_sideArms] call blck_fnc_spawnEmplacedWeaponArray;
	_temp params ["_emplacedObjects","_units","_abort"];
	_objects append _emplacedObjects;
	_blck_AllMissionAI append _units;
};



_vehToSpawn = [_noVehiclePatrols] call blck_fnc_getNumberFromRange;
if (blck_useVehiclePatrols && ((_vehToSpawn > 0) || !(_missionPatrolVehicles isEqualTo []) )) then
{
	_temp = [_coords,_vehToSpawn,_aiDifficultyLevel,_missionPatrolVehicles,useRelativePos,_uniforms,_headGear,_vests,_backpacks,_weaponList,_sideArms,false,_vehicleCrewCount] call blck_fnc_spawnMissionVehiclePatrols;

	_temp params ["_patrolVehicles","_units","_abort"];
	_blck_AllMissionAI append _units; 
};

// Spawn any submarine patrols
if (blck_useVehiclePatrols &&  !(_submarinePatrolParameters isEqualTo []) ) then
{

	_temp = [_coords,_vehToSpawn,_aiDifficultyLevel,_submarinePatrolParameters,true,_umsUniforms,_umsHeadgear,_umsVests,[],_umsWeapons,[],isScubaMission] call blck_fnc_spawnMissionVehiclePatrols;
	_missionAIVehicles append  (_temp select 0);
	_blck_AllMissionAI append (_temp select 1);
};

uiSleep  delayTime;


if (_spawnCratesTiming isEqualTo "atMissionSpawnGround") then
{
	if !(_missionLootBoxes isEqualTo []) then
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
uiSleep  delayTime;;



if !(_missionLootVehicles isEqualTo []) then
{
	_temp = [_coords,_missionLootVehicles,_loadCratesTiming,0] call blck_fnc_spawnMissionLootVehicles;
	_crates append _temp;
};
if (_noPara > 0 && (random(1) < _chancePara) && _paraTriggerDistance == 0) then
{

	private _paratroops = [_coords,_noPara,_aiDifficultyLevel,_uniforms,_headGear,_vests,_backpacks,_weaponList,_sideArms] call blck_fnc_spawnParaUnits;
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



private["_missionComplete","_endIfPlayerNear","_endIfAIKilled","_secureAsset","_crateStolen","_locations"];
_missionComplete = -1;
_startTime = diag_tickTime;



switch (_endCondition) do
{
	case "playerNear": {_secureAsset = false; _endIfPlayerNear = true;_endIfAIKilled = false;};
	case "allUnitsKilled": {_secureAsset = false; _endIfPlayerNear = false;_endIfAIKilled = true;};
	case "allKilledOrPlayerNear": {_secureAsset = false; _endIfPlayerNear = true;_endIfAIKilled = true;};
	case "assetSecured": {_secureAsset = true; _endIfPlayerNear = false; _endIfAIKilled = false;};
};

if (blck_showCountAliveAI) then
{

	blck_missionLabelMarkers pushBack [_markers select 1,_markerMissionName,_blck_AllMissionAI];
};

_crateStolen = false;
_locations = [_coords];
private _spawnPara = if (random(1) < _chancePara) then {true} else {false};
{
	_locations pushback (getPos _x);
	_x setVariable["crateSpawnPos", (getPos _x)];
} forEach _crates;

private["_minNoAliveForCompletion","_result","_minPercentageKilled"];
_minNoAliveForCompletion = (count _blck_AllMissionAI) - (round(blck_killPercentage * (count _blck_AllMissionAI)));
if (_secureAsset) then {_minNoAliveForCompletion = _minNoAliveForCompletion + 1};

while {_missionComplete isEqualTo -1} do
{
	#ifdef blck_debugMode
	if (blck_debugLevel > 3) exitWith {uiSleep blck_triggerLoopCompleteTime;diag_log "_missionSpawner (492) scripted Mission End blck_debugLevel = 3";};
	#endif
	
	if (_endIfPlayerNear) then
	{
		if ([_locations,20,true] call blck_fnc_playerInRangeArray) then {_missionComplete = 1};
	};

	if (_endIfAIKilled) then
	{
		if (({alive _x} count _blck_AllMissionAI) <= _minNoAliveForCompletion) then {_missionComplete = 1};
	};

	if (_spawnCratesTiming isEqualTo "atMissionSpawnGround") then
	{
		{
			private _d = _x distance (_x getVariable ["crateSpawnPos",_coords]);

			if (_d > 25) exitWith
			{
				_missionComplete = 1;
				_crateStolen = true;
			};
		}forEach _crates;
	};
	
	if (_secureAsset) then
	{
		if !(alive _assetSpawned) then 
		{
			_missionComplete = 1;
			[_assetSpawned] remoteExec["GMS_fnc_clearAllActions",-2, true];		
		} else {
			
			if (({alive _x} count _blck_AllMissionAI) <= _minNoAliveForCompletion) then
			{
				if ((_assetSpawned getVariable["blck_unguarded",0]) isEqualTo 0) then 
				{
					_assetSpawned setVariable["blck_unguarded",1,true];
				};
				
				if ((_assetSpawned getVariable["blck_AIState",0]) isEqualTo 1) then 
				{
					_missionComplete = 1;
					_assetSpawned allowdamage false;
					[_assetSpawned] remoteExec["GMS_fnc_clearAllActions",-2, true];
				};
				
			};
		};
	};
	if (_spawnPara) then
	{
		if ([_coords,_paraTriggerDistance,true] call blck_fnc_playerInRange) then
		{
			_spawnPara = false; // The player gets one try to spawn these.
			if (random(1) < _chancePara) then  //  
			{
				private _paratroops = [_coords,_noPara,_aiDifficultyLevel,_uniforms,_headGear,_vests,_backpacks,_weaponList,_sideArms] call blck_fnc_spawnParaUnits;
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
	uiSleep 1;
};

if (_crateStolen) exitWith
{

	[_coords,_mines,_objects,_crates, _blck_AllMissionAI,"Crate Removed from Mission Site Before Mission Completion: Mission Aborted",_markers,_markerPos,_markerName,_markerLabel,  2] call blck_fnc_endMission;
};

if (_spawnCratesTiming in ["atMissionEndGround","atMissionEndAir"]) then
{
	if (!(_secureAsset) || (_secureAsset && (alive _assetSpawned))) then
	{
		if !(_missionLootBoxes isEqualTo []) then
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
};


if (_spawnCratesTiming isEqualTo "atMissionSpawnGround" && _loadCratesTiming isEqualTo "atMissionCompletion") then
{
	if (!(_secureAsset) || (_secureAsset && (alive _assetSpawned))) then
	{
		{
			[_x] call blck_fnc_loadMissionCrate;
		} forEach _crates;
	};
};

private["_result"];



if (_secureAsset && (alive _assetSpawned)) then
{
	if (_assetSpawned getVariable["assetType",0] isEqualTo 1) then
	{
		_assetSpawned setVariable["GMSAnimations",[""],true];
		[_assetSpawned,""] remoteExec["switchMove",-2];;
		uiSleep 0.1;
		_assetSpawned enableAI "ALL";
		private _newPos = (getPos _assetSpawned) getPos [1000, random(360)];
		(group _assetSpawned) setCurrentWaypoint [group _assetSpawned, 0];
		[group _assetSpawned,0] setWaypointPosition [_newPos,0];
		[group _assetSpawned,0] setWaypointType "MOVE";
	};

	if (_assetSpawned getVariable["assetType",0] isEqualTo 2) then
	{
		[_assetSpawned,""] remoteExec["switchMove",-2];
		_assetSpawned setVariable["GMSAnimations",_assetSpawned getVariable["endAnimation",["AidlPercMstpSnonWnonDnon_AI"]],true];
		[_assetSpawned,selectRandom(_assetSpawned getVariable["endAnimation",["AidlPercMstpSnonWnonDnon_AI"]])] remoteExec["switchMove",-2];
	};
};
if (_secureAsset && !(alive _assetSpawned)) then
{

	[_coords,_mines,_objects,_crates,_blck_AllMissionAI,_assetKilledMsg,_markers,_markerPos,_markerName,_markerLabel, -1] call blck_fnc_endMission;
};

if (!(_secureAsset) || (_secureAsset && (alive _assetSpawned))) then
{
	[_coords,_mines,_objects,_crates,_blck_AllMissionAI,_endMsg,_markers,_markerPos,_markerName,_markerLabel, 0] call blck_fnc_endMission;
};


diag_log format["_fnc_missionSpawner (643) Mission Completed | _cords %1 : _markerName %2 :  _aiDifficultyLevel %3 _markerLabel %4",_coords,_markerName,_aiDifficultyLevel,_markerLabel];
blck_missionsRun = blck_missionsRun + 1;
diag_log format["_fnc_missionSpawner (644): Total Dyanamic Land and UMS Run = %1", blck_missionsRun];
