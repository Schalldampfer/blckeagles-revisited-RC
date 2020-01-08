/*
	GMS_fnc_monitorInitializedMissions

*/
//diag_log format["fnc_monitorInitializedMissions: time = %1 | count  blck_activeMissionsList %2 | blck_activeMissionsList %3",diag_tickTime,count blck_activeMissionsList,blck_activeMissionsList];
for "_i" from 1 to (count blck_activeMissionsList) do 
{

	if (_i > (count blck_activeMissionsList)) exitWith {};
	
	// Select a mission category (blue, red, green , etd)
	private _el = blck_activeMissionsList deleteAt 0;
	//diag_log format["fnc_monitorInitializedMissions: _el = %1",_el];
	// [_missionCategoryDescriptors,_missionTimeoutAt,_triggered,_spawnPara,_missionData,_missionParameters];
	_el params [
		"_missionCategoryDescriptors",  // 0
		"_missionTimeoutAt",			// 1
		"_triggered",					// 2
		"_spawnPara",					// 3
		"_missionData",					// 6
		"_missionParameters"			// 7
	];
	/*
	{
		diag_log format["_fnc_monitorInitializedMissions: _el:%1 = %2",_x, _el select _forEachIndex];
	} forEach [
		"_missionCategoryDescriptors",  // 0
		"_missionTimeoutAt",			// 1
		"_triggered",					// 2
		"_spawnPara",					// 3
		"_missionData",					// 6
		"_missionParameters"			// 7
	];
*/
/*
	private _missionCategoryDescriptors = [
		//_marker,
		_difficulty,
		_noMissions,  // Max no missions of this category
		0,  // Number active 
		//0, // times spawned, useful for keeping unique markers 
		_tMin, // Used to calculate waittime in the future
		_tMax, // as above
		_waitTime,  // time at which a mission should be spawned
		_missionsData  // 
	];
*/
	#define noActive 2
	#define waitTime 5
	#define missionData 6
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
	/*
	{
		diag_log format["fnc_monitorInitializeMission: _missionCategoryDescriptors:%1 = %2",_x,_missionCategoryDescriptors select _forEachIndex];
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
	*/
	#define setMissionData _missionData = [_coords,_mines,_objects,_crates, _blck_AllMissionAI,_assetSpawned,_missionAIVehicles,_mainMarker,_labelMarker];
	//_missionData = [_coords,_mines,_objects,_crates, _blck_AllMissionAI,_assetSpawned,_missionAIVehicles,_mainMarker,_labelMarker];
						//   0       1       2          3         4                   5            6 
	_missionData params ["_coords","_mines","_objects","_crates","_blck_AllMissionAI","_assetSpawned","_missionAIVehicles","_mainMarker","_labelMarker"];
	
	/*
	{
		diag_log format["_fnc_monitorInitializedMissions: _missionData:%1 = %2",_x, _missionData select _forEachIndex];
	} forEach ["_coords","_mines","_objects","_crates","_blck_AllMissionAI","_assetSpawned","_missionAIVehicles","_mainMarker","_labelMarker"];
	*/

	_missionParameters params[
		//"_markerClass",
		"_defaultMissionLocations",		
		"_crateLoot", // 0
		"_lootCounts", // 1
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
		"_noEmplacedToSpawn",
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
	
	//diag_log format["_fnc_monitorInitializedMissions:time = %1 | _missionTimout = %2",diag_tickTime,_missionTimeoutAt];

	//diag_log format["_fnc_monitorInitializedMissions: _coords = %1",_coords];
	//private _playesrNear = [_coords, blck_TriggerDistance] call blck_fnc_nearestPlayers;
	private _playerInRange = [_coords, blck_TriggerDistance, false] call blck_fnc_playerInRange;
	//diag_log format["_fnc_moniorInitializedMissions: _coords = %1 | _playerInRange %3 | _triggered = %4 | _missionTimeoutAt = %5",_coords,_playerInRange,_triggered,_missionTimeoutAt];
	#define delayTime 1

	private _monitorAction = -2;

	if (_triggered isEqualTo 0) then 
	{
		if (diag_tickTime > _missionTimeoutAt) then 
		{
			_monitorAction = -1;
		} else {
			if (_playerInRange) then {
				_monitorAction = 0;
			} else {
				if (blck_debugLevel >= 3) then {_monitorAction = 0};
			};
		};
	} else {
		if (_triggered isEqualTo 1) then 
		{
				_monitorAction = 1;
		}; 
	};
	//diag_log format["_monitorInitializedMissions(149): _triggered = %1 | _monitorAction = %2",_triggered,_monitorAction];
	private _blck_localMissionMarker = [_markerType,_coords,"","",_markerColor,_markerType];	
	switch (_monitorAction) do 
	{
		// Handle Timeout
		case -1:
		{
				diag_log format["_fnc_monitorInitializedMissions: mission timed out: %1",_el];
				_missionCategoryDescriptors set[noActive, _noActive - 1];
				[_mines,_objects,_crates, _blck_AllMissionAI,_endMsg,_blck_localMissionMarker,_coords,_markerType,  1] call blck_fnc_endMission;			
		}; 			
		
		//  Handle mission waiting to be triggerd and player is within the range to trigger		
		case 0: 
		{
			if (blck_debugLevel >= 3) then 
			{
				diag_log format["_fnc_moniorInitializedMissions: blck_debugLevel == 3, spawning objects for mission %1",_el];
			} else {
				//diag_log format["_fnc_moniorInitializedMissions: mission TRIGGERED by player: spawning objects for mission %1",_el];
			};

			#define triggered 2
			#define timedOut 1
			_el set[triggered,1];
			_el set[timedOut,diag_tickTime + 240];
			//diag_log format["_fnc_monitorInitializedMissions (167): spawning smoking wrecks as needed: blck_smokeAtMissions == %1",blck_SmokeAtMissions];
			private["_temp"];
			if (blck_SmokeAtMissions select 0) then  // spawn a fire and smoke near the crate
			{
				_temp = [_coords,blck_SmokeAtMissions select 1] call blck_fnc_smokeAtCrates;
				if (typeName _temp isEqualTo "ARRAY") then 
				{
					_objects append _temp;
					uiSleep delayTime;
				};
			};
			
			//diag_log format["_fnc_monitorInitializedMissions (193): spawning mines as needed: _useMines == %1",_useMines];
			if (_useMines) then
			{
				_mines = [_coords] call blck_fnc_spawnMines;
				uiSleep delayTime;
			};

			//diag_log format["_fnc_monitorInitializedMissions (200): spawning landscape as needed: _missionLandscapeMode = %1 |  _missionLandscape = %2",_missionLandscapeMode,_missionLandscape];
			if (_missionLandscapeMode isEqualTo "random") then
			{
				_temp = [_coords,_missionLandscape, 3, 15, 2] call blck_fnc_spawnRandomLandscape;
			} else {

				_temp = [_coords, _missionLandscape] call blck_fnc_spawnCompositionObjects;
			};
			_objects append _temp;
			uiSleep delayTime;	

			try {

				//diag_log format["_fnc_monitorInitializedMissions (213): spawning AI Patrols as needed: _missionGroups == %1",_missionGroups];
				_temp = [_coords, _minNoAI,_maxNoAI,_noAIGroups,_missionGroups,_difficulty,_uniforms,_headGear,_vests,_backpacks,_weaponList,_sideArms] call blck_fnc_spawnMissionAI;
				_temp params["_ai","_abort"];
				if (_abort) throw 1;
				_blck_AllMissionAI append (_ai);
				uiSleep delayTime;		

				//diag_log format["_fnc_monitorInitializedMissions (220): spawning hostages as needed: _hostageConfig == %1",_hostageConfig];
				//private ["_assetSpawned"];
				if !(_hostageConfig isEqualTo []) then
				{
					_temp = [_coords,_hostageConfig] call blck_fnc_spawnHostage;
					if (_temp isEqualTo grpNull) then {throw 1} else 
					{
						_assetSpawned = _temp select 0;
						//									0    1        2           3         4                    5              6             7
						//  	_missionData params ["_coords","_mines","_objects","_crates","_blck_AllMissionAI","_assetSpawned","_mainMarker","_labelMarker"];
						_missionData set[5,_assetSpawned];
						_objects pushBack (_temp select 1);
						_blck_AllMissionAI pushBack _assetSpawned;
					};
				};

				//diag_log format["_fnc_monitorInitializedMissions (234): spawning leaders as needed: _enemyLeaderConfig == %1",_enemyLeaderConfig];
				if !(_enemyLeaderConfig isEqualTo []) then
				{
					private _temp = [_coords,_enemyLeaderConfig] call blck_fnc_spawnLeader;
					if (_temp isEqualTo grpNull) then {throw 1} else 
					{
						_assetSpawned = _temp select 0;
						_missiondata set[5,_assetSpawned];
						_objects pushBack (_temp select 1);	
						_blck_AllMissionAI pushBack _assetSpawned;
					};
				};

				//diag_log format["_fnc_monitorInitializedMissions (248): spawning chopers as needed: _noChoppers = %1 | _chanceHeliPatrol = %2 | _missionHelis = %3",_noChoppers,_chanceHeliPatrol,_missionHelis];
				private _noChoppers = [_noChoppers] call blck_fnc_getNumberFromRange;
				if (_noChoppers > 0) then
				{
					for "_i" from 1 to (_noChoppers) do
					{
						if (random(1) < _chanceHeliPatrol) then
						{
							_temp = [_coords,_difficulty,_missionHelis,_uniforms,_headGear,_vests,_backpacks,_weaponList, _sideArms,"none"] call blck_fnc_spawnMissionHeli;
							if (typeName _temp isEqualTo "ARRAY") then 
							{
								blck_monitoredVehicles pushBack (_temp select 0);
								_blck_AllMissionAI append (_temp select 1);
							} else {
								if (typeName _temp isEqualTo "GROUP") then 
								{
									if (isNull _temp) throw 1;
								};
							};
						};
					};
				};		
				uisleep 3;

				//diag_log format["_fnc_monitorInitializedMissions (271): spawning garrisons using ATL coordinate system as needed: _garrisonedBuilding_ATLsystem == %1",_garrisonedBuilding_ATLsystem];
				if (count _garrisonedBuilding_ATLsystem > 0) then  // Note that there is no error checking here for nulGroups
				{
					private _temp = [_coords, _garrisonedBuilding_ATLsystem, _difficulty,_uniforms,_headGear,_vests,_backpacks,_weaponList,_sideArms] call blck_fnc_garrisonBuilding_ATLsystem;
					if (_temp isEqualTo grpNull) then {throw 1} else 
					// TODO: Add error checks for grpNull to the ATLsystem spawner
					{				
						_objects append (_temp select 1);
						blck_monitoredVehicles append (_temp select 2);
						_blck_AllMissionAI append (units (_temp select 0));
					};
				};	
				uiSleep 3;

				//diag_log format["_fnc_monitorInitializedMissions (285): spawning garrisons using relative coordinate system as needed: _garrisonedBuildings_BuildingPosnSystem == %1",_garrisonedBuildings_BuildingPosnSystem];
				if (count _garrisonedBuildings_BuildingPosnSystem > 0) then
				{
					private _temp = [_coords, _garrisonedBuildings_BuildingPosnSystem, _difficulty,_uniforms,_headGear,_vests,_backpacks,_weaponList,_sideArms] call blck_fnc_garrisonBuilding_RelPosSystem;
					if (_temp isEqualTo grpNull) then {throw 1} else 
					// TODO: add error checks for grpNull to the RelPosSystem
					{
						_objects append (_temp select 1);
						blck_monitoredVehicles append (_temp select 2);
						_blck_AllMissionAI append (units (_temp select 0));
					};
				};		
				uiSleep 15;

				private _userelativepos = true;
				//diag_log format["_fnc_monitorInitializedMissions (300): spawning static turrets needed: _noEmplacedToSpawn == %1 | _missionEmplacedWeapons = %2",_noEmplacedToSpawn,_missionEmplacedWeapons];
				private _noEmplacedToSpawn = [_noEmplacedToSpawn] call blck_fnc_getNumberFromRange;
				if (blck_useStatic && ((_noEmplacedToSpawn > 0) || count _missionEmplacedWeapons > 0)) then
				// TODO: add error checks for grpNull to the emplaced weapon spawner
				{

					private _temp = [_coords,_missionEmplacedWeapons,_userelativepos,_noEmplacedToSpawn,_difficulty,_uniforms,_headGear,_vests,_backpacks,_weaponList,_sideArms] call blck_fnc_spawnEmplacedWeaponArray;
					if (_temp isEqualTo grpNull) then {throw 1} else 
					{
						_objects append (_temp select 0);
						_blck_AllMissionAI append (_temp select 1);
					};
				};	
				uisleep 10;

				//diag_log format["_fnc_monitorInitializedMissions (316): spawning patrol vehicles as needed: _noVehiclePatrols == %1 | _missionPatrolVehicles = %2",_noVehiclePatrols,_missionPatrolVehicles];
				private _noVehiclePatrols = [_noVehiclePatrols] call blck_fnc_getNumberFromRange;
				if (blck_useVehiclePatrols && ((_noVehiclePatrols > 0) || count _missionPatrolVehicles > 0)) then
				{
					_temp = [_coords,_noVehiclePatrols,_difficulty,_missionPatrolVehicles,_userelativepos,_uniforms,_headGear,_vests,_backpacks,_weaponList,_sideArms,false,_vehicleCrewCount] call blck_fnc_spawnMissionVehiclePatrols;
					// TODO: add grpNull checks to missionVehicleSpawner
					if (_temp isEqualTo grpNull) then {throw 1} else 
					{
						_patrolVehicles = _temp select 0;
						_blck_AllMissionAI append (_temp select 1);
					};
				};		
				uiSleep  delayTime;

				/*
				diag_log format["_fnc_monitorInitializedMissions (329): spawning loot crates as needed: _crates = %1 | _loadCratesTiming = %2 | _spawnCratesTiming = %3| _missionLootBoxes = %4",
				_crates,
				_loadCratesTiming,
				_spawnCratesTiming,
				_missionLootBoxes
				];
				*/
				//									0    1        2           3         4                    5              6             7
				//  	_missionData [_coords,_mines,_objects,_crates, _blck_AllMissionAI,_asset,_mainMarker,_labelMarker];

				if (_spawnCratesTiming isEqualTo "atMissionSpawnGround") then
				{
					if (_missionLootBoxes isEqualTo []) then
					{
						_crates = [_coords,[[selectRandom blck_crateTypes,[1,1,0],_crateLoot,_lootCounts]], _loadCratesTiming, _spawnCratesTiming, "start", _difficulty] call blck_fnc_spawnMissionCrates;
					}
					else
					{
						_crates = [_coords,_missionLootBoxes,_loadCratesTiming, _spawnCratesTiming, "start", _difficulty] call blck_fnc_spawnMissionCrates;						
					};

					if (blck_cleanUpLootChests) then
					{
						_objects append _crates;
					};
				};
				_missionData set[2,_objects];
				_missionData set[3,_crates];				
				
				/*
				diag_log format["_fnc_monitorInitializedMissions (352): spawning loot crates as needed: _crates = %1 | _loadCratesTiming = %2 | _spawnCratesTiming = %3| _missionLootBoxes = %4",
				_crates,
				_loadCratesTiming,
				_spawnCratesTiming,
				_missionLootBoxes
				];	
				*/

				uiSleep  delayTime;

				//diag_log format["_fnc_monitorInitializedMissions (348): Indicating live AI as needed: blck_showCountAliveAI = %1",blck_showCountAliveAI];
				if (blck_showCountAliveAI) then
				{
						//diag_log format['_fnc_monitorInitializeMissions(367): _mainMarker = %1 | _labelMarker = %2 | _markerMissionName = %3 | count _blck_AllMissionAI = %4',_mainMarker,_labelMarker, _markerMissionName,_blck_AllMissionAI];
						[_mainMarker,_labelMarker,_markerMissionName,_blck_AllMissionAI] call blck_fnc_updateMarkerAliveCount;
				};
				{
					_x setVariable["crateSpawnPos", (getPos _x)];
				} forEach _crates;			
				private _spawnPara = if (random(1) < _chancePara) then {true} else {false};
				setMissionData  //  code defined above
				//{diag_log format["_monotirInitializedMissions:(371) _missiondata %1 = %2",_forEachIndex,_x]} forEach _missionData;

				_el set[missionData, _missionData];

				// Everything spawned withouth serous errors so lets keep the mission active for future monitoring

				blck_activeMissionsList pushBack _el;	
				//diag_log format["_fnc_monitorInitializedMissions (366): all objects, men and vehicles spawened, blck_activeMissionsList= %1", blck_activeMissionsList];										
			} 
			
			catch 
			{
				if (_exception isEqualTo 1) then 
				{
					_missionCategoryDescriptors set[noActive, _noActive - 1];				
					[_mines,_objects,_crates, _blck_AllMissionAI,_endMsg,_mainMarker,_labelMarker,_markerType,_coords,  1] call blck_fnc_endMission;	
					diag_log format["[blkeagls] <WARNING> grpNull returned by one or more critical functions, mission spawning aborted!"];
				};
			};
		};

		case 1:
		{
			//diag_log format["_fnc_moniorInitializedMissions(398): evaluating status of mission %1 | _missionTimeoutAt = %2 | time = %3 | _crates = %4",_el,_missionTimeoutAt,diag_tickTime,_crates];
			private _missionComplete = -1;
			private _crateStolen = -1;
			private ["_secureAsset","_endIfPlayerNear","_endIfAIKilled"];
		
			switch (_endCondition) do
			{
				case "playerNear": {_secureAsset = false; _endIfPlayerNear = true;_endIfAIKilled = false;};
				case "allUnitsKilled": {_secureAsset = false; _endIfPlayerNear = false;_endIfAIKilled = true;};
				case "allKilledOrPlayerNear": {_secureAsset = false; _endIfPlayerNear = true;_endIfAIKilled = true;};
				case "assetSecured": {_secureAsset = true; _endIfPlayerNear = false; _endIfAIKilled = false;};
			};
			if (blck_showCountAliveAI) then
			{
				[_mainMarker,_labelMarker,_markerMissionName,_blck_AllMissionAI] call blck_fnc_updateMarkerAliveCount;
			};
			try {
				private _playerIsNear = [_crates,20,true] call blck_fnc_playerInRangeArray;
				private _minNoAliveForCompletion = (count _blck_AllMissionAI) - (round(blck_killPercentage * (count _blck_AllMissionAI)));			
				private _aiKilled = if (({alive _x} count _blck_AllMissionAI) <= _minNoAliveForCompletion)  then {true} else {false}; // mission complete
				//diag_log format["_fnc_monitorInitializedMissions (404): _playerIsNear = %1 | _aiKilled = %2 | _crates = %3",_playerIsNear,_aiKilled,_crates];
				if (_endIfPlayerNear) then
				{
					//diag_log format["_fnc_monitorInitializedMissions: mission ended, condition player near, mission %1",_el];
					if (_playerIsNear) throw 1; // mission complete
				};

				if (_endIfAIKilled) then
				{
					//diag_log format["_fnc_monitorInitializedMissions: mission ended, condition AI Killed, mission %1",_el];	
					if (_aiKilled) throw 1;
				};

				if (_spawnCratesTiming isEqualTo "atMissionSpawnGround") then
				{
					{
						private _d = _x distance (_x getVariable ["crateSpawnPos",_coords]);
						if (_d > 25) then 
						{
							//diag_log format["_fnc_monitorInitializedMissions: mission ended, condition CRATE MOVED, mission %1",_el];
							throw 2;
						}; // crate moved illegally
					}forEach _crates;
				};

				if (_spawnPara) then
				{
					if ([_coords,_paraTriggerDistance,true] call blck_fnc_playerInRange) then
					{
						_spawnPara = false; // The player gets one try to spawn these.
						_el set[3,_spawnPara];
						if (random(1) < _chancePara) then  //  
						{
							private _paratroops = [_coords,_noPara,_difficulty,_uniforms,_headGear,_vests,_backpacks,_weaponList,_sideArms] call blck_fnc_spawnParaUnits;
							if !(isNull _paratroops) then 
							{
								_blck_AllMissionAI append (units _paratroops);
							};
							if (random(1) < _chanceLoot) then
							{
								private _extraCrates = [_coords,[[selectRandom blck_crateTypes,[0,0,0],_paraLoot,_paraLootCounts]], "atMissionSpawn","atMissionStartAir", "start", _difficulty] call blck_fnc_spawnMissionCrates;
								if (blck_cleanUpLootChests) then
								{
									_objects append _extraCrates;
								};		
							};	
						};
					};
				};

				if (_secureAsset) then
				{		
					!(alive _assetSpawned) then {throw 3} else 
					{
						if (({alive _x} count _blck_AllMissionAI) <= _minNoAliveForCompletion) then
						{
							if ((_assetSpawned getVariable["blck_unguarded",0]) isEqualTo 0) then 
							{
								_assetSpawned setVariable["blck_unguarded",1,true];
							};
							
							if ((_assetSpawned getVariable["blck_AIState",0]) isEqualTo 1) then 
							{
								_assetSpawned allowdamage false;
								[_assetSpawned] remoteExec["GMS_fnc_clearAllActions",-2, true];
								throw 1;								
							};
						};
					};
				};
				if (blck_debugLevel > 3 && diag_tickTime > _missionTimeoutAt) then 
				{
					diag_log format["_monitoInitializeMissions: debugLevel == 3, mission triggered, timout condition reached, ending mission"];
					throw 1;

				};
				setMissionData  // Code defined above
				#define missionData 6
				_el set[missionData, _missionData];

				// If there were no throws then lets check on the mission in a bit.
				blck_activeMissionsList pushBack _el;	
			}

			catch // catch all conditions that cause the mission to end.
			{
				//diag_log format["_fnc_monitorInitializeMissions (507): _exception = %1",_exception];
				switch (_exception) do 
				{
					case 1: {  // Normal Mission End
								if (_spawnCratesTiming in ["atMissionEndGround","atMissionEndAir"]) then
								{
									if (!(_secureAsset) || (_secureAsset && (alive _assetSpawned))) then
									{
										if (count _missionLootBoxes > 0) then
										{
											_crates = [_coords,_missionLootBoxes,_loadCratesTiming,_spawnCratesTiming, "end", _difficulty] call blck_fnc_spawnMissionCrates;
										}
										else
										{
											_crates = [_coords,[[selectRandom blck_crateTypes,[0,0,0],_crateLoot,_lootCounts]], _loadCratesTiming,_spawnCratesTiming, "end", _difficulty] call blck_fnc_spawnMissionCrates;
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

								_blck_localMissionMarker set [2, _markerMissionName];

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
								diag_log format["_fnc_monitorInitializedMissions (430) calling <_fnc_endMission> | _cords %1 : _markerType %2 :  _difficulty %3 _markerMissionName %4",_coords,_markerType,_difficulty,_markerMissionName];														
								// 	params ["_mines","_objects","_crates","_blck_AllMissionAI","_endMsg","_mainMarker","_labelMarker","_markerClass","_coords",["_endCondition",0]];
								[_mines,_objects,_crates,_blck_AllMissionAI,_endMsg,_mainMarker,_labelMarker,_markerType,_coords, 0] call blck_fnc_endMission;
								//diag_log format["_fnc_monitorInitializedMissions (430) Mission Completed | _cords %1 : _markerType %2 :  _difficulty %3 _markerMissionName %4",_coords,_markerType,_difficulty,_markerMissionName];						
								_waitTime = diag_tickTime + _tMin + random(_tMax - _tMin);
								/*
								 _missionCategoryDescriptors params [
									//"_marker",
									"_difficulty",  0
									"_noMissions",  1  // Max no missions of this category
									"_noActive",  2  // Number active 
									//"_timesSpawned", // times spawned, useful for keeping unique markers 
									"_tMin", 3  // Used to calculate waittime in the future
									"_tMax", 4  // as above
									"_waitTime",  5  // time at which a mission should be spawned
									"_missionsData"  // 
								];
								*/
								_missionCategoryDescriptors set [noActive,_noActive - 1];
								_missionCategoryDescriptors set [waitTime,_waitTime];
								/*
								{
									diag_log format["_fnc_monitorInitializedMissions (570): _missionCategoryDescriptors parameter %1 = %2",_x,_missionCategoryDescriptors select _forEachIndex];
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
								*/
					};
					case 2: { // Abort, crate moved.
								[_mines,_objects,_crates, _blck_AllMissionAI,"Crate Removed from Mission Site Before Mission Completion: Mission Aborted",_markerMissionName,_coords,_markerType,  2] call blck_fnc_endMission;
								_endMsg = "Crate Removed from Mission Site Before Mission Completion: Mission Aborted";
								[_mines,_objects,_crates,_blck_AllMissionAI,_endMsg,_mainMarker,_labelMarker,_markerType,_coords, 0] call blck_fnc_endMission;
							};
					case 3: {  // Abort, key asset killed				
								[_mines,_objects,_crates,_blck_AllMissionAI,_endMsg,_mainMarker,_labelMarker,_markerType,_coords, 0] call blck_fnc_endMission;
							};
				};
			};
		};
		default 
		{
			blck_activeMissionsList pushBack _el;
		};
	};
};