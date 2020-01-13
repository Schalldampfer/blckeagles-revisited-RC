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
_crateLoot = blck_BoxLoot_Orange;
_lootCounts = blck_lootCountsOrange;
_startMsg = "An enemy research center was sighted in a nearby sector! Check the Orange marker on your map for the location!";
_endMsg = "The Sector at the Orange Marker is under survivor control!";

_markerType = ["ellipse",[250,250],"Cross"];
_markerColor = "ColorPink";
_markerLabel = "";
_markerMissionName = "Soylent Green";

_missionLandscapeMode = "precise"; // acceptable values are "none","random","precise"

//////////
//   Past the output of the script here
_garrisonedBuildings_BuildingPosnSystem = [
];

_garrisonedBuilding_ATLsystem = [
     ["Land_Offices_01_V1_F",[-37.4473,-24.3594,4.76837e-007],269.862,true,true,
        [
                #ifdef blck_milServer
                ["O_Radar_System_02_F",[27.1289,15.6582,-2.38419e-007],0],
                #endif
                ["O_HMG_01_high_F",[1.91211,10.3887,0.915],96.7764],
                ["O_HMG_01_F",[-6.00781,11.4434,0.915001],186.886],
                ["O_Mortar_01_F",[-0.0390625,-2.37891,17.852],208.222],
                ["O_HMG_01_high_F",[-7.19141,11.9668,17.8518],308.501],
                ["O_GMG_01_high_F",[-7.29492,-15.7617,17.8518],232.577]
        ],
        []],
     ["Land_Offices_01_V1_F",[-30.4688,17.5137,4.76837e-007],0,true,true,[["O_HMG_01_high_F",[10.4004,-2.66406,0.914999],181.335],["O_HMG_01_F",[11.4473,5.94141,0.915],272.565],["O_static_AA_F",[-2.10938,0.380859,17.6633],308.394],["O_HMG_01_high_F",[11.7383,7.01758,17.8518],58.5428],["O_GMG_01_high_F",[-15.666,7.14453,17.8518],322.918]],[]],
     ["Land_Offices_01_V1_F",[4.64063,-32.6953,4.76837e-007],179.838,true,true,[["O_HMG_01_high_F",[-10.3906,2.07813,0.915],0],["O_HMG_01_F",[-11.4414,-5.97852,0.915001],90.6397],["O_static_AA_F",[3.31055,0.535156,17.8518],130.28],["O_HMG_01_high_F",[-11.709,-6.99219,17.8518],230.558],["O_GMG_01_high_F",[15.8945,-7.25195,17.8518],144.952]],[]],
     ["Land_Offices_01_V1_F",[14.7305,9.32617,4.76837e-007],89.712,true,true,[["O_HMG_01_high_F",[-2.4082,-10.3828,0.915],272.89],["O_HMG_01_F",[6.36328,-11.4355,0.915001],0],["O_Mortar_01_F",[-0.0273438,2.89258,17.8518],30.2156],["O_HMG_01_high_F",[7.41211,-11.8789,17.8518],151.994],["O_GMG_01_high_F",[7.23828,15.8262,17.8518],53.1106]],[]]
];

_missionLandscape = [
     ["Land_HBarrier_01_line_5_green_F",[-49.4258,-8.95898,0],35.5083,true,true],
     ["Land_HBarrier_01_line_5_green_F",[-50.459,3.74805,0],130.91,true,true],
     ["Land_HBarrier_01_line_5_green_F",[-53.6367,-2.9082,0],271.072,true,true],
     ["Land_SandbagBarricade_01_hole_F",[-32.1289,-2.82031,0],85.991,true,true],
     ["Land_HBarrier_01_line_5_green_F",[-10.8418,-45.0996,0],316.085,true,true],
     ["Land_HBarrier_01_line_5_green_F",[-23.8027,-45.4668,0],39.0453,true,true],
     ["Land_HBarrier_01_line_5_green_F",[-17.7578,-48.5176,0],0,true,true],
     ["Land_SandbagBarricade_01_hole_F",[-17.4551,-28.5508,0],0,true,true],
     ["Land_SandbagBarricade_01_hole_F",[-9.41406,2.51953,0],0,true,true],
     ["Land_HBarrier_01_line_5_green_F",[-7.30664,31.8574,0],0,true,true],
     ["Land_HBarrier_01_line_5_green_F",[-14.8711,29.2754,0],320.811,true,true],
     ["Land_HBarrier_01_line_5_green_F",[25.8145,-19.0801,0],314.213,true,true],
     ["Land_SandbagBarricade_01_hole_F",[-1.125,-13.3516,0],269.802,true,true],
     ["Land_HBarrier_01_line_5_green_F",[27.041,-5.65234,0],237.111,true,true],
     ["Land_HBarrier_01_line_5_green_F",[0.744141,30.1113,0],207.1,true,true],
     ["Land_HBarrier_01_line_5_green_F",[29.6445,-12.6523,0],89.2182,true,true]
];

_missionLootBoxes = [
];

_missionLootVehicles = [
];

_missionPatrolVehicles = [
         #ifdef blck_milServer
        ["O_Radar_System_02_F",[27.1289,15.6582,-2.38419e-007],0],
        ["O_T_APC_Tracked_02_AA_ghex_F",[-62.4141,31.1484,2.38419e-007],297.601],
        ["O_MBT_04_command_F",[-56.8105,-47.6035,0],227.158],
        ["O_MBT_04_command_F",[27.918,39.0273,0],29.7763],
        ["O_T_APC_Tracked_02_AA_ghex_F",[37.4941,-42.7852,2.38419e-007],109.403],        
        ["O_T_LSV_02_armed_F",[-69.6152,-6.05859,0],205.251],
        ["O_T_LSV_02_AT_F",[51.2461,-15.6367,0],0]
        #else 

        #endif
];

_submarinePatrolParameters = [
];

_airPatrols = [
     ["O_Heli_Attack_02_dynamicLoadout_F",[-107.992,41.2598,186.215],0],
     ["O_Heli_Light_02_dynamicLoadout_F",[52.3965,14.125,121.794],221.059]
];

_missionEmplacedWeapons = [

];

_missionGroups = [
     [[-2542.97,1313.37,4577.72],3,6,"Orange",30,45],
     [[-41.7031,-5.2207,0.00143886],3,6,"Orange",30,45],
     [[-19.2266,-35.998,0.00143886],3,6,"Orange",30,45],
     [[-14.5547,-25.7461,0.00143886],3,6,"Orange",30,45],
     [[-2.14453,6.67773,0.00143886],3,6,"Orange",30,45],
     [[-27.1367,1.83398,0.00143886],3,6,"Orange",30,45],
     [[-11.2852,20.4746,0.00143886],3,6,"Orange",30,45],
     [[16.5527,-11.834,0.00143886],3,6,"Orange",30,45],
     [[5.4375,-15.7051,0.00143886],3,6,"Orange",30,45]
];

_scubaGroupParameters = [
];



//////////
//   The lines below define additional variables you may wish to configure.


//  Change _useMines to true/false below to enable mission-specific settings.
_useMines = blck_useMines;
_minNoAI = blck_MinAI_Orange;
_maxNoAI = blck_MaxAI_Orange;
_noAIGroups = blck_AIGrps_Orange;
_noVehiclePatrols = blck_SpawnVeh_Orange;
_noEmplacedWeapons = blck_SpawnEmplaced_Orange;

//  Change _useMines to true/false below to enable mission-specific settings.
_useMines = blck_useMines;  // Setting this in the mission file overrides the defaults 
_uniforms = blck_SkinList;  // Setting this in the mission file overrides the defaults 
_headgear = blck_headgear;  // Setting this in the mission file overrides the defaults 
_vests = blck_vests;
_backpacks = blck_backpacks;
_weaponList = ["Orange"] call blck_fnc_selectAILoadout;
_sideArms = blck_Pistols;
_chanceHeliPatrol = blck_chanceHeliPatrolOrange;  // Setting this in the mission file overrides the defaults 
_noChoppers = blck_noPatrolHelisOrange;
_missionHelis = blck_patrolHelisOrange;

_chancePara = blck_chanceParaOrange; // Setting this in the mission file overrides the defaults 
_noPara = blck_noParaOrange;  // Setting this in the mission file overrides the defaults 
_paraTriggerDistance = 400; // Distance from mission at which a player triggers these reinforcements and any supplemental loot. 						// To have paras spawn at the time the mission spawns with/without accompanying loot set this to 0.
_paraSkill = "Orange";  // Choose any skill you like; bump up skill or add AI to justify more valuable loot.
_chanceLoot = 0.0; 
_paraLoot = blck_BoxLoot_Orange;
_paraLootCounts = blck_lootCountsOrange;  // Throw in something more exotic than found at a normal Orange mission.

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
#include "\q\addons\custom_server\Compiles\Missions\GMS_fnc_missionSpawner.sqf";
