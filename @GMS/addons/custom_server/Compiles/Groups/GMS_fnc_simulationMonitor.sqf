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
//diag_log format["_fnc_simulationMonitor Called at %1 | blck_simulationManager = %2 | blck_simulationManagementOff = %3",diag_tickTime,blck_simulationManager,blck_simulationManagementOff];
if (blck_simulationManager isEqualTo blck_simulationManagementOff) exitWith 
{
	//diag_log format["_fnc_simulationMonitor: monitoring disabled at %1",diag_tickTime];
};

if (blck_simulationManager isEqualTo blck_useDynamicSimulationManagement) exitWith 
{
	//diag_log format["_fnc_simulationMonitor: evaluating simulation using dynamic simulation - poking groups that need to be activated"];
	{
		private _group = _x;
		private _nearplayer = [position (leader _group),blck_simulationEnabledDistance] call blck_fnc_nearestPlayers;	
		//diag_log format["_fnc_simulationMonitor (24): _nearPlayer = %1",_nearPlayer];
		if !(_nearPlayer isEqualTo []) then 
		{
			// toWhom reveal [target, accuracy]
			//diag_log format["_fnc_simulationMonitor: (28) revealing group %1",_group];
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
				diag_log format["_fnc_simulationMonitor: (50) disabling simulation for group %1",_group];					
			};
		};
	} forEach blck_monitoredMissionAIGroups;

	{
		// disable simulation once players have left the area.
		private _nearplayer = [position (leader _group),blck_simulationEnabledDistance] call blck_fnc_nearestPlayers;	
		if (simulationEnabled _x) then 
		{
			private _unit = _x; //blck_deadAI deleteAt 0;
			if (_nearPlayer isEqualTo []) then 
			{
				_unit enableSimulationGlobal false;
				//diag_log format["_fnc_simulationMonior: simulation for unit %1 set to FALSE",_unit];
			};
		} else {
			if !(_nearPlayers isEqualTo []) then 
			{
				_unit enableSimulationGlobal true;
				//diag_log format["_fnc_simulationMonior: simulation for unit %1 set to TRUE",_unit];			
			};
		};
	} forEach units blck_graveyardGroup;		
};


