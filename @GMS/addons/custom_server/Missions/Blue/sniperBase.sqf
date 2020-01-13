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

//diag_log "[blckeagls] Spawning blue Mission with template = default";
_crateLoot = blck_BoxLoot_blue;
_lootCounts = blck_lootCountsblue;
_startMsg = "An enemy sniper base was sighted in a nearby sector! Check the blue marker on your map for the location!";
_endMsg = "The sniper base is under survivor control!";

_markerMissionName = "Snipers";
_missionLandscapeMode = "precise"; // acceptable values are "none","random","precise"

//////////
//   Past the output of the script here
_markerType = ["ELLIPSE",[150,150],"GRID"];
_markerColor = "ColorBlue";
_markerLabel = "";


_garrisonedBuildings_BuildingPosnSystem = [
];

_garrisonedBuilding_ATLsystem = [
];

_missionLandscape = [
     ["Land_W_sharpRock_apart",[-33.6221,-30.3281,-0.00143909],0,true,true],
     ["Land_PaperBox_closed_F",[-2.8418,-6.85547,-0.00143909],0,true,true],
     ["Land_BagBunker_Tower_F",[-11.3848,-14.0015,-0.00143909],270.925,true,true],
     ["Campfire_burning_F",[-2.02588,-2.06641,-0.00143909],0,true,true],
     ["Land_MedicalTent_01_MTP_closed_F",[-0.307617,-16.1699,-0.00143909],0,true,true],
     ["Land_BagBunker_Tower_F",[-10.3452,10.9658,-0.00143909],89.9776,true,true],
     ["Land_Scrap_MRAP_01_F",[-21.4419,9.74609,-0.00143909],268.595,true,true],
     ["Land_MedicalTent_01_MTP_closed_F",[-18.3423,-0.807617,-0.00143909],268.829,true,true],
     ["Land_Limestone_01_apart_F",[-21.1758,32.8794,-0.00143909],0,true,true],
     ["Land_BagBunker_Tower_F",[10.4399,-13.6836,-0.00143909],269.494,true,true],
     ["Land_Cliff_boulder_F",[23.2451,-22.4072,-0.00143909],0,true,true],
     ["Land_MedicalTent_01_MTP_closed_F",[13.2949,-1.83154,-0.00143909],90.3645,true,true],
     ["Land_BagBunker_Tower_F",[10.3564,10.1025,-0.00143909],89.7075,true,true],
     ["Land_PaperBox_open_full_F",[4.02588,7.57764,-0.00143909],0,true,true],
     ["Land_MedicalTent_01_MTP_closed_F",[0.0830078,15.2441,-0.00143909],0,true,true],
     ["Land_Limestone_01_spike_F",[28.3145,34.4702,-0.00143909],0,true,true]
];

_missionLootBoxChoices = [
     ["Box_NATO_WpsSpecial_F",[-3.34033,1.96777,-0.00144005],_crateLoot,_lootCounts,360],
     ["Land_CargoBox_V1_F",[-7.19092,3.10742,0.0291028],_crateLoot,_lootCounts,1.99369e-005],
     ["Land_CargoBox_V1_F",[-7.13135,5.33545,0.0291038],_crateLoot,_lootCounts,359.999],
     ["Box_NATO_Wps_F",[-1.1499,2.29102,-0.00144005],_crateLoot,_lootCounts,360],
     ["Land_TentDome_F",[1.91309,-2.93213,-0.00143909],_crateLoot,_lootCounts,0],
     ["Land_TentDome_F",[2.39795,1.80518,-0.00143909],_crateLoot,_lootCounts,0]
];
_missionLootBoxes = [];
for "_i" from 1 to (floor(random(3)) + 1) do
{
	_missionLootBoxes pushBack (selectRandom _missionLootBoxChoices);
};
_missionLootVehicles = [
];

_missionPatrolVehicles = [
     //["B_LSV_01_armed_F",[-30.9727,-11.311,-0.023613],0.00171228],
     //["B_MRAP_01_hmg_F",[24.6577,5.46826,-0.012536],0.000195805]
];

_submarinePatrolParameters = [
];

_airPatrols = [
];

_missionEmplacedWeapons = [
];

_missionGroups = [
     //[[-11.4458,-1.25,0],3,6,"Red",30,45],
     //[[-16.7178,8.44629,0],3,6,"Red",30,45],
     //[[11.1196,-8.32813,0],3,6,"Red",30,45],
     //[[6.56494,-3.40234,0],3,6,"Red",30,45],
     //[[2.40869,-6.76172,0],3,6,"Red",30,45]
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
