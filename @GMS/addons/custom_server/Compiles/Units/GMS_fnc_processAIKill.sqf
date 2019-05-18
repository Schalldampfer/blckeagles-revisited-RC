/*
	Handle AI Deaths
	Last Modified 7/27/17
	By Ghostrider [GRG]
	Copyright 2016
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/

// assumptions: this is always run on the server rgardless if th event is triggered on an HC or other client.
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_unit","_killer","_instigator"];
diag_log format["_fnc_processAIKill: _unit = %1 | _killer = %2 | _instigator = %3" ,_unit,_killer,_instigator];
if (_unit getVariable["blck_cleanupAt",-1] > 0) exitWith {};  // this is here so that the script is not accidently run more than once for each MPKilled occurrence.
_unit setVariable ["blck_cleanupAt", (diag_tickTime) + blck_bodyCleanUpTimer];
blck_deadAI pushback _unit;
private _group = group _unit;
[_unit] joinSilent grpNull;
if (count(units _group) == 0) then 
{
	deleteGroup _group;
};
diag_log format[
	"_fnc_processAIKill: _killer = %1 | vehicle _killer = %2 | typeOf (vehicle _killer = %3) | driver(vehicle _killer) = %4",
	_killer,
	vehicle _killer,
	typeOf(vehicle _killer),
	driver(vehicle _killer)
	];

if !((vehicle _unit) isEqualTo _unit) then 
{
	private _veh = vehicle _unit;
	diag_log format["_processAIKill: _unit %1 is in vehicle %2",_unit,_veh];
	if ({alive _x} count (crew _veh) == 0) then
	{	
		diag_log format["_processAIKill: no units alive in vehicle %1 of type %2",_veh, typeOf _veh];
		if (_veh getVariable["GRG_vehType","none"] isEqualTo "emplaced") then
		{
			diag_log format["_fnc_processAIKill: emplaced weapon %1 being handled",_veh];
			[_veh] call GMS_fnc_handleEmptyStaticWeapon;			
		} else {
			if (blck_killEmptyAIVehicles) then
			{
				diag_log format["_processAIKill: disabling vehicle %1 and setting a delete time",_veh];
				_veh setDamage 0.7;
				_veh setFuel 0;
				_veh setVariable["blck_deleteAtTime",diag_tickTime + 60];
			} else {
				diag_log format["_processAIKill: releasing vehicle %1 to players and setting a default delete timer",_veh];
				_veh setVariable["blck_deleteAtTime",diag_tickTime + blck_vehicleDeleteTimer,true];	
				[_veh] call blck_fnc_releaseVehicleToPlayers;
			};
		};			
	};
	[_unit, ["Eject", vehicle _unit]] remoteExec ["action",(owner _unit)];
} else {
	if (_unit getVariable["GRG_vehType","none"] isEqualTo "emplaced") then 
	{
		[_unit getVariable "GRG_vehicle"] call GMS_fnc_handleEmptyStaticWeapon;
	};
};

if (blck_launcherCleanup) then {[_unit] call blck_fnc_removeLaunchers};
if (blck_removeNVG) then {[_unit] call blck_fnc_removeNVG};
if !(isPlayer _killer) exitWith {};

[_unit,_killer] call blck_fnc_alertGroupUnits;
[_killer] call blck_fnc_alertNearbyVehicles;
if (vehicle _killer != _killer) then 
{
	[_unit, vehicle _killer] call GMS_fnc_revealVehicleToUnits;
};
private _wp = [_group, currentWaypoint _group];
_wp setWaypointBehaviour "COMBAT";
_group setCombatMode "RED";
_wp setWaypointCombatMode "RED";

if (blck_showCountAliveAI) then
{
	{
		[_x select 0, _x select 1, _x select 2] call blck_fnc_updateMarkerAliveCount;
	} forEach blck_missionMarkers;
};
private _isLegal = [_unit,_killer] call blck_fnc_processIlleagalAIKills;
diag_log format["_fnc_processAIKill: _isLegal = %1",_isLegal];
if !(_isLegal) exitWith {};
[_unit,_killer] call GMS_fnc_handlePlayerUpdates;