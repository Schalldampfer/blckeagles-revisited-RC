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
private["_cleanupAliveAITimer","_cleanupCompositionTimer","_isScubaMission"];
	
_fn_missionCleanup = {	
	params["_mines","_objects","_blck_AllMissionAI","_mission","_cleanupAliveAITimer","_cleanupCompositionTimer",["_isScubaMission",false]];
	[_mines] call blck_fnc_clearMines;
	//[_coords,_objects, _cleanupCompositionTimer] call blck_fnc_addObjToQue;
	blck_oldMissionObjects pushback [_coords,_objects, (diag_tickTime + _cleanupCompositionTimer)];	
	blck_liveMissionAI pushback [_coords,_blck_AllMissionAI, (diag_tickTime + _cleanupAliveAITimer)];
	blck_missionsRunning = blck_missionsRunning - 1;
	blck_ActiveMissionCoords = blck_ActiveMissionCoords - [ _coords];	
	if !(_isScubaMission) then
	{
		blck_recentMissionCoords pushback [_coords,diag_tickTime]; 
		[_mission,"inactive",[0,0,0]] call blck_fnc_updateMissionQue;	
	};
	if (_isScubaMission) then
	{
		blck_priorDynamicUMS_Missions pushback [_coords,diag_tickTime]; 
		blck_UMS_ActiveDynamicMissions = blck_UMS_ActiveDynamicMissions - [_coords];
		blck_dynamicUMS_MissionsRuning = blck_dynamicUMS_MissionsRuning - 1;		
	};
};

///////////////////////////////////////////////////////////////////////
//  MAIN FUNCTION STARTS HERE
//////////////////////////////////////////////////////////////////////

params["_mines","_objects","_crates","_blck_AllMissionAI","_endMsg","_blck_localMissionMarker","_coords","_mission",["_endCondition",0],["_vehicles",[]],["_isScubaMission",false]];
private _param = ["_mines","_objects","_crates","_blck_AllMissionAI","_endMsg","_blck_localMissionMarker","_coords","_mission","_endCondition","_vehicles","_isScubaMission"];
diag_log format["_fnc_endMission: _this = %1",_this];
/*
if (blck_debugLevel >=3) then 
{
	diag_log format["_fnc_endMission: param %1 = %2",_forEachIndex,_x];
} forEach _this;
*/
if (_endCondition > 0) exitWith  // Mision aborted for some reason
{
	[_blck_localMissionMarker select 0] call blck_fnc_deleteMarker;
	_cleanupCompositionTimer = 0;
	_cleanupAliveAITimer = 0;

	[_mines,_objects,_blck_AllMissionAI,_mission,_cleanupAliveAITimer,_cleanupCompositionTimer,_isScubaMission] call _fn_missionCleanup;
	{
		//if (local _x) then {deleteVehicle _x};
	}forEach _crates;
	{
		deleteVehicle _x;
	}forEach _vehicles;
};
if (_endCondition <= 0) then // Normal Mission End State
{

	private["_cleanupAliveAITimer","_cleanupCompositionTimer"];
	if (blck_useSignalEnd) then
	{
		[_crates select 0] spawn blck_fnc_signalEnd;
		{
			_x enableRopeAttach true;
		}forEach _crates;
	};
	
	_cleanupCompositionTimer = blck_cleanupCompositionTimer;
	_cleanupAliveAITimer = blck_AliveAICleanUpTimer;
	if (_endCondition == 0) then {[["end",_endMsg,_blck_localMissionMarker select 2]] call blck_fnc_messageplayers;};
	if (_endCondition == -1) then {[["warning",_endMsg,_blck_localMissionMarker select 2]] call blck_fnc_messageplayers;};
	[_blck_localMissionMarker select 0] call blck_fnc_deleteMarker;		
	[_blck_localMissionMarker select 1, _markerClass] spawn blck_fnc_missionCompleteMarker;
	// Using a variable attached to the crate rather than the global setting to be sure we do not fill a crate twice.
	// the "lootLoaded" loaded should be set to true by the crate filler script so we can use that for our check.
	{
		if !(_x getVariable["lootLoaded",false] || _endCondition == 1) then // dont load loot if the asset was killed
		{
			// _crateLoot,_lootCounts are defined above and carry the loot table to be used and the number of items of each category to load
			[_x,_crateLoot,_lootCounts] call blck_fnc_fillBoxes;
		};
	}forEach _crates;

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
	[_mines,_objects,_blck_AllMissionAI,_mission,_cleanupAliveAITimer,_cleanupCompositionTimer,_isScubaMission] call _fn_missionCleanup;
};

	_endCondition
