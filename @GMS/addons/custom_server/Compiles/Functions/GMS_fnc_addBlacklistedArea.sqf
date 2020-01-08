/*
	Adds the basic list of parameters that define a mission such as the marker name, mission list, mission path, AI difficulty, and timer settings, to the arrays that the main thread inspects.
	
	By Ghostrider-GRG-
	Copyright 2016
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_location","radius",["_timeOut",-1]];
private _locationMarker = createMarker [format["blackList:%1",random(1000000)], _location];
_locationMarker setMarkerShape "ELLIPSE";
_locationMarker setMarkerSize [_radius,_radius];
blck_blackListedLocations pushBack [_locationMarker,_timeOut];

/*
General notes:
things that should be included are:

blacklisted locations defined by users 
Traders, at least major ones 1000 meters to start 
Bases - to the extent possible - 1000 meters where possible 
players - were possible - no spawn at < 1000 meters to start 
recent locations of missions 
locations of helicrashes 
locations of towns / cities 

_minDistFromBases = blck_minDistanceToBases;
_minDistFromMission = blck_MinDistanceFromMission;
_minDistanceFromTowns = blck_minDistanceFromTowns;
_minSistanceFromPlayers = blck_minDistanceToPlayer;
_weightBlckList = 0.95;
_weightBases = 0.9;
_weightMissions = 0.8;
_weightTowns = 0.7;
_weightPlayers = 0.6;
if (blck_modType isEqualTo "Epoch") then {_pole = "PlotPole_EPOCH"};
if (blck_modType isEqualTo "Exile") then {_pole = "Exile_Construction_Flag_Static"};
_recentMissionCoords = +blck_recentMissionCoords;

Markers are conveinient to hold the location to avoid; the text could be used for a type for reference when doing the scalling down to find a new spot if needed. That text could be used to determne by how much to downsize marker dimensions when a location is not found. it cold also be used to hold a timestamp.




