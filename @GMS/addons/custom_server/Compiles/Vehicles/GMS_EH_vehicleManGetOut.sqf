//  NOT USED AT PRESENT

/*
this addEventHandler ["GetOutMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];
}];

    unit: Object - unit the event handler is assigned to
    role: String - Can be either "driver", "gunner" or "cargo"
    vehicle: Object - Vehicle that the unit left
    turret: Array - turret path
*/

//diag_log format["EH_vehicleManGetOut: _this = %1",_this];
params["_unit","_role","_veh"];
[_veh,_unit] remoteExec["blck_fnc_handleAIgetOut",2];




