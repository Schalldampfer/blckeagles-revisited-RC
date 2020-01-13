/*
	Mission Template by Ghostrider [GRG]
	Mission Compositions by Bill prepared for ghostridergaming
	Copyright 2016
	Last modified 3/20/17
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";
#include "\q\addons\custom_server\Missions\privateVars.sqf";

//diag_log "[blckeagls] Spawning Blue Mission with template = default";
_crateLoot = blck_BoxLoot_Blue;
_lootCounts = blck_lootCountsBlue;
_startMsg = "An enemy cache of supplies was sighted in a nearby sector! Check the Blue marker on your map for the location!";
_endMsg = "The supply cache is under survivor control!";

_markerMissionName = "Survival Supplies";
_missionLandscapeMode = "precise"; // acceptable values are "none","random","precise"

//////////
//   Past the output of the script here
_markerType = ["ELLIPSE",[50,50],"GRID"];
_markerColor = "ColorBlue";
_markerLabel = "";


_garrisonedBuildings_BuildingPosnSystem = [
];

_garrisonedBuilding_ATLsystem = [
];

_missionLandscape = [
     ["Land_Crane_F",[2.51807,-4.66016,-0.00143909],0,true,true],
     ["Land_Sink_F",[-3.77686,7.6582,-0.00135088],0,true,true],
     ["Land_Wreck_Truck_dropside_F",[-2.01465,-10.9937,-0.00143909],49.8078,true,true],
     ["Land_Wreck_Car2_F",[4.23486,-2.31738,-0.00143909],0,true,true],
     ["Campfire_burning_F",[8.26514,-6.04102,-0.00143909],0,true,true],
     ["Land_Timbers_F",[26.1719,2.8457,-0.00143909],0,true,true],
     ["Land_Timbers_F",[23.7666,2.78564,-0.00143909],0,true,true],
     ["Land_WoodPile_F",[10.9204,-6.24805,-0.00143909],0,true,true],
     ["Land_Wreck_Offroad_F",[18.9897,-2.52344,-0.00143909],129.737,true,true],
     ["Land_i_Barracks_V2_F",[6.89893,14.2139,-0.00143909],0,true,true]
];

_missionLootBoxChoices = [
     ["Land_TentDome_F",[3.95752,-7.90479,-0.00143909],_crateLoot,_lootCounts,180.277],
     ["Land_TentDome_F",[8.38623,-9.71533,-0.00143909],_crateLoot,_lootCounts,90.7262],
     ["B_supplyCrate_F",[7.30811,-1.28076,-0.00143671],_crateLoot,_lootCounts,359.999],
     ["Box_NATO_Uniforms_F",[9.19336,-1.03125,-0.00143957],_crateLoot,_lootCounts,359.999]
];
_missionLootBoxes = [];
for "_i" from 1 to (floor(random(3)) + 1) do
{
	_missionLootBoxes pushBack (selectRandom _missionLootBoxChoices);
};
_missionLootVehicles = [
];

_missionPatrolVehicles = [
];

_submarinePatrolParameters = [
];

_airPatrols = [
];

_missionEmplacedWeapons = [
	#ifdef blck_milServer
     ["I_Mortar_01_F",[4.10889,-12.8853,0.0354419],360],
     ["I_HMG_01_F",[15.5317,-3.51758,0.0759335],202.402],
     ["I_HMG_01_high_F",[9.75928,6.43506,-0.0135579],178.241]
	 #else
     [selectRandom blck_staticWeapons,[4.10889,-12.8853,0.0354419],360],
     [selectRandom blck_staticWeapons,[15.5317,-3.51758,0.0759335],202.402],
     [selectRandom blck_staticWeapons,[9.75928,6.43506,-0.0135579],178.241]
	 #endif  
	 //  selectRandom blck_staticWeapons
];

_missionGroups = [
   //  [[-3.30518,3.38721,0],3,6,"blue",30,45],
   //  [[2.85107,0.941895,0],3,6,"blue",30,45],
   //  [[13.2217,6.82227,0],3,6,"blue",30,45],
   //  [[8.5625,-3.65332,0],3,6,"blue",30,45]
];

_scubaGroupParameters = [
];



//////////
//   The lines below define additional variables you may wish to configure.


//  Change _useMines to true/false below to enable mission-specific settings.

_minNoAI = blck_MinAI_Blue;  // Setting this in the mission file overrides the defaults such as blck_MinAI_Blue
_maxNoAI = blck_MaxAI_Blue;  // Setting this in the mission file overrides the defaults 
_noAIGroups = blck_AIGrps_Blue;  // Setting this in the mission file overrides the defaults 
_noVehiclePatrols = blck_SpawnVeh_Blue;  // Setting this in the mission file overrides the defaults 
_noEmplacedWeapons = blck_SpawnEmplaced_Blue;  // Setting this in the mission file overrides the defaults 
//  Change _useMines to true/false below to enable mission-specific settings.
_useMines = blck_useMines;  // Setting this in the mission file overrides the defaults 
/*
_uniforms = blck_SkinList;  // Setting this in the mission file overrides the defaults 
_headgear = blck_headgear;  // Setting this in the mission file overrides the defaults 
_vests = blck_vests;
_backpacks = blck_backpacks;
_weaponList = ["blue"] call blck_fnc_selectAILoadout;
_sideArms = blck_Pistols;
_chanceHeliPatrol = blck_chanceHeliPatrolBlue;  // Setting this in the mission file overrides the defaults 
_noChoppers = blck_noPatrolHelisBlue;
_missionHelis = blck_patrolHelisBlue;

_chancePara = blck_chanceParaBlue; // Setting this in the mission file overrides the defaults 
_noPara = blck_noParaBlue;  // Setting this in the mission file overrides the defaults 
_paraTriggerDistance = 400; // Distance from mission at which a player triggers these reinforcements and any supplemental loot. 						// To have paras spawn at the time the mission spawns with/without accompanying loot set this to 0.
_paraSkill = "blue";  // Choose any skill you like; bump up skill or add AI to justify more valuable loot.
_chanceLoot = 0.0; 
_paraLoot = blck_BoxLoot_Blue;
_paraLootCounts = blck_lootCountsblue;  // Throw in something more exotic than found at a normal blue mission.

_spawnCratesTiming = blck_spawnCratesTiming; // Choices: "atMissionSpawnGround","atMissionEndGround","atMissionEndAir". 
						 // Crates spawned in the air will be spawned at mission center or the position(s) defined in the mission file and dropped under a parachute.
						 //  This sets the default value but can be overridden by defining  _spawnCrateTiming in the file defining a particular mission.
_loadCratesTiming = blck_loadCratesTiming; // valid choices are "atMissionCompletion" and "atMissionSpawn"; 
						// Pertains only to crates spawned at mission spawn.
						// This sets the default but can be overridden for specific missions by defining _loadCratesTiming
						
						// Examples:
						// To spawn crates at mission start loaded with gear set blck_spawnCratesTiming = "atMissionSpawnGround" && blck_loadCratesTiming = "atMissionSpawn"
						// To spawn crates at mission start but load gear only after the mission is completed set blck_spawnCratesTiming = "atMissionSpawnGround" && blck_loadCratesTiming = "atMissionCompletion"
						// To spawn crates on the ground at mission completion set blck_spawnCratesTiming = "atMissionEndGround" // Note that a loaded crate will be spawned.
						// To spawn crates in the air and drop them by chutes set blck_spawnCratesTiming = "atMissionEndAir" // Note that a loaded crate will be spawned.
_endCondition = blck_missionEndCondition;  // Options are "allUnitsKilled", "playerNear", "allKilledOrPlayerNear"
									// Setting this in the mission file overrides the defaults 
//_timeOut = -1;
*/
#include "\q\addons\custom_server\Compiles\Missions\GMS_fnc_missionSpawner.sqf";
