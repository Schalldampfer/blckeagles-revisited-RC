/*
	Purpose: returns the nearest marker of a specific type 
	Parameters: type of marker to search for as a "STRING"
	Returns: The nearest marker of that type
*/

params["_mType"];
private _nearestMarker = [player, (allMapMarkers select {(getMarkerType _x) isEqualTo _mType})] BIS_fnc_nearestPosition;
_nearestMarker;
