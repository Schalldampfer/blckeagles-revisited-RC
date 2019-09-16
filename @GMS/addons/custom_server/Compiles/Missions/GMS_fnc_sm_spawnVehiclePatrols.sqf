/*
	by Ghostrider [GRG]
	for ghostridergaming
	12/5/17
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_coords","_noVehiclePatrols","_vehiclePatrolSpawns","_aiDifficultyLevel"];
//diag_log format["_sm_spawnVehiclePatrols:: _vehiclePatrolSpawns = %1",_vehiclePatrolSpawns];
private["_vehGroup","_patrolVehicle","_missionAI","_missiongroups","_vehicles","_return","_vehiclePatrolSpawns","_randomVehicle","_return","_abort"];
private ["_weaponList","_sideArms","_uniforms","_headgear","_vests","_backpacks"];

if (_vehiclePatrolSpawns isEqualTo []) then
{
	private["_spawnPoints","_vehType"];
	_spawnPoints = [_coords,_noVehiclePatrols,75,100] call blck_fnc_findPositionsAlongARadius;
	{
	  //  ["Vehicle Class Name", position[x,y,z], AI Skill [blue, red, green, orange],patrol radius [0 for static units], respawn time [seconds]]
		#define vehiclePatrolRadius 150
		#define vehicleRespawnTime 900
		_vehType = selectRandom blck_AIPatrolVehicles;
		_vehiclePatrolSpawns pushBack [_vehType, _x, _aiDifficultyLevel, vehiclePatrolRadius,vehicleRespawnTime];
	} forEach _spawnPoints;
};

{
	private _patrolVehicle = objNull;
	_x params["_vehicle","_spawnPos","_aiDifficultyLevel","_patrolRadius","_respawnTime"];
	private _vehGroup = [blck_AI_Side,true]  call blck_fnc_createGroup;
	if !(isNull _vehGroup) then 
	{
		_vehGroup setVariable["soldierType","vehicle"];		
		_weaponList = [_aiDifficultyLevel] call blck_fnc_selectAILoadout;
		_sideArms 	= [_aiDifficultyLevel] call blck_fnc_selectAISidearms;
		_uniforms 	= [_aiDifficultyLevel] call blck_fnc_selectAIUniforms;
		_headGear 	= [_aiDifficultyLevel] call blck_fnc_selectAIHeadgear;
		_vests 		= [_aiDifficultyLevel] call blck_fnc_selectAIVests;
		_backpacks 	= [_aiDifficultyLevel] call blck_fnc_selectAIBackpacks;		

		[_vehGroup,_spawnPos,_spawnPos,3,3,_difficulty,1,2,_uniforms,_headGear,false] call blck_fnc_spawnGroup;
		blck_monitoredMissionAIGroups pushback _vehGroup;
		#define useWaypoints true
		//  params[["_group","Error"],"_pos",  "_center", ["_numai1",5],  ["_numai2",10],  ["_skillLevel","red"], ["_minDist",30], ["_maxDist",45],["_configureWaypoints",true], 
		//  ["_uniforms",[]], ["_headGear",[]],["_vests",[]],["_backpacks",[]],["_weaponList",[]],["_sideArms",[]], ["_scuba",false],["_patrolRadius",30]];
		_patrolVehicle = [_spawnPos,_spawnPos,_vehicle,_patrolRadius,_patrolRadius,_vehGroup,useWaypoints,[difficulty] call blck_fnc_selectVehicleCrewCount,_patrolRadius] call blck_fnc_spawnVehiclePatrol;  // Check whether we should pass the group; looks like we should.

	};
} forEach _vehiclePatrolSpawns;

true


