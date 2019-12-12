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
private["_chopperType","_patrolHeli","_launcherType","_unitPilot","_unitCrew","_mags","_turret","_return","_abort","_supplyHeli","_minDist","_maxDist"];
params["_coords","_skillAI","_helis",["_uniforms",[]], ["_headGear",[]],["_vests",[]],["_backpacks",[]],["_weaponList",[]],["_sideArms",[]],["_Launcher","none"],["_crewCount",4]];

if (_uniforms isEqualTo []) 		then {_uniforms = [_skillAI] call blck_fnc_selectAIUniforms};
if (_headGear  isEqualTo [])		then {_headGear = [_skillAI] call blck_fnc_selectAIHeadgear};
if (_vests isEqualTo []) 			then {_vests = [_skillAI] call blck_fnc_selectAIVests};
if (_backpacks  isEqualTo []) 		then {_backpacks = [_skillAI] call blck_fnc_selectAIBackpacks};
if (_weaponList  isEqualTo []) 		then {_weaponList = [_skillAI] call blck_fnc_selectAILoadout};
if (_sideArms isEqualTo []) 		then {[_skillAI] call blck_fnc_selectAISidearms};

switch (toLower(_skillAI)) do
{
	case "blue": {_minDist = 150;_maxDist = blck_maxPatrolRadiusHelisBlue};
	case "red" : {_minDist = 150;_maxDist = blck_maxPatrolRadiusHelisRed};
	case "green" : {_minDist = 150;_maxDist = blck_maxPatrolRadiusHelisGreen};
	case "orange" : {_minDist = 150;_maxDist = blck_maxPatrolRadiusHelisOrange};
	default {_minDist = 150; _maxDist = 500};
};
private ["_return"];
try 
{
	private _grpPilot = [blck_AI_Side,true]  call blck_fnc_createGroup;
	if (isNull _grpPilot) then {throw 1};
	[_grpPilot,_coords,_coords,_crewCount,_crewCount,_skillAI,_minDist,_maxDist,true,_uniforms,_headgear,_vests,_backpacks,_weaponList,_sideArms,false] call blck_fnc_spawnGroup;
	_grpPilot setBehaviour "SAFE";
	_grpPilot setCombatMode "RED";
	_grpPilot setSpeedMode "NORMAL";
	_grpPilot allowFleeing 0;
	_grpPilot setVariable["patrolCenter",_coords];
	_grpPilot setVariable["minDis",_minDist];
	_grpPilot setVariable["maxDis",_maxDist];
	_grpPilot setVariable["timeStamp",diag_tickTime];
	_grpPilot setVariable["arc",0];
	_grpPilot setVariable["wpRadius",0];
	_grpPilot setVariable["wpMode","SAD"];

	#define aircraftWaypointTimeout [1,1.5,2]
	[_coords,_minDist,_maxDist,_grpPilot,"random","SAD","aircraft",_maxDist,aircraftWaypointTimeout] call blck_fnc_setupWaypoints;
	blck_monitoredMissionAIGroups pushBack _grpPilot;

	//create helicopter and spawn it
	if (( typeName _helis) isEqualTo "ARRAY") then 
	{
		_chopperType = selectRandom _helis
	} else {
		_chopperType = _helis
	};
	
	//_patrolHeli = createVehicle [_chopperType, _coords, [], 90, "FLY"];
	_patrolHeli = [_chopperType,_coords,"FLY"] call blck_fnc_spawnVehicle;
	[_patrolHeli,2] call blck_fnc_configureMissionVehicle;
	_patrolHeli setVariable["blck_vehicleSearchRadius",blck_playerDetectionRangeAir];
	_patrolHeli setVariable["blck_vehiclePlayerDetectionOdds",blck_vehiclePlayerDetectionOdds];
	_patrolHeli setFuel 1;
	_patrolHeli engineOn true;
	_patrolHeli flyInHeight 100;
	[_patrolHeli,_grpPilot,_crewCount] call blck_fnc_loadVehicleCrew;
	//diag_log format["[blckeagls] _fnc_spawnMissionHeli:: _patrolHeli %1 | _grpPilot %2 | _abort %3",_patrolHeli,_grpPilot,_abort];
	_return = [_patrolHeli,units _grpPilot];
}

catch 
{
	_return = grpNull;
	diag_log format["[blckeagls] <WARNING> createGroup returned grpNull"];
};

_return;
