/*
	by Ghostridere-GRG-
	Copyright 2016
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_coords","_missionLootVehicles",["_loadCrateTiming","atMissionSpawn"],["_lock",0]];
if (count _coords == 2) then {_coords pushBack 0};
private _vehs = [];
{
	//diag_log format["spawnMissionCVehicles.sqf _x = %1",_x];
	_x params["_vehType","_vehOffset","_lootArray","_lootCounts",["_dir",0]];
	//diag_log format["spawnMissionCVehicles: _vehType = %1 | _vehOffset = %2 | _lootArray = %3 | _lootCounts = %4",_vehType,_vehOffset,_lootArray,_lootCounts];
	_pos = _coords vectorAdd _vehOffset;
	_veh = [_vehType, _pos] call blck_fnc_spawnVehicle;
	_veh setDir _dir;
	_veh lock _lock;
	if (_loadCrateTiming isEqualTo "atMissionSpawn") then
	{
		//diag_log format["blck_fnc_spawnMissionLootVehicles::-> loading loot at mission spawn for veh %1",_x];
		[_veh,_lootArray,_lootCounts] call blck_fnc_fillBoxes;
		_veh setVariable["lootLoaded",true];
	};
	_vehs pushback _veh;
}forEach _missionLootVehicles;
_vehs
