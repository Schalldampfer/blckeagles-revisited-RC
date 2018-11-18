/*
	by Ghostrider [GRG]
	Copyright 2016
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

//static mission descriptor for code: [position,level, numAI or [min,maxAI],patrolRadius, respawn, group[groupNull],spawnedAt[0],respawn[0]]
#include "\q\addons\custom_server\Configs\blck_defines.hpp";
#include "\q\addons\custom_server\Missions\UMS\GMS_UMS_StaticMissions_Lists.sqf";



private["_mod","_map","_missionMod","_missionMap","_missionLocation","_missionDataFile"];
_mod = toLower(toLower blck_modType);


{
	if ((toLower worldName) isEqualTo toLower(_x select 1)) then
	{
		if ((_mod isEqualTo "epoch") && (toLower(_x select 0) isEqualTo "epoch")) then
		{
			
			call compilefinal preprocessFileLineNumbers format["\q\addons\custom_server\Missions\UMS\staticMissions\%1",(_x select 2)];
		};

		if ((_mod isEqualTo "exile") && (toLower(_x select 0) isEqualTo "exile")) then
		{
			call compilefinal preprocessFileLineNumbers format["\q\addons\custom_server\Missions\UMS\staticMissions\%1",(_x select 2)];
		};
	};
}forEach _staticMissions;


