/*
	blck_fnc_spawnGroup
	By Ghostrider [GRG]
	Copyright 2016
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

private["_numbertospawn","_safepos","_launcherType","_infantryType"];	
params[["_group","Error"],"_pos",  "_center", ["_numai1",5],  ["_numai2",10],  ["_skillLevel","red"], ["_minDist",30], ["_maxDist",45],["_configureWaypoints",true], ["_uniforms",[]], ["_headGear",[]],["_vests",[]],["_backpacks",[]],["_weaponList",[]],["_sideArms",[]], ["_scuba",false]];

#ifdef blck_debugMode 
if (blck_debugLevel > 3) then 
{
	{
		diag_log format["_fnc_spawnGroup: _this select %1 = %2",_forEachIndex,_this select _forEachIndex];
	}forEach _this;
};
#endif

if !(typeName _group isEqualTo "GROUP") exitWith {
	if (_group isEqualTo "Error") exitWith {diag_log format["_fnc_spawnGroup [ERROR]: no parameter was passed for _group"]};
	diag_log format["_fnc_spawnGroup {ERROR]}: parameter %2 of type %1 passed, 'GROUP expected",typeName _group,_group];
};
//if (isNull _group) exitWith {diag_log format["ERROR: No valid value _group was passed to blck_fnc_spawnGroup"]};
if (_weaponList isEqualTo []) then {_weaponList = [_skillLevel] call blck_fnc_selectAILoadout};
if (_sideArms isEqualTo [])  then {_sideArms = [_skillLevel] call blck_fnc_selectAISidearms};
if (_uniforms isEqualTo [])  then {_uniforms = [_skillLevel] call blck_fnc_selectAIUniforms};
if (_headGear isEqualTo [])  then {_headGear = [_skillLevel] call blck_fnc_selectAIHeadgear};
if (_vests isEqualTo [])     then {_vests = [_skillLevel] call blck_fnc_selectAIVests};
if (_backpacks isEqualTo []) then {_backpacks = [_skillLevel] call blck_fnc_selectAIBackpacks};

_numbertospawn = [_numai1,_numai2] call blck_fnc_getNumberFromRange;

if !(isNull _group) then
{
	if (_weaponList isEqualTo []) then
	{
		_weaponList = [_skillLevel] call blck_fnc_selectAILoadout;
	};

	//Spawns the correct number of AI Groups, each with the correct number of units
	//Counter variable
	_i = 0;
	while {_i < _numbertospawn} do 
	{
		_i = _i + 1;
		if (blck_useLaunchers && _i <= blck_launchersPerGroup) then
		{
			_launcherType = selectRandom blck_launcherTypes;
		} else {
			_launcherType = "none";
		};
		 //params["_pos","_aiGroup",_skillLevel,_uniforms, _headGear,_vests,_backpacks,_Launcher,_weaponList,_sideArms,_scuba];
		[_pos,_group,_skillLevel,_uniforms,_headGear,_vests,_backpacks,_launcherType, _weaponList, _sideArms, _scuba] call blck_fnc_spawnUnit;
	};
	_group selectLeader ((units _group) select 0);
	// params["_pos","_minDis","_maxDis","_group",["_mode","random"],["_pattern",["MOVE","SAD"]]];
	if (_configureWaypoints) then
	{
		if (_scuba) then {_infantryType = "scuba"} else {_infantryType = "infantry"};
		[_pos,_minDist,_maxDist,_group,"random","SAD",_infantryType] spawn blck_fnc_setupWaypoints;
	};
} else 
{
	diag_log "_fnc_spawnGroup:: ERROR CONDITION : NULL GROUP CREATED";
};
#ifdef blck_debugMode 
if (blck_debugLevel > 2) then 
{
	diag_log format["_fnc_spawnGroup:_group = %1",_group];
};
#endif
_group
