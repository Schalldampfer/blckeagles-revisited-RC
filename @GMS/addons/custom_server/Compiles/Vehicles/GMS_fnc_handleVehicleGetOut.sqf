/*
	By Ghostrider [GRG]
    _fnc_handleVehicleGetOut
    Processes an event that fires when a unit gets out of a vehicle
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
/*
this addEventHandler ["GetOut", {
	params ["_vehicle", "_role", "_unit", "_turret"];
}];

    vehicle: Object - Vehicle the event handler is assigned to
    role: String - Can be either "driver", "gunner" or "cargo"
    unit: Object - Unit that left the vehicle
    Introduced with Arma 3 version 1.36
    turret: Array - turret path
*/

//diag_log format["_fnc_handleAIgetOut: _this = %1",_this];
private _veh = _this select 0;
private _unit = _this select 2;
[_veh] call blck_fnc_checkForEmptyVehicle;