/*
	By Ghostrider [GRG]
	Copyright 2016	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";
<<<<<<< Updated upstream
params["_markerName"];
=======
params[["_markerName",""]];
diag_log format["_fnc_deleteMarker: _maerkName = %1",_markerName];
if (_markerName isEqualTo "" || !(typeName _markerName isEqualTo "STRING")) exitWith {diag_log format"[blckeagls] <ERROR> illeagal or missing marker name: typeName _markerName = %1 | _makerName = %2",typeName _markerName,_markerName};
>>>>>>> Stashed changes
deleteMarker _markerName;
deleteMarker ("label" + _markerName);

