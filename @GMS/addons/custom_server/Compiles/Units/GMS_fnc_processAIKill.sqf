/*
	Handle AI Deaths
	By Ghostrider [GRG]

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
//  TODO: check that emplaced weapons that should be deleted are added to the scheduler.
// assumptions: this is always and only run on the server regardless if th event is triggered on an HC or other client.
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_unit","_killer","_instigator"];

if (local _unit) then 
{

	// soldierOne action ["Eject", vehicle soldierOne];
	if !((vehicle _unit) isKindOf "Man") then 
	{
		_unit action["Eject", vehicle _unit];
		[vehicle _unit] call blck_fnc_checkForEmptyVehicle;
	};
};

if !(isServer) exitWith {};

//diag_log format["_fnc_processAIKill: _unit = %1 | _killer = %2",_unit,_killer];
if (_unit getVariable["blck_cleanupAt",-1] > 0) exitWith {};  // this is here so that the script is not accidently run more than once for each MPKilled occurrence.
_unit setVariable ["blck_cleanupAt", (diag_tickTime) + blck_bodyCleanUpTimer];
_unit setVariable ["blck_killedAt",diag_tickTime];
_unit disableAI "ALL";

{
	_unit removeAllMPEventHandlers _x;
}forEach["MPHit","MPKilled"];
{
	_unit removeAllEventHandlers _x;
}forEach["FiredNear","Reloaded"];
[_unit] joinSilent blck_graveyardGroup;
//diag_log format["_processAIKill: units in graveyardGroup = %1",units blck_graveyardGroup];
//blck_deadAI pushback _unit;
if (count(units (group _unit)) isEqualTo 0) then 
{
	deleteGroup _group;
};

//diag_log format["_fnc_processAIKill: unit linked to crew of vehicle %1 | typeOf (vehicle _unit = %2)",vehicle _unit,typeOf (vehicle _unit)];
if !((vehicle _unit) isKindOf "Man") then 
{
	[_unit, ["Eject", vehicle _unit]] remoteExec ["action",(owner _unit)];
};

if (blck_launcherCleanup) then {[_unit] call blck_fnc_removeLaunchers};
if (blck_removeNVG) then {[_unit] call blck_fnc_removeNVG};
if !(isPlayer _killer) exitWith {};
[_unit,_killer,50] call GMS_fnc_alertNearbyGroups;
[_killer] call blck_fnc_alertNearbyVehicles;
private _wp = [group _unit, currentWaypoint (group _unit)];
_wp setWaypointBehaviour "COMBAT";
(group _unit) setCombatMode "RED";
_wp setWaypointCombatMode "RED";

if (blck_showCountAliveAI && (isNil "blck_spawnerMode")) then
// TODO: remove backwards compatible code when appropriate.
{
	{
		[_x select 0, _x select 1, _x select 2] call blck_fnc_updateMarkerAliveCount;
	} forEach blck_missionMarkers;
};

if ([_unit,_killer] call blck_fnc_processIlleagalAIKills) then {
	[_unit,_killer] call GMS_fnc_handlePlayerUpdates;
};
