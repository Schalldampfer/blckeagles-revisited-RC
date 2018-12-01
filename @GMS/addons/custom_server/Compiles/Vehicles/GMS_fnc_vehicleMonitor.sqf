/*
	By Ghostrider [GRG]
	Copyright 2016

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

private ["_vehList"];
_vehList = +blck_monitoredVehicles;

//diag_log format["_fnc_vehicleMonitor:: function called at %1 with _vehList %2 ",diag_tickTime,_vehList,blck_monitoredVehicles];

{
	private["_veh","_isEmplaced","_allCrewDead","_evaluate","_deleteAtTime"];
	_veh = _x; // (purely for clarity at this point, _x could be used just as well)
	
	_isEmplaced = _veh getVariable["GRG_vehType","none"] isEqualTo "emplaced";
	_allCrewDead = {alive _x} count (crew _veh) == 0;
	_evaluate = 0;
	_deleteAtTime = _veh getVariable ["blck_deleteAtTime",diag_tickTime + 1];

	if (diag_tickTime > _deleteAtTime) then 
	{
		_evaluate = 3;
	} else {
		if (_allCrewDead) then
		{
			_evaluate = if (_isEmplaced) then {1} else {2};
		};
	};

	//diag_log format["_fnc_vehicleMonitor: vehicle = %1 | owner = %2 | crew = %3 | _evaluate = %4",_veh, owner _veh, {alive _x} count (crew _veh), _evaluate];
	switch (_evaluate) do
	{
		case 0:{[_veh] call blck_fnc_reloadVehicleAmmo;};
		case 1:{
			if (blck_killEmptyStaticWeapons) then
			{
				if (blck_debugLevel > 2) then {diag_log format["_fnc_vehicleMonitor:: case of destroyed where vehicle = %1",_veh];};
				_veh setDamage 1;
				_veh setVariable["blck_deleteAtTime",diag_tickTime + 60];
			}else {
				//diag_log format["_fnc_vehicleMonitor: calling _fnc_releaseVehicleToPlayers for vehicle %1",_veh];
				[_veh] call blck_fnc_releaseVehicleToPlayers;
			};
		};
		case 2:{
			if (blck_killEmptyAIVehicles) then
			{
				//if (blck_debugLevel > 2) then {diag_log format["_fnc_vehicleMonitor:: case of destroyed where vehicle = %1",_veh];};
				_veh setDamage 0.7;
				_veh setFuel 0;
				_veh setVariable["blck_deleteAtTime",diag_tickTime + 60];
			} else {
				//diag_log format["_fnc_vehicleMonitor: calling _fnc_releaseVehicleToPlayers for vehicle %1",_veh];					
				[_veh] call blck_fnc_releaseVehicleToPlayers;
			};
		};
		case 3:{
			//diag_log format["_fnc_releaseVehicleToPlayers: destroying vehicle and crew for vehicle %1 at time %2",_veh,diag_tickTime];
			[_veh] call blck_fnc_destroyVehicleAndCrew;				
		};

	};
}forEach _vehList;



