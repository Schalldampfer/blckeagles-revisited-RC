/*
	by Ghostrider [GRG]
	Copyright 2016
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";
#define configureWaypoints true
#define isScubaGroup true

params["_pos",["_skillLevel","red"],["_numUnits",6],["_patrolRadius",15]];

private["_group"];
try 
{
	_group = [blck_AI_Side,true]  call blck_fnc_createGroup;  // allow server to delete the group as soon as it is empty
	if (isNull _group) throw 1; 
	[_group,_pos,_pos,_numUnits,_numUnits,_skillLevel, _patrolRadius - 2, _patrolRadius, configureWaypoints, blck_UMS_uniforms, blck_UMS_headgear, blck_UMS_vests, [], blck_UMS_weapons, [], isScubaGroup] call blck_fnc_spawnGroup;
	private _diveDepth = [_pos] call blck_fnc_findWaterDepth * 0.5;
	{
		_x swimInDepth (_diveDepth);
	} forEach units _group;
}

catch
{
	diag_log format["[blckeagls] <WARNING> createGroup returned grpNull"];
};
_group;
