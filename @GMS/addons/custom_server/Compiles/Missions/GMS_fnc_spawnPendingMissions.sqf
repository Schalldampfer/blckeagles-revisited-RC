/*
	for ghostridergaming
	By Ghostrider [GRG]
	Copyright 2016
	checks the status of each entry in 
/*
	By Ghostrider [GRG]
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/

			_marker,
		_difficulty,
		_noMissions,
		0,  // Number active 
		0, // times spawned, useful for keeping unique markers 
		_tMin,
		_tMax,
		_waitTime,
		_missionsData  // 
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

if !(isNil "blck_spawnerMode") exitWith 
{
	diag_log format["_fnc_spawnPendingMissions: count blck_missionData = %1",count blck_missionData];
	{	
		/*
		_missionCategoryDescriptors params [
				"_marker",
				"_difficulty",
				"_noMissions",  // Max no missions of this category
				"_noActive",  // Number active 
				"_timesSpawned", // times spawned, useful for keeping unique markers 
				"_tMin", // Used to calculate waittime in the future
				"_tMax", // as above
				"_waitTime",  // time at which a mission should be spawned
				"_missionsData"  // 
			];
		*/	
		private _md = _x;	
									// 0		1					2				   						3		4		  5	       6	   
		_md params[/*"_marker",*/"_difficulty","_maxNoMissions","_noActiveMissions",/*"_timesSpawned",*/"_tMin","_tMax","_waitTime","_missionsData"];
		
		
		{
			diag_log format["_fnc_spawnPendingMissions: _x param %1 = %2",_x,_md select _forEachIndex];
		} forEach [/*"_marker",*/"_difficulty","_maxNoMissions","_noActiveMissions",/*"_timesSpawned",*/"_tMin","_tMax","_waitTime","_missionsData"];
		
		if (_noActiveMissions < _maxNoMissions && diag_tickTime > _waitTime && blck_missionsRunning < blck_maxSpawnedMissions) then 
		{
			// time to reset timers and spawn something.
			private _wt = diag_tickTime + _tmin + (random(_tMax - _tMin));

			#define waitTime 5
			#define noActive 2
			
			_x set[waitTime, _wt];
			//_x set[timesSpawned, _timesSpawned + 1];
			_x set[noActive, _noActiveMissions + 1];
			private _m = selectRandom _missionsData;
			//private _mrkr = format["%1:%2",_marker,_timesSpawned];
			//diag_log format["_fnc_spawnPendingMissions: using marker %1 | spawning mission %1",_mrkr,_m];
			//uisleep 1;  // only for debugging purposes.  
			//  TODO: comment out uiSleep at a later time.
			[_x,_m] call blck_fnc_initializeMission;
		};
	} forEach blck_missionData;
};

true
