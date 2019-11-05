/*
  Delete Dead AI and nearby weapons after an appropriate period.
  by Ghostrider-GRG-
  
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

#ifdef blck_debugMode
if (blck_debugLevel > 2) then {diag_log format["fnc_cleanupDeadAI called at time %1",diag_tickTime];};
#endif

for "_i" from 1 to count blck_deadAI do
{
	if (_i > count blck_deadAI) exitWith {};
	private _unit = blck_deadAI deleteAt 0;
	if (diag_tickTime > _unit getVariable ["blck_cleanupAt",0]) then 
	{
		private _nearplayer = (_unit nearEntities 1500) select {isplayer _x};
		if (_nearplayer isequalto []) then {
			{
				deleteVehicle _unit;
			}forEach nearestObjects [getPos _unit,["WeaponHolderSimulated","GroundWeapoonHolder"],3];	
			deleteVehicle _unit;
		} else {
			blck_deadAI pushBack _unit;
		};
	} else{
		blck_deadAI pushBack _unit;
	};
};

