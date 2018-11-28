/*
	[] call blck_fnc_waypointMonitor;
	
	Scans all groups in  for those that have been stuck in a particular waypoint for an excessive time and checks if they are in combat. 
	If not it directs them to the next waypoint. 
	It uses a timestamp attached to the group that is cleared upon waypoint completion.
	
	By Ghostrider-GRG-

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

#ifdef blck_debugMode
diag_log format["_fnc_missionGroupMonitor (4/29:4:09 PM)::-->> running function at diag_tickTime = %1 with blck_fnc_missionGroupMonitor = %2",diag_tickTime,blck_monitoredMissionAIGroups];
#endif

#ifdef blck_debugMode
if (blck_debugLevel > 2) then {diag_log format["_fnc_missionGroupMonitor: executing function at %1",diag_tickTime];};
#endif
//[] call blck_fnc_cleanEmptyGroups;
uiSleep 0.1;
//[] call bck_fnc_groupWaypointMonitor;

//if (blck_simulationManager == blck_useBlckeaglsSimulationManagement) then {call blck_fnc_blckSimulationManager};

