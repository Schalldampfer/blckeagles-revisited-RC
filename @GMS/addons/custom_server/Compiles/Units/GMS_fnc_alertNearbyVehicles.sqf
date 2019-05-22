/*
	by Ghostrider
	 
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_target"];
private["_vehGroup"];
{
	_vehGroup = _x getVariable["vehicleGroup",grpNull];
	if (_target distance2D (leader _vehGroup) < 1000) then {[_vehGroup,_target] call blck_fnc_alertGroupUnits;};
}forEach blck_monitoredVehicles;



