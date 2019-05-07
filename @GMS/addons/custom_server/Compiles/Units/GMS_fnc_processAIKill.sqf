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

private["_group","_isLegal","_weapon","_lastkill","_kills","_message","_killstreakMsg"];
params["_unit","_killer"/*,"_instigator"*/];
if (_unit getVariable["blck_cleanupAt",-1] > 0) exitWith {};
_unit setVariable ["blck_cleanupAt", (diag_tickTime) + blck_bodyCleanUpTimer];
blck_deadAI pushback _unit;
_group = group _unit;
[_unit] joinSilent grpNull;
if (count(units _group) < 1) then 
{
	deleteGroup _group;
};

if !((vehicle _unit) isEqualTo _unit) then 
{
	private _veh = vehicle _unit;
	diag_log format["_processAIKill: _unit %1 is in vehicle %2",_unit,_veh];
	if ({alive _x} count (crew _veh) == 0) then
	{	
		diag_log format["_processAIKill: no units alive in vehicle %1 of type %2",_veh, typeOf _veh];
		if (_veh getVariable["GRG_vehType","none"] isEqualTo "emplaced") then
		{
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

if (blck_launcherCleanup) then {[_unit] call blck_fnc_removeLaunchers;};
if (blck_removeNVG) then {[_unit] call blck_fnc_removeNVG;};
if !(isPlayer _killer) exitWith {};

[_unit,_killer] call blck_fnc_alertGroupUnits;
[_killer] call blck_fnc_alertNearbyVehicles;
_wp = [_group, currentWaypoint _group];
_wp setWaypointBehaviour "COMBAT";
_group setCombatMode "RED";
_wp setWaypointCombatMode "RED";
_isLegal = [_unit,_killer] call blck_fnc_processIlleagalAIKills;
if !(_isLegal) exitWith {};
_lastkill = _killer getVariable["blck_lastkill",diag_tickTime];
_killer setVariable["blck_lastkill",diag_tickTime];
_kills = (_killer getVariable["blck_kills",0]) + 1;
if ((diag_tickTime - _lastkill) < 240) then
{
	_killer setVariable["blck_kills",_kills];
} else {
	_killer setVariable["blck_kills",0];
};

if (blck_useKillMessages) then
{
	_weapon = currentWeapon _killer;
	_killstreakMsg = format[" %1X KILLSTREAK",_kills];

	if (blck_useKilledAIName) then
	{
		_message = format["[blck] %2: killed by %1 from %3m",name _killer,name _unit,round(_unit distance _killer)];
	}else{
		_message = format["[blck] %1 killed with %2 from %3 meters",name _killer,getText(configFile >> "CfgWeapons" >> _weapon >> "DisplayName"), round(_unit distance _killer)];
	};
	_message =_message + _killstreakMsg;
	[["aikilled",_message,"victory"],allPlayers] call blck_fnc_messageplayers;
};

[_unit,_killer] call blck_fnc_rewardKiller;
if (blck_showCountAliveAI) then
{
	{
		[_x select 0, _x select 1, _x select 2] call blck_fnc_updateMarkerAliveCount;
	} forEach blck_missionMarkers;
};

