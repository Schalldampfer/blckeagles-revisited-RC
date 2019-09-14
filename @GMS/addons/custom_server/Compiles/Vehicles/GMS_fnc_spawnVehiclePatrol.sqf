/*
	By Ghostrider [GRG]
	Copyright 2016
	
	spawns a vehicle of _vehType and mans it with units in _group.
	returns _veh, the vehicle spawned.
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_center","_pos",["_vehType","I_G_Offroad_01_armed_F"],["_minDis",40],["_maxDis",60],["_group",grpNull],["_setWaypoints",true],["_crewCount",4],["_patrolRadius",150],["_waypointTimeout",[5,7.5,10]]];

{
	//diag_log format["_fnc_spawnVehiclePatrol/Vehicles: parameter %1 = %2",_forEachIndex,_x];
}forEach _this;
//_center  Center of the mission area - this is usually the position treated as the center by the mission spawner. Vehicles will patrol the perimeter of the mission area.
// _pos the approximate spawn point for the vehicle
//_vehType = [_this,1,"I_G_Offroad_01_armed_F"] call BIS_fnc_param; 
//_minDis =  
//_maxDis =  
//_groupForVehiclePatrol = The group with which to man the vehicle
// _crewCount = the number of AI including driver and gunners to place in the vehicle
if (_group isEqualTo grpNull) exitWith 
 {
	diag_log format["_fnc_spawnVehiclePatrol(30): <ERROR> Function can not accept a null group"];
};

private _veh = objNull;
//diag_log format["_fnc_spawnVehiclePatrol(34): _vehType = %1",_vehType];

_veh = [_vehType,_pos] call blck_fnc_spawnVehicle;
//diag_log format["_fnc_spawnVehiclePatrol(37): _veh = %1 | typeOf _veh = %2",_veh,typeOf _veh];

_veh setVariable["blck_vehicleSearchRadius",blck_playerDetectionRangeGroundVehicle];
_veh setVariable["blck_vehiclePlayerDetectionOdds",blck_vehiclePlayerDetectionOdds];
private _maxCrew = [_crewCount] call blck_fnc_getNumberFromRange;
[_veh,_group,_maxCrew] call blck_fnc_loadVehicleCrew;
//diag_log format["_fnc_spawnVehiclePatrol(43): crew of vehicle %1 = %2",_veh, crew _veh];

[_veh,2] call blck_fnc_configureMissionVehicle;
if (_setWaypoints) then
{
	// params["_pos","_minDis","_maxDis","_group",["_mode","random"],["_wpPatrolMode","SAD"],["_soldierType","null"] ];
	[_center,_minDis,_maxDis,_group,"perimeter","SAD","vehicle",_patrolRadius,_waypointTimeout] spawn blck_fnc_setupWaypoints;
	//diag_log format["_fnc_spawnVehiclePatrol(50): waypoint configuration set for vehicle %1 with crew %2",_veh, crew _veh];
};

//diag_log format["_fnc_spawnVehiclePatrol(53):  _veh = %1",_veh];

_veh


