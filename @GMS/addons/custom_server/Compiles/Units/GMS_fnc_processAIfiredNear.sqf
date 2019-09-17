
/*
	blck_fnc_processAIfiredNear
	firedNear event handler for _units
	By Ghostrider-GRG-

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/

	See https://community.bistudio.com/wiki/Arma_3:_Event_Handlers#FiredNear for details on this event handler. 

	this addEventHandler ["FiredNear", {
	params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];
}];

    unit: Object - Object the event handler is assigned to
    firer: Object - Object which fires a weapon near the unit
    distance: Number - Distance in meters between the unit and firer (max. distance ~69m)
    weapon: String - Fired weapon
    muzzle: String - Muzzle that was used
    mode: String - Current mode of the fired weapon
    ammo: String - Ammo used
    Introduced with Arma 3 version 1.65
    gunner: Object - gunner, whose weapons are fired
*/
//#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_unit","_firedBy"];
//if ((side _unit) isEqualTo (side _firedBy) exitWith {};  // nearyby friendly fire 
(group _unit) setBehaviour "COMBAT";
(group _unit) setCombatMode "RED";
diag_log format["_fnc_processAIfiredNear: _unit %1 knows %2 about _firedBy %3",_unit, _unit knowsAbout _firedBy,_firedBy];
diag_log format["_fnc_processAIfiredNear: owner _unit = %1 | local _unit = %2",owner _unit, local _unit];

