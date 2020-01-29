/*
  Delete alive AI.
  by Ghostrider
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";
//diag_log format["_fnc_cleanupaliveAI: called at %1 | count %2 | blck_liveMissionAI = %3",diag_ticktime,count blck_liveMissionAI,blck_liveMissionAI];
for "_i" from 1 to (count blck_liveMissionAI) do {
	if ((_i) <= count blck_liveMissionAI) then {
		_units = blck_liveMissionAI deleteAt 0;
		_units params ["_missionCenter","_unitsarr","_timer"];
		//diag_log format["_fnc_cleanupAliveAI: _units = %4 | _missionCenter %1 | typeName _unitsArr = %2 | _unitsarr = %3",_missionCenter,typeName _unitsArr, _unitsarr,_units];
		if (diag_tickTime > _timer) then 
		{
			private _nearplayer = [_missionCenter,800] call blck_fnc_nearestPlayers;
			if (_nearPlayer isEqualTo []) then 
			{
				{
					private _unit = _x;
					if ((alive _unit) && !(isNull objectParent _unit)) then {
						[objectParent _unit] call blck_fnc_deleteAIvehicle;
					};
					[_unit] call blck_fnc_deleteAI;
				} forEach _unitsarr;
			} else { 
				blck_liveMissionAI pushback _units;
			};
		} else {
			blck_liveMissionAI pushback _units;
		};
	};
};
