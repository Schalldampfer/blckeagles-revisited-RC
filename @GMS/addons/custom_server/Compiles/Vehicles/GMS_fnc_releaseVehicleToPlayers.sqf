
/*
	By Ghostrider-GRG-
	And Ignatz-HeMan
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/

#include "\q\addons\custom_server\Configs\blck_defines.hpp";

	params["_veh"];
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

	{
		_veh removealleventhandlers _x;
	} forEach ["GetIn","GetOut","fired","hit","hitpart","reloaded","dammaged","HandleDamage"];
	{
		_veh removeAllMPEventHandlers _x;
	} forEach ["MPHit","MPKilled"];
	if ((damage _veh) > 0.6) then {_veh setDamage 0.6};  //  So they don't blow up when a player tries to get in.
