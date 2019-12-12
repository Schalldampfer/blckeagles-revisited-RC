/*
	schedules deletion of all remaining alive AI and mission objects.
	Updates the mission que.
	Updates mission markers.
	By Ghostrider-GRG-
	Copyright 2016
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp"
private["_cleanupAliveAITimer","_cleanupCompositionTimer"];
	
_fn_missionCleanup = {	
	params["_mines","_objects","_blck_AllMissionAI","_cleanupAliveAITimer","_cleanupCompositionTimer"];
	[_mines] call blck_fnc_clearMines;
	//[_coords,_objects, _cleanupCompositionTimer] call blck_fnc_addObjToQue;
	blck_oldMissionObjects pushback [_coords,_objects, (diag_tickTime + _cleanupCompositionTimer)];	
	blck_liveMissionAI pushback [_coords,_blck_AllMissionAI, (diag_tickTime + _cleanupAliveAITimer)];
	blck_missionsRunning = blck_missionsRunning - 1;
	blck_ActiveMissionCoords = blck_ActiveMissionCoords - [ _coords];	
	//if !(_isScubaMission) then
	//{
		blck_recentMissionCoords pushback [_coords,diag_tickTime]; 
		//[_mission,"inactive",[0,0,0]] call blck_fnc_updateMissionQue;	
	//};
	/*
	if (_isScubaMission) then
	{
		blck_priorDynamicUMS_Missions pushback [_coords,diag_tickTime]; 
		blck_UMS_ActiveDynamicMissions = blck_UMS_ActiveDynamicMissions - [_coords];
		blck_dynamicUMS_MissionsRuning = blck_dynamicUMS_MissionsRuning - 1;		
	};
	*/
};

///////////////////////////////////////////////////////////////////////
//  MAIN FUNCTION STARTS HERE
//////////////////////////////////////////////////////////////////////

private ["_mines","_objects","_crates","_blck_AllMissionAI","_endMsg","_coords","_mission","_endCondition","_vehicles","_mainMarker","_labelMarker","_markerClass"];

params ["_mines","_objects","_crates","_blck_AllMissionAI","_endMsg","_mainMarker","_labelMarker","_markerClass","_coords",["_endCondition",0]];

{
	diag_log format["_fnc_endMission: %1 = %2",_x, _this select _forEachIndex];
} forEach  ["_mines","_objects","_crates","_blck_AllMissionAI","_endMsg","_mainMarker","_labelMarker","_markerClass","_coords","_endCondition"];

if (_endCondition > 0) exitWith  // Mision aborted for some reason
{
	[_mainMarker] call blck_fnc_deleteMarker;
	_cleanupCompositionTimer = 0;
	_cleanupAliveAITimer = 0;
	//  	params["_mines","_objects","_blck_AllMissionAI","_mission","_cleanupAliveAITimer","_cleanupCompositionTimer"];
	[_mines,_objects,_blck_AllMissionAI,_mission,_cleanupAliveAITimer,_cleanupCompositionTimer] call _fn_missionCleanup;

	{
		if (local _x) then {deleteVehicle _x};
	}forEach _crates;
};
if (_endCondition <= 0) then // Normal Mission End State
{

	if (blck_useSignalEnd) then
	{
		[_crates select 0] spawn blck_fnc_signalEnd;
		{
			_x enableRopeAttach true;
		}forEach _crates;
	};
	
	if (_endCondition == 0) then {[["end",_endMsg,_markerMissionName],allPlayers] call blck_fnc_messageplayers;};
	// pass the string identifying main marker as a unique marker root name for the mission completed marker.
	[_coords] spawn blck_fnc_missionCompleteMarker;
	if (_endCondition == -1) then {[["warning",_endMsg,_markerMissionName],allPlayers] call blck_fnc_messageplayers;};
	[_mainMarker] call blck_fnc_deleteMarker;		
	
	// Using a variable attached to the crate rather than the global setting to be sure we do not fill a crate twice.
	// the "lootLoaded" loaded should be set to true by the crate filler script so we can use that for our check.
	{
		if !(_x getVariable["lootLoaded",false]) then
		{
			// _crateLoot,_lootCounts are defined above and carry the loot table to be used and the number of items of each category to load
			[_x,_crateLoot,_lootCounts] call blck_fnc_fillBoxes;
		};
	}forEach _crates;
	/*
	{
		private ["_v","_posnVeh"];
		_posnVeh = blck_monitoredVehicles find _x;  // returns -1 if the vehicle is not in the array else returns 0-(count blck_monitoredVehicles -1)
		if (_posnVeh >= 0) then
		{
			(blck_monitoredVehicles select _posnVeh) setVariable ["missionCompleted", diag_tickTime];
		} else {
			_x setVariable ["missionCompleted", diag_tickTime];
			blck_monitoredVehicles pushback _x;
		};
	} forEach _vehicles;
	*/
	[_mines,_objects,_blck_AllMissionAI,blck_AliveAICleanUpTimer,blck_cleanupCompositionTimer] call _fn_missionCleanup;
};

true