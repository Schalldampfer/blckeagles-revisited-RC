/*
	By Ghostrider [GRG]
	Copyright 2016	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

//diag_log format["starting _fnc_mainThread with time = %1",diag_tickTime];

private["_timer1sec","_timer5sec","_timer20sec","_timer5min","_timer5min"];
_timer1sec = diag_tickTime;
_timer5sec = diag_tickTime;
_timer20sec = diag_tickTime;
_timer1min = diag_tickTime;
_timer5min = diag_tickTime;

while {true} do
{
	uiSleep 1;
	if (diag_tickTime > _timer1sec) then 
	{		
		[] call blck_fnc_monitorInitializedMissions;
		_timer1sec = diag_tickTime + 1;
	};
	if (diag_tickTime > _timer5sec) then
	{
		_timer5sec = diag_tickTime + 5;
		if (blck_simulationManager isEqualTo blck_useBlckeaglsSimulationManagement) then {[] call blck_fnc_simulationManager};
		[] call blck_fnc_sm_staticPatrolMonitor;  // TODO: sort out static missions
		[] call blck_fnc_vehicleMonitor;		
		//[] call blck_fnc_cleanupAliveAI;
		//[] call blck_fnc_cleanupObjects;
		//[] call blck_fnc_cleanupDeadAI;			
		#ifdef GRGserver
		[] call blck_fnc_broadcastServerFPS;
		#endif		
	};
	if (diag_tickTime > _timer20sec) then
	{
		[] call blck_fnc_scanForPlayersNearVehicles;
		[] call GMS_fnc_cleanupTemporaryMarkers;
		[] call GMS_fnc_updateCrateSignals;				
		_timer20sec = diag_tickTime + 20;
	};
	if ((diag_tickTime > _timer1min)) then
	{
		_timer1min = diag_tickTime + 60;

			[] call blck_fnc_spawnPendingMissions;

		[] call blck_fnc_groupWaypointMonitor; 
		//if (blck_dynamicUMS_MissionsRuning < blck_numberUnderwaterDynamicMissions) then {[] spawn blck_fnc_addDyanamicUMS_Mission};
		if (blck_useHC) then {[] call blck_fnc_HC_passToHCs};
		if (blck_useTimeAcceleration) then {[] call blck_fnc_timeAcceleration};
		if (blck_ai_offload_to_client) then {[] call blck_fnc_ai_offloadToClients};
		#ifdef blck_debugMode
		diag_log format["_fnc_mainThread: active scripts include: %1",diag_activeScripts];
		#endif
	};
	if (diag_tickTime > _timer5min) then 
	{
		diag_log format["[blckeagls] Timstamp %8 |Dynamic Missions Running %1 | Vehicles %2 | Groups %3 | Server FPS %4 | Server Uptime %5 Min | Missions Run %6",blck_missionsRunning,count blck_monitoredVehicles,count blck_monitoredMissionAIGroups,diag_FPS,floor(diag_tickTime/60),blck_missionsRun, diag_tickTime];
		#ifdef blck_debugMode
		/*
			Syntax:
			diag_activeSQFScripts 
			Return Value:
			Array of Arrays - to format [[scriptName, fileName, isRunning, currentLine], ...]: 
		*/
		//private _activeScripts = call diag_activeSQFScripts;
		{
			if (_x select 2 /* isRunning */) then 
			{
				//diag_log format["script name %1",_x select 0];
			};
		} forEach diag_activeSQFScripts;
		#endif		
		[] call blck_fnc_cleanupAliveAI;
		[] call blck_fnc_cleanupObjects;
		[] call blck_fnc_cleanupDeadAI;	
		[] call blck_fnc_cleanEmptyGroups;			
		_timer5min = diag_tickTime + 300;
	};
};
