/*
	blck_fnc_spawnMissionVehiclePatrols
	by Ghostrider [GRG]
	returns [] if no groups could be created
	returns [_AI_Vehicles,_missionAI] otherwise;
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_coords","_noVehiclePatrols","_skillAI","_missionPatrolVehicles",["_useRelativePos",true],["_uniforms",[]], ["_headGear",[]],["_vests",[]],["_backpacks",[]],["_weaponList",[]],["_sideArms",[]], ["_isScubaGroup",false],["_crewCount",4]];

if (_uniforms isEqualTo []) 		then {_uniforms = [_skillAI] call blck_fnc_selectAIUniforms};
if (_headGear  isEqualTo [])		then {_headGear = [_skillAI] call blck_fnc_selectAIHeadgear};
if (_vests isEqualTo []) 			then {_vests = [_skillAI] call blck_fnc_selectAIVests};
if (_backpacks  isEqualTo []) 		then {_backpacks = [_skillAI] call blck_fnc_selectAIBackpacks};
if (_weaponList  isEqualTo []) 		then {_weaponList = [_skillAI] call blck_fnc_selectAILoadout};
if (_sideArms isEqualTo []) 		then {[_skillAI] call blck_fnc_selectAISidearms};

private["_vehGroup","_vehiclePatrolSpawns","_missionAI","_missiongroups","_vehicles","_return","_vehiclePatrolSpawns","_vehicle","_return","_abort","_spawnPos","_v"];
_vehicles = [];
_missionAI = [];
_abort = false;
//diag_log format["fnc_spawnMissionVehiclePatrols(29):  _missionPatrolVehicles = %1",_missionPatrolVehicles];
if (_missionPatrolVehicles isEqualTo []) then
{
	_useRelativePos = false;
	_vehiclePatrolSpawns = [_coords,_noVehiclePatrols,45,60] call blck_fnc_findPositionsAlongARadius;
	{
		_v = [_skillAI] call blck_fnc_selectPatrolVehicle;
		_missionPatrolVehicles pushBack [_v, _x];
	}forEach _vehiclePatrolSpawns;
	//diag_log format["fnc_spawnMissionVehiclePatrols(38):  _missionPatrolVehicles updated to %1",_missionPatrolVehicles];
};
#define configureWaypoints false
{
	if (_useRelativePos) then
	{
		_spawnPos = _coords vectorAdd (_x select 1)
	} else {
		_spawnPos = _x select 1;
	};
	_vehicle = _x select 0;
	_vehGroup = [blck_AI_Side,true]  call blck_fnc_createGroup;
	_patrolVehicle = objNull;
	//diag_log format["fnc_spawnMissionVehiclePatrols(50):  _vehicle = %1 | _spawnPos = %2 | _vehGroup = %3",_vehicle,_spawnPos,_vehGroup];
	if !(isNull _vehGroup) then 
	{
		_vehGroup setVariable["soldierType","vehicle"];
		[_vehGroup,_spawnPos,_coords,_crewCount,_crewCount,_skillAI,1,2,false,_uniforms, _headGear,_vests,_backpacks,_weaponList,_sideArms,_isScubaGroup] call blck_fnc_spawnGroup;
		_missionAI append (units _vehGroup);
		blck_monitoredMissionAIGroups pushBack _vehGroup;
		//params["_center","_pos",["_vehType","I_G_Offroad_01_armed_F"],["_minDis",40],["_maxDis",60],["_group",grpNull],["_setWaypoints",true],["_crewCount",4]];
		//diag_log format["fnc_spawnMissionVehiclePatrols(59):  _vehicle = %1 | _vehGroup = %2 | units _vehGroup",_vehicle,_vehGroup, units _vehGroup];
		#define useWaypoints true
		_patrolVehicle = [_coords,_spawnPos,_vehicle,40,60,_vehGroup,useWaypoints,_crewCount] call blck_fnc_spawnVehiclePatrol; 
		/*
		if (isNil "_patrolVehicle") then 
		{
			diag_log format["_fnc_spawnMissionVehiclePatrols:  nil value returned for _patrolVehicle"];
			_patrolVehicle = objNull;
		};
		*/
		//diag_log format["fnc_spawnMissionVehiclePatrols(68): _vehGroup = %1 | units _vehGroup = %2",_vehGroup, units _vehGroup];
		if !(isNull _patrolVehicle) then
		{
			//_patrolVehicle setVariable["vehicleGroup",_vehGroup];
			_vehicles pushback _patrolVehicle;
		};
	};
} forEach _missionPatrolVehicles;
blck_monitoredVehicles append _vehicles;
_return = [_vehicles, _missionAI, _abort];
_return
