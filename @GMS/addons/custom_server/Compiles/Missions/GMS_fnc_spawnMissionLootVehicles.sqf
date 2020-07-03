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
if (count _coords isEqualTo 2) then {_coords pushBack 0};
private _vehs = [];
{
	_x params["_vehType","_vehOffset",["_dir",0],"_lootArray","_lootCounts"];
	//diag_log format["spawnMissionCVehicles: _vehType = %1 | _vehOffset = %2 | _lootCounts = %4 | _dir %5 | _lock %6 | _lootArray = %3 ",_vehType,_vehOffset,_lootArray,_lootCounts,_dir,_lock];
	private _pos =_coords vectorAdd _vehOffset;
	_veh = [_vehType, _pos] call blck_fnc_spawnVehicle;
	if (typeName _dir isEqualTo "SCALAR") then 
	{
		_veh setDir _dir;
	};
	if (typeName _dir isEqualTo "ARRAY") then
	{
		_veh setVectorDirAndUp _dir;
	};
	_veh lock _lock;
	if (_loadCrateTiming isEqualTo "atMissionSpawn") then
	{
		//diag_log format["blck_fnc_spawnMissionLootVehicles::-> loading loot at mission spawn for veh %1",_x];
		[_veh,_lootArray,_lootCounts] call blck_fnc_fillBoxes;
		_veh setVariable["lootLoaded",true];
	};
	_veh addEventHandler ["GetIn", {
		private ["_vehicle","_unit","_vehSlot"];
		_vehicle = _this select 0;
		_unit = _this select 2;
		if !(isPlayer _unit) exitWith {};
		if !(EPOCH_VehicleSlots isEqualTo []) then {
			_vehSlot = EPOCH_VehicleSlots deleteAt 0;
			missionNamespace setVariable ['EPOCH_VehicleSlotCount', count EPOCH_VehicleSlots, true];
			_vehicle setVariable["VEHICLE_SLOT", _vehSlot, true];
		};
		_vehicle removeAllEventHandlers "GetIn";
	}];
	_vehs pushback _veh;
}forEach _missionLootVehicles;
_vehs
