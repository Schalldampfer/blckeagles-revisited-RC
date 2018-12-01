
/*
	Checks for groups that have not reached their waypoints within a proscribed period
	and redirects them.

	for ghostridergaming
	By Ghostrider [GRG]
	Copyright 2016
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

_fn_waypointComplete = {
	private _group = _this select 0;
	private _wp = currentWaypoint _group;
	private _done = if (currentWaypoint _group) > (count (waypoints _group)) then {true} else {false};
	_done
};

_fn_aliveGroupUnits = {
	private _group = _this select 0;
	private _units = {alive _x} count (units _group);
	_units
};
{
	private["_timeStamp","_index","_unit","_soldierType"];
	// check for error conditions
	if ( !(_x isEqualTo grpNull) && ([_x] call _fn_aliveGroupUnits > 0) ) then
	{
	/*
	#define blck_turnBackRadiusInfantry 800
	#define blck_turnBackRadiusVehicles 1000
	#define blck_turnBackRadiusHelis 1000
	#define blck_turnBackRadiusJets 1500
	*/
	diag_log format["_fn_monitorGroupWaypoints - radii: on foot %1 | vehicle %2 | heli %3 | jet %4",blck_turnBackRadiusInfantry,blck_turnBackRadiusVehicles,blck_turnBackRadiusHelis,blck_turnBackRadiusJets];
	_timeStamp = _x getVariable ["timeStamp",0];
	if (_timeStamp isEqualTo 0) then {
		_x setVariable["timeStamp",diag_tickTime];
		//diag_log format["_fn_monitorGroupWaypoints::--> updating timestamp for group %1 at time %2",_x,diag_tickTime];
	};
	_soldierType = _x getVariable["soldierType","null"];
	//diag_log format["_fn_monitorGroupWaypoints::--> soldierType for group %1 = %2 and timeStamp = %3",_x,_soldierType,_timeStamp];
	private _maxtime = 0;
	switch (soldierType) do
	{
		case "infantry": {_maxtime = 60};
		case "vehicle": {_maxtime = 90};
		case "aircraft": {_maxtime = 90};
	};
	_private _updateNeeded = if (diag_tickTime > (_x getVariable "timeStamp") + 60) then
	{
		
	}
	if (_soldierType isEqualTo "infantry") then
	{
		if (diag_tickTime > (_x getVariable "timeStamp") + 60) then
		{
			_units = [_x] call _fn_aliveGroupUnits;
			if (count _units > 0) then
			{
				private _leader = leader _x;
				(_leader) call blck_fnc_changeToMoveWaypoint;
				#ifdef blck_debugMode
				if (blck_debugLevel > 2) then {diag_log format["_fnc_missionGroupMonitor: infantry group %1 stuck, waypoint reset",_x];};
				#endif
				/*
				if ( (getPos _leader) distance2d (_group getVariable "patrolCenter") > 200) then 
				{

				};
				*/
			};

		};
	};
	if (_soldierType isEqualTo "vehicle") then
	{
		if (diag_tickTime > (_x getVariable "timeStamp") + 60) then
		{
			_units = [_x] call _fn_aliveGroupUnits;
			if (count _units > 0) then
			{
				private _leader = leader _x;
				(_leader) call blck_fnc_changeToMoveWaypoint;
				//#ifdef blck_debugMode
				if (true /*blck_debugLevel > 2*/) then {diag_log format["_fnc_missionGroupMonitor: vehicle group %1 stuck, waypoint reset",_x];};
				//#endif
				/*
				if ( (getPos _leader) distance2d (_group getVariable "patrolCenter") > 200) then 
				{
				};
				*/
			};

		};
	};
	/*
	if (_soldierType isEqualTo "helicopter") then
	{
		if ((diag_tickTime > (_x getVariable "timeStamp")) then
		{
			private _units = [_x] call _fn_aliveGroupUnits;
			if (count _units > 0) then
			{
				private _leader = leader _x;
				if (_leader distance (_group getVariable "patrolCenter") > blck_turnBackRadiusHelis) then
				{
					_leader call blck_fnc_changeToMoveWaypoint;
					//#ifdef blck_debugMode
					if (true ) then {diag_log format["_fnc_missionGroupMonitor: helicopter group %1 stuck, waypoint reset",_x];};
					//#endif
					//diag_log format["_fnc_missionGroupMonitor: helicopter group %1 stuck, waypoint reset",_x];
				};					
			};

		};
	};	
	*/
} forEach blck_monitoredMissionAIGroups;

