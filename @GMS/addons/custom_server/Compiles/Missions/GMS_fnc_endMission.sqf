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
	params["_coords","_mines","_objects","_blck_AllMissionAI","_markerName","_cleanupAliveAITimer","_cleanupCompositionTimer",["_isScubaMission",false]];
	[_mines] call blck_fnc_clearMines;
	//[_coords,_objects, _cleanupCompositionTimer] call blck_fnc_addObjToQue;
	blck_oldMissionObjects pushback [_coords,_objects, (diag_tickTime + _cleanupCompositionTimer)];	
	blck_liveMissionAI pushback [_coords,_blck_AllMissionAI, (diag_tickTime + _cleanupAliveAITimer)];
	blck_missionsRunning = blck_missionsRunning - 1;
	blck_ActiveMissionCoords = blck_ActiveMissionCoords - [ _coords];	
	if !(_isScubaMission) then
	{
		blck_recentMissionCoords pushback [_coords,diag_tickTime]; 
		[_markerName,"inactive",[0,0,0]] call blck_fnc_updateMissionQue;	
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

params[
	"_coords",
	"_mines",
	"_objects",
	"_crates",
	"_blck_AllMissionAI",
	"_endMsg",
	"_markers",
	"_markerPos",
	"_markerName",
	"_markerLabel",
	["_endCondition",0],
	["_vehicles",[]],
	["_isScubaMission",false]
];
/*
private _param = ["_coords","_mines","_objects","_crates","_blck_AllMissionAI","_endMsg","_markers","_markerPos","_markerName","_markerLabel","_endCondition","_vehicles","_isScubaMission"];
{
	diag_log format["_fnc_endMission: parameter %1 named %2 = %3",_forEachIndex,_param select _forEachIndex,_x];
} forEach _this;
*/
{
	[_x] call blck_fnc_deleteMarker;
}forEach (_blck_localMissionMarker select 0);


if (_endCondition > 0) exitWith  // Mision aborted for some reason
{
	#define	cleanupCompositionTimer  0
	#define	cleanupAliveAITimer  0
	// 	params["_coords","_mines","_objects","_blck_AllMissionAI","_markerName","_cleanupAliveAITimer","_cleanupCompositionTimer",["_isScubaMission",false]];
	[_coords,_mines,_objects,_blck_AllMissionAI,_markerName,cleanupAliveAITimer,cleanupCompositionTimer,_isScubaMission] call _fn_missionCleanup;
	/*
	{
		if (local _x) then {deleteVehicle _x};
	}forEach _crates;
	*/
	{
		if (local _x) then {deleteVehicle _x};
	}forEach _vehicles;
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
	diag_log format["_fnc_endMission (93) _endMsg = %1 | _markerLabel = %2",_endMsg,_markerLabel];
	if (_endCondition == 0) then {[["end",_endMsg,_markerLabel]] call blck_fnc_messageplayers;};
	if (_endCondition == -1) then {[["warning",_endMsg,_markerLabel]] call blck_fnc_messageplayers;};
	[_markerPos, _markerName] spawn blck_fnc_missionCompleteMarker;
	{
		if !(_x getVariable["lootLoaded",false] || _endCondition == 1) then // dont load loot if the asset was killed
		{

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
	// 	params["_coords","_mines","_objects","_blck_AllMissionAI","_markerName","_cleanupAliveAITimer","_cleanupCompositionTimer",["_isScubaMission",false]];
	[_coords,_mines,_objects,_blck_AllMissionAI,_markerName,blck_AliveAICleanUpTimer,blck_cleanupCompositionTimer,_isScubaMission] call _fn_missionCleanup;
};

	_endCondition
