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

// params["_pos",  "_center", ["_numai1",5],  ["_numai2",10],  ["_skillLevel","red"], ["_minDist",30], ["_maxDist",45],["_configureWaypoints",true], ["_uniforms",[]], 
//["_headGear",[]],["_vests",[]],["_backpacks",[]],["_weaponList",[]],["_sideArms",[]], ["_scuba",false]];
switch (toLower(_skillAI)) do
{
	case "blue": {_minDist = 150;_maxDist = blck_maxPatrolRadiusHelisBlue};
	case "red" : {_minDist = 150;_maxDist = blck_maxPatrolRadiusHelisRed};
	case "green" : {_minDist = 150;_maxDist = blck_maxPatrolRadiusHelisGreen};
	case "orange" : {_minDist = 150;_maxDist = blck_maxPatrolRadiusHelisOrange};
	default {_minDist = 150; _maxDist = 500};
};
private _grpPilot = [] call blck_fnc_createGroup;
[_grpPilot,_coords,_coords,_crewCount,_crewCount,_skillAI,_minDist,_maxDist,true,_uniforms,_headgear,_vests,_backpacks,_weaponList,_sideArms,false] call blck_fnc_spawnGroup;
#ifdef blck_debugMode 
if (blck_debugLevel > 2) then 
{
	diag_log format["_fnc_spawnMissionHeli: _group = %1 | units _grpPilot = %2 | _crewCount = %3",_grpPilot, units _grpPilot,_crewCount];
};
#endif
_abort = if (isNull _grpPilot) then{true} else {false};
if !(isNull _grpPilot)  then
{

	_grpPilot setBehaviour "COMBAT";
	_grpPilot setCombatMode "RED";
	_grpPilot setSpeedMode "NORMAL";
	_grpPilot allowFleeing 0;
	_grpPilot setVariable["patrolCenter",_coords];
	_grpPilot setVariable["minDis",_minDist];
	_grpPilot setVariable["maxDis",_maxDist];
	_grpPilot setVariable["timeStamp",diag_tickTime];
	_grpPilot setVariable["arc",0];
	_grpPilot setVariable["wpRadius",30];
	_grpPilot setVariable["wpMode","SAD"];
	#ifdef blck_debugMode 
	if (blck_debugLevel > 2) then 
	{
		diag_log format["_fnc_spawnMissionHeli - max radii are: blue %1 | red %2 | green %3 | orange %4",blck_maxPatrolRadiusHelisBlue,blck_maxPatrolRadiusHelisRed,blck_maxPatrolRadiusHelisGreen,blck_maxPatrolRadiusHelisOrange];
		diag_log format["_fnc_spawnMissionHeli(59):  _skillAI = %1 | _minDist = %2 | _maxDist = %3",_skillAI,_minDist,_maxDist];
	};
	#endif
	[_coords,_minDist,_maxDist,_grpPilot,"random","SAD","aircraft"] call blck_fnc_setupWaypoints;


	blck_monitoredMissionAIGroups pushBack _grpPilot;
	//create helicopter and spawn it
	if (( typeName _helis) isEqualTo "ARRAY") then 
	{
		_chopperType = selectRandom _helis
	} else {
		_chopperType = _helis
	};
	
	#ifdef blck_debugMode
	if (blck_debugLevel > 1) then
	{
			diag_log format["_fnc_spawnMissionHeli(59):  _skillAI = %1 | _minDist = %2 | _maxDist = %3",_skillAI,_minDist,_maxDist];
			diag_log format["_fnc_spawnMissionHeli (78):: _chopperType selected = %1",_chopperType];
	};
	#endif

	//_patrolHeli = createVehicle [_chopperType, _coords, [], 90, "FLY"];
	_patrolHeli = [_chopperType,_coords,"FLY"] call blck_fnc_spawnVehicle;
	#ifdef blck_debugMode 
	if (blck_debugLevel > 2) then 
	{
		diag_log format["_fnc_spawnMissionHeli (75): _patrolHeli = %1 | getPosATL _patrolHeli = %2",_patrolHeli,getposATL _patrolHeli];
	};
	#endif 
	[_patrolHeli,2] call blck_fnc_configureMissionVehicle;
	//_patrolHeli setVariable["blck_vehicle",true];
	_patrolHeli setVariable["blck_vehicleSearchRadius",blck_playerDetectionRangeAir];
	_patrolHeli setVariable["blck_vehiclePlayerDetectionOdds",blck_vehiclePlayerDetectionOdds];
	//_patrolHeli addEventHandler["GetOut",{_this remoteExec["blck_EH_vehicleGetOut",2]}];
	//[_patrolHeli] call blck_fnc_protectVehicle;
	_patrolHeli setFuel 1;
	_patrolHeli engineOn true;
	_patrolHeli flyInHeight 100;
	//_patrolHeli setVehicleLock "LOCKED";
	// params["_veh","_group",["_crewCount",4]];
	[_patrolHeli,_grpPilot,_crewCount] call blck_fnc_loadVehicleCrew;
	
	#ifdef blck_debugMode
	if (blck_debugLevel > 1) then
	{
		diag_log format["_fnc_spawnMissionHeli (93):: heli %1 spawned with crew count of %2 | desired crew count = %3",_patrolHeli,count(crew _patrolHeli),_crewCount];
		diag_log format["_fnc_spawnMissionHeli (89): _patrolHeli = %1 | getPosATL _patrolHeli = %2 | driver _patrolHeli = %4",_patrolHeli,getposATL _patrolHeli,driver _patrolHeli];
		diag_log format["_fnc_spawnMissionHeli (133)::-->> Heli %1 outfited with a crew numbering %2",_patrolHeli, crew _patrolHeli];
	};
	#endif
};
//diag_log format["[blckeagls] _fnc_spawnMissionHeli:: _patrolHeli %1 | _grpPilot %2 | _abort %3",_patrolHeli,_grpPilot,_abort];
_return = [_patrolHeli,units _grpPilot,_abort];

#ifdef blck_debugMode
if (blck_debugLevel > 0) then
{
	diag_log format["_fnc_spawnMissionHeli:: function returning value for _return of %1",_return];
};
#endif
_return;
