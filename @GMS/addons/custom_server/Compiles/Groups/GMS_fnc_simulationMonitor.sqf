/*
	Managages simulation using blckeagls logic 	
	By Ghostrider-GRG-

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

if (blck_simulationManager isEqualTo blck_simulationManagementOff) exitWith 
{
	//diag_log format["_fnc_simulationMonitor: monitoring disabled at %1",diag_tickTime];
};

if (blck_simulationManager isEqualTo blck_useDynamicSimulationManagement) exitWith 
{
	// wake groups up if needed.
	{
		private _group = _x;
		private _nearplayer = [position (leader _group),blck_simulationEnabledDistance] call blck_fnc_nearestPlayers;	
		if !(_nearPlayer isEqualTo []) then 
		{
			_group reveal [(_nearplayer select 0),(_group knowsAbout (_nearPlayer select 0)) + 0.001];  //  Force simulation on
		};
	} forEach blck_monitoredMissionAIGroups;
};

if (blck_simulationManager isEqualTo blck_useBlckeaglsSimulationManager) then
{
	//diag_log format["_fnc_simulationMonitor: evaluating simulation using blckeagls code"];
	{
		private _group = _x;
		private _nearplayer = [position (leader _group),blck_simulationEnabledDistance] call blck_fnc_nearestPlayers;	
		if !(_nearplayer isEqualTo []) then
		{
			if !(simulationEnabled (leader _group)) then
			{	
				{
					_x enableSimulationGlobal  true;
					_x reveal [(_nearplayer select 0),(_group knowsAbout (_nearPlayer select 0)) + 0.001];   //  Force simulation on
				}forEach units _group;
				//diag_log format["_fnc_simulationMonitor: (44) enabling simulation for group %1",_group];
			};
		}else{
			if (simulationEnabled (leader _group)) then
			{	
				{_x enableSimulationGlobal false} forEach units _group;
				//diag_log format["_fnc_simulationMonitor: (50) disabling simulation for group %1",_group];					
			};
		};
	} forEach blck_monitoredMissionAIGroups;

	{
		// diag_log format["_fnc_simulationManager: _x = %1 | blck_graveyardGroup = %2",_x, units blck_graveyardGroup];
		// disable simulation once players have left the area.
		private _nearPlayers = [position (_x),blck_simulationEnabledDistance] call blck_fnc_nearestPlayers;		
		if (simulationEnabled _x) then 
		{		
			if (_nearPlayers isEqualTo []) then 
			{
				_x enableSimulationGlobal false;
				//diag_log format["_fnc_simulationMonior: simulation for unit %1 set to FALSE",_unit];
			};
		} else {
			if !(_nearPlayers isEqualTo []) then 
			{
				_x enableSimulationGlobal true;
				//diag_log format["_fnc_simulationMonior: simulation for unit %1 set to TRUE",_unit];			
			};
		};
	} forEach units blck_graveyardGroup;		
};


