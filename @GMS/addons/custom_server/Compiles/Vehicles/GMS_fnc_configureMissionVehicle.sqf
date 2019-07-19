// Configures a mission vehicle
/*
	By Ghostrider [GRG]
	Copyright 2016
	
	spawns a vehicle of _vehType and mans it with units in _group.
	returns _veh, the vehicle spawned.
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_veh",["_locked",0]];
private["_unit"];
//_veh setVehicleLock "LOCKEDPLAYER";
_veh lock _locked;
_veh addMPEventHandler["MPHit",{ _this call blck_EH_AIVehicle_HandleHit}];
_veh addMPEventHandler["MPKilled",{_this call blck_EH_vehicleKilled}];
_veh addEventHandler["GetOut",{_this remoteExec["blck_EH_vehicleGetOut",2]}];
//_veh addEventHandler["Local", {if (isServer) then {_this call blck_EH_changeLocality}}];

blck_monitoredVehicles pushBackUnique _veh;
if (blck_modType isEqualTo "Epoch") then
{
	if (blck_allowSalesAtBlackMktTraders) then {_veh setVariable["HSHALFPRICE",1,true]};
};
if (blck_modType isEqualTo "Exile")	then 
{
	if (blck_allowClaimVehicle) then 
	{
		_veh setVariable ["ExileIsPersistent", false];
	};
};

_veh
