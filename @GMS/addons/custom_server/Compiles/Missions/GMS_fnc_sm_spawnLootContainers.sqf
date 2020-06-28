/*
	by Ghostrider [GRG]

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_objectDescriptors","_coords"];

if !(_objectDescriptors isEqualTo []) then
{  //  Spawn loot crates where specified in _objects using the information for loot parameters provided for each location.
	{
		// data within the descriptor for each loot crate is organized as follows (not that the _allowDamageSim is included just for backward compatibilty but is not used
		_x params["_crateClassName","_cratePosASL","_vectorDirUp","_allowDamageSim","_crateLoot","_lootCounts"];	
		private _crate = [_cratePosASL, _crateClassName] call blck_fnc_spawnCrate;
		[_crate, _crateLoot,_lootCounts] call blck_fnc_fillBoxes;
	} forEach _objectDescriptors;
}
else 
// In the case where no loot crate parameters are defined in _objects just spawn 1 at the center of the mission.
{
	_crateType = selectRandom blck_crateTypes;
	_crate = [_coords,_crateType] call blck_fnc_spawnCrate;
	[_crate,blck_BoxLoot_Red,blck_lootCountsGreen] call blck_fnc_fillBoxes;
};

