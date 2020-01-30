/*
	Spawn a vehicle and protect it against cleanup by Epoch
	Returns the object (vehicle) created.
	By Ghostrider [GRG]

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_vehType","_pos",["_special","NONE"]];
//diag_log format["spawnVehicle.sqf: _this = %3 | _vehType = %1 | _pos = %2",_vehType,_pos,_special];
private _veh = createVehicle[_vehType, _pos, [], 0, _special];
_veh setVectorUp surfaceNormal position _veh;
_veh allowDamage true;
_veh enableRopeAttach true;
_veh setVariable["blck_vehicle",true];
[_veh] call blck_fnc_protectVehicle;
[_veh] call blck_fnc_emptyObject;
//diag_log format["spawnVehicle:: returning parameter _veh = %1",_veh];
_veh
	
