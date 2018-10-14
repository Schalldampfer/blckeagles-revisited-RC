// GMS_fnc_vehiclePlayerSensingLogic.sqf

// No params

{
	//  
	//params["_vehicle","_group","searchRadius","_detectionOdds"];
	_group = group driver _vehicle;
	_searchRadius = _vehicle getVariable["blck_vehicleSearchRadius",800];
	_detectionOdds = _vehicle getVariable["blck_vehiclePlayerDetectionOds",0.5];
	[_vehicle,_group,_searchRadius,_detectionOdds] call blck_fnc_senseNearbyPlayers;
}forEach blck_monitoredVehicles;