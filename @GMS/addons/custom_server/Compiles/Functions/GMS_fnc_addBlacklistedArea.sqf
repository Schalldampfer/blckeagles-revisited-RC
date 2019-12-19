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