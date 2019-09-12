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

params["_center","_pos",["_vehType","I_G_Offroad_01_armed_F"],["_minDis",40],["_maxDis",60],["_group",grpNull],["_setWaypoints",true],["_crewCount",4]];

//_center  Center of the mission area - this is usuall the position treated as the center by the mission spawner. Vehicles will patrol the perimeter of the mission area.
// _pos the approximate spawn point for the vehicle
//_vehType = [_this,1,"I_G_Offroad_01_armed_F"] call BIS_fnc_param; 
//_minDis = minimum distance from the center of the mission for vehicle waypoints
//_maxDis = maximum distance from the center of the mission for vehicle waypoints
//_groupForVehiclePatrol = The group with which to man the vehicle
// _crewCount = the number of AI including driver and gunners to place in the vehicle
// TODO: verify that all old code is now called in the varous functions 
private["_veh"];
if !(isNull _group) then {
	_veh = [_vehType,_pos] call blck_fnc_spawnVehicle;
	//diag_log format["_fnc_spawnVehiclePatrol: _veh = %1 | typeOf _ve = %2",_veh,typeOf _veh];
	//_veh addMPEventHandler["MPHit",{ _this call blck_EH_AIVehicle_HandleHit}];
	//_veh addMPEventHandler["MPKilled",{_this call blck_EH_vehicleKilled}];
	//_veh addEventHandler["GetOut",{_this remoteExec["blck_EH_vehicleGetOut",2]}];
	_veh setVariable["blck_vehicleSearchRadius",blck_playerDetectionRangeGroundVehicle];
	_veh setVariable["blck_vehiclePlayerDetectionOdds",blck_vehiclePlayerDetectionOdds];
	private _maxCrew = [_crewCount] call blck_fnc_getNumberFromRange;
	[_veh,_group,_crewCount] call blck_fnc_loadVehicleCrew;
	//diag_log format["_fnc_spawnVehiclePatrol: crew of vehicle %1 = %2",_veh, crew _veh];
	[_veh,2] call blck_fnc_configureMissionVehicle;
	if (_setWaypoints) then
	{
		// params["_pos","_minDis","_maxDis","_group",["_mode","random"],["_wpPatrolMode","SAD"],["_soldierType","null"] ];
		#define vehiclePatrolRadius 400
		#defin vehicleWaypointTimout [6, 9, 12]
		[_center,_minDis,_maxDis,_group,"perimeter","SAD","vehicle",vehiclePatrolRadius,vehicleWaypointTimout] spawn blck_fnc_setupWaypoints;
	};
};

_veh


