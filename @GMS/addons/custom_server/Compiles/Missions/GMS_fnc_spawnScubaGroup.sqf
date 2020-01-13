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
#define UMS_backpacks [] 
#define UMS_sidearms [] 

params["_group","_pos",["_skillLevel","red"],["_numUnits",6],["_patrolRadius",15]];
//{diag_log format["_fnc_spawnScubaGroup: _this select %1 = %2",_foreachindex,_x]} forEach _this; 

	//params[["_group","Error"],"_pos",  "_center", ["_numai1",5],  ["_numai2",10],  ["_skillLevel","red"], ["_minDist",30], ["_maxDist",45],["_configureWaypoints",true],
	//["_uniforms",[]], ["_headGear",[]],["_vests",[]],["_backpacks",[]],["_weaponList",[]],["_sideArms",[]], ["_scuba",false],["_patrolRadius",30]];
[_group,_pos,_pos,_numUnits,_numUnits,_skillLevel, _patrolRadius - 2, _patrolRadius, configureWaypoints, blck_UMS_uniforms, blck_UMS_headgear, blck_UMS_vests, UMS_backpacks, blck_UMS_weapons, UMS_sidearms, isScubaGroup] call blck_fnc_spawnGroup;



