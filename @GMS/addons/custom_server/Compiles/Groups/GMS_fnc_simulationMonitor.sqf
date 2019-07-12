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
private["_playerType","_players"];
_playerType = ["LandVehicle","SHIP","AIR","TANK"];
//diag_log format["_fnc_simulationMonitor Called at %1",diag_tickTime];
switch (toLower(blck_modType)) do
{
	case "exile": {_playerType = _playerType + ["Exile_Unit_Player"]};
	case "epoch": {_playerType = _playerType + ["Epoch_Male_F","Epoch_Female_F"]};
};
{
	private _group = _x;
	_players = ((leader _group) nearEntities [_playerType, blck_simulationEnabledDistance]) select {isplayer _x};
	
	if !(_players isEqualTo []) then
	{
		{	
			if !(simulationEnabled _x) then
			{	
				_x enableSimulationGlobal  true;
				(_players select 0) reveal _x;  //  Force simulation on
			};
		}forEach (units _group);
	}else{
		{
			if (simulationEnabled _x) then
			{	
				_x enableSimulationGlobal false;
			};
		}forEach (units _x);
	};
} forEach blck_monitoredMissionAIGroups;
{
	if (simulationEnabled _x) then 
	{
		if !([_x,25,true] call blck_fnc_playerInRange) then 
		{
			#ifdef blck_debugMode
			diag_log format['_fnc_simulationManager: disabling simulation for dead AI %1',_x];
			#endif
			_x enableSimulationGlobal false;
		};
	} else {
		if ([_x,25,true] call blck_fnc_playerInRange) then 
		{
			#ifdef blck_debugMode
			diag_log format['_fnc_simulationManager: enabling simulation for dead AI %1',_x];
			#endif
			_x enableSimulationGlobal true;
		};
	};
} forEach blck_deadAI;
//  TODO: Add check for dead AI.
// TODO: Can this be run less often, say every 5 sec?