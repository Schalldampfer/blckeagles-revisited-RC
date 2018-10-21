// GMS_fnc_vehiclePlayerSensingLogic.sqf

// No params
private["_searchRadius","_detectionOdds"];
{
	_searchRadius = _x getVariable["blck_vehicleSearchRadius",800];
	_detectionOdds = _x getVariable["blck_vehiclePlayerDetectionOdds",0.5];
	[_x,_searchRadius,_detectionOdds] call blck_fnc_revealNearbyPlayers;
}forEach blck_monitoredVehicles;