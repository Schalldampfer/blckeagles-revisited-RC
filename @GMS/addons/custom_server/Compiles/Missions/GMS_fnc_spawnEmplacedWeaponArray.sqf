/*

	[_missionEmplacedWeapons,_noEmplacedWeapons,_aiDifficultyLevel,_coords,_uniforms,_headGear] call blck_fnc_spawnEmplacedWeaponArray;
	By Ghostrider [GRG]
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_coords",["_missionEmplacedWeapons",[]],["_useRelativePos",true],["_noEmplacedWeapons",0],["_aiDifficultyLevel","red"],["_uniforms",[]], ["_headGear",[]],["_vests",[]],["_backpacks",[]],["_weaponList",[]],["_sideArms",[]]];
if (_uniforms isEqualTo []) 		then {_uniforms = [_aiDifficultyLevel] call blck_fnc_selectAIUniforms};
if (_headGear  isEqualTo [])		then {_headGear = [_aiDifficultyLevel] call blck_fnc_selectAIHeadgear};
if (_vests isEqualTo []) 			then {_vests = [_aiDifficultyLevel] call blck_fnc_selectAIVests};
if (_backpacks  isEqualTo []) 		then {_backpacks = [_aiDifficultyLevel] call blck_fnc_selectAIBackpacks};
if (_weaponList  isEqualTo []) 	then {_weaponList = [_aiDifficultyLevel] call blck_fnc_selectAILoadout};
if (_sideArms isEqualTo []) 		then {[_aiDifficultyLevel] call blck_fnc_selectAISidearms};

/*
{
	diag_log format["_fnc_spawnEmplacedWeaponArray: _this %1 varName %2 = %3",_forEachIndex,_x,_this select _forEachIndex];
} forEach ["_coords","_missionEmplacedWeapons","_useRelativePos","_noEmplacedWeapons","_aiDifficultyLevel"];
*/

private["_return","_emplacedWeps","_emplacedAI","_wep","_units","_gunner","_abort","_pos","_mode","_useRelativePos","_useRelativePos"];
_emplacedWeps = [];
_emplacedAI = [];
_units = [];
_abort = false;
_pos = [];

// Define _missionEmplacedWeapons if not already configured.
if (_missionEmplacedWeapons isEqualTo []) then
{
	_missionEmplacedWeaponPositions = [_coords,_noEmplacedWeapons,35,50] call blck_fnc_findPositionsAlongARadius;

	{
		_static = selectRandom blck_staticWeapons;
		_missionEmplacedWeapons pushback [_static,_x];
	} forEach _missionEmplacedWeaponPositions;
	_useRelativePos = false;
};

{
	if (_useRelativePos) then 
	{
		_pos = _coords vectorAdd (_x select 1);
	} else {
		_pos = (_x select 1);
	};

	#define configureWaypoints false
	#define minAI 1
	#define maxAI 1
	#define minDist 1
	#define maxDist 2
	
	/// // params["_pos",  "_center", _numai1,  _numai2,  _skillLevel, _minDist, _maxDist, _configureWaypoints, _uniforms, _headGear,_vests,_backpacks,_weaponList,_sideArms, _scuba ];
	private _empGroup = [blck_AI_Side,true]  call blck_fnc_createGroup;
	if !(isNull _empGroup) then 
	{
		[_empGroup,(_x select 1),_pos,minAI,maxAI,_aiDifficultyLevel,minDist,maxDist,configureWaypoints,_uniforms,_headGear,_vests,_backpacks,_weaponList,_sideArms] call blck_fnc_spawnGroup;
		_empGroup setcombatmode "RED";
		_empGroup setBehaviour "COMBAT";
		_empGroup setVariable ["soldierType","emplaced"];
		[(_x select 1),0.01,0.02,_empGroup,"random","SAD","emplaced"] spawn blck_fnc_setupWaypoints;
		private _wep = [(_x select 0),[0,0,0]] call blck_fnc_spawnVehicle;
		_wep setVariable["GRG_vehType","emplaced"];	
		_wep setPos _pos;
		_wep setdir (random 359);
		[_wep,2] call blck_fnc_configureMissionVehicle;	
		_emplacedWeps pushback _wep;
		_units = units _empGroup;
		_gunner = _units select 0;
		_gunner moveingunner _wep;
		_gunner setVariable["GRG_vehType","emplaced"];	
		_emplacedAI append _units;		
	} else {
		_abort = true;
		_return = grpNull;
		diag_log format["[blckeagls] <WARNING> createGroup returned grpNull"];
	};
} forEach _missionEmplacedWeapons;
if !(_abort) then 
{
	blck_monitoredVehicles append _emplacedWeps;
	 if !(isNil "blck_spawnerMode") then 
	 {
		_return = [_emplacedWeps,_emplacedAI];
	 } else {
		_return = [_emplacedWeps,_emplacedAI,_abort];
	 };
} else {
	 if !(isNil "blck_spawnerMode") then 
	 {	
		{[_x] call blck_fnc_destroyVehicleAndCrew} forEach _emplacedWeps;
		_return = grpNull;
	 } else {
		blck_monitoredVehicles append _emplacedWeps;
		_return = [_emplacedWeps,_emplacedAI,_abort];		
	 };
};

_return
