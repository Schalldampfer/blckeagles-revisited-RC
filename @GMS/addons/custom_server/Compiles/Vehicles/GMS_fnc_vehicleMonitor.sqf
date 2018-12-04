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

//diag_log format["_fnc_vehicleMonitor:: function called at %1 with _vehList %2 ",diag_tickTime,blck_monitoredVehicles];
private _serverIDs =  ([2] + (entities "HeadlessClient_F"));
for "_i" from 1 to (count blck_monitoredVehicles) do
{
	if (_i > (count blck_monitoredVehicles)) exitWith {};
	private _veh = blck_monitoredVehicles deleteAt 0;
	if !(_veh isEqualTo objNull) then
	{
		// if the owner is a player do not add back for further monitoring
		if ((owner _veh) in (_serverIDs)) then 
		{
			//diag_log format["_fnc_vehicleMonitor: vehicle %1 to be deleted at %2",_veh,(_veh getVariable ["blck_deleteAtTime",0])];
			if ((_veh getVariable ["blck_deleteAtTime",0]) > 0) then
			{
				if (diag_tickTime > ( _veh getVariable ["blck_deleteAtTime",0])) then
				{
					//diag_log format["_fnc_vehicleMonitor: deleting vehicle and crew for %1",_veh];
					[_veh] call blck_fnc_destroyVehicleAndCrew;				
				} else {
					blck_monitoredVehicles pushBack _veh;
				};
			} else {
				if ({alive _veh} count (crew _veh) == 0) then
				{	
					if (_veh getVariable["GRG_vehType","none"] isEqualTo "emplaced") then
					{
						if (blck_killEmptyStaticWeapons) then
						{
							//diag_log format["_fnc_vehicleMonitor: disabling static %1 and setting its delete time",_veh];
							_veh setDamage 1;
							_veh setVariable["blck_deleteAtTime",diag_tickTime + 60,true];
						}else {
							//diag_log format["_fnc_vehicleMonitor: releasing static %1 to players and setting a default delete timer",_veh];
							[_veh] call blck_fnc_releaseVehicleToPlayers;
							_veh setVariable["blck_DeleteAt",diag_tickTime + blck_vehicleDeleteTimer,true];
						};			
					} else {
						if (blck_killEmptyAIVehicles) then
						{
							//diag_log format["_fnc_vehicleMonitor: disabling vehicle %1 and setting a delete time",_veh];
							_veh setDamage 0.7;
							_veh setFuel 0;
							_veh setVariable["blck_deleteAtTime",diag_tickTime + 60];
						} else {
							//diag_log format["-------->_fnc_vehicleMonitor: releasing vehicle %1 to players and setting a default delete timer",_veh];
							_veh setVariable["blck_deleteAtTime",diag_tickTime + blck_vehicleDeleteTimer,true];	
							[_veh] call blck_fnc_releaseVehicleToPlayers;
						};
					};
					
				};
				blck_monitoredVehicles pushBack _veh;
			};
		} else {
			//diag_log format["_fnc_vehicleMonitor:  owner of vehicle %1 is a player, discontinuing further monitoring",_veh];
		};
	};
};
