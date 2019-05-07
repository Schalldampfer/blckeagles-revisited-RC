
/*
	By Ghostrider [GRG]
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";
params["_center","_landscape"];
// diag_log format["fnc_spawnMissionLandscapeRelative: _center = %1",_center];
private["_obj","_objects"];
_objects = [];
{
    _x params["_objClassName","_objRelPos","_objDir"];
    _obj = [_objClassName, _objRelPos vectorAdd _center, _objDir,enableSimulationForObject,enableDamageForObject,enableRopesforObject,"CAN_COLLIDE"] call blck_fnc_spawnSingleObject;
    _objects pushBack _obj;
}forEach _landscape;
_objects