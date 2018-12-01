
/*
	Killed handler for _units
	By Ghostrider-GRG-

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
//  Needs optimization for headless clients
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

	params["_veh"];
	blck_monitoredVehicles = blck_monitoredVehicles - [_veh];
	//diag_log format["_fnc_releaseVehicleToPlayersl: _veh = %1 | isLocal _veh = %3 | (owner _veh) = %2",_veh,(owner _veh),Local _veh];
    if (local _veh) then {
        _veh lock false;
    }
    else {
        if (isserver) then {
            [_veh,false] remoteExecCall ["lock",_veh];    // let the machine, where the vehicle is local unlock it (only the server knows, who the owner is!!!)
        }
        else {
            [[_veh,false],["lock",_veh]] remoteExecCall ["remoteExecCall", 2];    // If run on HC, move to the server. Server will remoteexec on local machine
        };
    };
	//diag_log format["_fnc_releaseVehicleToPlayers: _veh=%1 | owner = %2 | lock = %3",_veh,owner _veh, locked _veh];
	{
		_veh removealleventhandlers _x;
	} forEach ["GetIn","GetOut","fired","hit","hitpart","reloaded","dammaged","HandleDamage"];
	{
		_veh removeAllMPEventHandlers _x;
	} forEach ["MPHit","MPKilled"];
	_veh setVariable["blck_DeleteAt",nil];
	if ((damage _veh) > 0.6) then {_veh setDamage 0.6};
