/*
	By Ghostrider [GRG]

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
/*
    _loadVehicleCrew
	Expects the group has units and they are configured
*/
if (isNil "blck_blacklisted_vehicle_weapons") then {blck_blacklisted_vehicle_weapons = []};
params["_veh","_group",["_crewCount",4]];
private _units = units _group;
#ifdef blck_debugMode 
if (blck_debugLevel > 2) then 
{
	diag_log format["_fnc_loadVehicleCrew: _veh = %1 | _group = %2 | group units = %4 | _crewCount = %3",_veh,_group,_crewCount, units _group];
};
#endif 
for "_i" from 1 to _crewCount do 
{
	if (_units isEqualTo []) exitWith {};
	_crew = _units deleteAt 0;
	/*
	Note that in documentation for the moveinAny command the order seats are filled is:
	driver
	commander
	gunner
	other turrets 
	cargo

	https://community.bistudio.com/wiki/moveInAny 
	*/
	_crew moveInAny _veh;
	#ifdef blck_debugMode
	if (blck_debugLevel > 2) then 
	{
		diag_log format["_fnc_loadVehicleCrew: loaded unit %1 into vehicle %2",_crew,_veh];
		diag_log format["_fnc_loadVehicleCrew: new crew for vehicle %1 = %2",_veh, crew _veh];
	};
	#endif
};
{deleteVehicle _x} forEach _units;
#ifdef blck_debugMode 
if (blck_debugLevel > 2) then 
{
	diag_log format["_fnc_loadVehicleCrew: _veh = %1 | crew = %2 | driver = %3",_veh,crew _veh,driver _veh];
};
#endif 
