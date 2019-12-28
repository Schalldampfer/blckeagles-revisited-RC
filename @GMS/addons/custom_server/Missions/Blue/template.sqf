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

//diag_log "[blckeagls] Spawning Green Mission with template = default";
_crateLoot = blck_BoxLoot_Green;
_lootCounts = blck_lootCountsGreen;
_startMsg = "An enemy research center was sighted in a nearby sector! Check the Green marker on your map for the location!";
_endMsg = "The Sector at the Green Marker is under survivor control!";
_markerMissionName = "Development";


_missionLandscapeMode = "precise"; // acceptable values are "none","random","precise"

//////////
//   Paste the output of the script here
_markerType = ["mil_box",[0,0]];
_markerColor = "Default";
_markerLabel = "";

_garrisonedBuildings_BuildingPosnSystem = [
     ["Land_i_House_Big_02_V2_F",[-76.2197,64.5181,0],0,true,false,0.67,3,[],4],
     ["Land_Unfinished_Building_01_F",[-65.1536,-71.8145,0],0,true,false,0.67,3,[],4]
];

_garrisonedBuilding_ATLsystem = [
	
     ["Land_i_Shop_01_V2_F",[87.1704,-65.3169,0],0,true,false,[["B_HMG_01_high_F",[-2.15186,2.76953,0.303085],0]],[]],
     ["Land_i_House_Big_01_V3_F",[101.868,63.7637,0],0,true,false,[["B_HMG_01_high_F",[-3.44702,-2.7793,0.41],0],["B_HMG_01_high_F",[2.81006,-5.2124,3.92],0]],[]]
	 
];

_missionLandscape = [
     ["Sign_Sphere100cm_F",[-77.7651,66.4019,0.259255],0,true,true],
     ["Sign_Sphere100cm_F",[-62.7002,-68.5952,0.185],0,true,true],
     ["Land_Chapel_V2_F",[-19.5349,-23.1558,0],0,true,true],
     ["Land_CarService_F",[-19.4431,7.30078,0],0,true,true],
     ["Land_Church_01_V1_F",[13.1187,-24.9375,0],0,true,true],
     ["Land_GH_House_2_F",[17.7576,14.8853,0],0,true,true]
];

_missionLootBoxes = [
     ["Box_NATO_Wps_F",[-12.8772,-14.7461,0],_crateLoot,_lootCounts,0],
     ["Box_FIA_Ammo_F",[-11.5447,4.01025,0],_crateLoot,_lootCounts,0],
     ["IG_supplyCrate_F",[7.43652,-15.4175,0],_crateLoot,_lootCounts,0],
     ["Box_FIA_Support_F",[9.36304,4.36914,0],_crateLoot,_lootCounts,0]
];

_missionPatrolVehicles = [
     ["B_LSV_01_armed_F",[-50.4993,-5.56201,0],0],
     ["B_MRAP_01_hmg_F",[-4.58496,-51.4932,-4.76837e-007],0],
     ["B_MRAP_01_hmg_F",[-1.01758,31.3022,-4.76837e-007],0],
     ["B_LSV_01_armed_F",[38.8872,-7.23975,0],0]
];

_submarinePatrolParameters = [
];

_airPatrols = [
];

_missionEmplacedWeapons = [
     ["B_T_HMG_01_F",[-24.9949,-6.60889,0],0],
     ["B_T_HMG_01_F",[-2.10034,17.6167,0],0],
     ["B_T_HMG_01_F",[-1.02319,-24.769,0],0],
     ["B_T_HMG_01_F",[19.394,-7.26514,0],0]
];

_missionGroups = [
     [[-6.98657,-17.4019,0.00143862],3,6,"Red",30,45],
     [[-12.3303,1.17432,0.00143909],3,6,"Red",30,45],
     [[16.0247,0.0390625,0.00143909],3,6,"Red",30,45],
     [[8.53687,13.0479,0.00143909],3,6,"Red",30,45],
     [[79.074,6.02344,0.00143909],3,6,"Red",30,45]
];

_scubaGroupParameters = [
];




//////////
//  Edit these variables as needed
_crateLoot = blck_BoxLoot_Red;  				// can be individualized for a particular mission by defining a loot array.
_lootCounts = blck_lootCountsRed;  				//  can be individualized for a particular mission by defining an array with the counts of each loot type.
_minNoAI = blck_MinAI_Red;  					// can be any value
_maxNoAI = blck_MaxAI_Red;						// can be any value
_noAIGroups = blck_AIGrps_Red;					// can be any value
_noVehiclePatrols = blck_SpawnVeh_Red;			// can be any value
_noEmplacedWeapons = blck_SpawnEmplaced_Red;	// can be any value

//////////
//   The lines below define additional variables you may wish to configure.


//  Available variables you may wish to change are listed below.
/*
//  Change _useMines to true/false below to enable mission-specific settings.
_useMines = blck_useMines;  // Setting this in the mission file overrides the defaults 
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
_paraSkill = "red";  // Choose any skill you like; bump up skill or add AI to justify more valuable loot.
_chanceLoot = 0.0; 
_paraLoot = blck_BoxLoot_Blue;
_paraLootCounts = blck_lootCountsRed;  // Throw in something more exotic than found at a normal blue mission.

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
*/

//////////
//  DO NOT TOUCH ANYTHING BELOW THIS LINE

#include "\q\addons\custom_server\Compiles\Missions\GMS_fnc_missionSpawner.sqf";
