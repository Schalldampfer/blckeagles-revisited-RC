/*
	By Ghostrider [GRG]
	Copyright 2016
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

// parameters for _fnc_initializeMission
// params["_missionCategoryDescriptors","_missionParameters"];
for "_i" from 1 to (count blck_initializedMissionsList) do 
{
	if (_i > (count blck_initializedMissionsList)) exitWith {};
	// params[["_coords",[]],["_range",0],["_onFootOnly",false]];
	private _mission = blck_initializedMissionsList deleteAt 0;
	private _missionInitialized = [_mission select 0,_mission select 1] call blck_fnc_initializeMission;
	//diag_log format['_fnc_spawnInitializedMissions (22): _missionInitialized = %1 for _mission = %2',_missionInitialized,_mission];
	uisleep 1;
	if !(_missionInitialized) then 
	{
		blck_initializedMissionsList pushBack _mission;
		//diag_log format["fnc_spawnInitializedMissions: player near selected spawn location, defering till next cycle"];
	};
};