/*
	By Ghostrider [GRG]
	Copyright 2016

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
// assumptions: there are no crew in vehicle. there are no players in vehicle. thus we can just be sure the owner is the server then set the lock locally
#include "\q\addons\custom_server\Configs\blck_defines.hpp";
params["_veh"];

if (local _veh) then
{
	//diag_log format["blck_fnc_unlockVehicle: handling case of local vehicle %2 that is local to owner %1",owner _veh, _veh];
	_veh lock 1;
}
else
{
	//diag_log format["blck_fnc_unlockVehicle: handling case of non-local vehicle %2 that is local to owner %1",owner _veh, _veh];
	[_veh, 1] remoteExecCall ["lock", _veh];
};
///diag_log format["blck_fnc_unlockVehicle: _vehcle %1 of typeOf %3 locked set to %2",_veh, locked _veh,typeOf _veh];