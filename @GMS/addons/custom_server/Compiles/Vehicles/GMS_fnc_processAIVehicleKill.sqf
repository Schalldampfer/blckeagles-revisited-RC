/*
	By Ghostrider [GRG]

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

private ["_veh","_killer","_group","_wp"];
//diag_log format["_fnc_processAIVehicleKill:  _this = %1",_this];
params["_veh","_killer","_killer"];
//params["_veh","_killer"];

{
	_veh removealleventhandlers _x;
} forEach ["GetIn","GetOut","fired","hit","hitpart","reloaded","dammaged","HandleDamage"];
{
	_veh removeAllMPEventHandlers _x;
} forEach ["MPHit","MPKilled"];

//diag_log format["_fnc_processAIVehicleKill:  _this = %1",_this];
//diag_log format["_fnc_processAIVehicleKill:: _veh = %1 and _killer = %2 units damage is %3",_veh,_killer, damage _veh];

if (!(isPlayer _killer)) exitWith {};

if !(count(crew _veh) isEqualTo 0) then
{
	[_crew select 0,_killer] call blck_fnc_alertGroupUnits;	
	private _group = group (_crew select 0);
	_group setBehaviour "COMBAT";
	_wp = [_group, currentWaypoint _group];
	_wp setWaypointBehaviour "COMBAT";
	_group setCombatMode "RED";
	_wp setWaypointCombatMode "RED";	
};
[_killer] call blck_fnc_alertNearbyVehicles;



