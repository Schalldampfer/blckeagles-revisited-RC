/*
	blck_fnc_spawnMissionAI
	by Ghostrider [GRG]

	returns an array of the units spawned
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";
#define configureWaypoints true
// TODO: consolidate code where possible, for example the recurring code to create the group and add units to the list of units spawned.
// TODO: find reason that this sometimes throws errors because it passes an array rather than group.

params["_coords",["_minNoAI",3],["_maxNoAI",6],["_noAIGroups",0],["_missionGroups",[]],["_aiDifficultyLevel","red"],["_uniforms",[]],["_headGear",blck_BanditHeadgear],["_vests",[]],["_backpacks",[]],["_weapons",[]],["_sideArms",[]],["_isScubaGroup",false]];

/*
private _params = ["_coords","_minNoAI","_maxNoAI","_noAIGroups","_missionGroups","_aiDifficultyLevel","_uniforms","_headGear","_vests","_backpacks","_weapons","_sideArms","_isScubaGroup"];
{
	diag_log format["_fnc_spawnMissionAI: _this %1 | name %3 = %2",_forEachIndex,_x,_params select _forEachIndex];
} forEach _this;
*/

private _unitsToSpawn = 0;
private _unitsPerGroup = 0;
private _ResidualUnits = 0;
private _adjusttedGroupSize = 0;

// TODO: Does not really look right
if (_noAIGroups > 0) then
{
	// Can add optional debug code here if needed.
	_unitsToSpawn = [[_minNoAI,_maxNoAI]] call blck_fnc_getNumberFromRange;  //round(_minNoAI + round(random(_maxNoAI - _minNoAI)));
	_unitsPerGroup = floor(_unitsToSpawn/_noAIGroups);
	_ResidualUnits = _unitsToSpawn - (_unitsPerGroup * _noAIGroups);
};
private _allSpawnedAI = [];
private _abort = false;

private _newGroup = grpNull;
//_newGroup setVariable ["soldierType","infantry"];
if !(_missionGroups isEqualTo []) then
{ 	
	//diag_log "_fnc_missionspawner: spawning pre-defined groups";
	{
		_x params["_position","_minAI","_maxAI","_skillLevel","_minPatrolRadius","_maxPatrolRadius"];
		private _p = ["_position","_minAI","_maxAI","_skillLevel","_minPatrolRadius","_maxPatrolRadius"];
		private _p1 = [_position,_minAI,_maxAI,_skillLevel,_minPatrolRadius,_maxPatrolRadius];	

		/*
		{
			diag_log format["_fnc_spawnMissionAI: %1 = %2",_p select _forEachIndex, _x];
		} forEach _p1;
		*/

		private _groupSpawnPos = _coords vectorAdd _position;
		_newGroup = [blck_AI_Side,true]  call blck_fnc_createGroup;
		//diag_log format["_fnc_spawnMissionAI(55): _newGroup = %1",_newGroup];
		_newGroup setVariable ["soldierType","infantry"];	
		#ifdef blck_debugMode
		if (blck_debugLevel >= 2) then
		{
			diag_log format["_fnc_spawnMissionAI (37):: case 1 - > _newGroup = %1",_newGroup];
		};
		#endif

		if !(isNull _newGroup) then 
		{
			//[["_group","Error"],"_pos",  "_center", ["_numai1",5],  ["_numai2",10],  ["_skillLevel","red"], ["_minDist",30], ["_maxDist",45],["_configureWaypoints",true], ["_uniforms",[]], ["_headGear",[]],["_vests",[]],["_backpacks",[]],["_weaponList",[]],["_sideArms",[]], ["_scuba",false],["_patrolRadius",30]];
			[_newGroup,_groupSpawnPos,_coords,_minAI,_maxAI,_aiDifficultyLevel,_minPatrolRadius,_maxPatrolRadius,configureWaypoints,_uniforms,_headGear,_vests,_backpacks,_weapons,_sideArms,_isScubaGroup] call blck_fnc_spawnGroup;
			_newGroup setVariable ["soldierType","infantry"];
			//private _newAI = units _newGroup;
			blck_monitoredMissionAIGroups pushback _newGroup;

			
			_allSpawnedAI append (units _newGroup);
			diag_log format["_fnc_spawnMissionAI(77): group %1 | count _newAI = %2 | count _allSpawnedAI = %3",_forEachIndex,count (units _newGroup), count _allSpawnedAI];			
		};
	}forEach _missionGroups;
};
if (_missionGroups isEqualTo [] && _noAIGroups > 0) then
{
	private _minPatrolRadius = blck_minimumPatrolRadius;
	private _maxPatrolRadius = blck_maximumPatrolRadius;
	
	switch (_noAIGroups) do
	{
		case 1: {  // spawn the group near the mission center
				
				#ifdef blck_debugMode
				if (blck_debugLevel >= 2) then
				{
					diag_log format["missionSpawner: Spawning Groups: case 1: _noAIGroups=1"];
				};
				#endif
				_newGroup = [blck_AI_Side,true] call blck_fnc_createGroup;
				_newGroup setVariable ["soldierType","infantry"];				
				#ifdef blck_debugMode
				if (blck_debugLevel >= 2) then
				{
					diag_log format["_fnc_spawnMissionAI (37):: case 1 - > _newGroup = %1",_newGroup];
				};
				#endif
				if !(isNull _newGroup) then 
				{
					[_newGroup,_coords,_coords,_unitsToSpawn,_unitsToSpawn,_aiDifficultyLevel,_minPatrolRadius,_maxPatrolRadius,configureWaypoints,_uniforms,_headGear,_vests,_backpacks,_weapons,_sideArms,_isScubaGroup] call blck_fnc_spawnGroup;
					_newGroup setVariable ["soldierType","infantry"];
					_newAI = units _newGroup;
					blck_monitoredMissionAIGroups pushback _newGroup;
					#ifdef blck_debugMode
					if (blck_debugLevel >= 2) then
					{
						diag_log format["_fnc_spawnMissionAI(41): Spawning Groups: _noAIGroups=1 _newGroup=%1 _newAI = %2",_newGroup, _newAI];
					};
					#endif

					_allSpawnedAI append _newAI;
				
				};
			 };
		case 2: {

				#ifdef blck_debugMode
				if (blck_debugLevel >= 2) then
				{
					diag_log format["_fnc_spawnMissionAI(47): Spawning Groups: case 2: _noAIGroups=2"];  // spawn groups on either side of the mission area
				};
				#endif
				_groupLocations = [_coords,_noAIGroups,15,30] call blck_fnc_findPositionsAlongARadius;
				{
					if (_ResidualUnits > 0) then
					{
						_adjusttedGroupSize = _unitsPerGroup + _ResidualUnits;
						_ResidualUnits = 0;
					} else {
						_adjusttedGroupSize = _unitsPerGroup;
					};
					_newGroup = [blck_AI_Side,true]  call blck_fnc_createGroup;
					_newGroup setVariable ["soldierType","infantry"];					
					if !(isNull _newGroup) then 
					{
						[_newGroup,_x,_coords,_adjusttedGroupSize,_adjusttedGroupSize,_aiDifficultyLevel,_minPatrolRadius,_maxPatrolRadius,configureWaypoints,_uniforms,_headGear,_vests,_backpacks,_weapons,_sideArms,_isScubaGroup] call blck_fnc_spawnGroup;
						_newAI = units _newGroup;
						blck_monitoredMissionAIGroups pushback _newGroup;
						#ifdef blck_debugMode
						if (blck_debugLevel >= 2) then
						{
							diag_log format["_fnc_spawnMissionAI(61): case 2: _newGroup=%1",_newGroup];
						};
						#endif

						_allSpawnedAI append _newAI;
					};
				}forEach _groupLocations;

			};
		case 3: { // spawn one group near the center of the mission and the rest on the perimeter
				
				#ifdef blck_debugMode
				if (blck_debugLevel >= 2) then
				{
					diag_log format["_fnc_spawnMissionAI (68): Spawning Groups: case 3: _noAIGroups=3"];
				};
				#endif
				_newGroup = [blck_AI_Side,true]  call blck_fnc_createGroup;
				_newGroup setVariable ["soldierType","infantry"];
				if !(isNull _newGroup) then 
				{
					[_newGroup,_coords,_coords,_unitsPerGroup + _ResidualUnits,_unitsPerGroup + _ResidualUnits,_aiDifficultyLevel,_minPatrolRadius,_maxPatrolRadius,configureWaypoints,_uniforms,_headGear,_vests,_backpacks,_weapons,_sideArms,_isScubaGroup] call blck_fnc_spawnGroup;
					_newAI = units _newGroup;
					blck_monitoredMissionAIGroups pushback _newGroup;
					#ifdef blck_debugMode
					if (blck_debugLevel >= 2) then
					{
						diag_log format["_fnc_spawnMissionAI (73): Case 3:  _newGroup=%1",_newGroup];
					};
					#endif
					_allSpawnedAI append _newAI;
					_groupLocations = [_coords,2,20,35] call blck_fnc_findPositionsAlongARadius;
					{
						_newGroup = [blck_AI_Side,true]  call blck_fnc_createGroup;	
						_newGroup setVariable ["soldierType","infantry"];		
						if !(isNull _newGroup) then 
						{
							[_newGroup,_x,_coords,_unitsPerGroup,_unitsPerGroup,_aiDifficultyLevel,_minPatrolRadius,_maxPatrolRadius,configureWaypoints,_uniforms,_headGear,_vests,_backpacks,_weapons,_sideArms,_isScubaGroup] call blck_fnc_spawnGroup;
							_newAI = units _newGroup;
							blck_monitoredMissionAIGroups pushback _newGroup;
							#ifdef blck_debugMode
							if (blck_debugLevel >= 2) then
							{
								diag_log format["_fnc_spawnMissionAI(78): Case 3: line 81: _newGroup = %1",_newGroup];
							};
							#endif
							_allSpawnedAI append _newAI;
						};
					}forEach _groupLocations;
				};
			};
		default {  // spawn one group near the center of the mission and the rest on the perimeter

				#ifdef blck_debugMode
				if (blck_debugLevel >= 2) then
				{
					diag_log format["_fnc_spawnMissionAI (88) spawning groups: Case default:"];
				};
				#endif

				_newGroup = [blck_AI_Side,true]  call blck_fnc_createGroup;	
				_newGroup setVariable ["soldierType","infantry"];			
				if (isNull _newGroup) then 
				{
					[_newGroup,_coords,_coords,_unitsPerGroup + _ResidualUnits,_unitsPerGroup + _ResidualUnits,_aiDifficultyLevel,_minPatrolRadius,_maxPatrolRadius,configureWaypoints,_uniforms,_headGear,_vests,_backpacks,_weapons,_sideArms,_isScubaGroup] call blck_fnc_spawnGroup;				
					_newAI = units _newGroup;
					blck_monitoredMissionAIGroups pushback _newGroup;
					#ifdef blck_debugMode
					if (blck_debugLevel >= 2) then
					{
						diag_log format["_fnc_spawnMissionAI(92): Spawning Groups: Default - > Center Position:  _noAIGroups=1 _newGroup=%1 _newAI = %2",_newGroup, _newAI];
					};
					#endif
					_allSpawnedAI append _newAI;
				};
				_groupLocations = [_coords,(_noAIGroups - 1),20,40] call blck_fnc_findPositionsAlongARadius;
				{
					_newGroup = [blck_AI_Side,true]  call blck_fnc_createGroup;
					_newGroup setVariable ["soldierType","infantry"];
					if !(isNull _newGroup) then 
					{
						[_newGroup,_x,_coords,_unitsPerGroup,_unitsPerGroup,_aiDifficultyLevel,_minPatrolRadius,_maxPatrolRadius,configureWaypoints,_uniforms,_headGear,_vests,_backpacks,_weapons,_sideArms,_isScubaGroup] call blck_fnc_spawnGroup;
						_newAI = units _newGroup;
						blck_monitoredMissionAIGroups pushback _newGroup;
						#ifdef blck_debugMode
						if (blck_debugLevel > 2) then
						{
							diag_log format["_fnc_spawnMissionAI(99): Default: Radial Positions: _newGroup=%1",_newGroup];
						};
						#endif
						_allSpawnedAI append _newAI;
					};
				}forEach _groupLocations;
			};
	};
};

#ifdef blck_debugMode
if (blck_debugLevel >= 1) then
{
	diag_log format["_fnc_spawnMissionAI(243): _abort = %1 | _allSpawnedAI = %2",_abort,_allSpawnedAI];
};
#endif
//diag_log format["_fnc_spawnMissionAI(246): _unitsToSpawn = %1 | count _allSpawnedAI = %2",_unitsToSpawn,count _allSpawnedAI];
_return = [_allSpawnedAI,_abort];
_return
